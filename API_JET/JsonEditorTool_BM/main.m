//
//  main.m
//  JsonEditorTool_BM
//
//  Created by vincent on 1/15/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LunarSolarCalendarConverter.h"

NSDate *createDate(int year, int month, int day) {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}
NSString *getResult(NSString *str) {
    NSString *url = [NSString stringWithFormat:@"http://localhost:1337/?src=%@", str];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

void unitTest() {
    NSDate *sd = createDate(2020, 7, 1);
//    NSDate *endTime = createDate(2099, 12, 31);
    Solar * solar = Solar.new;
    solar.solarDay = 7;
    solar.solarMonth =  2;
    solar.solarYear = 2020;
    Lunar *ld = [LunarSolarConverter solarToLunar:solar];

}

int main(int argc, char * argv[]) {
    @autoreleasepool {
           unitTest();
       }

       return 0;
}


