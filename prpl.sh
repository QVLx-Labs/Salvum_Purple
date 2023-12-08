#!/bin/bash
#$t@$h
output_in_memory=""

run_command() {
    output_in_memory=$("$@" 2>&1)
    echo "$output_in_memory"
}

parse_output() {
    local token=$1
    local parsed_line
    parsed_line=$(grep "$token" <<< "$output_in_memory")
    local IFS=' '
    read -ra parsed_array <<< "$parsed_line"
}

get_token() {
    local index=$1
    echo "${parsed_array[$index]}"
}

write_output() {
    local file="prpl.txt"
    echo "$output_in_memory" > "$file"
}

case $1 in
    run)
        run_command "${@:2}"
        ;;
    parse)
        parse_output "${@:2}"
        ;;
    get)
        get_token "${@:2}"
        ;;
    write)
        write_output
        ;;
    *)
        echo "Invalid command"
        exit 1
        ;;
esac
