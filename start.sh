#!/bin/bash

dbpassword=$env_dbpassword

DB_PASSWORD=$dbpassword
DB_SHUTDOWN_PASSWORD=$dbpassword
DB_BASEDIR=/h2data
#DB_LIB=h2-2.1.214.jar
DB_LIB=h2-1.4.200.jar

sed -i "s|\$DB_PASSWORD|${DB_PASSWORD}|"  init.sql

echo "jdbc:h2:/$DB_BASEDIR/iotdata"
echo "$DB_PASSWORD"
echo "$DB_SHUTDOWN_PASSWORD"
echo "starting ..."
#iotdata
java -cp $DB_LIB org.h2.tools.RunScript -url jdbc:h2:/$DB_BASEDIR/iotdata -user sa -script init.sql
if [ "$?" -ne "0" ]; then
  echo "1 failed"
  java -cp $DB_LIB org.h2.tools.RunScript -url jdbc:h2:/$DB_BASEDIR/iotdata -user sa -password $DB_PASSWORD -script init.sql
  if [ "$?" -ne "0" ]; then
    echo "1a failed"
  else
    echo "1a success"
  fi
fi
#auth
java -cp $DB_LIB org.h2.tools.RunScript -url jdbc:h2:/$DB_BASEDIR/auth -user sa -script init.sql
if [ "$?" -ne "0" ]; then
  echo "2 failed"
  java -cp $DB_LIB org.h2.tools.RunScript -url jdbc:h2:/$DB_BASEDIR/auth -user sa -password $DB_PASSWORD -script init.sql
  if [ "$?" -ne "0" ]; then
    echo "2a failed"
  else
    echo "2a success"
  fi
fi
#user
java -cp $DB_LIB org.h2.tools.RunScript -url jdbc:h2:/$DB_BASEDIR/user -user sa -script init.sql
if [ "$?" -ne "0" ]; then
  echo "3 failed"
  java -cp $DB_LIB org.h2.tools.RunScript -url jdbc:h2:/$DB_BASEDIR/user -user sa -password $DB_PASSWORD -script init.sql
  if [ "$?" -ne "0" ]; then
    echo "3a failed"
  else
    echo "3a success"
  fi
fi
#cms
java -cp $DB_LIB org.h2.tools.RunScript -url jdbc:h2:/$DB_BASEDIR/cms -user sa -script init.sql
if [ "$?" -ne "0" ]; then
  echo "4 failed"
  java -cp $DB_LIB org.h2.tools.RunScript -url jdbc:h2:/$DB_BASEDIR/cms -user sa -password $DB_PASSWORD -script init.sql
  if [ "$?" -ne "0" ]; then
    echo "4a failed"
  else
    echo "4a success"
  fi
fi
#shortener
java -cp $DB_LIB org.h2.tools.RunScript -url jdbc:h2:/$DB_BASEDIR/shortener -user sa -script init.sql
if [ "$?" -ne "0" ]; then
  echo "5 failed"
  java -cp $DB_LIB org.h2.tools.RunScript -url jdbc:h2:/$DB_BASEDIR/shortener -user sa -password $DB_PASSWORD -script init.sql
  if [ "$?" -ne "0" ]; then
    echo "5a failed"
  else
    echo "5a success"
  fi
fi

java -server -Xms500m -Xmx4g -XX:+UseParallelGC -cp $DB_LIB org.h2.tools.Server -tcp -tcpPassword $DB_SHUTDOWN_PASSWORD -tcpAllowOthers -baseDir $DB_BASEDIR
