//
//  AppData.h
//  AppData
//
//  Created by caishuning on 2021/9/2.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppData : NSObject
@property (nonatomic,strong) UserInfo *userInfo;
+ (AppData *)shareInstance;
@end

NS_ASSUME_NONNULL_END
