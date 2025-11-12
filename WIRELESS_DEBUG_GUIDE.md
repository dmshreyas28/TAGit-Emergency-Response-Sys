# Wireless Debugging Setup Guide for TAGit App

This guide will help you set up wireless debugging for your Flutter Android app, allowing you to develop without keeping your device plugged in via USB.

## Prerequisites

- Android device running Android 11 or higher (for easiest setup)
- Device and computer on the same Wi-Fi network
- USB cable (for initial setup only)

## Quick Setup

### Method 1: Using the PowerShell Script (Easiest)

1. **Connect your device via USB** and ensure USB debugging is enabled

2. **Run the setup script:**
   ```powershell
   .\wireless-debug-setup.ps1 -Connect
   ```

3. **Get your device's IP address** (see below) and connect:
   ```powershell
   .\wireless-debug-setup.ps1 -Connect -DeviceIP '192.168.1.XXX'
   ```

4. **Disconnect USB cable** - you're now connected wirelessly!

5. **Run your Flutter app:**
   ```powershell
   flutter run
   ```

---

### Method 2: Manual Setup

#### Step 1: Enable Developer Options on Your Device

1. Go to **Settings** → **About phone**
2. Tap **Build number** 7 times
3. Enter your PIN/password if prompted
4. You'll see "You are now a developer!"

#### Step 2: Enable USB and Wireless Debugging

1. Go to **Settings** → **System** → **Developer options**
2. Enable **USB debugging**
3. Enable **Wireless debugging** (Android 11+)

#### Step 3: Connect via USB and Enable TCP/IP Mode

1. Connect your device via USB cable
2. Open PowerShell in the project directory
3. Run:
   ```powershell
   $env:Path += ";C:\Users\SHREYAS\AppData\Local\Android\sdk\platform-tools"
   adb devices
   ```
4. Accept the debugging prompt on your device if it appears
5. Run:
   ```powershell
   adb tcpip 5555
   ```

#### Step 4: Find Your Device's IP Address

**Option A: From Wireless Debugging (Android 11+)**
- Settings → Developer options → Wireless debugging → IP address & Port

**Option B: From Wi-Fi Settings**
- Settings → Wi-Fi → Tap on connected network → Look for IP address

**Option C: Using ADB**
```powershell
adb shell ip -f inet addr show wlan0
```

#### Step 5: Connect Wirelessly

Replace `192.168.1.XXX` with your actual device IP:

```powershell
adb connect 192.168.1.XXX:5555
```

You should see: `connected to 192.168.1.XXX:5555`

#### Step 6: Verify Connection

```powershell
adb devices
```

You should see your device listed with its IP address.

#### Step 7: Disconnect USB Cable

You can now unplug the USB cable! Your device will remain connected wirelessly.

---

## Running Your Flutter App

Once connected wirelessly, run your app as usual:

```powershell
flutter run
```

Or to hot reload while running:
- Press `r` for hot reload
- Press `R` for hot restart
- Press `q` to quit

---

## Troubleshooting

### Device Not Showing Up

1. **Check both devices are on the same Wi-Fi network**
   - Device and computer must be on the same network
   - Some networks isolate devices (check router settings)

2. **Restart ADB:**
   ```powershell
   adb kill-server
   adb start-server
   ```

3. **Check firewall settings:**
   - Windows Firewall might be blocking ADB
   - Add an exception for adb.exe

### Connection Drops Frequently

1. **Keep Wi-Fi from sleeping:**
   - Settings → Wi-Fi → Advanced → Keep Wi-Fi on during sleep → Always

2. **Disable battery optimization for Developer Options:**
   - Settings → Apps → Developer options → Battery → Don't optimize

3. **Use a static IP** for your device in router settings

### Can't Find IP Address

Use this command while connected via USB:
```powershell
adb shell ip -f inet addr show wlan0
```

Or install a network info app from Play Store.

---

## Useful Commands

### Connection Management
```powershell
# Add ADB to PATH (run this first in new PowerShell windows)
$env:Path += ";C:\Users\SHREYAS\AppData\Local\Android\sdk\platform-tools"

# List connected devices
adb devices

# Enable TCP/IP mode (while connected via USB)
adb tcpip 5555

# Connect to device wirelessly
adb connect 192.168.1.XXX:5555

# Disconnect specific device
adb disconnect 192.168.1.XXX:5555

# Disconnect all devices
adb disconnect

# Kill and restart ADB
adb kill-server
adb start-server
```

### Flutter Commands
```powershell
# Run app
flutter run

# Run with verbose output
flutter run -v

# Run on specific device
flutter run -d <device-id>

# List all connected devices
flutter devices

# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

---

## Adding ADB to PATH Permanently (Optional)

To avoid typing the PATH command each time:

1. Press `Win + X` and select "System"
2. Click "Advanced system settings"
3. Click "Environment Variables"
4. Under "User variables", find "Path" and click "Edit"
5. Click "New" and add:
   ```
   C:\Users\SHREYAS\AppData\Local\Android\sdk\platform-tools
   ```
6. Click "OK" on all dialogs
7. Restart PowerShell

---

## Android 10 and Below (Pairing Method)

For older Android versions without native wireless debugging:

1. Install **Wireless ADB** app from Play Store
2. Connect via USB and enable TCP/IP mode: `adb tcpip 5555`
3. Use the app to get your IP address
4. Connect: `adb connect <IP>:5555`

---

## Tips for Better Experience

1. **Use a static IP:** Configure your router to always assign the same IP to your device
2. **Save connection script:** Create a batch file with your device IP for quick reconnection
3. **Multiple devices:** You can connect multiple devices wirelessly simultaneously
4. **Network quality:** Use 5GHz Wi-Fi for better performance and stability

---

## Security Note

Wireless debugging opens a port on your device that can be accessed by anyone on your network. Only use on trusted networks and disable wireless debugging when not in use.

---

## Next Steps

After setting up wireless debugging, you can:

1. Test your TAGit app's NFC functionality
2. Debug location services
3. Test Firebase integration
4. Work on the UI while moving around freely

Happy coding! 🚀
