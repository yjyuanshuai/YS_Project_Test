//
//  CanlenderViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "CanlenderViewController.h"
#import <EventKit/EventKit.h>
#import "YSCalendarEventTableViewCell.h"
#import "YSCommenInputVC.h"

static NSString * const CalendarEventCellID = @"CalendarEventCellID";
static NSString * const CreateCalendarEventCellID = @"CreateCalendarEventCellID";

@interface CanlenderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * calendarTableView;
@property (nonatomic, strong) NSMutableArray * fectchEventArr;

@end

@implementation CanlenderViewController
{
    EKEventStore * _calendarEventStore;
    EKEvent * _event;

    NSMutableArray * _createEventArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"日历";
    [self initUIAndData];
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 2017.06.23
- (void)initUIAndData
{
    _calendarEventStore = [[EKEventStore alloc] init];
    _event = [EKEvent eventWithEventStore:_calendarEventStore];

    _fectchEventArr = [NSMutableArray array];
    _createEventArr = [@[@"标题", @"开始时间", @"终止时间", @"内容", @"url"] mutableCopy];
}

- (void)createTableView
{
    _calendarTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _calendarTableView.delegate = self;
    _calendarTableView.dataSource = self;
    _calendarTableView.tableFooterView = [UIView new];
    _calendarTableView.rowHeight = UITableViewAutomaticDimension;
    _calendarTableView.estimatedRowHeight = 80;
    [self.view addSubview:_calendarTableView];

    [_calendarTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [_calendarTableView registerClass:[YSCalendarEventTableViewCell class] forCellReuseIdentifier:CalendarEventCellID];
    [_calendarTableView registerClass:[YSCalendarEventTableViewCell class] forCellReuseIdentifier:CreateCalendarEventCellID];
}

// 读取日历事件
- (void)fetchCalenfarEvent
{
    if ([_calendarEventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        [_calendarEventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {

            if (granted) {

                NSCalendar * calendar = [NSCalendar currentCalendar];
                // 起始时间
                NSDateComponents * startComponents = [[NSDateComponents alloc] init];
                startComponents.day = -3;
                NSDate * startDate = [calendar dateByAddingComponents:startComponents toDate:[NSDate date] options:0];

                // 结束时间
                NSDateComponents * endComponents = [[NSDateComponents alloc] init];
                endComponents.year = 0;
                NSDate * endDate = [calendar dateByAddingComponents:endComponents toDate:[NSDate date] options:0];

                // 谓词
                NSPredicate * predicate = [_calendarEventStore predicateForEventsWithStartDate:startDate
                                                                                       endDate:endDate
                                                                                     calendars:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray * events = [_calendarEventStore eventsMatchingPredicate:predicate];

                    if ([events count] > 0) {
                        _fectchEventArr = [events mutableCopy];
                        NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:0];
                        [_calendarTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                    }
                });
                
            }
            else {
                NSLog(@"----------- has not root of read calendar!");
                
            }
        }];

    }
}

- (void)createCalendarEvent
{
    if ([_calendarEventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        [_calendarEventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 总结下 event
                EKEvent * collectionEvent = [EKEvent eventWithEventStore:_calendarEventStore];
                collectionEvent.title = _event.title;
                collectionEvent.notes = _event.notes;
                collectionEvent.URL = _event.URL;
                collectionEvent.startDate = _event.startDate;
                collectionEvent.endDate = _event.endDate;
                collectionEvent.location = _event.location;
                [collectionEvent addAlarm:[EKAlarm alarmWithRelativeOffset:-(60*60)]];  // 时间前多长时间提醒
                [collectionEvent setCalendar:[_calendarEventStore defaultCalendarForNewEvents]];

                NSError * error = nil;
                [_calendarEventStore saveEvent:collectionEvent span:EKSpanThisEvent error:&error];

                if (error) {
                    NSLog(@"----------- create calendar event error!");
                }
                else {
                    [self showAlertView:@"创建日历事件成功"];
                }
            }
            else {
                NSLog(@"----------- has not root of read calendar!");

            }
        }];
    }
}

- (void)editCalendarEvent:(NSIndexPath *)indexPath
{
    // 编辑
    __weak typeof(self) weakSelf = self;

    NSError * error = nil;
    EKEvent * editEvent = weakSelf.fectchEventArr[indexPath.row];
    editEvent.title = @"修改过的事件title";
    [_calendarEventStore saveEvent:editEvent span:EKSpanThisEvent error:&error];
    if (error) {
        NSLog(@"------- delete event error!");
    }
    else {
        [self showAlertView:@"编辑日历事件成功"];
        [weakSelf.fectchEventArr replaceObjectAtIndex:indexPath.row withObject:editEvent];
        [weakSelf.calendarTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }

}

- (void)deleteCalendarEvent:(NSIndexPath *)indexPath
{
    // 删除
    __weak typeof(self) weakSelf = self;
    NSError * error = nil;
    EKEvent * deleteEvent = weakSelf.fectchEventArr[indexPath.row];
    [_calendarEventStore removeEvent:deleteEvent span:EKSpanThisEvent error:&error];
    if (error) {
        NSLog(@"------- delete event error!");
    }
    else {
        [self showAlertView:@"删除日历事件成功"];
        [weakSelf.fectchEventArr removeObject:deleteEvent];
        [weakSelf.calendarTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }

}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return ([_fectchEventArr count] < 5) ? [_fectchEventArr count] : 5;
    }
    else if (section == 1) {
        return [_createEventArr count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        YSCalendarEventTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CalendarEventCellID];
        if (indexPath.row < [_fectchEventArr count]) {
            EKEvent * event = _fectchEventArr[indexPath.row];
            [cell setCalendarEventContent:event];
        }
        return cell;
    }
    else {
        YSCalendarEventTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CreateCalendarEventCellID];
        NSString * title = _createEventArr[indexPath.row];
        NSString * detail = @"";
        switch (indexPath.row) {
            case 0:
            {
                detail = _event.title;
            }
                break;
            case 1:
            {
                NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                detail = [formatter stringFromDate:_event.startDate];
            }
                break;
            case 2:
            {
                NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                detail = [formatter stringFromDate:_event.endDate];
            }
                break;
            case 3:
            {
                detail = _event.notes;
            }
                break;
            case 4:
            {
                detail = [NSString stringWithFormat:@"%@", _event.URL];
            }
                break;
                
            default:
                break;
        }
        [cell setCreateCalendarEventInfo:title detail:detail];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {

    }
    else if (indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == 3)) {

        NSCalendar * calendar = [NSCalendar currentCalendar];
        // 起始时间
        NSDateComponents * startComponents = [[NSDateComponents alloc] init];
        startComponents.day = 0;
        startComponents.minute = -60;
        NSDate * startDate = [calendar dateByAddingComponents:startComponents toDate:[NSDate date] options:0];

        // 结束时间
        NSDateComponents * endComponents = [[NSDateComponents alloc] init];
        endComponents.year = 0;
        NSDate * endDate = [calendar dateByAddingComponents:endComponents toDate:[NSDate date] options:0];

        _event.startDate = startDate;
        _event.endDate = endDate;
        _event.URL = [NSURL URLWithString:@"https://www.baidu.com/"];

        YSCommenInputVC * inputVC = [[YSCommenInputVC alloc] initWithTitle:_createEventArr[indexPath.row] block:^(NSString *inputStr) {

            if (indexPath.row == 0) {
                // 标题
                _event.title = inputStr;
            }
            else if (indexPath.row == 3) {
                // notes
                _event.notes = inputStr;
            }

            [_calendarTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        }];
        [self.navigationController pushViewController:inputVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    sectionView.backgroundColor = YSColorDefault;
    sectionView.layer.borderWidth = 1.0;
    sectionView.layer.borderColor = YSDefaultGrayColor.CGColor;

    UILabel * fetchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 45)];
    fetchLabel.font = YSFont_Sys(16);
    [sectionView addSubview:fetchLabel];

    SEL tapEvent = nil;

    if (section == 0) {
        fetchLabel.text = @"获取日历事件";
        tapEvent = @selector(fetchCalenfarEvent);
    }
    else {
        fetchLabel.text = @"创建日历事件";
        tapEvent = @selector(createCalendarEvent);
    }
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:tapEvent];
    [sectionView addGestureRecognizer:tap];

    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;

    UITableViewRowAction * deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        [weakSelf deleteCalendarEvent:indexPath];
    }];
    deleteAction.backgroundColor = YSColorDefault;

    UITableViewRowAction * editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        [weakSelf editCalendarEvent:indexPath];
    }];
    editAction.backgroundColor = [UIColor redColor];

    return @[deleteAction, editAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)showAlertView:(NSString *)msg
{
    UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];

    [alertCon addAction:sure];
    [self presentViewController:alertCon animated:YES completion:nil];
}

