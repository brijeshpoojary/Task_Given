#!/usr/bin/env python
import os,sys
import csv


filelist = {"SEMIS_Basic_Data_26-09-2012 22-10-24.csv":"tb_semis_basic_data",
            "SEMIS_EnrolmentAndRepeaters_Data_26-09-2012 22-11-52.csv":"tb_semis_enrolment_repeaters_data",
            "SEMIS_Facility_Data_26-09-2012 22-13-45.csv":"tb_semis_facility_data",
            "SEMIS_Teachers_Data_26-09-2012 22-16-59.csv":"tb_semis_teachers_data_22_16_59",
            "SEMIS_Teachers_Data_26-09-2012 22-22-21.csv":"tb_semis_teachers_data_22_22_21",
            "SEMIS_Teachers_Data_26-09-2012 22-25-18.csv":"tb_semis_teachers_data_22_25_18"}

try:
  for file in filelist.keys():
    semisdatafile=open("../db_scripts/load/" + filelist[file] + '.sql' ,'a')
    csvbuffer = csv.reader(open('../data/'+file,'rb'), delimiter='|', quotechar='\'')
    header = csvbuffer.next()
    headlen = len(header)
    for row in csvbuffer:
      if len(row) > headlen :
        print row
        print filelist[file]
      semisdatafile.write('INSERT INTO ' + filelist[file] + ' values('+ (', '.join('\''+ item +'\'' for item in row)) +');\n')
except:
  print "Unexpected error:", sys.exc_info()
  print "Exception in user code:"
  print '-'*60
  traceback.print_exc(file=sys.stdout)
  print '-'*60
finally:
  semisdatafile.close()
