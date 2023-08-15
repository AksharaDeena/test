#!/bin/bash
command_to_run="$*"

# Temporary file to capture stdout
temp_stdout=$(mktemp)

# Run the command in the background, redirecting stdout to the temp file and to the terminal
$command_to_run > >(tee "$temp_stdout") &
command_pid=$!

# Trap termination signal to cleanup
trap "rm $temp_stdout; exit" SIGTERM

# Set the timeout duration in seconds
timeout_duration=50 # 1800 # 30 minutes

# Get the current timestamp
start_time=$(date +%s)

# Function to check if the process is still running
function is_process_running {
    ps -p $1 >/dev/null
}

# Function to get the last modification time of the stdout file
function get_stdout_last_modified {
    stat -c %Y "$temp_stdout" # for linux
    #stat -f %m "$temp_stdout" # for macos
}

# Loop to periodically check for stdout inactivity and process status
while is_process_running $command_pid; do
    # Get the elapsed time
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))

    # Check if the process has been running for more than the timeout duration
    if [ $elapsed_time -ge $timeout_duration ]; then
        echo "Process timed out after 1 minute of no stdout activity."
        kill $command_pid # Terminate the main process
        break
    fi

    # Check if the stdout file was modified within the last second
    last_modified=$(get_stdout_last_modified)
    if [ $((current_time - last_modified)) -le 1 ]; then
        # stdout has been modified recently, reset the timer
        start_time=$(date +%s)
    fi

    sleep 1
done

# Cleanup
rm "$temp_stdout"