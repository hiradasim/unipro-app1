plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

val flutterVersionCode = (project.findProperty("flutter.versionCode") as String?) ?: "1"
val flutterVersionName = (project.findProperty("flutter.versionName") as String?) ?: "1.0"

android {
    namespace = "com.example.unipro"      // <-- change if you want a different package
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.unipro"  // <-- change to your app id if needed
        minSdk = 21
        targetSdk = 34
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    // AGP 8.x requires Java 17
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions {
        jvmTarget = "17"
    }

    packaging {
        resources {
            excludes += setOf(
                "META-INF/DEPENDENCIES",
                "META-INF/LICENSE",
                "META-INF/LICENSE*",
                "META-INF/NOTICE",
                "META-INF/AL2.0",
                "META-INF/LGPL2.1"
            )
        }
    }
}

// Mandatory for Flutter’s Gradle integration
flutter {
    source = "../.."
}

// No repositories here — they are centralized in settings.gradle.kts
