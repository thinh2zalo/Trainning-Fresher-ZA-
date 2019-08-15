//
//  NSArray+handleTailFile.m
//  project7_11
//
//  Created by CPU11606 on 8/7/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "NSArray+handleTailFile.h"

@implementation NSArray (handleTailFile)
- (NSArray *)HandleTaiFile:(NSArray *)listFileName{
    NSMutableArray * result;
    NSMutableDictionary<NSString*, NSNumber*> *dictForListFile = NSMutableDictionary.new;
    for (NSString  *each in listFileName) {
        NSInteger count = 0;
        NSInteger index = 0;
        count = [dictForListFile objectForKey:each].integerValue;
        NSString *stringAfterAppend;
        NSObject * checkObject = [dictForListFile objectForKey:each];
        if(!checkObject){
            [dictForListFile setObject:[NSNumber numberWithUnsignedInteger:0] forKey:each];
            NSLog(@"%@",each);
        }
        else{
            do{
                index++;
                NSString* aStringAddedInDex = [NSString stringWithFormat:@"(%tu)", index];
                stringAfterAppend = [each stringByAppendingString:aStringAddedInDex];
            } while([dictForListFile objectForKey:stringAfterAppend]);
            //update dictionary for key and key after
            [dictForListFile setObject:[NSNumber numberWithUnsignedInteger:count++] forKey:each];
            [dictForListFile setObject:[NSNumber numberWithUnsignedInteger:0] forKey:stringAfterAppend];
            NSLog(@"%@", stringAfterAppend);
            
        }
    }
    return result;
}


@end
