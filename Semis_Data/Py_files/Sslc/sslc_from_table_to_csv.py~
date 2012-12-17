#!/usr/bin/python
# -*- coding: utf-8 -*-

import psycopg2
import csv
import sys

con = None
try:
    #Connection to Database
    con = psycopg2.connect(database='sslc', user='postgres',host='localhost', password='hello') 
    cur = con.cursor()     

    #Running a query to retrieve the contents
    result="select distinct dist_code,school_code,schoolname from tb_sslcresults where ayid=101"
    
    cur.execute(result)

    #Opening a file with specified headers and adding the data into csv file
    fp=csv.writer(open('/home/brijesh/klp/Semis_Data/sslc_data/sslc.csv','w'),delimiter='|',quotechar='\'')
    headers=['District_code','School_code','School_name']
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
