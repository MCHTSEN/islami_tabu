# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep your application classes
-keep class com.mucahitsen.islami_tabu.** { *; }

# Keep Hive
-keep class com.hivedb.** { *; }
-keep class * extends com.hivedb.** { *; }

# Keep Riverpod
-keep class * extends Provider { *; }
-keep class * extends StateNotifier { *; }

# Keep Play libraries
-keep class com.google.android.play.review.** { *; }
-keep class com.google.android.play.core.review.** { *; }
-keep class com.google.android.play.appupdate.** { *; }
-keep class com.google.android.play.core.appupdate.** { *; }

# Ignore missing Play Core classes (required for Flutter)
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task 