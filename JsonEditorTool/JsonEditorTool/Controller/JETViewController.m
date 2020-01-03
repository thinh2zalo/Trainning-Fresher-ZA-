//
//  ViewController.m
//  JsonEditorTool
//
//  Created by Steve on 11/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "JETViewController.h"
#import "Define.h"
#import "../Network/NetworkManager.h"
#import <IGListKit/IGListKit.h>
#import "../View/InforJsonCell.h"
#import "../SectionController/SearchSectionController.h"
#import "../SectionController/KeyValueSectionController.h"
#import "../Controller/AlertController.h"
#import "../handleContentFile/HandleContentFile.h"
#import "../Model/JsonModekFactory.h"
#import "../DLRadioButton/DLRadioButton.h"
#import "../View/Button.h"
#import "../Network/EndPoint.h"

#import "../View/EmptyView.h"
#import "OrderedDictionary.h"
#import "../../Pods/AFNetworking/AFNetworking/AFNetworking.h"
#import "JsonSerializationCustom.h"
#import "ArrayJM.h"
#import "BoolJM.h"
#import "StringJM.h"
#import "NullJM.h"
#import "NumberJM.h"


@interface JETViewController () <SearchSectionControllerDelegate, UITextFieldDelegate, IGListAdapterMoveDelegate>
@property (nonatomic, strong) NSDictionary * dict;
@property (nonatomic, strong) IGListAdapter * adapter;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong)  AlertController * alert;
@property (nonatomic,strong) DLRadioButton * grRadioBtn;
@property (nonatomic, strong) UITextField * oSVField;
@property (nonatomic, strong) TextField * verField;
@property (nonatomic, strong) Button *  commitBtn;
@property (nonatomic, strong) UIView *  settingView;
@property (nonatomic, strong) EmptyView *  emptyView;
@property (nonatomic, strong) UIView * backGroundSettingView ;
@property (nonatomic, strong) UILabel * errorMessLabel ;
@property (nonatomic, strong) UIGestureRecognizer  * longPress ;

 

@property (nonatomic, strong) NSString * osStr;
@property (nonatomic, strong) NSMutableArray <JsonModel *> * allJsonModel;

typedef NS_ENUM(NSInteger, TypeEditJson){
    typeAddNewJson,
    typeDeleteJson,
    typeEditNameJson,
};
@property (nonatomic, assign) TypeEditJson  typeEditJson;
@end

@interface JETViewController() <IGListAdapterDataSource, UISearchBarDelegate, UICollectionViewDelegate, KeyValueSectionControllerDelegate> {
    NSNumber * searchToken;
    NSString * textFilter;
}
@end

@implementation JETViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    textFilter = @"";
    searchToken = @(42);
    self.osStr = @"ios";
    if (!_jsonModel) {
        self.backGroundSettingView.frame = self.view.bounds;
        self.backGroundSettingView.backgroundColor = [UIColor whiteColor];
        self.settingView.frame = CGRectMake(0, self.view.frame.size.height/5, self.view.frame.size.width, 200);
        
        [self.navigationController setNavigationBarHidden:YES];
        [self setUpSettingView];
    } else {
        [self setupUI];
    }
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}



- (void)commitEndpoint {
    if (![self.verField.text isEqualToString:@""]) {
        EndPoint * endpoint = [[EndPoint alloc] initWithOs:self.osStr andVer:self.verField.text];
        [self loadData:endpoint];
    } else {
        
    }
    
}

