//
//  AppDelegate.m
//  YYSportsProject
//
//  Created by k on 15/11/17.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "AppDelegate.h"

#import "HomeVC.h"
#import "ShopVC.h"
#import "CartVC.h"
#import "UserVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent)];
    
    
    NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
    NSNumber * userId = [userDef objectForKey:@"userId"];
    NSString * token = [userDef objectForKey:@"token"];
    
    if (!userId || !token ) {
        userId = @0;
        token = @"0";
        [userDef setObject:userId forKey:@"userId"];
        [userDef setObject:token forKey:@"token"];
        [userDef synchronize];
    }
    [GiFHUD setGifWithImageName:@"pika.gif"];
    
    
    [self configVC];
    return YES;
}
- (void)configVC {
    UITabBarController * tabbarController = [[UITabBarController alloc] init];
    self.window.rootViewController = tabbarController;
    
    UIViewController * homeVC = [[HomeVC alloc] init];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected"]];
    
    UIViewController * marketListVC = [[ShopVC alloc] init];
    marketListVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"商铺" image:[UIImage imageNamed:@"tabbar_market"] selectedImage:[UIImage imageNamed:@"tabbar_market_selected"]];
    
    UIViewController * shoppingListVC = [[CartVC alloc] init];
    shoppingListVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"tabbar_shopping"] selectedImage:[UIImage imageNamed:@"tabbar_shopping_selected"]];
    
    UIViewController * userVC = [[UserVC alloc] init];
    userVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbar_user"] selectedImage:[UIImage imageNamed:@"tabbar_user_selected"]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kRGB(206, 0, 0)} forState:(UIControlStateSelected)];
    [tabbarController.tabBar setTintColor:kRGB(206, 0, 0)];
    
    
    tabbarController.viewControllers = @[
                                         [[UINavigationController alloc] initWithRootViewController:homeVC],
                                         [[UINavigationController alloc] initWithRootViewController:marketListVC],
                                         [[UINavigationController alloc] initWithRootViewController:shoppingListVC],
                                         [[UINavigationController alloc] initWithRootViewController:userVC]];
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
