//
//  data.m
//  step4
//
//  Created by CPU11606 on 8/4/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//


#import "DataModel.h"
#import "NSDictionary+ParseJson.h"
@implementation Data


/**
 function to init object Data with param is a dictionary
 
 @param dict dictionary
 @return object data
 */
-(Data*)initWithDict:(NSDictionary *) dict{
    if (!SAFE_TYPE(dict, NSDictionary)) {
        NSLog(@"dictionary is error ");
        return nil;
    }
    self = [super init];
    if (self) {
        self.contents = NSMutableArray.new;
        NSArray *arrResults = [dict getNSArray:@"contents"];
        for (NSDictionary *groupDic in arrResults) {
            Content * contentTemp = [[Content alloc] initWithDict:groupDic];
            
            if (SAFE_TYPE(contentTemp, Content)) {
                [self.contents addObject:contentTemp];
            }
        }
        
        self.boxes = NSMutableArray.new;
        NSArray *arrResultsBoxes = [dict getNSArray:@"boxes"];
        for (NSDictionary *groupDic in arrResultsBoxes) {
            Box * boxesTemp = [[Box alloc] initWithDict:groupDic];
            
            if (SAFE_TYPE(boxesTemp, Box)) {
                [self.boxes addObject:boxesTemp];
            }
        }
    }
    
    self.tittle = [dict getTitle];
    return self;
    
}
@end