- (void )toggleOs:(DLRadioButton *) radioBtn {
    self.osStr = radioBtn.titleLabel.text;
}
- (void)loadData:(EndPoint *)endPoint {
    NSURL * url = [NSURL URLWithString:endPoint.urlRequest];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self.navigationController setNavigationBarHidden:NO];
    [NetworkManager.shareInstance  request:request completion:^(id  _Nullable response, NSString * _Nullable errorMsg){
        
        if ([response isKindOfClass:NSData.class]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                
                OrderedDictionary * orderDict = [JsonSerializationCustom JSONObjectWithData:response options:0 error:nil];
                
                OrderedDictionary * resultDict = [orderDict objectForKey:@"result"];
                self.jsonModel = [[DictionaryJM alloc] initWithObject:resultDict andKey:@"results"];
                self.allJsonModel = nil;
                [self createDictSameLevel:(DictionaryJM *)self.jsonModel];
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [self setupUI];
                    [self adapter];
                    
                    [self.backGroundSettingView setHidden:YES];
                });
            });
        } else {
            self.errorMessLabel.text = errorMsg;
            [self.errorMessLabel setHidden:NO];
        }
    }];
    
}

- (void)createDictSameLevel:(JsonModel *)jsonModel {
    if ([jsonModel isKindOfClass:DictionaryJM.class] || [jsonModel isKindOfClass:ArrayJM.class ]) {
        [self.allJsonModel addObject:jsonModel];
        for (JsonModel * jm in jsonModel.value) {
            if ([jm isKindOfClass:DictionaryJM.class] || [jm isKindOfClass:ArrayJM.class]) {
                [self createDictSameLevel:jm];
            }
            else {
                [self.allJsonModel addObject:jm];
                
            }
        }
        
    }
}

- (BOOL)isAlreadyJsonModel:(JsonModel *)jsonModel inArray:(NSArray <JsonModel *> *) arrJsonModel{
    for (JsonModel * js in arrJsonModel) {
        if ([jsonModel.key isEqualToString: js.key]) {
            return true;
        }
    }
    return false;
}
#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([text isEqualToString:@""]) {
        [self.commitBtn setUserInteractionEnabled:NO];
    } else {
        [self.commitBtn setUserInteractionEnabled:YES];
        
    }
    return true;
}



- (void)editRootJM:(JsonModel *)rootJM oldJM:(JsonModel *) oldJM newJM:(JsonModel *)newJM {
    NSMutableArray * arrRootAllJM = [(JETViewController *)self.navigationController.childViewControllers.firstObject allJsonModel];
    if (oldJM) {
        JsonModel *parrentOfOldJM = oldJM.parrent;
        if (newJM) {
            NSUInteger index =   [parrentOfOldJM.value indexOfObject:oldJM];
            [parrentOfOldJM.value replaceObjectAtIndex:index withObject:newJM];
            NSUInteger index2 = [arrRootAllJM indexOfObject:oldJM];
            [arrRootAllJM replaceObjectAtIndex:index2 withObject:newJM];
        }
        else {
            [parrentOfOldJM.value removeObject:oldJM];
            [arrRootAllJM removeObject:oldJM];
        }
    } else {
        if (newJM) {
            [rootJM.value addObject:newJM];
            [arrRootAllJM addObject:newJM];
            
        }
    }
    
}


#pragma mark - IGListAdapterMoveDelegate

- (void)listAdapter:(IGListAdapter *)listAdapter moveObject:(id)object from:(NSArray *)previousObjects to:(NSArray *)objects {
    NSRange range = NSMakeRange(1, objects.count - 1);
    self.jsonModel.value = [NSMutableArray arrayWithArray:[objects subarrayWithRange:range]];
    
}

#pragma mark - KeyValueSectionControllerDelegate

- (void)performUpdate:(JsonModel *)oldObject andNewObject:(JsonModel *)newObject {
    JsonModel * rootJM = [self.navigationController.childViewControllers.firstObject jsonModel];
    [self editRootJM:rootJM oldJM:oldObject newJM:newObject];
    [self.adapter performUpdatesAnimated:YES completion:nil];
    
}

#pragma mark - save after add + edit name json




#pragma mark - AlertViewPotocol

