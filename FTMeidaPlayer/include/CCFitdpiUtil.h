//
//  CCFitdpiUtil.h
//  ComicColoroom
//
//  Created by henry on 2019/5/14.
//  Copyright © 2019 henry. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRefereWidth 375.0 // 参考宽度
#define kRefereHeight 667.0 // 参考高度

#define AdaptW(floatValue) [CCFitdpiUtil adaptWidthWithValue:floatValue]

@interface CCFitdpiUtil : NSObject

/**
 以屏幕宽度为固定比例关系，来计算对应的值。假设：参考屏幕宽度375，floatV=10；当前屏幕宽度为750时，那么返回的值为20
 @param floatV 参考屏幕下的宽度值
 @return 当前屏幕对应的宽度值
 */
+ (CGFloat)adaptWidthWithValue:(CGFloat)floatV;
+(BOOL)isPhoneX;

+ (CGFloat)topSafeAreaHeight;

+ (CGFloat)bottomSafeAreaHeight;

//是否开启APP推送
+ (BOOL)isSwitchAppNotification;

@end
