#!/bin/bash
# ==========================================
# check_unsigned_processes.sh
# Lists only unsigned or suspicious processes
# ==========================================

echo "Scanning for unsigned or invalidly signed processes..."
echo "--------------------------------------------------------"

for pid in $(ps -axo pid=); do
  path=$(ps -p "$pid" -o comm= 2>/dev/null)
  # Ensure path exists and is a file
  if [ -n "$path" ] && [ -f "$path" ]; then
    codesign -v "$path" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "Unsigned or invalid: PID $pid ($path)"
    fi
  fi
done

echo "Scan complete."
