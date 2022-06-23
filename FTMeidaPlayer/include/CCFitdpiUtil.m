//
//  CCFitdpiUtil.m
//  ComicColoroom
//
//  Created by henry on 2019/5/14.
//  Copyright © 2019 henry. All rights reserved.
//

#import "CCFitdpiUtil.h"
#import <UserNotifications/UserNotifications.h>

#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

@implementation CCFitdpiUtil

+ (CGFloat)adaptWidthWithValue:(CGFloat)floatV;
{
    return floatV*[[UIScreen mainScreen] bounds].size.width/kRefereWidth;
}

+(BOOL)isPhoneX {
    BOOL iPhoneXN = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        return iPhoneXN;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXN = YES;
        }
    }
    return iPhoneXN;
}

+ (CGFloat)topSafeAreaHeight{
    CGFloat height = 0.0;
    if([CCFitdpiUtil isPhoneX] == YES){
        height = 24.0;
    }
    return height;
}

+ (CGFloat)bottomSafeAreaHeight{
    CGFloat height = 0.0;
    if([CCFitdpiUtil isPhoneX] == YES){
        height = 34.0;
    }
    return height;
}

/**是否开启推送*/
+ (BOOL)isSwitchAppNotification {
    if (@available(iOS 10.0, *)) {
        __block BOOL result = NO;
        //异步线程中操作是否完成
        __block BOOL inThreadOperationComplete = NO;
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                result = NO;
            }else if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                result = NO;
            }else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                result = YES;
            }else {
                result = NO;
            }
            inThreadOperationComplete = YES;
        }];

        while (!inThreadOperationComplete) {
            [NSThread sleepForTimeInterval:0];
        }
        return result;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    else if (IOS_VERSION >= 8.0)
    {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }else {
            return NO;
        }

    }else
    {
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type) {
            return YES;
        }else {
            return NO;
        }
    }
#pragma clang diagnostic pop
}

@end
