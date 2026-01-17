#!/bin/bash

# Monitor configurations
MON1=1
MON1_INPUT1=0x1b
MON1_INPUT2=0x11

MON2=2
MON2_INPUT1=0x0f
MON2_INPUT2=0x05

# Function to get current input
get_current_input() {
    local mon=$1
    ddcutil --display $mon getvcp 60 | grep -oP 'sl=\K0x[0-9A-Fa-f]+' | tr '[:upper:]' '[:lower:]'
}

# Function to switch monitor input
switch_monitor() {
    local mon=$1
    local input1=$2
    local input2=$3
    
    local current=$(get_current_input $mon)
    echo "Monitor $mon current input: $current"
    
    local next
    if [ "$current" = "$input1" ]; then
        next=$input2
    else
        next=$input1
    fi
    
    echo "Monitor $mon switching to: $next"
    ddcutil --display $mon setvcp 60 $next
}

# Function to set specific input
set_input() {
    local mon=$1
    local input=$2
    
    echo "Monitor $mon setting to: $input"
    ddcutil --display $mon setvcp 60 $input
}

# Parse arguments
case "$1" in
    "monitor1"|"1")
        switch_monitor $MON1 $MON1_INPUT1 $MON1_INPUT2
        ;;
    "monitor2"|"2")
        switch_monitor $MON2 $MON2_INPUT1 $MON2_INPUT2
        ;;
    "sync-both"|"sync")
        # Get current input of monitor1 and set both to their respective inputs
        local current=$(get_current_input $MON1)
        local next1
        local next2
        
        if [ "$current" = "$MON1_INPUT1" ]; then
            next1=$MON1_INPUT2
            next2=$MON2_INPUT2
        else
            next1=$MON1_INPUT1
            next2=$MON2_INPUT1
        fi
        
        echo "Syncing both monitors to their respective inputs"
        echo "Monitor1 setting to: $next1"
        echo "Monitor2 setting to: $next2"
        set_input $MON1 $next1
        set_input $MON2 $next2
        ;;
    "set-monitor1")
        if [ -z "$2" ]; then
            echo "Usage: $0 set-monitor1 <input>"
            echo "Available inputs for monitor1: $MON1_INPUT1, $MON1_INPUT2"
            exit 1
        fi
        set_input $MON1 "$2"
        ;;
    "set-monitor2")
        if [ -z "$2" ]; then
            echo "Usage: $0 set-monitor2 <input>"
            echo "Available inputs for monitor2: $MON2_INPUT1, $MON2_INPUT2"
            exit 1
        fi
        set_input $MON2 "$2"
        ;;
    *)
        echo "Usage: $0 <command>"
        echo "Commands:"
        echo "  monitor1|1        - Toggle monitor1 input"
        echo "  monitor2|2        - Toggle monitor2 input"
        echo "  sync-both|sync     - Sync both monitors to their respective inputs"
        echo "  set-monitor1 <input> - Set monitor1 to specific input"
        echo "  set-monitor2 <input> - Set monitor2 to specific input"
        echo ""
        echo "Monitor1 inputs: $MON1_INPUT1, $MON1_INPUT2"
        echo "Monitor2 inputs: $MON2_INPUT1, $MON2_INPUT2"
        exit 1
        ;;
esac