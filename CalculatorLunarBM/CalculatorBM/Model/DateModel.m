//
//  DateModel.m
//  CalculatorBM
//
//  Created by vincent on 2/26/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "DateModel.h"
#import "SingletonAPI.h"
@interface DateModel ()

@end

@implementation DateModel

- (instancetype)initWithDate:(NSInteger)jdn quote:(NSString *)quote imageURL:(NSURL *)imageURL {
    self = [super init];
    if (self) {
        _jdn = jdn;
        _quote = quote;
        _imageURL = imageURL;
    }
    return self;
}

+ (DateModel *)createDataModel:(NSInteger)jdn {
    NSString *quote = [SingletonAPI.sharedInstance getQuote:jdn];
    NSURL *urlImage = [SingletonAPI.sharedInstance getURLImage:jdn];
    return [[DateModel alloc] initWithDate:jdn quote:quote imageURL:urlImage];
}


- (NSString *)quote {
    if (!_quote) {
        _quote = NSString.new;
    }
    return _quote;
}

- (NSURL *)imageURL {
    if (!_imageURL) {
        _imageURL = NSURL.new;
    }
    return _imageURL;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
