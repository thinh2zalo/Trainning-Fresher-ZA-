//
//  testHandleContentFile.m
//  bacsicObjCTests
//
//  Created by CPU11606 on 8/11/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
NSString *currentpath1 = NSTemporaryDirectory() ;
currentpath1 = [currentpath1 stringByAppendingPathComponent:@"txt(1)"];
NSString *currentpath2 = NSTemporaryDirectory() ;
currentpath2 = [currentpath2 stringByAppendingPathComponent:@"txt(2)"];
NSURL *currentURL1 = [NSURL fileURLWithPath:currentpath1];
NSURL *currentURL2 = [NSURL fileURLWithPath:currentpath2];
NSArray<NSURL*>* listURL = @[currentURL1,currentURL2];

HandleContentFile *test = [[HandleContentFile alloc] init];

[test mergeFileAtURL:listURL];
return YES;
