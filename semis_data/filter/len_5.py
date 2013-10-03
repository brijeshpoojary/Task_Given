#!/usr/bin/python
# -*- coding: utf-8 -*-

import psycopg2
import csv
import sys
import re

con = None
try:

    def rm_spc_char(value):
	text=''
	for c in value:
		if c!='\'':
			text=text+c
	return text

    con = psycopg2.connect(database='semis',user='postgres',host='localhost',password='hello') 
    cur = con.cursor()     
    
    fp=csv.reader(open('/home/brijesh/len5.csv','r'),delimiter='|',quotechar='\'')
    for row in fp:
		cur.execute("insert into len_5 values('"+row[0]+"','"+row[1]+"')")
    con.commit()
except psycopg2.DatabaseError, e:
    print 'Error %s' % e    
    sys.exit(1)
    
    
finally:
    
    if con:
        con.close()
