FROM sudarsha/docker-vpnrdpweb:latest
MAINTAINER Sudarsha Hewa <sudarsha@gamil.com>

RUN echo "Setting up Oracle JDK8 ..." \
	&& curl \
                -LO --insecure --junk-session-cookies --location \
		--remote-name \
		--header "Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.rpm \
	&& dnf localinstall -y jdk-8u171-linux-x64.rpm \
	&& dnf clean all \
	&& rm -f jdk-8u171-linux-x64.rpm \
 	&& echo 'export JAVA_HOME=/usr/java/latest' > /etc/profile.d/jdksetup.sh \
 	&& chmod +x /etc/profile.d/jdksetup.sh \
 	&& echo "Setting up maven ..." \
 	&& mkdir -p /opt/maven \
 	&& cd /opt/maven \
 	&& curl -LO --silent http://apache.mirror.rafal.ca/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz \
 	&& tar zxf apache-maven-3.5.4-bin.tar.gz \
 	&& ln -sf apache-maven-3.5.4 latest \
 	&& rm -f apache-maven-3.5.4-bin.tar.gz \
 	&& echo 'M2_HOME=/opt/maven/latest' > /etc/profile.d/mvnsetup.sh \
 	&& echo 'MAVEN_OPtS="-Xms1g -Xmx2g"' >> /etc/profile.d/mvnsetup.sh \
 	&& echo 'PATH=$PATH:$M2_HOME/bin' >> /etc/profile.d/mvnsetup.sh \
 	&& chmod +x /etc/profile.d/mvnsetup.sh \
 	&& mkdir -p /opt/tomcat \
 	&& echo "Setting up tomcat ..." \
 	&& cd /opt/tomcat \
 	&& curl -LO --silent http://apache.mirror.globo.tech/tomcat/tomcat-8/v8.5.32/bin/apache-tomcat-8.5.32.tar.gz \
 	&& tar zxf apache-tomcat-8.5.32.tar.gz \
 	&& ln -sf apache-tomcat-8.5.32 latest \
 	&& rm -f apache-tomcat-8.5.32.tar.gz \
 	&& echo "org.apache.catalina.webresources.Cache.level=SEVERE" >> /opt/tomcat/latest/conf/logging.properties \
  	&& echo "Setting up intellij ..." \
  	&& mkdir -p /opt/intellij \
  	&& cd /opt/intellij \
  	&& curl -LO --silent https://download.jetbrains.com/idea/ideaIU-2018.1.6-no-jdk.tar.gz \
  	&& mkdir /opt/intellij/ideaUI-2018.1 \
  	&& tar zxf ideaIU-2018.1.6-no-jdk.tar.gz --strip-components=1 -C /opt/intellij/ideaUI-2018.1 \
  	&& ln -sf /opt/intellij/ideaUI-2018.1 latest \
  	&& ln -sf /opt/intellij/latest/bin/idea.sh /usr/bin/idea.sh \
  	&& rm -f ideaIU-2018.1.6-no-jdk.tar.gz
