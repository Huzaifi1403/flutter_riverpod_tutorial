# Flutter CI/CD Workflows

## ⚠️ Critical Files - DO NOT CHANGE

**To keep CI/CD working, these files and settings must remain unchanged:**

### 🚨 Never Change These:

#### **GitHub Secrets (Repository Level)**
```
FIREBASE_ANDROID_APP_ID
FIREBASE_IOS_APP_ID  
FIREBASE_CLI_TOKEN
IOS_P12_BASE64
IOS_P12_PASSWORD
IOS_PROVISIONING_PROFILE
KEYCHAIN_PASSWORD
```

#### **App Identity Configuration**
```yaml
# Apple Developer Team ID (in workflows)
teamID: 66VPE47DN4

# Bundle Identifiers
iOS: com.example.flutterRiverpodTutorial1
Android: com.example.flutter_riverpod_tutorial
```

#### **Critical Files**
```
ios/Runner/GoogleService-Info.plist     # Firebase iOS config
android/app/google-services.json        # Firebase Android config
ios/Runner.xcodeproj/project.pbxproj    # iOS bundle ID & signing
android/app/build.gradle                # Android bundle ID
ios/ExportOptions.plist                 # iOS export configuration (CI/CD overwrites this)
```

### ✅ Safe to Change:
- 📱 App code in `lib/`
- 🎨 Assets, images, fonts
- 📦 Dependencies in `pubspec.yaml`
- 🔢 Version numbers
- 📝 App name and description
- 🛠️ Build configurations (gradle versions, etc.)

### 🔍 Before Merging PRs:
```bash
# Check if critical files were modified
git diff main..feature-branch ios/Runner.xcodeproj/project.pbxproj | grep PRODUCT_BUNDLE_IDENTIFIER
git diff main..feature-branch android/app/build.gradle | grep applicationId
git diff main..feature-branch ios/Runner/GoogleService-Info.plist
git diff main..feature-branch android/app/google-services.json
```

**Rule: If it's related to app identity, signing, or Firebase config - don't change it!**

---

This project has two separate workflows for different stages of development:

## 📱 Test Phase Workflow (`test_phase.yml`)
**Triggers**: Push to `main` for testflight & beta or `develop` branches  
**Purpose**: Quick testing and Firebase distribution for internal testing

### What it does:
- ✅ Builds Android APK and distributes via Firebase App Distribution
- ✅ Builds iOS IPA (development signed) and distributes via Firebase App Distribution
- ✅ Fast feedback for development team

### Required Secrets (Already configured):
- `FIREBASE_ANDROID_APP_ID`
- `FIREBASE_IOS_APP_ID` 
- `FIREBASE_CLI_TOKEN`
- `IOS_P12_BASE64` (Development certificate)
- `IOS_P12_PASSWORD`
- `IOS_PROVISIONING_PROFILE` (Development profile)
- `KEYCHAIN_PASSWORD`

---

## 🚀 Production Release Workflow (`release.yml`)
**Triggers**: Git tags (v1.0.0, v2.1.3, etc.) or manual dispatch  
**Purpose**: Official releases to Google Play Store and Apple App Store/TestFlight

### What it does:
- 🏪 Builds Android AAB and uploads to Google Play Console
- 🍎 Builds iOS IPA (distribution signed) and uploads to TestFlight
- 📦 Creates GitHub release with downloadable artifacts
- 📝 Includes release notes and build information

### Additional Secrets Needed:

#### Android Play Store:
```bash
ANDROID_SIGNING_KEY              # Base64 encoded keystore file
ANDROID_KEY_ALIAS               # Keystore alias
ANDROID_KEYSTORE_PASSWORD       # Keystore password
ANDROID_KEY_PASSWORD            # Key password
GOOGLE_PLAY_SERVICE_ACCOUNT_JSON # Service account JSON for Play Console API
```

#### iOS App Store:
```bash
IOS_DISTRIBUTION_P12_BASE64      # Distribution certificate (not development)
IOS_DISTRIBUTION_P12_PASSWORD    # Distribution certificate password
IOS_APPSTORE_PROVISIONING_PROFILE # App Store provisioning profile
APPSTORE_ISSUER_ID              # App Store Connect API issuer ID
APPSTORE_API_KEY_ID             # App Store Connect API key ID
APPSTORE_API_PRIVATE_KEY        # App Store Connect API private key
```

---

## 🔄 Workflow Usage

### For Testing (Automatic):
1. Push code to `main` or `develop`
2. `test_phase.yml` runs automatically
3. Get builds via Firebase App Distribution

### For Production Release:
1. **Tag-based release**:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. **Manual release**:
   - Go to GitHub Actions
   - Select "Flutter Production Release"
   - Click "Run workflow"
   - Enter version and release notes

---

## 📋 Setup Checklist

### Test Phase (✅ Already Working):
- [x] Firebase App Distribution configured
- [x] Development certificates and profiles
- [x] Basic workflow secrets

### Production Release (🔧 Needs Setup):
- [ ] Generate Android signing key
- [ ] Setup Google Play Console API
- [ ] Create iOS Distribution certificate
- [ ] Create App Store provisioning profile
- [ ] Setup App Store Connect API
- [ ] Add all production secrets to GitHub

---

## 🛠️ Getting Production Secrets

### Android:
1. **Signing Key**: Generate via Android Studio or `keytool`
2. **Play Console API**: Enable Google Play Developer API in Google Cloud Console
3. **Service Account**: Create service account with Play Console access

### iOS:
1. **Distribution Certificate**: Generate in Apple Developer Console
2. **App Store Profile**: Create App Store provisioning profile
3. **App Store API**: Generate API key in App Store Connect → Users and Access → Keys

### Need help setting up any of these? Let me know! 🚀