#pragma mark - 日历事件添加
/*
-(void)saveEventToCalendarWithData:(NSString *)time
                  dateFormatterStr:(NSString *)dateFormatterStr
                             title:(NSString *)title
                          location:(NSString *)location
                             notes:(NSString *)notes
                               url:(NSString *)urlStr
                         startDate:(NSString *)startDateStr
                           endDate:(NSString *)endDateStr
{
    //事件市场
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    //6.0及以上通过下面方式写入事件
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    // display error message here
                }
                else if (!granted)
                {
                    // 被用户拒绝，不允许访问日历
                    // display access denied error message here
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提醒" message:@"请设置本应用日历权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    // 事件保存到日历
                    // 创建事件
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     = title;
                    event.location  = location;
                    event.notes     = notes;
                    event.URL       = [NSURL URLWithString:urlStr];     //日历中显示的url
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:dateFormatterStr];
                    //创建一个时间段的日历事件
//                    NSString * startDateStr  =   @"15.08.2016 14:10";
//                    NSString * endDateStr    =   @"15.08.2016 14:50";
                    
                    event.startDate = [tempFormatter dateFromString:startDateStr];
                    event.endDate   = [tempFormatter dateFromString:endDateStr];
                    
                    //创建一个一天的日历事件
                    //                    event.startDate = [[NSDate alloc]init ];
                    //                    event.endDate   = [[NSDate alloc]init ];
                    //                    event.allDay = YES;
                    
                    //                    NSDate *currentDate=[NSDate date];
                    //                    NSLog(@"Current Date is %@ ",[tempFormatter stringFromDate:currentDate]);
                    //                    //添加提醒
                    //                    NSDate *laterDate=[NSDate dateWithTimeIntervalSinceNow:60];
                    //                    NSLog(@"laterDate Date is %@ ",[tempFormatter stringFromDate:laterDate]);
                    NSString *alarmDateStr=@"15.08.2016 14:10";
                    
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                    //给事件 添加一个提醒  这样显示的是事件前多长时间提醒  比如1小时前
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:-(60*60)]];
                    //这样显示的就是具体什么时候开始提醒
                    //                    [event addAlarm:[EKAlarm alarmWithAbsoluteDate:[tempFormatter dateFromString:alarmDateStr]]];
                    
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    //需要保存事件  才会添加到日历中去
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"提醒"
                                          message:@"创建成功?"
                                          delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
                    [alert show];
                    
                    NSLog(@"保存成功");
                }
            });
        }];
    }
}


-(void)saveEventToCalendar//:(id)event{
{
    //事件库
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    //6.0及以上通过下面方式写入事件
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提醒" message:@"请设置本应用日历权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    //事件保存到日历
                    //创建事件
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     = @"我是日历事件啊";
                    event.location = @"我在shanghai";
                    event.notes =@"notes notes notes notes notes notes notes notesnotes notes notes notes notes notes notes notes notes notes notes notes notes notesnotes notes notes notes notes notes notes notes notes notes notes notes";
                    //日历中显示的url
                    event.URL=[NSURL URLWithString:@"http://www.baidu.com"];
                    
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    //创建一个时间段的日历事件
                    NSDate * currentDate = [NSDate date];
                    NSString *startDateStr= @"15.08.2016 14:10";
                    NSString *endDateStr=@"15.08.2016 14:50";
                    event.startDate=[tempFormatter dateFromString:startDateStr];
                    event.endDate=[tempFormatter dateFromString:endDateStr];
                    //创建一个一天的日历事件
                    //                    event.startDate = [[NSDate alloc]init ];
                    //                    event.endDate   = [[NSDate alloc]init ];
                    //                    event.allDay = YES;
                    
                    //                    NSDate *currentDate=[NSDate date];
                    //                    NSLog(@"Current Date is %@ ",[tempFormatter stringFromDate:currentDate]);
                    //                    //添加提醒
                    //                    NSDate *laterDate=[NSDate dateWithTimeIntervalSinceNow:60];
                    //                    NSLog(@"laterDate Date is %@ ",[tempFormatter stringFromDate:laterDate]);
                    NSString *alarmDateStr=@"15.08.2016 14:10";
                    
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                    //给事件 添加一个提醒  这样显示的是事件前多长时间提醒  比如1小时前
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:-(60*60)]];
                    //这样显示的就是具体什么时候开始提醒
                    //                    [event addAlarm:[EKAlarm alarmWithAbsoluteDate:[tempFormatter dateFromString:alarmDateStr]]];
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    //需要保存事件  才会添加到日历中去
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"提醒"
                                          message:@"创建成功?"
                                          delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
                    [alert show];
                    
                    NSLog(@"保存成功");
                    
                }
            });
        }];
    }
}
 */

@end
