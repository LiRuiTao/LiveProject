//
//  GXLiveManager.m
//  GXInteractionLive
//
//  Created by liruitao on 2023/7/28.
//

#import "GXLiveManager.h"
#import "AUIRoomAccount.h"
#import "AUIInteractionLiveManager.h"
#import "AUIRoomAppServer.h"
static BOOL isEntrying = false;
@implementation GXLiveManager

+ (void)initLiveSDK {
    [[AUIInteractionLiveManager defaultManager]setup];
}
+ (void)entryLiveWithUserId:(NSString *)userId userName:(NSString *)userName liveId:(NSString *)liveId onCompleted:(void(^)(BOOL success))completed {
    if (isEntrying) return;
    isEntrying = true;
    [AUIRoomAppServer requestWithPath:@"/api/v1/live/login" bodyDic:@{@"userId":userId, @"password":userName, @"username":userName} completionHandler:^(NSURLResponse * _Nonnull response, id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!error) {
            AUIRoomUser *me = [AUIRoomUser new];
            me.userId = userId;
            me.avatar = [GXLiveManager defaultAvatarWithUid:userId];
            me.nickName = userName;
            me.token = [responseObject objectForKey:@"token"];   // 用于服务端用户有效性验证
            [[AUIInteractionLiveManager defaultManager] setCurrentUser:me];
            if(completed) {
                completed(true);
            }
            [[AUIInteractionLiveManager defaultManager] joinLiveWithLiveId:liveId currentVC:[self getCurrentVC] completed:nil];
            isEntrying = false;
        } else {
            isEntrying = false;
            if(completed) {
                completed(false);
            }
        }
    }];
}

+ (UIViewController *)getCurrentVC {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

+ (NSArray *)defaultAvatarList {
    static NSArray *_avatarList = nil;
    if (!_avatarList) {
        _avatarList = @[
            @"https://img.alicdn.com/imgextra/i1/O1CN01chynzk1uKkiHiQIvE_!!6000000006019-2-tps-80-80.png",
            @"https://img.alicdn.com/imgextra/i4/O1CN01kpUDlF1sEgEJMKHH8_!!6000000005735-2-tps-80-80.png",
            @"https://img.alicdn.com/imgextra/i4/O1CN01ES6H0u21ObLta9mAF_!!6000000006975-2-tps-80-80.png",
            @"https://img.alicdn.com/imgextra/i1/O1CN01KWVPkd1Q9omnAnzAL_!!6000000001934-2-tps-80-80.png",
            @"https://img.alicdn.com/imgextra/i1/O1CN01P6zzLk1muv3zymjjD_!!6000000005015-2-tps-80-80.png",
            @"https://img.alicdn.com/imgextra/i2/O1CN01ZDasLb1Ca0ogtITHO_!!6000000000096-2-tps-80-80.png",
        ];
    }
    return _avatarList;
}

+ (NSString *)defaultAvatarWithUid:(NSString *)uid {
    if (uid.length > 0) {
        unsigned short first = [uid characterAtIndex:0];
        NSArray *array = [self defaultAvatarList];
        return array[first % array.count];
    }
    return @"";
}

@end
