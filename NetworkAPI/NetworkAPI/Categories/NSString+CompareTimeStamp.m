//
//  NSString+CompareTimeStamp.m
//  Step12_17
//
//  Created by CPU11606 on 8/7/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "NSString+CompareTimeStamp.h"

@implementation NSString (CompareTimeStamp)
+(NSString *)convertTimestamp:(NSInteger)timestampInput{
    long long timestamp = (long long)([[NSDate date] timeIntervalSince1970]);
    long long diffTimestamp = timestamp - timestampInput;
    
    if  (diffTimestamp < 0){
        diffTimestamp = - diffTimestamp;
    }
    NSString *strResults;
    long long seconds = diffTimestamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestampInput];
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
            if (timestamp > timestampInput) {
                NSLog(@"just now"); break;
            }
            else{
                NSLog(@"little bit"); break;
            }
            
        case periodTimeMinute:
            if (timestamp > timestampInput) {
                NSInteger minute = MINUTE;
                NSUInteger result = seconds/minute;
                strResults =[NSString stringWithFormat:@"%tu phút trước", result];
                break;
            }
            else{
                NSInteger minute = MINUTE;
                NSUInteger result = seconds/minute;
                strResults =[NSString stringWithFormat:@"%tu phút nữa", result];
                break;
                
            }
            
            
        case periodTimeHouse:
            if (timestamp > timestampInput) {
                NSInteger house = HOUSE;
                NSUInteger result = seconds/house;
                strResults =[NSString stringWithFormat:@"%tu giờ trước", result];
                break;
                
            }
            else{
                NSInteger house = HOUSE;
                NSUInteger result = seconds/house;
                strResults =[NSString stringWithFormat:@"%tu giờ nữa", result];
                break;
                
            }
        case periodTimeDay:
            
            if (timestamp > timestampInput) {
                
                NSInteger day = DAY;
                NSUInteger result = seconds/day;
                strResults =[NSString stringWithFormat:@"%tu ngày trước", result];
                break;
                
            }
            else{
                NSInteger day = DAY;
                NSUInteger result = seconds/day;
                strResults =[NSString stringWithFormat:@"%tu ngày nữa", result];
                break;
            }
        case periodTimeWeek:
            if (timestamp > timestampInput) {
                NSInteger week = WEEK;
                NSUInteger result = seconds/week;
                strResults =[NSString stringWithFormat:@"%tu tuần trước", result];
                break;
                
            }
            else{
                NSInteger week = WEEK;
                NSUInteger result = seconds/week;
                strResults =[NSString stringWithFormat:@"%tu tuần nữa", result];
                break;
            }
        case periodTimeMonth:
            
            strResults = [dateString copy];
    }
    
    return strResults;
    
}
@end
