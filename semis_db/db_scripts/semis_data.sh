#!/bin/sh

DBNAME=$(basename $0 .sh)
OWNER=klp


sudo -u postgres dropdb ${DBNAME}
sudo -u postgres createdb -O ${OWNER} -E UTF8 ${DBNAME}
sudo -u postgres psql -d ${DBNAME} -f /usr/share/postgresql/8.4/contrib/dblink.sql
sudo -u postgres createlang plpgsql ${DBNAME}

# Create schema
psql -U ${OWNER} -d ${DBNAME} -f ${DBNAME}.sql

echo parsing Semis csvs
python ../py_scripts/${DBNAME}.py

echo loading DB
psql -U ${OWNER} -d ${DBNAME} -f load/tb_semis_basic_data.sql
psql -U ${OWNER} -d ${DBNAME} -f load/tb_semis_enrolment_repeaters_data.sql
psql -U ${OWNER} -d ${DBNAME} -f load/tb_semis_facility_data.sql
psql -U ${OWNER} -d ${DBNAME} -f load/tb_semis_teachers_data_22_16_59.sql
psql -U ${OWNER} -d ${DBNAME} -f load/tb_semis_teachers_data_22_22_21.sql
psql -U ${OWNER} -d ${DBNAME} -f load/tb_semis_teachers_data_22_25_18.sql

echo "Seeding data done!"

echo "Aggregating data done!"

echo "All done!"
