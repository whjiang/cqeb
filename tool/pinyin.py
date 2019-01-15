#!/usr/bin/python

import sys
import getopt
from collections import defaultdict

def writeFileHeader(f, name):
    header = """---
name: %s
version: "1.0"
sort: original
columns:
  - text
  - code
  - weight
  - stem
encoder:
  rules:
    - length_equal: 2
      formula: "AaAbBaBb"
    - length_equal: 3
      formula: "AaAbBaCa"
    - length_in_range: [4, 10]
      formula: "AaBaCaZa"
...
""" % name
    f.write(header)

def main(argv):
    inputfile = ''
    try:
        opts, args = getopt.getopt(argv, "hi:", ["ifile="])
    except getopt.GetoptError:
        print 'pinyin.py -i <pinyin_simp.dict.yaml>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'pinyin.py -i <pinyin_simp.dict.yaml>'
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
    print 'Input file is "', inputfile

    with open(inputfile, "r") as f:
        content = f.readlines()

    content = [x.strip() for x in content]
    header = True
    iFCList = [] #reverse loop
    pyHSList = [] #mix input
    for x in content:
        if not header and x:
            items = x.split()
            word = items[0]
            items = items[1:]
            if items[-1].isdigit():
                items = items[:-1]
            pyHSList.append((word, "".join(items)))
            iFCList.append((word, "i" + "".join(items)))
            if len(items) > 1:
                iFCList.append((word, "i"+ "".join(map(lambda x: x[0], items))))
        if x == "...":
            header = False
    #sort by encoding
    iFCList.sort(key=lambda x: x[1])
    pyHSList.sort(key=lambda x: x[1])

    with open("iFC.dict.yaml", "w") as iFC:
        writeFileHeader(iFC, "iFC")
        for x in iFCList:
            iFC.write("%s\t%s\n" % (x[0], x[1]))

    with open("pyHS.dict.yaml", "w") as pyHS:
        writeFileHeader(pyHS, "pyHS")
        for x in pyHSList:
            pyHS.write("%s\t%s\n" % (x[0], x[1]))

    print "output files are: iFC.dict.yaml and pyHS.dict.yaml"
if __name__ == "__main__":
   main(sys.argv[1:])
