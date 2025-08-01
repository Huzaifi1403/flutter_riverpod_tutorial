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
.github/workflows/test_phase.yml         # Test phase CI/CD workflow
.github/workflows/release.yml            # Production release CI/CD workflow
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
**Triggers**: Push to `main` for testflight & beta or `test-phase-branch` branches to firebase distribution
**Purpose**: Quick testing and Firebase distribution for internal testing

### What it does:
- ✅ Builds Android APK and distributes via Firebase App Distribution
- ✅ Builds iOS IPA (development signed) and distributes via Firebase App Distribution
- ✅ Fast feedback for development team

### Required Secrets (Already configured):
- `FIREBASE_ANDROID_APP_ID` (Android app ID from Firebase project settings)
- `FIREBASE_IOS_APP_ID` (iOS app ID from Firebase project settings)
- `FIREBASE_CLI_TOKEN` (Authentication token for Firebase CLI access)
- `IOS_P12_BASE64` (Development certificate in base64 format for iOS signing)
- `IOS_P12_PASSWORD` (Password for the iOS development certificate)
- `IOS_PROVISIONING_PROFILE` (Development provisioning profile in base64 format)
- `KEYCHAIN_PASSWORD` (Password for macOS keychain to store certificates)

---

## 🚀 Production Release Workflow (`release.yml`)
**Triggers**: Push to `main` branch (currently configured for testing)  
**Purpose**: Official releases to Google Play Store and Apple App Store/TestFlight

### What it does:
- 🏪 Builds Android AAB and uploads to Google Play Console (internal track)
- 🍎 Builds iOS IPA (distribution signed) and uploads to TestFlight
- 📦 Creates GitHub release with downloadable artifacts
- 📝 Includes release notes and build information

### Current Configuration:
- **Android**: Uploads to Google Play **internal track** for testing
- **iOS**: Uses App Store distribution certificates and TestFlight upload
- **GitHub**: Creates release with downloadable AAB and IPA files

⚠️ **Note**: The workflow currently has `packageName: com.example.flutterRiverpodTutorial1` but your Android app uses `com.example.flutter_riverpod_tutorial`. This needs to be fixed before Android releases will work.

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
1. **Push to 'other' branch** (current configuration):
   ```bash
   git checkout other
   git merge main
   git push origin other
   ```

2. **For future tag-based releases** (modify workflow trigger):
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

3. **Manual release** (if workflow supports it):
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

---

## 📚 Resources & Documentation

### ⚙️ GitHub Actions for Flutter CI/CD:
- **[GitHub Actions Documentation](https://docs.github.com/en/actions)** - Complete GitHub Actions guide
- **[Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)** - YAML syntax reference
- **[Flutter Action](https://github.com/marketplace/actions/flutter-action)** - subosito/flutter-action (used in our workflows)
- **[Encrypted Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)** - Managing sensitive data securely
- **[Environment Variables](https://docs.github.com/en/actions/learn-github-actions/variables)** - Using variables in workflows

### 🔧 Actions Used in Our Workflows:
- **[actions/checkout](https://github.com/actions/checkout)** - Download repository code
- **[actions/upload-artifact](https://github.com/actions/upload-artifact)** - Save build outputs
- **[actions/download-artifact](https://github.com/actions/download-artifact)** - Retrieve build artifacts
- **[apple-actions/import-codesign-certs](https://github.com/apple-actions/import-codesign-certs)** - iOS certificate management
- **[Firebase Distribution Action](https://github.com/wzieba/Firebase-Distribution-Github-Action)** - Firebase app distribution

### 🛠️ Advanced GitHub Actions:
- **[Matrix Builds](https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs)** - Run jobs across multiple configurations
- **[Conditional Workflows](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idif)** - Run jobs based on conditions
- **[Workflow Triggers](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows)** - Different ways to trigger workflows
- **[Self-hosted Runners](https://docs.github.com/en/actions/hosting-your-own-runners)** - Use your own macOS machine for iOS builds

### 🔍 Debugging & Monitoring:
- **[Enabling Debug Logging](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/enabling-debug-logging)** - Detailed workflow logs
- **[Workflow Run Logs](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/using-workflow-run-logs)** - Understanding build outputs
- **[Workflow Status Badge](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/adding-a-workflow-status-badge)** - Add build status to README

### 📖 Best Practices:
- **[Security Hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)** - Secure your workflows
- **[Workflow Organization](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions#organizing-complex-workflows)** - Structure complex workflows
- **[Caching Dependencies](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)** - Speed up builds with caching

*Last updated: August 2025 | GitHub Actions for Flutter 3.29.2*
