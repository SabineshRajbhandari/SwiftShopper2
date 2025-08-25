// File: android/app/build.gradle.kts

import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    // If you use Firebase / Google services:
    // id("com.google.gms.google-services")
    // Add other plugins here as needed
}

// Load local.properties to retrieve Flutter and version values
val localProps = Properties().apply {
    FileInputStream(rootProject.file("local.properties")).use { load(it) }
}

// Extract values with fallbacks
val flutterMinSdk = localProps.getProperty("flutter.minSdkVersion")?.toInt() ?: 24
val flutterTargetSdk = localProps.getProperty("flutter.targetSdkVersion")?.toInt() ?: 33
val flutterVersionCode = localProps.getProperty("flutter.versionCode")?.toInt() ?: 1
val flutterVersionName = localProps.getProperty("flutter.versionName") ?: "1.0.0"
// Optional: override compile/ndk versions if needed
val flutterCompileSdk = localProps.getProperty("flutter.compileSdkVersion")?.toInt() ?: 36
val flutterNdkVersion = localProps.getProperty("flutter.ndkVersion") ?: "27.0.12077973"

android {
    namespace = "com.example.swiftshopper2"
    compileSdk = flutterCompileSdk
    ndkVersion = flutterNdkVersion

    compileOptions {
        // Enable core library desugaring for Java 8+ APIs
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.example.swiftshopper2"
        minSdk = flutterMinSdk
        targetSdk = flutterTargetSdk
        versionCode = flutterVersionCode
        versionName = flutterVersionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false // Optional, keep if needed
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Required for core library desugaring (e.g., flutter_local_notifications)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
