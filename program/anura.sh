#!/bin/bash
# -- PATHS --
# Used from stable version
STYLES="/etc/anura-css/styles"
COMMANDS="/etc/anura-css/commands"
PDATA="/etc/anura-css/data"


ans="$1"
export ans
var="$2"
Pfind(){
	DIRNAME=$(cat .data/projects.csv | grep $var)
	status=(${DIRNAME//,/ })
	ST=${status[3]}
	PTH=${status[2]}
	if [ "$ST" == "up" ]
	then
		echo $(tput setaf 2)Applying changes to $var$(tput setaf 7)
		
	else
		echo $var does not exist
	fi
}

case $ans in
        "create")
		touch styles/example.css
               	cat << EOF > commands/index.py
#!/usr/bin/python3 -tt

def getTitle():
	title = "$2"
	return title
def getStyle():
	style = "$3"
	return style

EOF
		LOC=`pwd`
		if [ ! -z $3 ]
		then
			STYFIND=$(ls styles | grep $3)
			if [ ! -z $STYFIND ]
			then
				echo -e $2,$3,$LOC,up >> .data/projects
			else
				echo "$(tput setaf 1)$(tput bold)Err:$(tput sgr0) File not created, cause:$(tput setaf 7)" 
			fi
		else
			echo $(tput setaf 2)$2 branch: 1$(tput setaf 7)
			echo -e $2,default,$LOC,up >> .data/projects
		fi
		
		chmod 770 commands/index.py
		chmod 770 commands/create.py
		./commands/index.py
		./commands/create.py
#		chmod -w $2
		exit 0
		#mv "$2" folder
                ;;
        "help")
		clear
                cat help
                ;;
	"rename")
		mv $2 $3
		;;
	"build")
#		cat << EOF > commands/exc.py
#!/usr/bin/python3 -tt
#import build
#build.buildstyle()
#EOF
#chmod 770 commands/exc.py
#./commands/exc.py

		while IFS= read -r line
		do	
			echo $line
		done < styles/.names > styles/example.css 

		while IFS= read -r line
		do	
			((n=n+1))
			sed -i "$n s/hola/$line/g" styles/example.css
			#sed -i "$n s/BL/\n/g" styles/example.css &
			#sed -i "$n s/TB/\t/g" styles/example.css &
			echo $n
		done < styles/.settings 
	;;
	"in")
		if [ ! -z $2 ]
		then
			Pfind
			FPTH=$PTH/$2
		#	echo $FPTH
			./lotus.sh $var
		else
			echo "Anura-css: In what?"
		fi
	;;
	"remove")
		chmod +w $2
		sed -i "/$2/d" .data/projects.csv
		rm -rf $2
		echo $(tput setaf 2)$2 removed succesfully$(tput setaf 7)
	;;
	"")
		echo "No arguments, type 'anura help' to view commands information"
		;;
	*)
		echo "$ans is not a anura command"
esac

