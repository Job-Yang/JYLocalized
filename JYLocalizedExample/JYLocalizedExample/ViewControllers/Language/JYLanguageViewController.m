//
//  JYLanguageViewController.m
//  360zebra
//
//  Created by 杨权 on 2016/11/3.
//  Copyright © 2016年 360zebra. All rights reserved.
//

#import "JYLanguageViewController.h"
#import "JYCellModel.h"

static NSString *const kJYTableViewCell = @"JYTableViewCell";

@interface JYLanguageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<JYCellModel *> *languageList;
@end

@implementation JYLanguageViewController

#pragma mark - life cycle
- (void)dealloc {
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = JYLocalizedString(@"语言设置", nil);
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - setup methods

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.languageList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYTableViewCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kJYTableViewCell];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    JYCellModel *model = self.languageList[indexPath.row];
    cell.accessoryType = model.enabled ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    cell.textLabel.text = model.title;

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (int i = 0; i < self.languageList.count; i++) {
        JYCellModel *model = self.languageList[i];
        model.enabled = (indexPath.row == i);
    }
    [self.tableView reloadData];
}

#pragma mark - requests

#pragma mark - router

#pragma mark - event & response
- (void)rightBarButtonAction:(id)sender {
    
    NSString *key = [self getCurrentKey];
    NSString *currentLanguage = [[JYLocalizedHelper standardHelper] currentLanguage];
    if (key && ![key isEqualToString:currentLanguage]) {
        @weakify(self);
        //这里延时是为了让用户觉得我们确实在费力的切换语言，不然很突兀
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self changeLanguageForKey:key];
        });
    }
}

#pragma mark - private methods
- (void)changeLanguageForKey:(NSString *)key {
    [[JYRouter router] popToRoot];
    [[JYLocalizedHelper standardHelper] setUserLanguage:key]; //将新的语言标示存入本地
    //延时操作，等POP动画结束
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotifyRootViewControllerReset" object:nil];//发送刷新页面通知
    });
}

- (NSString *)getCurrentKey {
    NSString *key;
    for (int i = 0; i < self.languageList.count; i++) {
        JYCellModel *model = self.languageList[i];
        if (self.languageList[i].enabled == YES) {
            key = model.key;
        }
    }
    return key;
}

#pragma mark - getter & setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_LAYOUT_GUIDE, SCREEN_WIDTH, SAFE_HEIGHT)];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray<JYCellModel *> *)languageList {
    if (!_languageList) {
        _languageList  = [NSMutableArray array];
        NSError *error = nil;
        NSString *path = [JYBundle pathForResource:@"myAddress" ofType:@"json"];
        NSData *data   = [[NSData alloc] initWithContentsOfFile:path];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
        for (NSDictionary *dic in array) {
            JYCellModel *model = [JYCellModel yy_modelWithJSON:dic];
            if ([model.key isEqualToString:[[JYLocalizedHelper standardHelper] currentLanguage]]) {
                model.enabled = YES;
            }
            [_languageList addObject:model];
        }
    }
    return _languageList;
}


@end
