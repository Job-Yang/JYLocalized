//
//  JYMineViewController.m
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/9/27.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import "JYMineViewController.h"
#import "JYCellModel.h"
#import "JYMineHeaderView.h"
#import "JYTableViewCell.h"

static NSString *const kJYTableViewCell = @"JYTableViewCell";

@interface JYMineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) JYMineHeaderView *headerView;
@property (strong, nonatomic) NSArray<JYCellModel *> *models;

@end

@implementation JYMineViewController

#pragma mark - life cycle
- (void)dealloc {
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - setup methods

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [JYTableViewCell heightWithData:self.models[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJYTableViewCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:kJYTableViewCell owner:self options:nil] lastObject];
    }
    [cell resetWithData:self.models[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JYCellModel *model = self.models[indexPath.row];
    SEL sel = NSSelectorFromString(model.selName);
    if (sel && [self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *)imp;
        func(self, sel, nil);
    }
}

#pragma mark - requests

#pragma mark - event & response
- (void)jumpToMultiLanguageVC {
    NSDictionary *params = @{
                             @"hidesBottomBarWhenPushed" : @(YES),
                             };
    [[JYRouter router] push:@"JYLanguageViewController" animated:YES params:params];
}

#pragma mark - private methods
- (void)resetModels {
    self.models = nil;
    [self models];
    [self.tableView reloadData];
}

#pragma mark - getter & setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, SAFE_HEIGHT+NAVIGATION_BAR_HEIGHT)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (JYMineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[JYMineHeaderView alloc] init];
    }
    return _headerView;
}

- (NSArray<JYCellModel *> *)models {
    if (!_models) {
        NSError *error = nil;
        NSString *path = [[NSBundle localizedBundle] pathForResource:@"mineConfig" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        _models = [NSArray yy_modelArrayWithClass:[JYCellModel class] json:array];
    }
    return _models;
}


@end
