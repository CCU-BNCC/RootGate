#!/data/data/com.termux/files/usr/bin/bash

# ===============================
# Author: Made in MD Abdullah
# Script Name: LockShield v1.0
# Protected Access: HRX-BOSS
# ===============================

# 🔐 Login Lock
echo "🛡️ Welcome to LockShield - Secure Access Required"
read -p "👤 Username: " input_user
read -sp "🔑 Password: " input_pass
echo ""

# ✅ Validation
if [[ "$input_user" == "HRX-BOSS" && "$input_pass" == "hunter1880" ]]; then
  echo "✅ Access Granted. Welcome, $input_user!"
else
  echo "❌ Access Denied! Unauthorized user."
  exit 1
fi

# Start SecureCheck
log_file="lockshield_report_$(date +%F_%H-%M).log"

echo "🔒 [SecureCheck] শুরু হলো..." | tee -a "$log_file"

# System Info
echo -e "\n📟 সিস্টেম ইনফো:" | tee -a "$log_file"
uname -a | tee -a "$log_file"
uptime | tee -a "$log_file"

# Installed packages
echo -e "\n📦 ইনস্টলড প্যাকেজ লিস্ট:" | tee -a "$log_file"
pkg list-installed | tee -a "$log_file"

# Running processes
echo -e "\n🧪 চলমান প্রসেস:" | tee -a "$log_file"
ps -aux | tee -a "$log_file"

# Open Ports
echo -e "\n🌐 খোলা পোর্ট (127.0.0.1):" | tee -a "$log_file"
netstat -tnlp 2>/dev/null | tee -a "$log_file"

# Cron-like jobs
echo -e "\n📆 Cron-like কাজ:" | tee -a "$log_file"
[ -d "$HOME/.termux/tasker" ] && ls -l "$HOME/.termux/tasker" | tee -a "$log_file" || echo "❌ Cron system পাওয়া যায়নি।" | tee -a "$log_file"

# Suspicious scripts
echo -e "\n🔍 সন্দেহজনক স্ক্রিপ্ট (শেষ ২ দিনে):" | tee -a "$log_file"
find $HOME -type f \( -name "*.sh" -o -name "*.py" \) -mtime -2 2>/dev/null | tee -a "$log_file"

# bashrc / profile check
echo -e "\n🕵️‍♂️ .bashrc / .profile দেখানো হচ্ছে:" | tee -a "$log_file"
cat $HOME/.bashrc 2>/dev/null | tee -a "$log_file"
cat $HOME/.profile 2>/dev/null | tee -a "$log_file"

# Package Update
echo -e "\n🔄 Termux প্যাকেজ আপডেট হচ্ছে..." | tee -a "$log_file"
pkg update -y && pkg upgrade -y >> "$log_file" 2>&1

# Storage check
echo -e "\n📂 স্টোরেজ অবস্থা:" | tee -a "$log_file"
termux-setup-storage
du -sh $HOME/* | tee -a "$log_file"

# Done
echo -e "\n✅ LockShield সম্পন্ন ✅ রিপোর্ট: $log_file" | tee -a "$log_file"
