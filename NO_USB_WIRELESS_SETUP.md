# Wireless Debugging WITHOUT USB Cable

## Requirements
- Android 11 or higher
- Phone and PC on the **same Wi-Fi network**

## 🚀 Quick Setup (3 Steps)

### Step 1: Enable Wireless Debugging on Your Phone

1. **Settings** → **About phone** → Tap **Build number** 7 times
2. **Settings** → **System** → **Developer options**
3. Enable **Wireless debugging**
4. Tap on **Wireless debugging** to open it

### Step 2: Pair Your Device (One-time Setup)

**On Your Phone:**
1. Inside **Wireless debugging**, tap **"Pair device with pairing code"**
2. You'll see a popup with:
   - 🔢 **6-digit pairing code** (e.g., 123456)
   - 📍 **IP address:Port** (e.g., 192.168.1.5:41453)

**On Your PC (in PowerShell):**
```powershell
.\wireless-debug-setup.ps1 -Pair -PairingIP '192.168.1.5:41453' -PairingCode '123456'
```
*(Replace with YOUR actual IP, port, and code!)*

You should see: **"Successfully paired to..."**

### Step 3: Connect to Device

**On Your Phone:**
1. Go BACK to the main **Wireless debugging** screen (not the pairing popup)
2. You'll see **IP address & Port** at the top (may be a DIFFERENT port!)
   - Example: `192.168.1.5:37471`

**On Your PC:**
```powershell
.\wireless-debug-setup.ps1 -Connect -DeviceIP '192.168.1.5:37471'
```
*(Use the IP:port from the MAIN wireless debugging screen)*

### Step 4: Run Your App! 🎉

```powershell
flutter run
```

---

## 📱 Visual Guide

```
Phone Settings Path:
Settings 
  └── About phone
       └── [Tap "Build number" 7 times]
  
  └── System
       └── Developer options
            └── Wireless debugging [ENABLE]
                 └── [Tap to open]
                      ├── IP address & Port: 192.168.1.5:37471  ← Use for CONNECT
                      └── Pair device with pairing code [Tap]
                           └── Pairing code: 123456               ← Use for PAIR
                           └── IP address: 192.168.1.5:41453     ← Use for PAIR
```

---

## ⚠️ Important Notes

1. **Two Different Ports**: The pairing screen shows ONE port, the main screen shows ANOTHER
   - Use pairing port for `adb pair`
   - Use main screen port for `adb connect`

2. **Same Wi-Fi Network**: Your phone and PC MUST be on the same Wi-Fi network

3. **Pairing Timer**: The pairing code expires after ~60 seconds. If it expires, tap "Pair device" again

4. **One-Time Pairing**: You only need to pair once. After that, just use the Connect step

---

## 🔧 Troubleshooting

### "Failed to pair"
- ✅ Check both devices on same Wi-Fi
- ✅ Enter pairing code quickly (it expires!)
- ✅ Make sure you used the correct IP:port from the PAIRING popup
- ✅ Check Windows Firewall isn't blocking ADB

### "Connection refused"
- ✅ Make sure you used the IP:port from MAIN wireless debugging screen (not pairing)
- ✅ Restart wireless debugging on phone
- ✅ Try: `adb kill-server` then `adb start-server`

### Device not showing in `flutter run`
```powershell
# Check if device is connected
adb devices

# Should show something like:
# 192.168.1.5:37471    device
```

---

## 🎯 Quick Commands Reference

```powershell
# Check connection status
adb devices

# Disconnect
adb disconnect

# Kill and restart ADB
adb kill-server
adb start-server

# Run Flutter app
flutter run

# Run with device selection
flutter devices
flutter run -d <device-id>
```

---

## 🔒 Security Note

Wireless debugging is only active when enabled in Developer Options. Turn it off when not developing for security.

---

## Why This Works Without USB

Android 11+ has **native wireless debugging** built-in. The old method required USB to switch ADB into TCP/IP mode, but now you can pair directly over Wi-Fi using the pairing code system!

Happy wireless coding! 🚀📱
