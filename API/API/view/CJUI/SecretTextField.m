//
//  SecretTextField.m
//  SecretTextField
//
//  Created by caishuning on 2021/9/2.
//

#import "SecretTextField.h"

@implementation SecretTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.secureTextEntry = YES;
    }
    return self;
}

- (NSString *)textFieldPlaceholder
{
    return @"请输入客户端注册的密码";
}

@end
