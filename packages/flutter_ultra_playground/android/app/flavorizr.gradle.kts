import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("development") {
            dimension = "flavor-type"
            applicationId = "com.wisemen.app.development"
            resValue(type = "string", name = "app_name", value = "Flutter Ultra")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "com.wisemen.app.staging"
            resValue(type = "string", name = "app_name", value = "Flutter Ultra")
        }
        create("qa") {
            dimension = "flavor-type"
            applicationId = "com.wisemen.app.qa"
            resValue(type = "string", name = "app_name", value = "Flutter Ultra")
        }
        create("production") {
            dimension = "flavor-type"
            applicationId = "com.wisemen.app"
            resValue(type = "string", name = "app_name", value = "Flutter Ultra")
        }
    }
}