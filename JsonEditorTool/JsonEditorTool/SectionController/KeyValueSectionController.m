//
//  KeyValueSectionController.m
//  JsonEditorTool
//
//  Created by Steve on 12/4/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "KeyValueSectionController.h"
#import "../View/InforJsonCell.h"
#import "../Model/JsonModel.h"
#import "../Controller/ViewController.h"
#import "../Controller/AlertController.h"



@interface KeyValueSectionController ()<AlertViewProtocol> {
    JsonModel * oldJsonModel;
    JsonModel * newJsonModel;

}
@property (nonatomic, strong)  AlertController * alert;
@end
@implementation KeyValueSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(20, 0, 0, 0);
    }
    return self;
}



#pragma mark - override listSectionController

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 70);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    InforJsonCell * cell = [self.collectionContext dequeueReusableCellOfClass:InforJsonCell.class forSectionController:self atIndex:index];
    [cell updateContentInsideCell:oldJsonModel];
    return cell;
}

- (void)didUpdateToObject:(id)object {
    oldJsonModel = object;
    
    
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    ViewController * viewController = ViewController.new;
    
    viewController.jsonModel = oldJsonModel;
    if (oldJsonModel.typeValue == typeValueArray || oldJsonModel.typeValue == typeValueDictionary) {
        UINavigationController *navController = self.viewController.navigationController;
        [navController pushViewController:viewController animated:YES];
    } else {
        _alert = AlertController.new;
        _alert.contentView.delegate = self;
        [_alert showAlert:self.viewController withJsonModel:oldJsonModel];
    }
   
}


- (void)cancelAlert {
    [_alert fadeOut];
}

- (void)saveAfterConfig:(JsonModel *) jsonModel {
    // check respone
    if (self.delegate) {
        [self.delegate performUpdate:oldJsonModel andNewObject:jsonModel];
        
    }
    [_alert fadeOut];

    
}

@end
