//
//  GXLiveManager.m
//  GXInteractionLive
//
//  Created by liruitao on 2023/7/28.
//

#import "GXLiveManager.h"
#import "AUIInteractionLiveListViewController.h"
#import "AUIRoomAccount.h"
#import "AUIInteractionLiveManager.h"
#import "AUIRoomAppServer.h"
@implementation GXLiveManager

+ (void)entryLiveWithUserId:(NSString *)userId liveId:(NSString *)liveId {
    NSDictionary *data = @{@"id": liveId, @"nick": userId};
    AUIRoomLiveInfoModel *model = [[AUIRoomLiveInfoModel alloc]initWithResponseData:data];
    [[AUIInteractionLiveManager defaultManager] joinLive:model currentVC:[GXLiveManager getCurrentVC]];
}

+ (void)initLiveSDK:(NSString *)uid onCompleted:(void(^)(BOOL success))completed {
    [AUIInteractionLiveManager registerLive];
    [AUIRoomAppServer requestWithPath:@"/api/v1/live/login" bodyDic:@{@"password":uid, @"username":uid} completionHandler:^(NSURLResponse * _Nonnull response, id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!error) {
            AUIRoomAccount.me.userId = uid;
            AUIRoomAccount.me.avatar = [GXLiveManager defaultAvatarWithUid:uid];
            AUIRoomAccount.me.nickName = uid;
            AUIRoomAccount.me.token = [responseObject objectForKey:@"token"];
            [GXLiveManager saveCurrentUser];
            if(completed) {
                completed(true);
            }
        } else {
            if(completed) {
                completed(false);
            }
        }
    }];
}

+ (BOOL)isLogin {
    return AUIRoomAccount.me.userId.length > 0;
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

+ (void)loadCurrentUser {
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"my_user_id"];
    NSString *nickName = [[NSUserDefaults standardUserDefaults] objectForKey:@"my_user_name"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"my_user_token"];
    if (userId.length > 0) {
        AUIRoomAccount.me.userId = userId;
        AUIRoomAccount.me.avatar = [self defaultAvatarWithUid:userId];
        AUIRoomAccount.me.nickName = nickName;
        AUIRoomAccount.me.token = token;
    }
}

+ (void)saveCurrentUser {
    [[NSUserDefaults standardUserDefaults] setObject:AUIRoomAccount.me.userId forKey:@"my_user_id"];
    [[NSUserDefaults standardUserDefaults] setObject:AUIRoomAccount.me.token forKey:@"my_user_token"];
    [[NSUserDefaults standardUserDefaults] setObject:AUIRoomAccount.me.nickName forKey:@"my_user_name"];
    [[NSUserDefaults standardUserDefaults] setObject:AUIRoomAccount.me.nickName forKey:@"last_login_name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
