#!/bin/bash

# Model calculator script (mock implementation)
# Compatible with fz framework
#
# This is a template script that demonstrates the structure of a calculator.
# Replace this with actual calls to your simulation code.

# if directory as input, cd into it
if [ -d "$1" ]; then
  cd "$1"
  # Find the first input file (not .out or .msg)
  input=$(ls | grep -v '\.out$' | grep -v '\.msg$' | grep -v '\.sh$' | head -n 1)
  if [ -z "$input" ]; then
    echo "No input file found in directory. Exiting."
    exit 1
  fi
  shift
# if $1 is a file, use it
elif [ -f "$1" ]; then
  input="$1"
  shift
else
  echo "Usage: $0 <input_file or input_directory>"
  exit 2
fi

PID_FILE=$PWD/PID
echo $$ >> $PID_FILE

# Mock calculation: extract the value from the input file and write to output
# This simulates a real calculation that produces an output file
# Replace this section with actual calls to your simulation code

echo "Running mock calculation on $input..."

# Extract variable value from input (looking for "value = X" pattern)
value=$(grep -E '^value\s*=' "$input" | sed 's/.*=\s*//' | tr -d '[:space:]')

if [ -n "$value" ]; then
    # Mock computation: just return the value (or compute something from it)
    result=$value
    echo "Input value: $value"
    echo "Result: $result"
    echo "$result" > output.txt
    echo "Calculation completed successfully."
else
    echo "Warning: No value found in input file"
    echo "" > output.txt
fi

if [ -f $PID_FILE ]; then
    rm -f $PID_FILE
fi
