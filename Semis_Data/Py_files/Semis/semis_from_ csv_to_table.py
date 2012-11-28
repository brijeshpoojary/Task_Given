#!/usr/bin/python
# -*- coding: utf-8 -*-

import psycopg2
import csv
import sys

con = None
try:
    con = psycopg2.connect(database='semis',user='postgres',host='localhost',password='hello') 
    cur = con.cursor()     
    
    fp=csv.reader(open('/home/brijesh/klp/Task_One/semis_kar_2010_2011/SEMIS_Basic_Data_26-09-2012 22-10-24.csv','r'),delimiter='|',quotechar='\'')
    i=0
    for row in fp:
	if(i!=0):
		cur.execute("insert into basic_data values('"+row[0]+"','"+row[1]+"','"+row[2]+"')")
	i=i+1
    con.commit()
except psycopg2.DatabaseError, e:
    print 'Error %s' % e    
    sys.exit(1)
    
    
finally:
    
    if con:
        con.close()
