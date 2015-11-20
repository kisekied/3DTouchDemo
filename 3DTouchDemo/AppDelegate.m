//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by kisekied on 15/11/17.
//  Copyright © 2015年 kisekied. All rights reserved.
//

//  静态添加ShortcutItems:
//  https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/iPhoneOSKeys.html#//apple_ref/doc/uid/TP40009252-SW36

#import "AppDelegate.h"
#import "ViewController.h"
#import "MyViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"one" localizedTitle:@"Title One" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay] userInfo:nil];
    
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"two" localizedTitle:@"Title Two" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome] userInfo:nil];
    
    
    [UIApplication sharedApplication].shortcutItems = @[item1, item2];
    
    return YES;
}

#pragma mark 选择shortcutItem
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    
    
    if ([shortcutItem.type isEqualToString:@"one"]) {
        NSLog(@"Choose One");
        MyViewController *vc = [[MyViewController alloc] init];
        vc.title = @"One";
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.window.rootViewController showViewController:vc sender:nil];
    } else if ([shortcutItem.type isEqualToString:@"two"]) {
        NSLog(@"Choose Two");
        
        MyViewController *vc = [[MyViewController alloc] init];
        vc.title = @"Two";
        vc.view.backgroundColor = [UIColor orangeColor];
        [self.window.rootViewController showViewController:vc sender:nil];
    }
     
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
