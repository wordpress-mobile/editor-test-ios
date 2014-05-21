#import <Foundation/Foundation.h>

@interface WPStyleGuide : NSObject

// Fonts
+ (UIFont *)largePostTitleFont;
+ (NSDictionary *)largePostTitleAttributes;
+ (UIFont *)postTitleFont;
+ (UIFont *)postTitleFontBold;
+ (NSDictionary *)postTitleAttributes;
+ (NSDictionary *)postTitleAttributesBold;
+ (UIFont *)subtitleFont;
+ (NSDictionary *)subtitleAttributes;
+ (UIFont *)subtitleFontItalic;
+ (NSDictionary *)subtitleItalicAttributes;
+ (UIFont *)subtitleFontBold;
+ (NSDictionary *)subtitleAttributesBold;
+ (UIFont *)labelFont;
+ (UIFont *)labelFontNormal;
+ (NSDictionary *)labelAttributes;
+ (UIFont *)regularTextFont;
+ (UIFont *)regularTextFontBold;
+ (NSDictionary *)regularTextAttributes;
+ (UIFont *)tableviewTextFont;
+ (UIFont *)tableviewSubtitleFont;
+ (UIFont *)tableviewSectionHeaderFont;

// Colors
+ (UIColor *)baseLighterBlue;
+ (UIColor *)baseDarkerBlue;
+ (UIColor *)lightBlue;
+ (UIColor *)newKidOnTheBlockBlue;
+ (UIColor *)midnightBlue;
+ (UIColor *)jazzyOrange;
+ (UIColor *)fireOrange;
+ (UIColor *)bigEddieGrey;
+ (UIColor *)littleEddieGrey;
+ (UIColor *)whisperGrey;
+ (UIColor *)allTAllShadeGrey;
+ (UIColor *)readGrey;
+ (UIColor *)itsEverywhereGrey;
+ (UIColor *)darkAsNightGrey;
+ (UIColor *)textFieldPlaceholderGrey;
+ (UIColor *)validationErrorRed;
+ (UIColor *)statsLighterBlue;
+ (UIColor *)statsDarkerBlue;

+ (UIColor *)tableViewActionColor;
+ (UIColor *)buttonActionColor;

+ (UIColor *)keyboardColor;

+ (UIColor *)notificationsLightGrey;
+ (UIColor *)notificationsDarkGrey;

@end
