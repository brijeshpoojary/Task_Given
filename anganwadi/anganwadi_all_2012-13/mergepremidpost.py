import csv
import psycopg2
import sys
import re
import os

rootdir = "/home/brijesh/"



outputfile=open(rootdir+sys.argv[1],'wb')

students={}

def getRow(row):
  line = str(row).strip('[')
  line = line.strip(']')
  return line

     
def main():
  edetails={"pre":[],"mid":[],"post":[]}
  inputfile=sys.argv[2]
  data=csv.reader(open(rootdir+inputfile,'r'),delimiter='|')
  firstLine=1
  for row in data:
    if firstLine:
      firstLine=0
      for i in range(11,len(row)):
        edetails["pre"].append(row[i])
      continue
    studentid=row[6]
    if studentid in students:
      print "duplicate"
      continue
    students[studentid]={}
    students[studentid]["examcount"]=1
    students[studentid]["details"]=""
    students[studentid]["pre"]={}
    students[studentid]["pre"]["details"]=""
    students[studentid]["details"]=row[0]
    for count in range(1,12):
      students[studentid]["details"]=students[studentid]["details"]+"|"+row[count]
    for count in range(12,len(row)):
      students[studentid]["pre"]["details"]=students[studentid]["pre"]["details"]+"|"+row[count]




  inputfile=sys.argv[3]
  data=csv.reader(open(rootdir+inputfile,'r'),delimiter='|')
  firstLine=1
  for row in data:
    if firstLine:
      firstLine=0
      for i in range(11,len(row)):
        edetails["post"].append(row[i])
      continue
    studentid=row[6]
    if studentid not in students:
      students[studentid]={}
      students[studentid]["examcount"]=0
      students[studentid]["details"]=""
      students[studentid]["details"]=row[0]
      for count in range(1,11):
        students[studentid]["details"]=students[studentid]["details"]+"|"+row[count]
    students[studentid]["examcount"]=students[studentid]["examcount"]+1
    students[studentid]["post"]={}
    students[studentid]["post"]["details"]=""
    for count in range(11,len(row)):
      students[studentid]["post"]["details"]=students[studentid]["post"]["details"]+"|"+row[count]


  tests=['pre','post']
  

  outputfile.write("DIST|PROJ|CIRCLE|SCODE|SNAME|STUID|CNAME|CSEX|DOB|CLANG|ASSMNTNAME")
  for e in range (0,len(edetails["pre"])):
    outputfile.write("|"+edetails["pre"][e])
  for e in range (0,len(edetails["post"])):
    outputfile.write("|"+edetails["post"][e])
  outputfile.write("\n")
  for stu in students:
    outputfile.write(str(students[stu]["details"]))
    for test in tests:
      if test not in students[stu]:
        outputfile.write("|"+test+"test")
        for e in range (1,len(edetails[test])):
          outputfile.write("|")
      else:
         outputfile.write(str(students[stu][test]["details"]))
    outputfile.write("\n")


main()

