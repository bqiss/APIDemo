//
//  UserInfo.h
//  UserInfo
//
//  Created by 陈剑 on 2021/9/2.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : JSONModel
@property (nonatomic,copy) NSString *userGetCount;
@property (nonatomic,assign) Boolean isFirst;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *integral;
@property (nonatomic,copy) NSString *points;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *message;
@end

NS_ASSUME_NONNULL_END
