import psycopg2
import csv
import re
con=psycopg2.connect(dbname='sslc',user='postgres',password='hello',host='localhost')
cur=con.cursor()

def upload():
	fp=csv.reader(open('/home/brijesh/sslc.csv','r'),delimiter='|',quotechar='\'')
	i=0
	for row in fp:
		if(i!=0):	
			cur.execute("insert into tb_sslc_data values('" + row[0] + "','" + row[1].replace("'","\\'") + "')")
		i=i+1	
	con.commit()
upload()

