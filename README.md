# ipucd13_flutter

IPUC Distrito 13 es una aplicacion movil multiplataforma, en la cual existen varios modulo
Comites, Podcats, Series, Eventos, Cronogramas, Lideres distrital segun el comité, Descargables publico segun el comité, escuchar Radio IPUC, ver transmisiones en del distrito 13, ver y buscar congregaciones donde tendra las opciones de pagina de facebook y ubicacion de la congregacion, cambiar el tema de la aplicacion, acceder a las redes sociales.

Los pastores y lideres distrital, tiene la posibilidad de acceder con usuario y contraseña. donde igualmente contiene los modulo de , congregaciones, eventos, cronograma distrital, descargable publico y privado, solicitudes de archivos descargables, certificados de dautismo, Video IPUC en linea, lista de pastores de distrito 13 al igual de lideres, perfil y cambiar el tema.

Desarrollado por Harold German Granados.
haresje@gmail.com

# ABRIR MAPA  DE FORMA NATIVA

Configurar cuando se registre la geoposicion de las congregaciones 
_openMaps

# COMANDOS A APLICAR ANTES DE SUBIR A PRODUCCION

flutter run --release --dart-define=ENV=local
flutter run --release --dart-define=ENV=production
flutter run --release --dart-define=ENV=post_production


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


# url_launcher - Info.plist

<key>LSApplicationQueriesSchemes</key>
<array>
  <string>tel</string>
</array>


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


# Proceso para generar archivo - Android

1. Cambiamos de version de la aplicacion
2. Buscamos y configuramos la key
3. Generar el appbundle - flutter build appbundle
4. Subimos la aplicacion a la play store
5. Prueba interna, solo los desarrolladores
6. Prueba cerrada, invitamos a otra personas a probar la aplicacion
7. prueba abierda, prueba un numero amplio de personas
Documentacion completa: https://docs.flutter.dev/deployment/android


android {
    namespace = "com.example.[project]"
    // Any value starting with "flutter." gets its value from
    // the Flutter Gradle plugin.
    // To change from these defaults, make your changes in this file.
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    ...

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.[project]"
        // You can update the following values to match your application needs.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // These two properties use values defined elsewhere in this file.
        // You can set these values in the property declaration
        // or use a variable.
        versionCode = flutterVersionCode.toInteger()
        versionName = flutterVersionName
    }

    buildTypes {
        ...
    }
}