# Razorpay ലൈബ്രറിക്ക്
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# അനോട്ടേഷനുകൾ നിലനിർത്താൻ
-keepattributes *Annotation*

# Play Core ഉം Flutter Play Store സപ്പോർട്ടിനും
-keep class com.google.android.play.core.splitcompat.SplitCompatApplication { *; }
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Flutter-ന്റെ deferred components-ന് ആവശ്യമായ splitinstall ക്ലാസുകൾ
-keep class com.google.android.play.core.splitinstall.SplitInstallManager { *; }
-keep class com.google.android.play.core.splitinstall.SplitInstallRequest$Builder { *; }
-keep class com.google.android.play.core.splitinstall.SplitInstallRequest { *; }
-keep class com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener { *; }
-keep class com.google.android.play.core.tasks.OnFailureListener { *; }
-keep class com.google.android.play.core.tasks.OnSuccessListener { *; }
-keep class com.google.android.play.core.tasks.Task { *; }

# Flutter Play Store സപ്പോർട്ട്
-keep class io.flutter.app.FlutterPlayStoreSplitApplication { *; }