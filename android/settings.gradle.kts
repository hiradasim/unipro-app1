// Kotlin DSL + Flutter — settings.gradle.kts

import java.util.Properties
import java.io.File

pluginManagement {
    // Resolve Flutter SDK path BEFORE using it
    val localPropsFile = File(rootDir, "local.properties")
    val props = Properties().apply {
        if (localPropsFile.exists()) {
            localPropsFile.inputStream().use { load(it) }
        } else {
            error("Missing ${localPropsFile.absolutePath}. Run `flutter pub get` to generate it, or add `flutter.sdk=...`.")
        }
    }
    val flutterSdkPath: String =
        props.getProperty("flutter.sdk")
            ?: error("`flutter.sdk` not found in local.properties")

    // Make Flutter's Gradle build logic visible
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
        maven("https://storage.googleapis.com/download.flutter.io")
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        maven("https://storage.googleapis.com/download.flutter.io")
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.3.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.10" apply false
    // id("com.android.library") version "8.3.0" apply false
}

rootProject.name = "android"
include(":app")
