export AWS_AUTO_SCALING_HOME=/usr/local/as-cli/
test -x /usr/libexec/java_home && export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$PATH::/usr/local/as-cli/bin:/usr/local/ec2/bin
