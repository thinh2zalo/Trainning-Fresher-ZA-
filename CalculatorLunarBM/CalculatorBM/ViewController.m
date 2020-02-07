//
//  ViewController.m
//  CalculatorBM
//
//  Created by vincent on 2/6/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "ViewController.h"
#import "BMYear.h"
#import "BMMonth.h"
#import "BMDay.h"
#import "CanChi.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Year :%@", [BMYear yearOfVietnames:1989]);
    NSLog(@"month :%@", [BMMonth monthOfVietnames:12 andYear:2020]);
    NSLog(@"day :%@", [BMDay dayOfVietnamese:30 :4 :2020]);
    NSLog(@"jdFromDate :%d", [CanChi jdFromDate:14 mm:4 yy:2]);
    NSLog(@"universalToJD :%f", [CanChi universalToJD:1 :1 :1900]);
    if ([BMYear isLeapLunarYear:2031]) {
            NSLog(@"leapppppp ");
    } else {
        NSLog(@"!!!!leapppppp ");

    }



    
    // Do any additional setup after loading the view.
}


@end