- (void)convertJsonModel:(JsonModel *)oldJM toJsonModel:(JsonModel *)newJM {
    if (self.typeEditJson == typeEditNameJson) {

           NSInteger indexVC = [self.navigationController.childViewControllers indexOfObject:self];
           JETViewController * vc =  self.navigationController.childViewControllers[indexVC -1];
           if ([vc isKindOfClass:JETViewController.class]) {
               NSInteger indexOfObject = [vc.jsonModel.value indexOfObject:self.jsonModel];
               [vc.jsonModel.value replaceObjectAtIndex:indexOfObject withObject:oldJM];
               [vc.adapter performUpdatesAnimated:NO completion:nil];
               self.navigationItem.title = oldJM.key;
               [_alert fadeOut];
           }

       } else {
           if (![self isAlreadyJsonModel:oldJM inArray:[self.jsonModel value]]) {
               oldJM.parrent = self.jsonModel;
               [[self.jsonModel value] addObject:oldJM];
               [[(JETViewController *)self.navigationController.childViewControllers.firstObject allJsonModel] addObject:oldJM];
               [self.adapter performUpdatesAnimated:YES completion:nil];
               [_alert fadeOut];
           } else {
               [[_alert.alertView errorLable] setText:@"key is already exists"];
               [[_alert.alertView errorLable] setHidden:NO];

           }
       }
}

- (void)cancelAlert {
    [self.adapter performUpdatesAnimated:YES completion:nil];
    [_alert fadeOut];
}



#pragma mark - set update view

- (void)setupUI {
    [self adapter];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.jsonModel.key style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    self.navigationItem.title = self.jsonModel.key;
    
    self.emptyView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more_btn"] style:UIBarButtonItemStyleDone target:self action:@selector(moreFunction)];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_btn"] style:UIBarButtonItemStyleDone target:self action:@selector(addNewItem)];
    [self.navigationItem setRightBarButtonItems:@[moreItem, addItem]];
    self.navigationItem.backBarButtonItem = backButtonItem;
    [self.view endEditing:YES];
    
    
}

- (void)showSettingView {
    [self.backGroundSettingView setHidden:NO];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)setUpSettingView {
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"change_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(showSettingView)];
    [self.navigationItem setLeftBarButtonItem:addItem];
    
    self.grRadioBtn = DLRadioButton.new;
    self.verField.frame = CGRectMake(0,  0 , 200, 50);
    self.verField.center =  CGPointMake(self.settingView.frame.size.width/2, self.settingView.frame.size.height/3);
    self.verField.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.verField.borderStyle = UITextBorderStyleRoundedRect;
    self.verField.layer.masksToBounds = YES;
    self.verField.layer.cornerRadius = 10;
    self.verField.layer.borderWidth = 1.0f;
    DLRadioButton * androidBtn = [self createRadioButtonWithFrame:CGRectMake(self.verField.frame.origin.x + 10 ,self.verField.frame.origin.y + self.verField.frame.size.height + 20, 150, 20) Title:@"android" Color:[UIColor blackColor]];
    DLRadioButton * iosBtn = [self createRadioButtonWithFrame:CGRectMake(50 + 180 ,androidBtn.frame.origin.y, 150, 20) Title:@"ios" Color:[UIColor blackColor]];
    self.commitBtn.frame = CGRectMake(40,  self.oSVField.frame.origin.y + 50 + 40, 200, 40);
    self.commitBtn.center = CGPointMake(self.settingView.frame.size.width/2, iosBtn.frame.origin.y + 70);
    
    self.errorMessLabel.frame = CGRectMake(0, self.commitBtn.frame.origin.y
                                           + 40, 166, 30);
    self.errorMessLabel.center = CGPointMake(self.view.frame.size.width/2, self.commitBtn.frame.origin.y + 70);
    [self.errorMessLabel setHidden:YES];
    self.grRadioBtn.otherButtons = @[androidBtn, iosBtn];
    self.grRadioBtn.otherButtons[1].selected = YES;
}

