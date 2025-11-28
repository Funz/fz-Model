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

# Mock calculation: extract values from the input file and compute a result
# This simulates a real calculation that produces an output file
# Replace this section with actual calls to your simulation code

echo "Running mock calculation on $input..."

# Extract variable values from input (looking for "var = X" pattern)
x=$(grep -E '^x\s*=' "$input" | sed 's/.*=\s*//' | tr -d '[:space:]')
y=$(grep -E '^y\s*=' "$input" | sed 's/.*=\s*//' | tr -d '[:space:]')
z=$(grep -E '^z\s*=' "$input" | sed 's/.*=\s*//' | tr -d '[:space:]')

# Fallback to 'value' for backwards compatibility
if [ -z "$x" ]; then
    x=$(grep -E '^value\s*=' "$input" | sed 's/.*=\s*//' | tr -d '[:space:]')
fi

if [ -n "$x" ]; then
    # Mock computation: compute result = x + y + z (or just x if y,z not present)
    # Using awk for floating point arithmetic
    result=$(awk "BEGIN {
        x = ${x:-0}
        y = ${y:-0}
        z = ${z:-0}
        print x + y + z
    }")
    echo "Input values: x=$x, y=${y:-0}, z=${z:-0}"
    echo "Result: $result"
    echo "$result" > output.txt
    echo "Calculation completed successfully."
else
    echo "Warning: No value found in input file"
    echo "" > output.txt
fi

if [ -f "$PID_FILE" ]; then
    rm -f "$PID_FILE"
fi
