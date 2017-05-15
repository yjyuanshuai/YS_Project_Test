//
//  CanlenderViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "CanlenderViewController.h"
#import <EventKit/EventKit.h>

@interface CanlenderViewController ()

@end

@implementation CanlenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"日历";
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加事件" style:UIBarButtonItemStylePlain target:self action:@selector(clickToAddEvent)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)clickToAddEvent
{
    [self saveEventToCalendar];
}

#pragma mark - 日历事件添加
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

@end
