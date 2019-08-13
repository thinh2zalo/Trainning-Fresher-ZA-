//
//  AppDelegate.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/9/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "AppDelegate.h"
#import "HandleContentFile.h"
#import "NSFileManager+InteractWithFile.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *currentpath1 = NSTemporaryDirectory() ;
    currentpath1 = [currentpath1 stringByAppendingPathComponent:@"img.jpg"];
    NSString *currentpath2 = NSTemporaryDirectory() ;
    currentpath2 = [currentpath2 stringByAppendingPathComponent:@"img(2).jpg"];
    NSURL *currentURL1 = [NSURL fileURLWithPath:currentpath1];
    NSURL *currentURL2 = [NSURL fileURLWithPath:currentpath2];
//    NSArray<NSURL*>* listURL = @[currentURL1,currentURL2];
    
    NSFileManager.defaultManager.testProperty = @"A";
    
    NSString* a = NSFileManager.defaultManager.testProperty;
    
    dispatch_queue_global_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_sync(queue, ^{
            NSLog(@"A");
        });
        NSLog(@"B");
//        [NSFileManager splitAFileIntoNFileWithURL:currentURL1 andNumberOfByte:1024 andBlock:^(float progess){
//            NSLog(@"%f",progess);
//        }];
    });
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [NSFileManager splitAFileIntoNFileWithURL:currentURL2 andNumberOfByte:1024 andBlock:^(float progess){
//            NSLog(@"%f",progess);
//        }];
//    });
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
