//
//  ViewController.m
//  JsonEditorTool
//
//  Created by Steve on 11/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ViewController.h"
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
#import <SCLAlertView.h>
#import <MBProgressHUD.h>
#import "../View/EmptyView.h"
#import "OrderedDictionary.h"
@interface ViewController () <SearchSectionControllerDelegate, UITextFieldDelegate>
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
@property (nonatomic, strong) NSString * osStr;
typedef NS_ENUM(NSInteger, TypeEditJson){
    typeAddNewJson,
    typeDeleteJson,
    typeEditNameJson,
};
@property (nonatomic, assign) TypeEditJson  typeEditJson;
@end

@interface ViewController() <IGListAdapterDataSource, UISearchBarDelegate, UICollectionViewDelegate, KeyValueSectionControllerDelegate, AlertViewProtocol> {
    NSNumber * searchToken;
    NSString * textFilter;
}
@end

@implementation ViewController

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
//

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
        
        if ([response isKindOfClass:NSDictionary.class]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                
                self.jsonModel = [[DictionaryJM alloc] initWithObject:response andKey:@"result"];
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [self setupUI];
                    [self adapter];
                    
                    [self.backGroundSettingView setHidden:YES];
                });
            });
        } else {
            NSLog(@"%@", errorMsg);
        }
    }];
    
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

#pragma mark - KeyValueSectionControllerDelegate

- (void)performUpdate:(JsonModel *)oldObject andNewObject:(JsonModel *)newObject {
    NSLog(@"newObject%@", newObject);
    NSUInteger index = [[self.jsonModel value] indexOfObject:oldObject];
    if (oldObject && newObject) {
        [[self.jsonModel value] replaceObjectAtIndex:index withObject:newObject];
    } else if (!oldObject && newObject){
        [[self.jsonModel value]  addObject:newObject];
    } else {
        [[self.jsonModel value] removeObject:oldObject];
    }
    [self.adapter performUpdatesAnimated:YES completion:nil];
    
    
}

#pragma mark - save after add + edit name json

- (void)cancelAlert {
    [_alert fadeOut];
}

- (void)saveAfterConfig:(JsonModel *) jsonModel {
    if (self.typeEditJson == typeEditNameJson) {
        
        NSInteger indexVC = [self.navigationController.childViewControllers indexOfObject:self];
        ViewController * vc = self.navigationController.childViewControllers[indexVC -1];
        if ([vc isKindOfClass:ViewController.class]) {
            NSInteger indexOfObject = [vc.jsonModel.value indexOfObject:self.jsonModel];
            [vc.jsonModel.value replaceObjectAtIndex:indexOfObject withObject:jsonModel];
            [vc.adapter performUpdatesAnimated:NO completion:nil];
            self.navigationItem.title = jsonModel.key;
            [_alert fadeOut];
        }
        
    } else {
        if (![self isAlreadyJsonModel:jsonModel inArray:[self.jsonModel value]]) {
            [[self.jsonModel value] addObject:jsonModel];
            [self.adapter performUpdatesAnimated:YES completion:nil];
            [_alert fadeOut];
        }
    }
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
    
    self.grRadioBtn.otherButtons = @[androidBtn, iosBtn] ;
    self.grRadioBtn.otherButtons[1].selected = YES;
}

#pragma mark - SearchSectionControllerDelegate
- (void)searchSectionController:(IGListSectionController *)sectionController andDidChangeText:(NSString *)text {
    textFilter = text;
    
    [self.adapter performUpdatesAnimated:YES completion:nil];
}
- (void)addNewItem {
    _alert = AlertController.new;
    _alert.alertView.delegate = self;
    [_alert showAlert:self withJsonModel:nil];
}

#pragma mark - IGListAdapterDataSource
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    NSLog(@"updateObejct ");
    if ([[self.jsonModel value] count] > 0) {
        if ([textFilter isEqual:@""]) {
            return [@[searchToken] arrayByAddingObjectsFromArray:[self.jsonModel value]];
        } else {
            
            NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"key contains[cd] %@", textFilter];
            NSArray * subArr = [[self.jsonModel value] filteredArrayUsingPredicate:filterPredicate];
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

// sav
- (NSString *)saveFile{
    NSDictionary * dict = [[(ViewController *) self.navigationController.viewControllers.firstObject jsonModel] toDictionary];
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
    
    __weak ViewController *weakSelf = self;
    
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

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
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
        _adapter.collectionView = self.collectionView;
        _adapter.dataSource = self;
    }
    return _adapter;
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
