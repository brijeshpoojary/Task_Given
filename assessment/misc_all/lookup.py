import csv
import web


csvreader=csv.reader(open('Akshara v1.0 (24-Sep).csv','r'),delimiter='|')
csvwriter=csv.writer(open('result.csv','w'),delimiter='|')

db=web.database(dbn='postgres',user='klp',pw='',db='klpproduction')

csvwriter.writerow(csvreader.next())

withcoord=0
withoutcoord=0
total=0
for row in csvreader:
    dise_code=''
    print len(row)
    if len(row[0].strip())>0:
        result=db.query('select dise_code from schools_institution where id=$s;',{'s':int(row[5])})
        for code in result:
            dise_code=code.dise_code
        if dise_code=='':
            #csvwriter.writerow(row)
            withoutcoord=withoutcoord+1
        else:
            withcoord=withcoord+1
        total=total+1
        row=row+[dise_code]
        csvwriter.writerow(row)
