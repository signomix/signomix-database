#!/bin/bash

java -cp h2-1.4.200.jar org.h2.tools.RunScript -url jdbc:h2://h2data/iot -user sa -script /h2/init.sql
java -cp h2-1.4.200.jar org.h2.tools.RunScript -url jdbc:h2://h2data/data -user sa -script /h2/init.sql
java -cp h2-1.4.200.jar org.h2.tools.RunScript -url jdbc:h2://h2data/iotdata -user sa -script /h2/init.sql
java -cp h2-1.4.200.jar org.h2.tools.RunScript -url jdbc:h2://h2data/actuator -user sa -script /h2/init.sql
java -cp h2-1.4.200.jar org.h2.tools.RunScript -url jdbc:h2://h2data/auth -user sa -script /h2/init.sql
java -cp h2-1.4.200.jar org.h2.tools.RunScript -url jdbc:h2://h2data/user -user sa -script /h2/init.sql
java -cp h2-1.4.200.jar org.h2.tools.RunScript -url jdbc:h2://h2data/cms -user sa -script /h2/init.sql
java -cp h2-1.4.200.jar org.h2.tools.RunScript -url jdbc:h2://h2data/shortener -user sa -script /h2/init.sql

java -server -Xms500m -Xmx4g -XX:+UseParallelGC -cp h2-1.4.200.jar org.h2.tools.Server -tcp -tcpAllowOthers -baseDir /h2data