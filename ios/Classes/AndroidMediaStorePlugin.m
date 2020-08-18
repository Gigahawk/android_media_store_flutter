#import "AndroidMediaStorePlugin.h"
#if __has_include(<android_media_store/android_media_store-Swift.h>)
#import <android_media_store/android_media_store-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "android_media_store-Swift.h"
#endif

@implementation AndroidMediaStorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAndroidMediaStorePlugin registerWithRegistrar:registrar];
}
@end
