//
//  YSLocalibleTool.m
//  YS_LightBlue
//
//  Created by YJ on 17/5/23.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSLocalizableTool.h"

@implementation YSLocalizableTool

+ (NSBundle *)ys_localizedSourceBundle
{
    static NSBundle * ysBundle = nil;
    if (ysBundle == nil) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"YSLightBlue" ofType:@"bundle"];
        if (!path) {

        }
        ysBundle = [NSBundle bundleWithPath:path];
    }
    return ysBundle;
}

+ (NSString *)ys_localizedStringWithKey:(NSString *)key
{
    return [self ys_localizedStringWithKey:key value:@""];
}

+ (NSString *)ys_localizedStringWithKey:(NSString *)key value:(NSString *)value
{
    static NSBundle * bundle = nil;
    NSString * preferLanguage = [NSLocale preferredLanguages].firstObject;
    if ([preferLanguage rangeOfString:@"zh-Hans"].location != NSNotFound) {
        preferLanguage = @"zh-Hans";
    }
    else {
        preferLanguage = @"en";
    }

    bundle = [NSBundle bundleWithPath:[[self ys_localizedSourceBundle] pathForResource:preferLanguage ofType:@"lproj"]];

    NSString * retValue = [bundle localizedStringForKey:key value:value table:nil];
    return retValue;
}

@end
