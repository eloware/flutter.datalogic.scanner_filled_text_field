#import "ScannerFilledTextFieldPlugin.h"
#if __has_include(<scanner_filled_text_field/scanner_filled_text_field-Swift.h>)
#import <scanner_filled_text_field/scanner_filled_text_field-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "scanner_filled_text_field-Swift.h"
#endif

@implementation ScannerFilledTextFieldPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftScannerFilledTextFieldPlugin registerWithRegistrar:registrar];
}
@end
