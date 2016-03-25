# Growthbeat SDK iOS Starter Project

[![Podspec][podspec-badge]][podspec-link]
[![license][license-badge]][license-link]


## Install

```javascript
$ git clone git@github.com:growthbeat/GrowthbeatStaterProject.git
```


## Usage

### 1. Add the [Growthbeat SDK](https://github.com/growthbeat/growthbeat-ios) to your Xcode Project

**CocoaPods**

Add the following line to your Podfile:

```
pod 'Growthbeat'
pod 'GrowthLink', :podspec => 'https://gist.githubusercontent.com/sotayamashita/27f091b8c83c83f3415a/raw/12e6f5d9b5361c75f2fc3d42cbcf4704712a02e9/GrowthLink.podspec'
```

Run `pod install`, and you should now have the latest Growthbeat release.

**Manually**

There are two ways to import libraries:

1. Drag the `<service>.framework` to Frameworks in Project Navigator.
2. Build Phases -> Link Binary With Libraries -> Add Other ... and choose `<service>.framework`.


### 2. Fill in with your Growthbeat application and credential id

**Objective-C** ([AppDelegate.m#L23-L27](https://github.com/growthbeat/Growthbeat-SDK-iOS-Starter-Project/blob/master/ios/GrowthbeatStarterProject/GrowthbeatStarterProject/AppDelegate.m#L23-L27))

```objc
// ****************************************************************************
// Uncomment and fill in with your Growthbeat application id and credentials:
// NSString *growthbeatAppID = @"Your Growthbeat application ID";
// NSString *grwothCredentialID = @"Your Growthbeat credential ID";
// ****************************************************************************
```

**Swift** ([AppDelegate.swift#L27-L30](https://github.com/growthbeat/Growthbeat-SDK-iOS-Starter-Project/blob/master/ios/GrowthbeatStarterProject-Swift/GrowthbeatStarterProject/AppDelegate.swift#L27-L31))

```swift
// ****************************************************************************
// Uncomment and fill in with your Growthbeat application id and credential id:
// let growthbeatApplicationID = "Your Growthbeat application ID"
// let growthbeatCredentialID = "Your Growthbeat credential ID"
// ****************************************************************************
```

## License

[BSD-3-Clause][license-link] © [SIROK, Inc.][sirok]


[sirok]: http://sirok.co.jp/

[license-badge]: https://img.shields.io/github/license/sotayamashita/Growthbeat-SDK-iOS-Starter-Project.svg?style=flat-square
[license-link]: https://github.com/growthbeat/Growthbeat-SDK-iOS-Starter-Project/blob/master/LICENSE

[podspec-badge]: https://img.shields.io/cocoapods/v/Growthbeat.svg?style=flat-square
[podspec-link]: https://cocoapods.org/pods/Growthbeat
