//
//  SceneDelegate.m
//  API
//
//  Created by caishuning on 2021/9/1.
//

#import "SceneDelegate.h"
#import "ViewController.h"
#import "DetailControllerViewController.h"
#import "UserInfo.h"
#import "AppData.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    self.window.backgroundColor = [UIColor whiteColor];
    [AppData shareInstance].userInfo = [NSKeyedUnarchiver unarchivedObjectOfClass:[UserInfo class] fromData:[[NSUserDefaults standardUserDefaults]valueForKey:@"USERINFO"] error:nil];
    if ([AppData shareInstance].userInfo == nil) {
        ViewController *naviRootVc = [[ViewController alloc] init];
        UINavigationController *windowRootVc = [[UINavigationController alloc] initWithRootViewController:naviRootVc];
        self.window.rootViewController = windowRootVc;
    }else{
        DetailControllerViewController *naviRootVc = [[DetailControllerViewController alloc] init];
        UINavigationController *windowRootVc = [[UINavigationController alloc] initWithRootViewController:naviRootVc];
        self.window.rootViewController = windowRootVc;
    }
   
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].delegate.window = self.window;
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    
    
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    NSData *userInfo =  [NSKeyedArchiver archivedDataWithRootObject:[AppData shareInstance].userInfo requiringSecureCoding:nil error:nil];
    [[NSUserDefaults standardUserDefaults]setObject:userInfo forKey:@"USERINFO"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    
    
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
//    NSData *userInfo =  [NSKeyedArchiver archivedDataWithRootObject:[AppData shareInstance].userInfo requiringSecureCoding:nil error:nil];
//    [[NSUserDefaults standardUserDefaults]setObject:userInfo forKey:@"USERINFO"];
}


@end
