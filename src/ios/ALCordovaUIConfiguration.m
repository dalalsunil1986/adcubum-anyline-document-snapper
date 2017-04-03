//
//  ALCordovaUIConfiguration.m
//  FoodNotifyBussines
//
//  Created by Matthias Gasser on 12/11/15.
//
//

#import "ALCordovaUIConfiguration.h"

NSString * const DONE_BUTTON = @"doneButton";
NSString * const DONE_BUTTON_TITLE = @"title";
NSString * const DONE_BUTTON_COLOR = @"textColor";
NSString * const DONE_BUTTON_COLOR_HIGHLIGHTED = @"textColorHighlighted";
NSString * const DONE_BUTTON_FONT_SIZE = @"fontSize";
NSString * const DONE_BUTTON_FONT_NAME = @"fontName";
NSString * const DONE_BUTTON_X_ALIGNMENT = @"positionXAlignment";
NSString * const DONE_BUTTON_Y_ALIGNMENT = @"positionYAlignment";
NSString * const DONE_BUTTON_BACKGROUND_COLOR = @"backgroundColor";
NSString * const DONE_BUTTON_TYPE = @"type";
NSString * const DONE_BUTTON_CORNER_RADIUS = @"cornerRadius";

NSString * const SEGMENT = @"segment";
NSString * const SEGMENT_TITLES = @"titles";
NSString * const SEGMENT_MODES = @"modes";
NSString * const SEGMENT_TINT_COLOR = @"tintColor";

NSString * const MULTIPAGE = @"multipage";
NSString * const MULTIPAGE_ENABLED = @"multipageEnabled";
NSString * const MULTIPAGE_TINTCOLOR = @"multipageTintColor";
NSString * const MULTIPAGE_TRANSLUCENT = @"multipageTranslucent";

NSString * const MANUAL_CROP = @"manualCrop";

NSString * const OFFSET = @"offset";
NSString * const OFFSET_X = @"offset.x";
NSString * const OFFSET_Y = @"offset.y";

