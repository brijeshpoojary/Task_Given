#!/usr/bin/python
# -*- coding: utf-8 -*-

import psycopg2
import csv

con=psycopg2.connect(dbname='semis',user='postgres',password='hello',host='localhost')
cur=con.cursor()

def filter_len6():

	cur.execute("select distinct school_code,school_name from sslc_data where length(school_code)=6")

	fp=csv.writer(open('/home/brijesh/len6.csv','w'),delimiter='|',quotechar='\'')

	result=cur.fetchall()

	for row in result:
		fp.writerow(row)

def filter_len5():

	cur.execute("select distinct school_code,school_name from sslc_data where length(school_code)<6")
		
	fp=csv.writer(open('/home/brijesh/len5.csv','w'),delimiter='|',quotechar='\'')

	result=cur.fetchall()

	for row in result:
		fp.writerow(row)

def check_repeat():

	cur.execute("select cast(substr(a.school_code,3) as int) from len_5 as a, len_6 as b where a.school_name=b.school_name and substr(trim(a.school_code),1,2)=substr(trim(b.school_code),1,2) and cast(substr(a.school_code,3) as int)=cast(substr(b.school_code,3) as int)")
		
	fp=csv.writer(open('/home/brijesh/filter_len5.csv','w'),delimiter='|',quotechar='\'')

	result=cur.fetchall()

	for row in result:
		fp.writerow(row)

def delete_repeat():

	

	cur.execute("delete from len_5 where school_code in (select a.school_code from len_5 as a, len_6 as b where a.school_name=b.school_name and substr(trim(a.school_code),1,2)=substr(trim(b.school_code),1,2) and cast(substr(a.school_code,3) as int)=cast(substr(b.school_code,3) as int));")
	
	con.commit()

def copytocsv():
	cur.execute("select * from len_5")
	result=cur.fetchall()
	cur.execute("select *from len_6")
	header=['School_code','School_name']
	fp=csv.writer(open('/home/brijesh/filter.csv','w'),delimiter='|',quotechar='\'')
	fp.writerow(header)
	for row in result:
		fp.writerow([row[0],row[1]])
	result=cur.fetchall()
	for row in result:
		fp.writerow([row[0],row[1]])


def upload():
	fp=csv.reader(open('/home/brijesh/klp/Task_One/filter/filter.csv','r'),delimiter='|',quotechar='\'')
    	for row in fp:
		cur.execute("insert into filter values('"+row[0]+"','"+row[1]+"')")
    	con.commit()	


#filter_len6()
#filter_len5()
#check_repeat()
#delete_repeat()
#copytocsv()
upload()
