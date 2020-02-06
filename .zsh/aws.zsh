export EC2_HOME=/usr/local/ec2
export AWS_AUTO_SCALING_HOME=/usr/local/as-cli/
test -x /usr/libexec/java_home && /usr/libexec/java_home >/dev/null 2>/dev/null && export JAVA_HOME=$(/usr/libexec/java_home)
add_to_path /usr/local/as-cli/bin:/usr/local/ec2/bin

# remove warnings when using brew provided 'aws'
alias aws="env PYTHONWARNINGS=ignore aws"
