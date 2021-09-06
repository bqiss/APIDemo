//
//  BaseTextField.m
//  BaseTextField
//
//  Created by caishuning on 2021/9/1.
//

#import "BaseTextField.h"

@implementation BaseTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = [self textFieldPlaceholder];
        self.layer.borderColor = [[UIColor blackColor]CGColor];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = CJHeight(10);
        self.font = [UIFont systemFontOfSize:CJHeight(18)];
    }
    return self;
}

- (NSString *)textFieldPlaceholder
{
    return @"";
}
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(CJWidth(20), 0, bounds.size.width, bounds.size.height);
}
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(CJWidth(20), 0, bounds.size.width, bounds.size.height);
}

@end
