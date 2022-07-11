#!/usr/bin/python3 -tt
import subprocess
import os
import shutil
title = "Example"
def example():
    div = "\n\t\t<li><a href=\"#home\">Home</a></li>\n\t\t\t<li><a href=\"#news\">News</a></li>\n\t\t\t<li><a href=\"#contact\">Contact</a></li>\n\t\t\t<li><a href=\"#about\">About</a></li>"
    nav = "\n\t<ul class=\"navbar\">" + div + "\n</ul> " 
    home = "<h1>Let's Jumping and Singing</h1>" + "\n<h3>Frogs are here!</h3>"
    exp = nav + home
    return exp

name = str("index.html")
bcx = "Example"

sFile = "styles/"+"example"
os.mkdir(bcx)
tFile = bcx + '/'+ 'style.css'
fileHandle = open(sFile, "r")
texts = fileHandle.readlines()
fileHandle.close()
fileHandle = open(tFile, "w")
for s in texts:
    fileHandle.write(s)
fileHandle.close()
print("example"+" style added")

path = bcx +'/'+ name
bcontent = example()
hcontent = str("\t<title>"+title+"</title>\n\t<link rel=\"stylesheet\" href=\"style.css\">\n\t<link rel = \'icon\' href=\"../logo.svg\" type = \"image/x-icon\"/>")
head = str("<head>\n" + hcontent + "\n</head>\n")
#componet = example()
body = str("<body>\n"+bcontent+"\n</body>")
file = open(path, "w")
file.write("<!DOCTYPE HTML>" + os.linesep)
file.write(head)
file.write(body)
file.close()
