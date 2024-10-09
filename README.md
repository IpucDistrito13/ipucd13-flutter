# ipucd13_flutter

A new Flutter project.

# url_launcher -iOS

<key>LSApplicationQueriesSchemes</key>
<array>
  <string>sms</string>
  <string>tel</string>
</array>


# Identificador de la app

dart run change_app_package_name:main org.ipuc.distrito13


# Generar icono

flutter pub get
dart run flutter_launcher_icons


# Actualizar splash
dart run flutter_native_splash:create


# image_picker - iOS

Version minimo Android 4.3

Add the following keys to your Info.plist file, located in <project root>/ios/Runner/Info.plist:


    NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.
        This permission will not be requested if you always pass false for requestFullMetadata, but App Store policy requires including the plist entry.
    NSCameraUsageDescription - describe why your app needs access to the camera. This is called Privacy - Camera Usage Description in the visual editor.
    
    NSMicrophoneUsageDescription - describe why your app needs access to the microphone, if you intend to record videos. This is called Privacy - Microphone Usage Description in the visual editor.



# flutter_local_notifications

https://pub.dev/packages/flutter_local_notifications

Para notificaciones push la version minima es 19

        minSdk = flutter.minSdkVersion

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.ipucd13_flutter"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 19
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }