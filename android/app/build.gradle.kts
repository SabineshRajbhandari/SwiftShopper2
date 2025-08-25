plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services") // FlutterFire plugin
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.swiftshopper2"
    compileSdk = 33
    ndkVersion = "21.4.7075529" // optional, matches your environment

    defaultConfig {
        applicationId = "com.example.swiftshopper2"
        minSdk = 21 // Minimum required for Firebase and desugaring
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Required for flutter_local_notifications and Java 11 desugaring
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
