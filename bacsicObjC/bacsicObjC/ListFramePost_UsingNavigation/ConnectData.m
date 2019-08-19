//
//  connectData.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/18/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "ConnectData.h"

@implementation ConnectData
+ (Data *)connectData{
    Data *data = Data.new;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"json"];
    if (![path isKindOfClass:NSString.class]){
        NSLog(@"path is error");
     
    }
    else{
        NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        NSDictionary *dataFromDict = [jsonObject objectForKey:@"data"];
        if ([dataFromDict isKindOfClass:NSDictionary.class]){
            data = [data initWithDict:dataFromDict];
        }
      
    }
    return data;
   
}
@end
