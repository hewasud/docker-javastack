FROM fedora:latest
MAINTAINER Sudarsha Hewa <sudarsha@gamil.com>

RUN dnf install -y openconnect vpnc-script git \
		firefox curl dbus-x11 \
		remmina-plugins-rdp \
		mozilla-fira-mono-fonts mozilla-fira-sans-fonts mozilla-fira-fonts-common \
		adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts \
		adobe-source-han-serif-cn-fonts adobe-source-han-serif-tw-fonts \
		dejavu-fonts-common dejavu-sans-fonts dejavu-sans-mono-fonts \
		dejavu-serif-fonts eosrei-emojione-fonts fontawesome-fonts \
		fontawesome-fonts-web gdouros-symbola-fonts gnu-free-fonts-common \
		gnu-free-mono-fonts gnu-free-sans-fonts gnu-free-serif-fonts \
		monofett-fonts overpass-mono-fonts \
		oxygen-fonts-common oxygen-mono-fonts pcaro-hermit-fonts \
	&& echo "Settingg up google chorme browser ..." \
	&& curl -LO --silent https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm \
	&& dnf localinstall -y google-chrome-stable_current_x86_64.rpm \
	&& rm -f google-chrome-stable_current_x86_64.rpm \
   && echo "Setting up Oracle JDK8 ..." \
	&& curl -LO --insecure --junk-session-cookies --location \
		--remote-name --silent \
		--header "Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.rpm \
	&& dnf localinstall -y jdk-8u162-linux-x64.rpm \
	&& rm -f jdk-8u162-linux-x64.rpm \
	&& dnf clean all \
	&& echo 'JAVA_HOME=/usr/java/latest' >> /etc/environment \
	&& echo "Setting up maven ..."
	&& mkdir -p /opt/maven \
	&& cd /opt/maven \
	&& curl -LO --silent http://apache.forsale.plus/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz \
	&& tar zxf apache-maven-3.5.2-bin.tar.gz \
	&& ln -sf apache-maven-3.5.2 latest \
	&& rm -f apache-maven-3.5.2-bin.tar.gz \
	&& echo 'M2_HOME=/opt/maven/latest' >> /etc/environment \
	&& echo 'PATH=$PATH:$M2_HOME/bin' >> /etc/environment \
	&& mkdir -p /opt/tomcat \
	&& echo "Setting up tomcat ..."
	&& cd /opt/tomcat \
	&& curl -LO --silent http://mirror.csclub.uwaterloo.ca/apache/tomcat/tomcat-8/v8.5.28/bin/apache-tomcat-8.5.28.tar.gz \
	&& tar zxf apache-tomcat-8.5.28.tar.gz \
	&& ln -sf apache-tomcat-8.5.28 latest \
	&& rm -f apache-tomcat-8.5.28.tar.gz \
	&& echo "org.apache.catalina.webresources.Cache.level=SEVERE" >> /opt/tomcat/latest/conf/logging.properties \
	&& echo "Setting up intellij ..."
	&& mkdir -p /opt/intellij \
	&& cd /opt/intellij \
	&& curl -LO --silent https://download.jetbrains.com/idea/ideaIU-2017.3.4-no-jdk.tar.gz \
	&& tar zxf ideaIU-2017.3.4-no-jdk.tar.gz \
	&& ln -sf idea-IU-173.4548.28 latest \
	&& ln -sf /opt/intellij/latest/bin/idea.sh /usr/bin/idea.sh 
