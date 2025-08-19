// Kotlin DSL + Flutter — settings.gradle.kts

import java.util.Properties
import java.io.File

// 1) Resolve Flutter SDK path BEFORE pluginManagement:
val localPropsFile = File(rootDir, "local.properties")
val props = Properties().apply {
    if (localPropsFile.exists()) {
        localPropsFile.inputStream().use { load(it) }
    } else {
        error("Missing ${localPropsFile.absolutePath}. Run `flutter pub get` once to generate it, or add `flutter.sdk=...`.")
    }
}
val flutterSdkPath: String = props.getProperty("flutter.sdk")
    ?: error("`flutter.sdk` not found in local.properties")

pluginManagement {
    // Make Flutter’s Gradle build logic visible
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    // Repos for PLUGIN resolution (AGP/Kotlin markers)
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
        // Flutter’s mirror with many Android artifacts (helps in restricted networks)
        maven("https://storage.googleapis.com/download.flutter.io")
    }
}

dependencyResolutionManagement {
    // Keep repositories only here (not in project build files)
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        maven("https://storage.googleapis.com/download.flutter.io")
    }
}

// Pin plugin versions here (not in build.gradle.kts files)
plugins {
    // Loads Flutter’s new plugin loader early (as recommended)
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"

    // Versions known to work well on Flutter + widely available
    id("com.android.application") version "8.3.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.10" apply false
    // (If you ever need the Android library plugin, add:
    // id("com.android.library") version "8.3.0" apply false)
}

rootProject.name = "android"
include(":app")
