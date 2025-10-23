#!/bin/bash
set -e

# ===========================
# 🌈  MÀU SẮC VÀ HIỆU ỨNG
# ===========================
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
MAGENTA="\033[1;35m"
CYAN="\033[1;36m"
RESET="\033[0m"
BOLD="\033[1m"

# ===========================
# 🚀  LOGO VÀ MỞ ĐẦU
# ===========================
clear
echo -e "${MAGENTA}"
echo "╔════════════════════════════════════════════════════╗"
echo "║         🚀  Galaxy A52s 5G ROM SYNC SCRIPT by anhdat1024     ║"
echo "║                  (Fast, Clean, Beautiful Clone)          ║"
echo "╚════════════════════════════════════════════════════╝"
echo -e "${RESET}"
sleep 1

# ===========================
# 📦  DANH SÁCH REPO
# ===========================
repos=(
  "https://github.com/anhdat1024/android_device_samsung_a52sxq.git device/samsung/a52sxq"
  "https://github.com/anhdat1024/android_device_samsung_sm7325-common.git device/samsung/sm7325-common"
  "https://github.com/anhdat1024/android_vendor_samsung_a52sxq.git vendor/samsung/a52sxq"
  "https://github.com/anhdat1024/android_vendor_samsung_sm7325-common.git vendor/samsung/sm7325-common"
  "https://github.com/anhdat1024/android_kernel_samsung_sm7325.git kernel/samsung/sm7325"
  "https://github.com/anhdat1024/android_hardware_dolby.git hardware/dolby"
  "https://github.com/anhdat1024/hardware_samsung-extra_interfaces.git -b 16.0 hardware/samsung-ext/interfaces"
  "https://github.com/anhdat1024/android_vendor_bcr.git vendor/bcr"
)

# ===========================
# 🔁  CLONE CÁC REPO
# ===========================
echo -e "${CYAN}${BOLD}==> Cloning device & vendor trees...${RESET}"
for entry in "${repos[@]}"; do
  set -- $entry
  url=$1
  shift
  dir=$@
  
  echo -e "\n${YELLOW}📂 Đang xử lý: ${BOLD}$dir${RESET}"
  [ -d "$dir" ] && rm -rf "$dir"

  if [[ "$dir" == "kernel/samsung/sm7325" ]]; then
    echo -e "${BLUE}→ Cloning kernel (shallow, depth=1)...${RESET}"
    git clone --depth=1 $url $dir
  else
    echo -e "${BLUE}→ Cloning full repo...${RESET}"
    git clone $url $dir
  fi

  echo -e "${GREEN}✔ Hoàn tất: ${dir}${RESET}"
done

# ===========================
# 🔧  CLONE HARDWARE LINEAGE
# ===========================
echo -e "\n${CYAN}${BOLD}==> Cloning LineageOS hardware/samsung...${RESET}"
[ -d hardware/samsung ] && rm -rf hardware/samsung
git clone https://github.com/LineageOS/android_hardware_samsung.git -b lineage-23.0 hardware/samsung
echo -e "${GREEN}✔ Đã thay thế hardware/samsung${RESET}"

# ===========================
# 🌀  REPO SYNC
# ===========================
echo -e "\n${CYAN}${BOLD}==> Syncing repo sources...${RESET}"
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync --no-tags -j$(nproc --all)
echo -e "${GREEN}✔ Repo sync hoàn tất${RESET}"

# ===========================
# 🎉  KẾT THÚC
# ===========================
echo -e "\n${MAGENTA}${BOLD}╔════════════════════════════════════╗"
echo -e "║     ✅  TẤT CẢ REPO ĐÃ SẴN SÀNG!    ║"
echo -e "╚════════════════════════════════════╝${RESET}"
echo -e "${BLUE}Build nào cũng smooth như kernel của bạn 😎${RESET}"
