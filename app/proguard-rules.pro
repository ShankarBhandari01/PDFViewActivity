## Add project specific ProGuard rules here.
## You can control the set of applied configuration files using the
## proguardFiles setting in build.gradle.
##
## For more details, see
##   http://developer.android.com/guide/developing/tools/proguard.html
#
## If your project uses WebView with JS, uncomment the following
## and specify the fully qualified class name to the JavaScript interface
## class:
##-keepclassmembers class fqcn.of.javascript.interface.for.webview {
##   public *;
##}
#
## Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable
#
## If you keep the line number information, uncomment this to
## hide the original source file name.
#
#-adaptresourcefilenames
#
###---------------Begin: proguard configuration common for all Android apps ----------
#-optimizationpasses 10
#-dontusemixedcaseclassnames
#-dontskipnonpubliclibraryclasses
#-dontskipnonpubliclibraryclassmembers
#-dontpreverify
##-verbose
##-dump class_files.txt
##-printseeds seeds.txt
##-printusage unused.txt
##-printmapping mapping.txt
#-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
#
#-adaptresourcefilenames    **.properties,**.gif,**.jpg
#-adaptresourcefilecontents **.properties,META-INF/MANIFEST.MF
#
#-flattenpackagehierarchy 'file'
#-allowaccessmodification
##-keepattributes SourceFile,LineNumberTable
#-repackageclasses 'file'
#
##-keep public class * extends android.app.Activity
##-keep public class * extends android.app.Application
##-keep public class * extends android.app.Service
##-keep public class * extends android.content.BroadcastReceiver
##-keep public class * extends android.content.ContentProvider
##-keep public class * extends android.app.backup.BackupAgentHelper
##-keep public class * extends android.preference.Preference
##-keep public class * extends android.support.v4.app.Fragment
##-keep public class * extends android.support.v4.app.DialogFragment
##-keep public class * extends com.actionbarsherlock.app.SherlockListFragment
##-keep public class * extends com.actionbarsherlock.app.SherlockFragment
##-keep public class * extends com.actionbarsherlock.app.SherlockFragmentActivity
##-keep public class * extends android.app.Fragment
##-keep public class com.android.vending.licensing.ILicensingService
#
##-keep public class  com.bharuwa.pos.login.model.dto.LoginRequestDTO.* {
##     public void setMyProperty(int);
##    public int getMyProperty();
## }
#-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
#-dontnote com.android.vending.licensing.ILicensingService
#
##For native methods, see #http://proguard.sourceforge.net/manual/examples.html
#-keepclassmembers enum * {
#    @com.google.gson.annotations.SerializedName <fields>;
#}
##serializable
 -keepclassmembers class * implements java.io.Serializable {
         static final long serialVersionUID;
         private static final java.io.ObjectStreamField[] serialPersistentFields;
         !static !transient <fields>;
         !private <fields>;
         !private <methods>;
         private void writeObject(java.io.ObjectOutputStream);
         private void readObject(java.io.ObjectInputStream);
         java.lang.Object writeReplace();
         java.lang.Object readResolve();
     }
##For native methods, see #http://proguard.sourceforge.net/manual/examples.html
##native
##-keepclasseswithmembernames,includedescriptorclasses class * {
##    native <methods>;
##}
#
##native
##-keepclasseswithmembernames class * {
## native <methods>;
##}
#
-keepclassmembers class * {
    *** get*();
    void set*(***);
}

