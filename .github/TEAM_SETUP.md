# Team Development Guide

## 🚀 Required Setup for Team Members

### 1. Apple Developer Account
- Must be added to Apple Developer Team: **66VPE47DN4**
- Contact team lead to add your Apple ID to the team

### 2. GitHub Repository Secrets
Each team member needs these secrets configured in their fork or the main repo needs shared secrets:

```
FIREBASE_ANDROID_APP_ID=1:YOUR_PROJECT_NUMBER:android:YOUR_APP_ID
FIREBASE_IOS_APP_ID=1:YOUR_PROJECT_NUMBER:ios:YOUR_APP_ID  
FIREBASE_CLI_TOKEN=YOUR_CLI_TOKEN
IOS_P12_BASE64=BASE64_ENCODED_CERTIFICATE
IOS_P12_PASSWORD=CERTIFICATE_PASSWORD
IOS_PROVISIONING_PROFILE=BASE64_ENCODED_PROFILE
KEYCHAIN_PASSWORD=ANY_SECURE_PASSWORD
```

### 3. Firebase Project Access
- Must be added to Firebase project
- Contact admin for Firebase project access

### 4. iOS Development Setup
- Xcode installed with command line tools
- Apple Developer account configured in Xcode
- Device registered in Apple Developer portal (for testing)

## 🔧 Testing the Workflow

### Before pushing code:
1. **Check Apple Developer access**: Can you see team 66VPE47DN4 in Xcode?
2. **Verify Firebase access**: Can you access the Firebase console?
3. **Test local iOS build**: Does `flutter build ipa --export-options-plist=ios/ExportOptions.plist` work?

### If workflow fails:
1. **Check secrets**: Are all GitHub secrets properly configured?
2. **Verify certificates**: Are your certificates valid and not expired?
3. **Check team membership**: Are you part of the Apple Developer team?

## 🚨 Common Issues

| Error | Likely Cause | Solution |
|-------|--------------|----------|
| "No signing certificate found" | Not in Apple Developer team | Add to team 66VPE47DN4 |
| "Provisioning profile invalid" | Profile doesn't include your device | Update profile or add device |
| "Firebase distribution failed" | No Firebase access | Add to Firebase project |
| "Certificate expired" | Old certificate | Update IOS_P12_BASE64 secret |

## 📞 Need Help?
Contact the team lead to:
- Add you to Apple Developer team
- Add you to Firebase project  
- Share the latest certificates/profiles
