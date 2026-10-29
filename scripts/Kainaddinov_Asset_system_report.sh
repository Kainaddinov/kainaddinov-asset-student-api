#!/bin/bash
STUDENT_NAME="Asset Kainaddinov"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="$SCRIPT_DIR/../logs/Kainaddinov_Asset_system_report.log"
report() {
echo "=============================================="
  echo " System report"
  echo "=============================================="
  echo "Student: $STUDENT_NAME"
  echo "Date and time: $(date '+%Y-%m-%d %H:%M:%S')"
  echo "Username: $(whoami)"
  echo "Kernel: $(uname -sr)"
  if [ -f /etc/os-release ]; then
    echo "Operating system: $(. /etc/os-release && echo "$PRETTY_NAME")"
  elif command -v sw_vers >/dev/null 2>&1; then
    echo "Operating system: macOS $(sw_vers -productVersion)"
  else
    echo "Operating system: $(uname -s)"
  fi
  echo
  echo "--- CPU ---"
  if command -v lscpu >/dev/null 2>&1; then
    lscpu | grep -E "Model name|^CPU\(s\)"
  else
    echo "Model: $(sysctl -n machdep.cpu.brand_string)"
    echo "Cores: $(sysctl -n hw.ncpu)"
  fi
  echo
  echo "--- Memory ---"
  if command -v free >/dev/null 2>&1; then
    free -h
  else
    echo "Total: $(( $(sysctl -n hw.memsize) / 1024 / 1024 )) MB"
    top -l 1 | grep PhysMem
  fi
  echo
  echo "--- Disk usage ---"
  df -h /
  echo
  echo "--- Available disk space ---"
  df -h / | awk 'NR==2 {print $4 " available on " $1}'
  echo "=============================================="
}
report | tee -a "$LOG_FILE"
