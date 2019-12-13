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



@interface KeyValueSectionController ()<AlertViewProtocol, ZASwipeViewCellDelegate> {
    JsonModel * oldJsonModel;
    JsonModel * newJsonModel;

}
@property (nonatomic, strong)  AlertController * alert;
@end
@implementation KeyValueSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

#pragma make ZASwipeViewCellDelegate



- (void)view:(UIView<ZASwipeCellParentViewProtocol> *)view didEndEdittingRowAtIndexPath:(NSIndexPath *)indexPath forOrientation:(ZASwipeActionsOrientation)orientation {
    NSLog(@"check");
}


- (ZASwipeCellOptions *)view:(UIView<ZASwipeCellParentViewProtocol> *)view editActionsOptionsForRowAtIndexPath:(NSIndexPath *)indexPath forOrientation:(ZASwipeActionsOrientation)orientation {
    ZASwipeCellOptions *options = [[ZASwipeCellOptions alloc] init];
    
    options.expansionStyle = orientation == ZASwipeActionsOrientationLeft ? [ZASwipeExpansionStyle selection] : [ZASwipeExpansionStyle destructive];
//    options.transitionStyle = ZASwipeStateLeft;
    
    options.buttonSpacing = 11;
    
    return options;
}


- (void)view:(UIView<ZASwipeCellParentViewProtocol> *)view willBeginEdittingRowAtIndexPath:(NSIndexPath *)indexPath forOrientation:(ZASwipeActionsOrientation)orientation {
        NSLog(@"check");

}

- (NSArray<ZASwipeAction *> *)view:(UIView<ZASwipeCellParentViewProtocol> *)view editActionsForRowAtIndexPath:(NSIndexPath *)indexPath forOrientation:(ZASwipeActionsOrientation)orientation {
            __weak typeof(self) weakSelf = self;

           ZASwipeAction *deleteAction = [[ZASwipeAction alloc] initWithStyle:ZASwipeActionStyleDestructive title:nil handler:^(ZASwipeAction *action, NSIndexPath *indexPath) {
               [weakSelf.delegate performUpdate:self->oldJsonModel andNewObject:nil];
           }];
    deleteAction.backgroundColor = [UIColor blueColor];
    deleteAction.image = [UIImage imageNamed:@""];
           return @[deleteAction];
       
}

//- (void)configureAction:(ZASwipeAction *)action withDescriptor:(ActionDescriptor *)descriptor {
//    action.title = [descriptor titleForDisplayMode:self.buttonDisplayMode];
//    action.image = [descriptor imageForStyle:self.buttonStyle inDisplayMode:self.buttonDisplayMode];
//
//    switch (self.buttonStyle) {
//        case ButtonStyleBackgroundColor:
//            action.backgroundColor = descriptor.color;
//            break;
//        case ButtonStyleCircular:
//            action.backgroundColor = [UIColor clearColor];
//            action.textColor = descriptor.color;
//            action.font = [UIFont systemFontOfSize:13];
//            action.transitionDelgate = [ZAScaleTransition defaultTransition];
//            break;
//        default:
//            break;
//    }
//}


#pragma mark - override listSectionController

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 80);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    InforJsonCell * cell = [self.collectionContext dequeueReusableCellOfClass:InforJsonCell.class forSectionController:self atIndex:index];
    cell.delegate = self;
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
        _alert.alertView.delegate = self;

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
