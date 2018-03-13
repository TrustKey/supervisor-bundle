FROM ubuntu:16.04

RUN apt-get update && \
	apt-get install -y ntp npm mongodb curl && \ 
	curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
	apt-get install -y nodejs

#Set MongoDB database path to /storage/db
RUN sed -i 's/\(^dbpath=\).*/\1\/storage\/db/' /etc/mongodb.conf

WORKDIR "/app"

COPY supervisor /app
RUN  npm install

#Copy not yet published in npm modules and install dependencies recuresively 
COPY modules /app/modules
RUN  cd modules && find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && npm install" \;

COPY entrypoint.sh /app
COPY config.js /app
COPY mongodb.conf /etc/mongodb.conf
COPY ntp.conf /etc/ntp.conf
RUN  chmod +x /app/entrypoint.sh

CMD  ["/app/entrypoint.sh"]

#http-server module
EXPOSE 3000
#MongoDB
EXPOSE 27017