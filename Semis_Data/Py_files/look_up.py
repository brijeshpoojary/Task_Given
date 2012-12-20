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

    con = psycopg2.connect(database='sslc',user='postgres',host='localhost',password='hello') 
    cur = con.cursor()     
    
    fp=csv.reader(open('/home/brijesh/klp/Task_One/sslc_data/SSLC_data.csv','r'),delimiter='|',quotechar='\'')
    i=0
    for row in fp:
	if(i!=0):	
		cur.execute("insert into tb_look_up values('"+row[1]+"','"+row[2]+"')")
	i=i+1
    con.commit()
except psycopg2.DatabaseError, e:
    print 'Error %s' % e    
    sys.exit(1)
    
    
finally:
    
    if con:
        con.close()
