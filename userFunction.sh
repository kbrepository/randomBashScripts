#!/bin/bash
## Bash function that transforms "Hello, world" into "Hello, [USER]", where [USER] is your system username.
hello_user() {
    local user_name=$(whoami)
    echo "Hello, ${user_name}"
}
## function call
hello_user