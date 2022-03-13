function wait_for_window()
{
	while :
	do
		if [ "$(wmctrl -lp | grep -c $1)" -gt "0" ]; then
			break
		fi
		sleep 0.01
	done
}

function get_id()
{
	echo $(wmctrl -lp | \grep $1 | cut -d' ' -f1)
}

function wait_and_get_id()
{
	wait_for_window $1
	echo $(get_id $1)
}
