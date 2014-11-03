#!/usr/bin/python
# -*- coding: utf-8 -*-

import psycopg2
import csv
import sys
import re


#try:
fp_2011_12=csv.reader(open('/home/brijesh/math_assessment_mundargi_4th_pretest_2012-13.csv','r'),delimiter='|',quotechar='\"')
fp_2012_13=csv.reader(open('/home/brijesh/math_assessment_mundargi_5th_pretest_2013-14.csv','r'),delimiter='|',quotechar='\"')
fp1_2=csv.writer(open('/home/brijesh/result.csv','w'),delimiter='|',quotechar='\"')

std_2011_12=[row for row in fp_2011_12]
std_2012_13=[row for row in fp_2012_13]

stu_2011_12=[]
stu_2012_13=[]

file1=[]
file2=[]
	
both=[]

file1empty=[]
file2empty=[]
	
result=[]

for row in std_2011_12:
    stu_2011_12.append(row[5])
for row in std_2012_13:
    stu_2012_13.append(row[5])
for row in stu_2011_12:
    if row in stu_2012_13:
        both.append(row)
    else:
        file1.append(row)
for row in stu_2012_13:
    if row not in stu_2011_12:
        file2.append(row)

for i in range(0,len(std_2011_12[0][13:])):
    file1empty.append('')
for i in range(0,len(std_2012_13[0][13:])):
    file2empty.append('')
result=[std_2011_12[0]+std_2012_13[0][13:]]

for stu in both:
    res=[]
    for row in std_2011_12[1:]:
        if row[5].strip()==stu.strip() and len(res)==0:
            res=row
    for row in std_2012_13[1:]:
        if row[5].strip()==stu.strip() and len(res)>0:
            res=res+row[13:]
    result.append(res)

for stu in file1:

    for row in std_2011_12[1:]:
        if row[5].strip()==stu.strip():
            result.append(row+file2empty)
for stu in file2:
    for row in std_2012_13[1:]:
        if row[5].strip()==stu.strip():
            result.append(row[0:13]+file1empty+row[13:])
for row in result:
    if len(row)>1:
        fp1_2.writerow(row)
