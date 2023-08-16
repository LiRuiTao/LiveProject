//
//  GXLiveManager.h
//  GXInteractionLive
//
//  Created by liruitao on 2023/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXLiveManager : NSObject

+ (void)initLiveSDK;

+ (void)entryLiveWithUserId:(NSString *)userId userName:(NSString *)userName liveId:(NSString *)liveId onCompleted:(void(^)(BOOL success))completed;;
@end

NS_ASSUME_NONNULL_END
