//
//  AppData.m
//  AppData
//
//  Created by caishuning on 2021/9/2.
//

#import "AppData.h"

@implementation AppData

static AppData *mInstance;
+(AppData *)shareInstance
{
    if (mInstance == nil) {
        mInstance = [[AppData alloc]init];
    }
    return mInstance;
}
@end
