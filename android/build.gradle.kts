allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://api.mapbox.com/downloads/v2/releases/maven")
            authentication {
                create<BasicAuthentication>("basic")
            }
            credentials {
                username = "mapbox"
                // Read from the user-level ~/.gradle/gradle.properties, never committed.
                password = providers.gradleProperty("MAPBOX_DOWNLOADS_TOKEN").getOrElse("")
            }
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// mapbox_maps_flutter's own plugin module reads Flutter's default
// compileSdkVersion independently and sets it *after* the library plugin is
// applied, so a plugins.withId hook gets overwritten. afterEvaluate fixes
// that ordering, but ":app" can't use it here (evaluationDependsOn(":app")
// above already forces it to evaluate early) — it already has its own
// compileSdk = 36 set directly in app/build.gradle.kts anyway.
subprojects {
    if (project.name != "app") {
        afterEvaluate {
            extensions.findByType(com.android.build.gradle.LibraryExtension::class.java)
                ?.let { it.compileSdk = 36 }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
