//
//  NSString+CompareTimeStamp.m
//  Step12_17
//
//  Created by CPU11606 on 8/7/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "NSString+CompareTimeStamp.h"

@implementation NSString (CompareTimeStamp)
-(NSString *)compareTimeStamp:(long long)timeStampInput{
    long long timeStamp = (long long)([[NSDate date] timeIntervalSince1970]);
    long long diffTimeStamp;
    diffTimeStamp = timeStamp - timeStampInput;
    if  (diffTimeStamp < 0){
        diffTimeStamp = -diffTimeStamp;
    }
    NSString *strResults;
    long long seconds = diffTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStampInput];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"dd-MM-yyyy"];
    NSString *dateString=[dateformatter stringFromDate:date];
    periodTime whatTime;
    ( seconds > MONTH)? whatTime = periodTimeMonth
    :( seconds > WEEK)? whatTime = periodTimeWeek
    :(seconds > DAY)?   whatTime = periodTimeDay
    :(seconds > HOUSE)? whatTime = periodTimeHouse
    :(seconds > MINUTE)?whatTime = periodTimeMinute
    :(seconds > SECOND)? whatTime = periodTimeSECOND
    : 7;
    switch ( whatTime ){
        case periodTimeSECOND:
            if (timeStamp > timeStampInput) {
                NSLog(@"just now"); break;
            }
            else{
                NSLog(@"little bit"); break;
            }
            
        case periodTimeMinute:
            if (timeStamp > timeStampInput) {
                NSInteger minute = MINUTE;
                NSUInteger result = seconds/minute;
                strResults =[NSString stringWithFormat:@"%tu minutes before", result];
                break;
            }
            else{
                NSInteger minute = MINUTE;
                NSUInteger result = seconds/minute;
                strResults =[NSString stringWithFormat:@"%tu minutes after", result];
                break;
           
            }
            
            
        case periodTimeHouse:
            if (timeStamp > timeStampInput) {
                NSInteger house = HOUSE;
                NSUInteger result = seconds/house;
                strResults =[NSString stringWithFormat:@"%tu house before ", result];
                break;
                
            }
            else{
                NSInteger house = HOUSE;
                NSUInteger result = seconds/house;
                strResults =[NSString stringWithFormat:@"%tu house after", result];
                break;
              
            }
        case periodTimeDay:
            
            if (timeStamp > timeStampInput) {
                
                NSInteger day = DAY;
                NSUInteger result = seconds/day;
                strResults =[NSString stringWithFormat:@"%tu day before", result];
                break;
                
            }
            else{
                NSInteger day = DAY;
                NSUInteger result = seconds/day;
                strResults =[NSString stringWithFormat:@"%tu day after", result];
                break;
            }
        case periodTimeWeek:
            if (timeStamp > timeStampInput) {
                NSInteger week = WEEK;
                NSUInteger result = seconds/week;
                strResults =[NSString stringWithFormat:@"%tu week before", result];
                break;
               
            }
            else{
                NSInteger week = WEEK;
                NSUInteger result = seconds/week;
                strResults =[NSString stringWithFormat:@"%tu week after", result];
                break;
            }
        case periodTimeMonth:
            
            strResults =[dateString copy];       
    }
    
    return strResults;
    
}
@end