#pragma mark - SearchSectionControllerDelegate
- (void)searchSectionController:(IGListSectionController *)sectionController andDidChangeText:(NSString *)text {
    textFilter = text;
    
    [self.adapter performUpdatesAnimated:YES completion:nil];
}


- (void)noHandle {
    
}

#pragma mark - IGListAdapterDataSource
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    
    if ([self.collectionView.gestureRecognizers containsObject:self.longPress]) {
        [self.collectionView removeGestureRecognizer:self.longPress];
    }
    
    self.longPress = [self.longPress initWithTarget:self action:@selector(handleLongPress:)];
    if ([[self.jsonModel value] count] > 0) {
        if ([textFilter isEqual:@""]) {
            [self.collectionView addGestureRecognizer:self.longPress];
            
            return [@[searchToken] arrayByAddingObjectsFromArray:[self.jsonModel value]];
        } else {
            
            self.longPress = [self.longPress initWithTarget:self action:@selector(noHandle)];
            
            NSPredicate *predicateIndex = [NSPredicate predicateWithFormat:@"key != %@", @"INDEX_"];
            
            NSPredicate *predicateKey = [NSPredicate predicateWithFormat:@"key contains[cd] %@ AND NOT (key contains[cd] %@)" ,textFilter, @"INDEX_"];
            NSPredicate *predicateType = [NSPredicate predicateWithFormat: @"self isKindOfClass: %@ OR self isKindOfClass: %@", NumberJM.class, StringJM.class];
            
            
            NSPredicate *predicateValue = [NSPredicate predicateWithFormat:@"CAST(value,'NSString') contains[cd] %@" , textFilter];
            NSPredicate *predicateValueAndType = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicateType, predicateValue, predicateIndex]];
            
            
            NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[predicateKey, predicateValueAndType]];
            NSArray * subArr = [[(JETViewController *)self.navigationController.viewControllers.firstObject allJsonModel] filteredArrayUsingPredicate:predicate];
            return [@[searchToken] arrayByAddingObjectsFromArray:subArr];
        }
    } else {
        return nil;
    }
    
}


- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ((NSNumber *)object == searchToken) {
        SearchSectionController * searchSC = SearchSectionController.new;
        searchSC.delegate = self;
        return searchSC;
    } else {
        KeyValueSectionController * kv = KeyValueSectionController.new;
        kv.delegate = self;
        return kv;
    }
    
}


- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    
    return self.emptyView;
}

#pragma mark - handle when touch button

- (void)addNewItem {
    _alert = AlertController.new;
    _alert.alertView.delegate = self;
    [_alert showAlert:self withJsonModel:nil];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint location = [gesture locationInView:self.collectionView];
            NSIndexPath * indexOfItemSeleted = [self.collectionView indexPathForItemAtPoint:location];
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexOfItemSeleted];
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            CGPoint position = [gesture locationInView:self.collectionView];
            [self.collectionView updateInteractiveMovementTargetPosition:position ];
            
        }
            break;
        case UIGestureRecognizerStateEnded:
            [self.collectionView endInteractiveMovement];
            break;
            
            
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}
// sav
- (NSString *)saveFile{
    OrderedDictionary * dict = [[(JETViewController *) self.navigationController.viewControllers.firstObject jsonModel] toOrderDictionary];
    NSData *myData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingFragmentsAllowed error:nil];
    NSString * date = [NSString stringWithFormat:@"%@", [NSDate date]];
    NSString * path = [NSString stringWithFormat:@"%@/tmp/fileJson_%@.txt", NSHomeDirectory(),date];
    
    OutputStream * output = [[OutputStream alloc]initWithPath: path];
    [output writeData:myData];
    return path;
    
}

- (void)shareMessenger {
    
    id fileURL = [[NSURL alloc] initFileURLWithPath:[self saveFile]];
    if (fileURL) {
        UIActivityViewController * ac = [[UIActivityViewController alloc] initWithActivityItems:@[fileURL] applicationActivities:nil];
        [self presentViewController:ac animated:YES completion:nil];
    }
    
}

