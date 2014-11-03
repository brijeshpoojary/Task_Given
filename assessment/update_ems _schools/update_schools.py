import csv

readfile=csv.reader(open('/home/brijesh/bangalore_schools_cluster_update.csv','r'),delimiter='|')
writefile=open('update_schools.sql','w')
readfile.next()

for row in readfile:
    writefile.write('update schools_institution set boundary_id='+row[4]+' where id=' +row[3] +';\n')
