//
//  Quotations.m
//  CalculatorBM
//
//  Created by vincent on 3/2/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "SingletonAPI.h"
#import "define2.h"
@interface SingletonAPI()
@property (nonatomic, strong)NSArray *quotationArr;
@property (nonatomic, strong)NSArray *imageArr;

@end
@implementation SingletonAPI
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
    if (self.getImageArr.count == 0) {
        return nil;
    }
    NSInteger index = jdn % self.getImageArr.count;
    NSString * strURL = self.getImageArr[index];
    return [NSURL URLWithString:strURL];
}



- (NSArray *)getQuotationArr {
    if (!_quotationArr) {
//        NSArray * arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:FILE_QUOTATIONS ofType:TYPEFILE_PLIST]];
  NSArray * arr = @[@"Hạnh phúc lớn nhất ở đời là có thể tin chắc rằng ta được yêu thương - Yêu vì chính bản thân ta, hay đúng hơn, yêu bất kể bản thân ta", @"Yêu thương mang lại nhiều lạc thú hơn là được yêu"];      _quotationArr = arr;
 }
    return _quotationArr;
}

-(NSArray *)getImageArr {
    if (!_imageArr) {
//        NSArray * arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:FILE_URLIMG ofType:TYPEFILE_PLIST]];
        NSArray * arr = @[@"https://i.imgur.com/FLL3rV4.jpg", @"https://i.imgur.com/WWclFV1.jpg"];

      
        _imageArr = arr;
        }
    return _imageArr;
}

@end
