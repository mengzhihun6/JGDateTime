//
//  JGRootViewController.m
//  JGDateTime
//
//  Created by stkcctv on 16/12/24.
//  Copyright © 2016年 JG. All rights reserved.
//

#import "JGRootViewController.h"
#import "MainViewController.h"

//尺寸
#define kDeviceHight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width

//颜色定义
#define JGRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JGGlobaBgColor JGRGBColor(32, 175, 157);


//方式一
#import "FDAlertView.h"
#import "RBCustomDatePickerView.h"

//方式二
#import "JGPicker.h"

//方式三
#import "GFCalendar.h"

//方式四
#import "JGPickerView.h"


@interface JGRootViewController () <JGPickerDelegate, JGPickerViewDelegate> {
    
    UITableViewCell *_index_cell;  //标记cell
    NSIndexPath *_indexPath;
    
}

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic,strong)JGPicker  *picker;
@property (nonatomic,strong)JGPickerView  *pickerView;

@property (nonatomic,strong)NSMutableArray  *titleDataArr;
@property (nonatomic,strong)NSMutableArray  *detailDataArr;
@end

static NSString * const JGTableViewCellId = @"JGTableViewCellId";

@implementation JGRootViewController

- (UILabel *)titleLbl {
    if (!_titleLbl) {
      
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 60)];
//        _titleLbl.backgroundColor = [UIColor lightGrayColor];
        _titleLbl.text = @"时间选择";
        _titleLbl.textColor = [UIColor redColor];
        _titleLbl.font = [UIFont systemFontOfSize:20];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLbl;
    
}



- (NSMutableArray *)titleDataArr {
    
    if (!_titleDataArr) {
        _titleDataArr = [NSMutableArray arrayWithObjects:@"样式一",@"样式二",@"样式三",@"样式四",@"样式五", nil];
    }
    return _titleDataArr;
}

- (NSMutableArray *)detailDataArr {
    
    if (!_detailDataArr) {
        _detailDataArr = [NSMutableArray arrayWithObjects:@"点击选择",@"点击选择",@"点击选择",@"点击选择",@"点击选择", nil];
    }
    return _detailDataArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.titleView = self.titleLbl;
    
    
    self.tableView.tableHeaderView = self.titleLbl;
//    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

    _picker = [[JGPicker alloc] initWithFrame:self.view.frame type:UIDatePickerModeDateAndTime andDelegate:self];
    
    
    _pickerView = [[JGPickerView alloc] init];
    _pickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
    _pickerView.delegate = self;
    //    _pickerView.curDate = [NSDate date];
    [self.view addSubview:_pickerView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleDataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JGTableViewCellId];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:JGTableViewCellId];
    }
    
    cell.textLabel.text = [self.titleDataArr objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.detailDataArr objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    _index_cell = [tableView cellForRowAtIndexPath:indexPath];
    _indexPath = indexPath;

    if (indexPath.row == 0) {
        
        FDAlertView *alert = [[FDAlertView alloc] init];
        RBCustomDatePickerView * contentView=[[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
        contentView.delegate=self;
        alert.contentView = contentView;
        [alert show];
        
    }else if (indexPath.row == 1) {
        
         [_picker show];
    }else if (indexPath.row == 2) {
        
        _pickerView.curDate = [NSDate date];
        [self.pickerView showInView:self.tableView];
        
    }else if (indexPath.row == 3) {
        
        [self loadDateStyle3];
    }else if (indexPath.row == 4) {
        
        MainViewController *mainVC = [[MainViewController alloc] init];
        [self presentViewController:mainVC animated:YES completion:nil];
        
//        [self.navigationController pushViewController:mainVC animated:YES];
    }
    
}

- (void)loadDateStyle3 {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHight)];
    view.backgroundColor = JGGlobaBgColor;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    CGFloat width = kDeviceWidth - 20.0;
    CGPoint origin = CGPointMake(10.0, 64.0 + 70.0);
    
    GFCalendarView *calendar = [[GFCalendarView alloc] initWithFrameOrigin:origin width:width];
    
    // 点击某一天的回调
    calendar.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
        
        NSString *dateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld", year, month, day];
        [_detailDataArr replaceObjectAtIndex:_indexPath.row withObject:dateStr];
        
        //一个cell刷新
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_indexPath.row inSection:_indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
        
        [view removeFromSuperview];
    };
    
    [view addSubview:calendar];
}



#pragma mark - 方式一 -
-(void)getTimeToValue:(NSString *)theTimeStr
{
    [_detailDataArr replaceObjectAtIndex:_indexPath.row withObject:theTimeStr];
    
    //一个cell刷新
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_indexPath.row inSection:_indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
//    NSLog(@"我获取到时间了，时间是===%@",theTimeStr);
}


#pragma mark - 方式二 - JGPickerDelegate
- (void)changeTime:(NSDate *)date
{
    
    [_detailDataArr replaceObjectAtIndex:_indexPath.row withObject:[_picker stringFromDate:date]];
    
    //一个cell刷新
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_indexPath.row inSection:_indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
    
    
//    NSLog(@"开始时间选择了:%@",[_picker stringFromDate:date]);
}

- (void)determinSelected:(NSDate *)date
{
    
    [_detailDataArr replaceObjectAtIndex:_indexPath.row withObject:[_picker stringFromDate:date]];
    
    //一个cell刷新
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_indexPath.row inSection:_indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
    
//    NSLog(@"最终选择了:%@",[_picker stringFromDate:date]);
}

#pragma mark - 方式四 - JGPickerViewDelegate
-(void)didFinishPickView:(NSString *)date
{
    [_detailDataArr replaceObjectAtIndex:_indexPath.row withObject:date];
    
    //一个cell刷新
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_indexPath.row inSection:_indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
//    NSLog(@"选择了:%@",date);
}




@end
