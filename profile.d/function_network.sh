# Get IP adress on ethernet
function my_ip() {
	MY_IP=$(ifconfig eth0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
	echo ${MY_IP:-"Not connected"}
}

# Get IP from hostname
hostname2ip() {
	ping -c 1 "$1" | egrep -m1 -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
}
