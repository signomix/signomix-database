FROM azul/zulu-openjdk-alpine:13

WORKDIR /h2
ADD https://search.maven.org/remotecontent?filepath=com/h2database/h2/1.4.200/h2-1.4.200.jar /h2/h2-1.4.200.jar
RUN mkdir /h2data
VOLUME /h2data
EXPOSE 9092
ADD init.sql /h2/init.sql
ADD start.sh /h2/start.sh
CMD ["sh", "/h2/start.sh"]