- (void)moreFunction {
    UIAlertController* moreFunction = [UIAlertController alertControllerWithTitle:@"more" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak JETViewController *weakSelf = self;
    
    UIAlertAction* shareMessage = [UIAlertAction actionWithTitle:@"share file" style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action) {
        [self shareMessenger];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
        
    }];
    UIAlertAction* editKey = [UIAlertAction actionWithTitle:NSLocalizedString(@"edit key", nil) style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * action) {
        
        weakSelf.alert = AlertController.new;
        weakSelf.alert.alertView.delegate = self;
        [weakSelf.alert showAlert:weakSelf withJsonModel:weakSelf.jsonModel];
        weakSelf.typeEditJson = typeEditNameJson;
        
    }];
    
    [moreFunction addAction:shareMessage];
    [moreFunction addAction:cancelAction];
    if ([self.navigationController.childViewControllers indexOfObject:self] != 0) {
        [moreFunction addAction:editKey];
        
    }
    
    [self presentViewController:moreFunction animated:YES completion:nil];
    
}



#pragma mark - lazy init
- (UILabel *)errorMessLabel {
    if (!_errorMessLabel) {
        _errorMessLabel = UILabel.new;
        _errorMessLabel.textColor = [UIColor redColor];
        [self.settingView addSubview:_errorMessLabel];
    }
    return _errorMessLabel;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}



- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init]
                                           viewController:self];
        _adapter.collectionViewDelegate = self;
        _adapter.moveDelegate = self;
        _adapter.collectionView = self.collectionView;
        _adapter.dataSource = self;
    }
    return _adapter;
}

- (NSMutableArray<JsonModel *> *)allJsonModel {
    if (!_allJsonModel) {
        _allJsonModel = NSMutableArray.new;
    }
    return _allJsonModel;
}

- (EmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = EmptyView.new;
        [self.view addSubview:_emptyView];
        
    }
    return _emptyView;
}
- (UIView *)backGroundSettingView {
    if (!_backGroundSettingView) {
        _backGroundSettingView = UIView.new;
        [self.view insertSubview:_backGroundSettingView aboveSubview:self.collectionView];
    }
    return _backGroundSettingView;
}



- (TextField *)verField {
    if (!_verField) {
        _verField = TextField.new;
        _verField.delegate = self;
        [_verField setPlaceholder:@"version"];
        [self.settingView addSubview:_verField];
    }
    return _verField;
}

- (Button *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = Button.new;
        _commitBtn.backgroundColor = [UIColor blueColor];
        [_commitBtn setTitle:@"Commit" forState:UIControlStateNormal];
        _commitBtn.layer.cornerRadius = 5;
        [_commitBtn addTarget:self action:@selector(commitEndpoint) forControlEvents:UIControlEventTouchUpInside];
        [self.settingView addSubview:_commitBtn];
    }
    return _commitBtn;
}

- (UIView *)settingView {
    if (!_settingView) {
        _settingView = UIView.new;
        [self.backGroundSettingView addSubview:_settingView];
    }
    return _settingView;
}

- (UIGestureRecognizer *)longPress {
    if (!_longPress) {
        _longPress = UILongPressGestureRecognizer.new;
    }
    return _longPress;
}
- (DLRadioButton *)createRadioButtonWithFrame:(CGRect) frame Title:(NSString *)title Color:(UIColor *)color
{
    DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:frame];
    radioButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [radioButton setTitle:title forState:UIControlStateNormal];
    [radioButton setTitleColor:color forState:UIControlStateNormal];
    radioButton.iconColor = color;
    radioButton.typeValue = [DLRadioButton getType:title];
    
    radioButton.indicatorColor = color;
    radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [radioButton addTarget:self action:@selector(toggleOs:) forControlEvents:UIControlEventTouchUpInside];
    [self.settingView addSubview:radioButton];
    
    return radioButton;
}




@end
