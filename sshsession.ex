#!/usr/bin/expect

cd ~/

set timeout -1

spawn /usr/bin/ssh -o PubkeyAuthentication=no -o ConnectTimeout=120 -p $::env(R_PORT) $::env(R_USER)@$::env(R_HOST) 
expect {
	-nocase "password" {
		send -- "$::env(R_PASS)\r"
		exp_continue
	}
	-nocase "are you sure you want to continue connecting (yes/no)?" {
		send -- "yes\r"
		exp_continue
	}
	-nocase "permission denied, please try again." { 
		send_user "Password failed\n"
		exit
	}
	-nocase "verification code" {
		stty -echo
		expect_user -re "(.*)\n"
		stty echo
		set R_VERI $expect_out(1,string)
		send -- "$R_VERI\r"
		exp_continue
	}
	":~" {
		interact
	}
	timeout {
		send_user "Timed Out!\n"
		exit
	} eof
}
