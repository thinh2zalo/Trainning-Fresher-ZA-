//
//  ViewController.m
//  TestCalendarFW
//
//  Created by vincent on 3/13/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "ViewController.h"
#import <BMCalendar/BMCalendar.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   BMCalendarController * bmCalendar = BMCalendarController.new;
   NSArray * arrImg = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:FILE_URLIMG ofType:TYPEFILE_PLIST]];
    [bmCalendar importImages:arrImg];
    NSArray * arrQuote = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:FILE_QUOTATIONS ofType:TYPEFILE_PLIST]];
      [bmCalendar importQuotations:arrQuote];
    [self addChildViewController:bmCalendar];
    [bmCalendar didMoveToParentViewController:self];
    bmCalendar.view.frame = self.view.bounds;
    [self.view addSubview:bmCalendar.view];
    
    bmCalendar.backgroundImgView.frame = self.view.bounds;
        bmCalendar.lunarCalendarView.frame = CGRectMake(0, HEIGHT_SCREEN - 160, WITDTH_SCREEN, 130);
        bmCalendar.pageViewController.view.frame = CGRectMake(0, 0, bmCalendar.view.frame.size.width, bmCalendar.lunarCalendarView.frame.origin.y);
        bmCalendar.solarMonthYearView.frame = CGRectMake(0, 0, 170, 40);
        bmCalendar.solarMonthYearView.center = CGPointMake(bmCalendar.view.frame.size.width/2, 100);
        bmCalendar.toDayLabel.frame = CGRectMake(20, bmCalendar.solarMonthYearView.frame.origin.y,90 , 40);
}


@end
