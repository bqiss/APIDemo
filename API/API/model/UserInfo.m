//
//  UserInfo.m
//  UserInfo
//
//  Created by 陈剑 on 2021/9/2.
//

#import "UserInfo.h"

@implementation UserInfo
- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    if (self != nil) {
        self.userGetCount = [dict objectForKey:@"userGetCount"];
        self.isFirst = NO;
        self.token = [dict objectForKey:@"token"];
        self.integral = [dict objectForKey:@"integral"];
        self.points = [dict objectForKey:@"points"];
    }
    return self;
}
@end
