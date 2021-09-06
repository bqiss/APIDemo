//
//  DetailLabel.m
//  DetailLabel
//
//  Created by caishuning on 2021/9/2.
//

#import "DetailLabel.h"

@implementation DetailLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)initWithTitle:(NSString *)titleText detailData:(NSString *)detailData
{
    if (titleText != nil && detailData != nil) {
        self.text = [titleText stringByAppendingString:detailData];
        self.textColor  = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:15];
    }
}

@end
