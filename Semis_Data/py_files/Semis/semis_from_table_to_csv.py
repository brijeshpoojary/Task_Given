#!/usr/bin/python
# -*- coding: utf-8 -*-

import psycopg2
import csv
import sys

con = None
try:
    #Connection to Database
    con = psycopg2.connect(database='semis', user='postgres',host='localhost', password='hello') 
    cur = con.cursor()     

    #Running a query to retrieve the contents
    result="select distinct school_code,school_name,district_name from basic_data"
    
    cur.execute(result)

    #Opening a file with specified headers and adding the data into csv file
    fp=csv.writer(open('/home/brijesh/klp/Task_One/semis.csv','w'),delimiter='|',quotechar='\'')
    headers=['School_code','School_name','District_name']
    fp.writerow(headers)
    while True:
      
        row = cur.fetchone()
        result=row
        if row == None:
            break
        fp.writerow(result)    

except psycopg2.DatabaseError, e:
    print 'Error %s' % e    
    sys.exit(1)
    
    
finally:
    
    if con:
        con.close()
