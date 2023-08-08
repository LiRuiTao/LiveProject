//
//  GXLiveManager.h
//  GXInteractionLive
//
//  Created by liruitao on 2023/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXLiveManager : NSObject

+ (BOOL)isLogin;

+ (void)initLiveSDK:(NSString *)uid onCompleted:(void(^)(BOOL success))completed;

+ (void)entryLiveWithUserId:(NSString *)userId liveId:(NSString *)liveId;

@end

NS_ASSUME_NONNULL_END
