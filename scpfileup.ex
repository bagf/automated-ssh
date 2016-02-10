#!/usr/bin/expect

cd ~/

set timeout -1

send_user "Local --> Remote\n"

send_user "Local File: "
expect_user -re "(.*)\n"
set local $expect_out(1,string)
send_user "Remote File: "
expect_user -re "(.*)\n"
set remote $expect_out(1,string)

spawn sh -c "scp -o PubkeyAuthentication=no $local $::env(R_USER)@$::env(R_HOST):$remote"
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
	timeout {
		send_user "Timed Out!\n"
		exit
	} eof
}
