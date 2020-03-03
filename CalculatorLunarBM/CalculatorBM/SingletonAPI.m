//
//  Quotations.m
//  CalculatorBM
//
//  Created by vincent on 3/2/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "SingletonAPI.h"
@interface SingletonAPI()
@property (nonatomic, strong)NSArray *quotationArr;
@property (nonatomic, strong)NSArray *imageArr;

@end
@implementation SingletonAPI
@synthesize quotationArr = _quotationArr;
+ (SingletonAPI *)sharedInstance {
    static SingletonAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getQuote:(NSInteger)jdn {
    NSInteger r = arc4random_uniform((uint32_t)self.getQuotationArr.count);
    return self.getQuotationArr[r];
}

-(NSURL *)getURLImage:(NSInteger)jdn {
    NSInteger index = jdn % self.getImageArr.count;
    NSString * strURL = self.getImageArr[index];
    return [NSURL URLWithString:strURL];
}

- (NSArray *)getQuotationArr{
    if (!_quotationArr) {
        NSArray * arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"quotations" ofType:@"plist"]];
      _quotationArr = arr;
 }
    return _quotationArr;
}

-(NSArray *)getImageArr {
    if (!_imageArr) {
        NSArray * arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"images" ofType:@"plist"]];
        _imageArr = arr;
        }
    return _imageArr;
}

@end
