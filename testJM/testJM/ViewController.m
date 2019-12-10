//
//  ViewController.m
//  testJM
//
//  Created by Steve on 12/8/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ViewController.h"
#import "CountryModel.h"
#import "Person.h"
#import "Hobby.h"
#import "FreeTime.h"
#import "Country.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init ];
    NSMutableDictionary * dictCountry = [[NSMutableDictionary alloc] init ];
    NSMutableDictionary * dictCountryModel = [[NSMutableDictionary alloc] init ];

    NSMutableDictionary * freeTime = NSMutableDictionary.new;
    NSMutableDictionary * freeTime1 = NSMutableDictionary.new;
    
    NSMutableDictionary * freeTime2 = NSMutableDictionary.new;
    NSMutableDictionary * dictHobby = [[NSMutableDictionary alloc] init ];
    [dictHobby setObject:@"cau long" forKey:@"nameHobby"];
    [dictHobby setObject:@"the thao" forKey:@"typeHobby"];
  
    [dictCountry setObject:@"Viet Nam" forKey:@"typeCountry"];
    [freeTime setValue:@"12h" forKey:@"time"];
    [freeTime setValue:@"binh dinh" forKey:@"location"];
    [freeTime setObject:dictCountry forKey:@"country"];
    [freeTime1 setValue:@"13h" forKey:@"time"];
    [freeTime1 setValue:@"Phu yen" forKey:@"location"];
    [freeTime1 setObject:dictCountry forKey:@"country"];

    [freeTime2 setValue:@"14h" forKey:@"time"];
    [freeTime2 setValue:@"Binh thuan" forKey:@"location"];
    [freeTime2 setObject:dictCountry forKey:@"country"];

    NSArray * arr = @[freeTime , freeTime1, freeTime2];
    [dictCountryModel setObject:@(1) forKey:@"ID"];
    [dictCountryModel setObject:@"THAI LAND" forKey:@"country"];
    
    
   
    NSNumber *  age = @(21);
  
    
    // dict set
//    [dict setObject:arr forKey:@"arrFreeTime"];
//    [dict setObject:dictCountryModel forKey:@"countryModel"];
    [dictHobby setValue:dictCountryModel forKey:@"countryModel"];

//    [dict setObject:age forKey:@"age"];

//    [dict setObject:dictHobby forKey:@"hobby"];
    
//    [dict setObject:@"Thi" forKey:@"firstName"];
//    [dict setObject:@"Nguyen" forKey:@"lastName"];
//    Person * per = [[Person alloc] initWithDictionary:dictHobby error:nil];
    Person * per = [[Person alloc] initWithDict:dictHobby];
    id value =  [per valueForKey:@"countryModel"];
    
//    NSDictionary * serialize = [per toDictionary];
//    id  str = [serialize valueForKeyPath:@"arrFreeTime.country"];
//    NSLog(@"%@", serialize);
//    NSLog(@"%@", str);

}


@end
