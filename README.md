# ipucd13_flutter

A new Flutter project.

# url_launcher -iOS

<key>LSApplicationQueriesSchemes</key>
<array>
  <string>sms</string>
  <string>tel</string>
</array>

# image_picker - iOS

Version minimo Android 4.3

Add the following keys to your Info.plist file, located in <project root>/ios/Runner/Info.plist:


    NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.
        This permission will not be requested if you always pass false for requestFullMetadata, but App Store policy requires including the plist entry.
    NSCameraUsageDescription - describe why your app needs access to the camera. This is called Privacy - Camera Usage Description in the visual editor.
    
    NSMicrophoneUsageDescription - describe why your app needs access to the microphone, if you intend to record videos. This is called Privacy - Microphone Usage Description in the visual editor.
