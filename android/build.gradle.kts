/*
 * Top-level build file for the Android part of a Flutter project.
 * Intentionally minimal — repository and plugin versions live in settings.gradle.kts.
 */

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
