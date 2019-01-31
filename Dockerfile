FROM nginx:latest

ENV WORKSPACE src/workspace
ENV PATH /root/bin/Sencha/Cmd:$PATH
ENV PATH /usr/local/Sencha/Test/2_2_1_83/stc:$PATH


RUN mkdir -p /usr/share/man/man1

RUN apt-get update -y && apt-get install -y \
    unzip \
    nodejs \
    nodejs-legacy \
    openjdk-8-jre \
    wget \
    nginx 
    
WORKDIR /tmp



# Download and install Sencha Cmd
RUN wget https://cdn.sencha.com/cmd/6.6.0.13/no-jre/SenchaCmd-6.6.0.13-linux-amd64.sh.zip \
    && unzip SenchaCmd-6.6.0.13-linux-amd64.sh.zip \
    && ./SenchaCmd-6.6.0.13-linux-amd64.sh -q
 
# Install Sencha Test
COPY docker/SenchaTest-2.2.1-linux-x64-no-jre.sh .
RUN ./SenchaTest-2.2.1-linux-x64-no-jre.sh -q
RUN rm SenchaTest-2.2.1-linux-x64-no-jre.sh
