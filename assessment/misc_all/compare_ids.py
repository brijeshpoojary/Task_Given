import csv

bellary_id_file=csv.reader(open('bellary_school_list.csv','r'),delimiter='|')
klp_id_file=csv.reader(open('klp_school_list.csv','r'),delimiter='|')
result_file=csv.writer(open('bellary_school_not_in_ems_database.csv','w'),delimiter='|')
#klp_id_file.next()

def convert(value):
    try:
        return int(value)
    except:
        return 0

klp_id_list=[row for row in klp_id_file]
for row_bellary in bellary_id_file:
    flag=0
    for row_klp in klp_id_list:
        if row_bellary[0].strip()==row_klp[1].strip():
            flag=1
            break
    if flag==0:
        result_file.writerow(row_bellary)