@implementation ALCordovaUIConfiguration

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self) {
        _buttonDoneFontName = @"HelveticaNeue";
        _buttonDoneTextColor = [UIColor whiteColor];
        _buttonDoneTextColorHighlighted = [UIColor grayColor];
        _buttonDoneBackgroundColor = [UIColor clearColor];
        _buttonDoneFontSize = 32.0;
        _buttonType = ALButtonTypeFullWidth;
        _buttonDoneTitle = NSLocalizedString(@"OK", @"Done button title");
        _buttonDoneXAlignment = ALButtonXAlignmentCenter;
        _buttonDoneYAlignment = ALButtonYAlignmentBottom;
        _buttonDoneYPositionOffset = -88.0;
        _buttonDoneXPositionOffset = 0;
        _buttonDoneCornerRadius = 4.0;
        
        _multipageTintColor = [UIColor clearColor];
        
        if([dictionary valueForKey:DONE_BUTTON]) {
            NSDictionary *btnDict = [dictionary valueForKey:DONE_BUTTON];
            
            if([btnDict valueForKey:DONE_BUTTON_FONT_NAME])
                _buttonDoneFontName = [btnDict valueForKeyPath:DONE_BUTTON_FONT_NAME];
            
            if([btnDict valueForKey:DONE_BUTTON_COLOR])
                _buttonDoneTextColor = [ALCordovaUIConfiguration colorFromHexString:[btnDict valueForKeyPath:DONE_BUTTON_COLOR]];
            
            if([btnDict valueForKey:DONE_BUTTON_COLOR_HIGHLIGHTED])
            _buttonDoneTextColorHighlighted = [ALCordovaUIConfiguration colorFromHexString:[btnDict valueForKeyPath:DONE_BUTTON_COLOR_HIGHLIGHTED]];
            
            
            if([btnDict valueForKey:DONE_BUTTON_FONT_SIZE])
                _buttonDoneFontSize = [[btnDict valueForKeyPath:DONE_BUTTON_FONT_SIZE] floatValue];
            
            if([btnDict valueForKey:DONE_BUTTON_TYPE])
                _buttonType =  [ALCordovaUIConfiguration stringToButtonType:[btnDict valueForKeyPath:DONE_BUTTON_TYPE]];
            
            if([btnDict valueForKey:DONE_BUTTON_BACKGROUND_COLOR])
                _buttonDoneBackgroundColor = [ALCordovaUIConfiguration colorFromHexString:[btnDict valueForKey:DONE_BUTTON_BACKGROUND_COLOR]];
            
            if([btnDict valueForKey:DONE_BUTTON_TITLE])
                _buttonDoneTitle = [btnDict valueForKeyPath:DONE_BUTTON_TITLE];
            
            if([btnDict valueForKey:DONE_BUTTON_X_ALIGNMENT]) {
                _buttonDoneXAlignment = [ALCordovaUIConfiguration stringToButtonXAlignment:[btnDict valueForKeyPath:DONE_BUTTON_X_ALIGNMENT]];
            }
            
            if([btnDict valueForKey:DONE_BUTTON_Y_ALIGNMENT]) {
                _buttonDoneYAlignment = [ALCordovaUIConfiguration stringToButtonYAlignment:[btnDict valueForKeyPath:DONE_BUTTON_Y_ALIGNMENT]];
            }
            
            
            if([btnDict valueForKeyPath:OFFSET_X])
                _buttonDoneXPositionOffset = [[btnDict valueForKeyPath:OFFSET_X] floatValue];
            
            if([btnDict valueForKeyPath:OFFSET_Y])
                _buttonDoneYPositionOffset = [[btnDict valueForKeyPath:OFFSET_Y] floatValue];
            
            if([btnDict valueForKey:DONE_BUTTON_CORNER_RADIUS])
                _buttonDoneCornerRadius = [[btnDict valueForKeyPath:DONE_BUTTON_CORNER_RADIUS] floatValue];
            
        }
        
        if ([dictionary valueForKey:SEGMENT]) {
            NSDictionary *segDict = [dictionary valueForKey:SEGMENT];
            
            if([segDict valueForKey:SEGMENT_TITLES])
                _segmentTitles = [segDict valueForKey:SEGMENT_TITLES];
            
            if([segDict valueForKey:SEGMENT_MODES])
                _segmentModes = [segDict valueForKey:SEGMENT_MODES];
            
            if([segDict valueForKey:SEGMENT_TINT_COLOR])
                _segmentTintColor = [ALCordovaUIConfiguration colorFromHexString:[segDict valueForKey:SEGMENT_TINT_COLOR]];
            
            if([segDict valueForKeyPath:OFFSET_X])
                _segmentXPositionOffset = [[segDict valueForKeyPath:OFFSET_X] floatValue];
            
            if([segDict valueForKeyPath:OFFSET_Y])
                _segmentYPositionOffset = [[segDict valueForKeyPath:OFFSET_Y] floatValue];
        }
        
        if ([dictionary valueForKey:MULTIPAGE]) {
            NSDictionary *multipageDict = [dictionary valueForKey:MULTIPAGE];
            
            if([multipageDict valueForKey:MULTIPAGE_ENABLED])
                _multipageEnabled = [multipageDict valueForKey:MULTIPAGE_ENABLED];
            
            if([multipageDict valueForKey:MULTIPAGE_TINTCOLOR])
                _multipageTintColor = [ALCordovaUIConfiguration colorFromHexString:[multipageDict valueForKey:MULTIPAGE_TINTCOLOR]];
            
            
            if([multipageDict valueForKey:MULTIPAGE_TRANSLUCENT])
                _multipageTranslucent = [multipageDict valueForKey:MULTIPAGE_TRANSLUCENT];
        }
        
        if([dictionary valueForKey:MANUAL_CROP])
            _manualCrop = [dictionary valueForKey:MANUAL_CROP];
    }
    return self;
}

+(ALButtonXAlignment) stringToButtonXAlignment:(NSString*) str {
    NSDictionary *map = @{
                          @"LEFT":@(ALButtonXAlignmentLeft),
                          @"CENTER":@(ALButtonXAlignmentCenter),
                          @"RIGHT":@(ALButtonXAlignmentRight),
                          };
    
    return [[map valueForKey:str.uppercaseString] integerValue];
}

+(ALButtonYAlignment) stringToButtonYAlignment:(NSString*) str {
    NSDictionary *map = @{
                          @"TOP":@(ALButtonYAlignmentTop),
                          @"CENTER":@(ALButtonYAlignmentCenter),
                          @"BOTTOM":@(ALButtonYAlignmentBottom),
                          };
    
    return [[map valueForKey:str.uppercaseString] integerValue];
}


+(ALButtonType) stringToButtonType:(NSString*) str {
    NSDictionary *map = @{
                          @"FULLWIDTH":@(ALButtonTypeFullWidth),
                          @"RECT":@(ALButtonTypeRect)
                          };
    
    return [[map valueForKey:str.uppercaseString] integerValue];
}


+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    // [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


@end