-keepclassmembers,allowobfuscation class * {
@com.google.gson.annotations.SerializedName <fields>;
}
#
##-keep public class *  {
##   public protected *;
##}
#
#
#-keepparameternames
##-renamesourcefileattribute SourceFile
##-keepattributes Signature,Exceptions,*Annotation*,
##                InnerClasses,PermittedSubclasses,EnclosingMethod,
##                Deprecated,LineNumberTable,JavascriptInterface
#
##-keepclasseswithmembernames,includedescriptorclasses class * {
##    native <methods>;
##}
-keep class mybeans.** {
    void set*(***);
    void set*(int, ***);

    boolean is*();
    boolean is*(int);

    *** get*();
    *** get*(int);
}
##-keepclassmembers,allowoptimization enum * {
##    public static **[] values();
##    public static ** valueOf(java.lang.String);
##}
#
#
##-keep public class * extends android.view.View {
##public <init>(android.content.Context);
##public <init>(android.content.Context, android.util.AttributeSet);
##public <init>(android.content.Context, android.util.AttributeSet, int);
##public void set*(...);
##}
##  -keepclasseswithmembers class * {
##   public <init>(android.content.Context, android.util.AttributeSet);
##   }
##  -keepclasseswithmembers class * {
##   public <init>(android.content.Context, android.util.AttributeSet,int);
##  }
##  -keepclassmembers class * extends android.app.Activity {
##   public void *(android.view.View);
##  }
#  #For enumeration classes, see
#  #enumerations
##-keepclassmembers enum * {
##public static **[] values();
##public static ** valueOf(java.lang.String);
##}
##-keep class * implements android.os.Parcelable {
##public static final android.os.Parcelable$Creator *;
##}
#-keepclassmembers class **.R$* {
#public static <fields>;
#}
##-keep class android.support.v4.app.** {*;}
##-keep interface android.support.v4.app.** {*;}
##-keep class com.actionbarsherlock.** {*;}
##-keep interface com.actionbarsherlock.** {*;}
##The support library contains references to newer platform versions.
##Don't warn about those in case this app is linking against an older
##platform version. We know about them, and they are safe.
#-dontwarn android.support.**
#
#-dontwarn com.google.android.material.**
##-keep class com.google.android.material.** { *; }
#-dontwarn androidx.**
##-keep class androidx.** { *; }
##-keep interface androidx.** { *; }
#-keepclassmembers class * {
#@android.webkit.JavascriptInterface <methods>;
#}
#
-keep public class com.project.prayaas.sidbi.** {
  public protected *;
}
#
### Rhino
#-keep class javax.script.** { *; }
#-keep class com.sun.script.javascript.** { *; }
#-keep class org.mozilla.javascript.** { *; }
#-dontwarn org.mozilla.javascript.**
#-dontwarn sun.**
#
#
#-assumenosideeffects class android.util.Log {
#    public static boolean isLoggable(java.lang.String, int);
#    public static int v(...);
#    public static int i(...);
#   public static int w(...);
#    public static int d(...);
#   public static int e(...);
#}
##
-assumenoexternalsideeffects class java.lang.StringBuilder {
    public java.lang.StringBuilder();
    public java.lang.StringBuilder(int);
    public java.lang.StringBuilder(java.lang.String);
    public java.lang.StringBuilder append(java.lang.Object);
    public java.lang.StringBuilder append(java.lang.String);
    public java.lang.StringBuilder append(java.lang.StringBuffer);
    public java.lang.StringBuilder append(char[]);
    public java.lang.StringBuilder append(char[], int, int);
    public java.lang.StringBuilder append(boolean);
    public java.lang.StringBuilder append(char);
    public java.lang.StringBuilder append(int);
    public java.lang.StringBuilder append(long);
    public java.lang.StringBuilder append(float);
    public java.lang.StringBuilder append(double);
    public java.lang.String toString();
}
##
-assumenoexternalreturnvalues public final class java.lang.StringBuilder {
    public java.lang.StringBuilder append(java.lang.Object);
    public java.lang.StringBuilder append(java.lang.String);
    public java.lang.StringBuilder append(java.lang.StringBuffer);
    public java.lang.StringBuilder append(char[]);
    public java.lang.StringBuilder append(char[], int, int);
    public java.lang.StringBuilder append(boolean);
    public java.lang.StringBuilder append(char);
    public java.lang.StringBuilder append(int);
    public java.lang.StringBuilder append(long);
    public java.lang.StringBuilder append(float);
    public java.lang.StringBuilder append(double);
}
#
#
#
#########--------Retrofit + RxJava--------#########
#-dontwarn retrofit.**
-keep class retrofit.** { *; }
#-dontwarn sun.misc.Unsafe
#-dontwarn com.octo.android.robospice.retrofit.RetrofitJackson**
#-dontwarn retrofit.appengine.UrlFetchClient
-keepclasseswithmembers class * {
    @retrofit.http.* <methods>;
}
-keep class com.google.gson.** { *; }
-keep class com.google.inject.** { *; }
-keep class org.apache.http.** { *; }
-keep class org.apache.james.mime4j.** { *; }
-keep class javax.inject.** { *; }
-keep class retrofit.** { *; }
-dontwarn org.apache.http.**
-dontwarn android.net.http.AndroidHttpClient
-dontwarn retrofit.**
#
#-dontwarn sun.misc.**
#
-keep class org.xmlpull.v1.** { *;}
-dontwarn org.xmlpull.v1.**
#-keep public class com.services.network.**{*;}
-keep public class com.data.models.**{*;}
#
##-keep,includedescriptorclasses class net.sqlcipher.** { *; }
##-keep,includedescriptorclasses interface net.sqlcipher.** { *; }
#
##database
-keep class com.google.gson.** { *; }
-keep class org.sqlite.** { *; }
-keep class org.sqlite.database.** { *; }
-keep class * extends androidx.room.RoomDatabase
-keep @androidx.room.Entity class *
-dontwarn androidx.room.paging.**
#
#
##-dontshrink
#-keepnames interface ** { *; }
##-keepnames enum ** { *; }
## Please add these rules to your existing keep rules in order to suppress warnings.
## This is generated automatically by the Android Gradle plugin.-dontwarn amlib.ccid.Reader4428
#
-dontwarn org.xmlpull.v1.**
-dontwarn amlib.ccid.Reader4442
-dontwarn amlib.ccid.Reader
-dontwarn amlib.hw.HWType
-dontwarn amlib.hw.HardwareInterface
-dontwarn amlib.hw.ReaderHwException
-dontwarn com.dtr.zbar.build.CameraManager
-dontwarn com.dtr.zbar.build.CameraPreview
-dontwarn com.dtr.zbar.build.MyPreviewCallBack
-dontwarn com.imagealgorithmlab.barcode.DecodeEngine
-dontwarn com.imagealgorithmlab.barcode.camera.DecoderLibrary$DecoderLibraryCallBack
-dontwarn com.imagealgorithmlab.barcode.camera.DecoderLibrary
-dontwarn com.nhaarman.listviewanimations.appearance.simple.AlphaInAnimationAdapter
-dontwarn com.nineoldandroids.view.ViewHelper
-dontwarn com.odm.tty.TtyDevice
-dontwarn com.pos.sdk.accessory.PosAccessoryManager$EventListener
-dontwarn com.pos.sdk.accessory.PosAccessoryManager
-dontwarn com.pos.sdk.card.PosCardInfo
-dontwarn com.pos.sdk.card.PosCardManager
-dontwarn com.pos.sdk.cardreader.PosCardReaderInfo
-dontwarn com.pos.sdk.cardreader.PosCardReaderManager
-dontwarn com.pos.sdk.cardreader.PosIccCardReader
-dontwarn com.pos.sdk.cardreader.PosMagCardReader
-dontwarn com.pos.sdk.cardreader.PosMifareCardReader
-dontwarn com.pos.sdk.cardreader.PosPiccCardReader
-dontwarn com.pos.sdk.emvcore.PosEmvAppList
-dontwarn com.pos.sdk.emvcore.PosEmvCapk
-dontwarn com.pos.sdk.emvcore.PosEmvCoreManager$EventListener
-dontwarn com.pos.sdk.emvcore.PosEmvCoreManager
-dontwarn com.pos.sdk.emvcore.PosEmvParam
-dontwarn com.pos.sdk.emvcore.PosEmvSmCapk
-dontwarn com.pos.sdk.emvcore.PosTermInfo
-dontwarn com.pos.sdk.printer.PosPrintStateInfo
-dontwarn com.pos.sdk.printer.PosPrinter$EventListener
-dontwarn com.pos.sdk.printer.PosPrinter$Parameters
-dontwarn com.pos.sdk.printer.PosPrinter$PrintData
-dontwarn com.pos.sdk.printer.PosPrinter
-dontwarn com.pos.sdk.printer.PosPrinterInfo
-dontwarn com.pos.sdk.security.PedKcvInfo
-dontwarn com.pos.sdk.security.PedKeyInfo
-dontwarn com.pos.sdk.security.PedRsaPinKey
-dontwarn com.pos.sdk.security.PosSecurityManager$EventListener
-dontwarn com.pos.sdk.security.PosSecurityManager
-dontwarn com.pos.sdk.servicemanager.PosServiceManager
-dontwarn com.pos.sdk.utils.PosByteArray
-dontwarn com.pos.sdk.utils.PosUtils
-dontwarn com.sun.xml.internal.messaging.saaj.util.ByteOutputStream
-dontwarn com.zkteco.android.biometric.core.device.BiometricDevice
-dontwarn com.zkteco.android.biometric.core.device.TransportType
-dontwarn com.zkteco.android.biometric.core.utils.ToolUtils
-dontwarn com.zkteco.android.biometric.nidfpsensor.NIDFPFactory
-dontwarn com.zkteco.android.biometric.nidfpsensor.NIDFPSensor
-dontwarn com.zkteco.android.biometric.nidfpsensor.exception.NIDFPException
-dontwarn java.awt.AlphaComposite
-dontwarn java.awt.BasicStroke
-dontwarn java.awt.Canvas
-dontwarn java.awt.Color
-dontwarn java.awt.Component
-dontwarn java.awt.Composite
-dontwarn java.awt.Font
-dontwarn java.awt.FontMetrics
-dontwarn java.awt.GradientPaint
-dontwarn java.awt.Graphics2D
-dontwarn java.awt.Graphics
-dontwarn java.awt.GraphicsConfiguration
-dontwarn java.awt.Image
-dontwarn java.awt.MediaTracker
-dontwarn java.awt.Paint
-dontwarn java.awt.Polygon
-dontwarn java.awt.Rectangle
-dontwarn java.awt.RenderingHints$Key
-dontwarn java.awt.RenderingHints
-dontwarn java.awt.Shape
-dontwarn java.awt.Stroke
-dontwarn java.awt.TexturePaint
-dontwarn java.awt.datatransfer.DataFlavor
-dontwarn java.awt.font.FontRenderContext
-dontwarn java.awt.font.GlyphVector
-dontwarn java.awt.geom.AffineTransform
-dontwarn java.awt.geom.Arc2D$Double
-dontwarn java.awt.geom.Area
-dontwarn java.awt.geom.Ellipse2D$Float
-dontwarn java.awt.geom.Line2D$Double
-dontwarn java.awt.geom.Line2D
-dontwarn java.awt.geom.NoninvertibleTransformException
-dontwarn java.awt.geom.PathIterator
-dontwarn java.awt.geom.Point2D
-dontwarn java.awt.geom.Rectangle2D$Double
-dontwarn java.awt.geom.Rectangle2D$Float
-dontwarn java.awt.geom.Rectangle2D
-dontwarn java.awt.geom.RoundRectangle2D$Double
-dontwarn java.awt.image.BufferedImage
-dontwarn java.awt.image.BufferedImageOp
-dontwarn java.awt.image.ColorModel
-dontwarn java.awt.image.ImageObserver
-dontwarn java.awt.image.ImageProducer
-dontwarn java.awt.image.MemoryImageSource
-dontwarn java.awt.image.PixelGrabber
-dontwarn java.awt.image.RenderedImage
-dontwarn java.awt.image.WritableRaster
-dontwarn java.awt.image.renderable.RenderableImage
-dontwarn java.awt.print.PrinterGraphics
-dontwarn java.awt.print.PrinterJob
-dontwarn javax.activation.ActivationDataFlavor
-dontwarn javax.activation.CommandMap
-dontwarn javax.activation.DataContentHandler
-dontwarn javax.activation.DataHandler
-dontwarn javax.activation.DataSource
-dontwarn javax.activation.FileDataSource
-dontwarn javax.activation.MailcapCommandMap
-dontwarn javax.imageio.IIOImage
-dontwarn javax.imageio.ImageIO
-dontwarn javax.imageio.ImageWriteParam
-dontwarn javax.imageio.ImageWriter
-dontwarn javax.imageio.metadata.IIOMetadata
-dontwarn javax.imageio.plugins.jpeg.JPEGImageWriteParam
-dontwarn javax.imageio.stream.ImageOutputStream
-dontwarn javax.mail.Address
-dontwarn javax.mail.Authenticator
-dontwarn javax.mail.BodyPart
-dontwarn javax.mail.Header
-dontwarn javax.mail.Message$RecipientType
-dontwarn javax.mail.Message
-dontwarn javax.mail.MessagingException
-dontwarn javax.mail.Multipart
-dontwarn javax.mail.Part
-dontwarn javax.mail.Session
-dontwarn javax.mail.Transport
-dontwarn javax.mail.internet.ContentType
-dontwarn javax.mail.internet.InternetAddress
-dontwarn javax.mail.internet.InternetHeaders
-dontwarn javax.mail.internet.MimeBodyPart
-dontwarn javax.mail.internet.MimeMessage
-dontwarn javax.mail.internet.MimeMultipart
-dontwarn javax.mail.internet.MimePart
-dontwarn javax.mail.internet.SharedInputStream
-dontwarn javax.naming.NamingEnumeration
-dontwarn javax.naming.NamingException
-dontwarn javax.naming.directory.Attribute
-dontwarn javax.naming.directory.Attributes
-dontwarn javax.naming.directory.DirContext
-dontwarn javax.naming.directory.InitialDirContext
-dontwarn javax.naming.directory.SearchControls
-dontwarn javax.naming.directory.SearchResult
-dontwarn junit.textui.TestRunner
-dontwarn kotlinx.parcelize.Parcelize
-dontwarn org.apache.cordova.CallbackContext
-dontwarn org.apache.cordova.CordovaInterface
-dontwarn org.apache.cordova.CordovaPlugin
-dontwarn org.apache.cordova.CordovaWebView
-dontwarn org.conscrypt.Conscrypt$Version
-dontwarn org.conscrypt.Conscrypt
-dontwarn org.conscrypt.ConscryptHostnameVerifier
-dontwarn org.openjsse.javax.net.ssl.SSLParameters
-dontwarn org.openjsse.javax.net.ssl.SSLSocket
-dontwarn org.openjsse.net.ssl.OpenJSSE

-dontwarn org.bouncycastle.jsse.BCSSLParameters
-dontwarn org.bouncycastle.jsse.BCSSLSocket
-dontwarn org.bouncycastle.jsse.provider.BouncyCastleJsseProvider

-dontwarn amlib.ccid.Reader4428
-dontwarn com.journeyapps.barcodescanner.BarcodeEncoder
-dontwarn sun.reflect.CallerSensitive