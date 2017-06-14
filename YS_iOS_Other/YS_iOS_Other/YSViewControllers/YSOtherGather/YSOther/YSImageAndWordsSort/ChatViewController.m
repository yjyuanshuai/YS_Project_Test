//
//  ChatViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatBottemView.h"
#import "EmotionView.h"
//#import "ChatViewTableViewCell.h"
#import "ChatViewTextMsgCell.h"
#import "NSDate+Utilities.h"
#import "ChatMsgModel.h"
#import "ChatMsgManager.h"
#import "YSHudView.h"
#import "NSString+YSStringDo.h"

static NSString * const ChatViewTextMsgCellID = @"ChatViewTextMsgCellID";

@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource, ChatBottemViewDelegate, EmotionViewDelegate>

@property (nonatomic, strong) UITableView * messageTableView;
@property (nonatomic, strong) ChatBottemView * chatBottemView;
@property (nonatomic, strong) EmotionView * emotionView;

@end

@implementation ChatViewController
{
    NSMutableArray * _messageDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
    [self createEmoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initUIAndData
{
    self.title = @"聊天界面";
    _messageDataArr = [ChatMsgManager queryChatMsgsWithLimit:20 currentModel:nil];
    
    UIBarButtonItem * deleteAll = [[UIBarButtonItem alloc] initWithTitle:@"删除记录" style:UIBarButtonItemStylePlain target:self action:@selector(deleteAllHistory)];
    self.navigationItem.rightBarButtonItem = deleteAll;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)createEmoView
{
    _chatBottemView = [[ChatBottemView alloc] initWithFrame:CGRectMake(0, kScreenHeightNo64 - 85, kScreenWidth, 85)];
    _chatBottemView.delegate = self;
    [self.view addSubview:_chatBottemView];
    
    _emotionView = [EmotionView shareEmotionView];
    _emotionView.hidden = YES;
    _emotionView.delegate = self;
    _emotionView.frame = CGRectMake(0, kScreenHeightNo64, kScreenWidth, [_emotionView getEmotionViewHeight]);
    [self.view addSubview:_emotionView];
    
    _chatBottemView.backgroundColor = YSColorDefault;
    _emotionView.backgroundColor = [UIColor greenColor];
}

- (void)createTableView
{
    _messageTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _messageTableView.estimatedRowHeight = 100;
//    _messageTableView.rowHeight = UITableViewAutomaticDimension;
//    _messageTableView.showsVerticalScrollIndicator = NO;
    _messageTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_messageTableView];
    
    [_messageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 85, 0));
    }];
    
    [_messageTableView registerClass:[ChatViewTextMsgCell class] forCellReuseIdentifier:ChatViewTextMsgCellID];
    
//    [_messageTableView setTransform:CGAffineTransformMakeRotation(-M_PI)];      // 倒置
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelFocus)];
    [_messageTableView addGestureRecognizer:tapGesture];

    _messageTableView.backgroundColor = [UIColor redColor];
}

#pragma mark -
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = value.CGRectValue;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [self focusMoveKeybordOrFunctionView:duration.doubleValue animationCurve:curve moveHeight:frame.size.height functionType:-1];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self cancelFocus];
}

#pragma mark - ChatBottemViewDelegate
- (void)showFunctionViewWithTag:(FunctionType)functionType
{
    if (functionType == FunctionType_Emotion) {
        
        [self focusMoveKeybordOrFunctionView:0.5 animationCurve:nil moveHeight:[_emotionView getEmotionViewHeight] functionType:FunctionType_Emotion];
        
    }
}

#pragma mark - EmotionViewDelegate
- (void)selectedEmotion:(EmotionModel *)model
{
    [_chatBottemView receviceEmoStr:model];
}

- (void)sendMessage
{
    NSString * currentChatStr = [_chatBottemView getChatText];
    
    if (![currentChatStr isBlank]) {
        
        // 1 存到数据库
        NSString * currentTime = [NSDate getCurrentTimeStrWithDate];
        ChatMsgModel * model = [[ChatMsgModel alloc] init];
        model.msgId = currentTime;
        model.msgTime = currentTime;
        model.msgType = ChatMsgTypeText;
        model.userName = @"YJ";
        model.userHeadImage = @"";
        model.msgContentData = [currentChatStr dataUsingEncoding:NSUTF8StringEncoding];
        model.isSelfSend = YES;
        BOOL insert = [ChatMsgManager insertChatMsg:model];
        
        if (insert) {
            // 2 刷新界面
//            [_messageDataArr insertObject:model atIndex:0];
            [_messageDataArr addObject:model];
            [_messageTableView reloadData];
            
            // 3 清除输入
            [_chatBottemView clearChatText];
            [self cancelFocus];
        }
        else {
            [YSHudView yiBaoHUDStopOrShowWithMsg:@"数据插入失败，请重试！" finsh:nil];
        }
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewTextMsgCell * cell = [tableView dequeueReusableCellWithIdentifier:ChatViewTextMsgCellID];
    [cell setChatMsgCell:_messageDataArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ChatViewTextMsgCell getChatViewTableViewHeight:_messageDataArr[indexPath.row]];
}

#pragma mark -
- (void)deleteAllHistory
{
    BOOL deleteAll = [ChatMsgManager deleteAllChatMsgs];
    if (deleteAll) {
        [YSHudView yiBaoHUDStopOrShowWithMsg:@"删除全部记录成功" finsh:^{
            [_messageDataArr removeAllObjects];
            [_messageTableView reloadData];
        }];
    }
    else {
        [YSHudView yiBaoHUDStopOrShowWithMsg:@"删除全部记录失败" finsh:nil];
    }
}

- (void)focusMoveKeybordOrFunctionView:(NSTimeInterval)animationTime animationCurve:(NSNumber *)curve moveHeight:(CGFloat)height functionType:(FunctionType)functionType
{
    [UIView animateWithDuration:animationTime animations:^{
        
        if (functionType == FunctionType_Emotion) {
            // 表情键盘

            [self moveChatBottemViewWithHeight:[_chatBottemView getBottemViewHeight] originY:kScreenHeightNo64 - [_chatBottemView getBottemViewHeight] - height];
            [self moveTableViewWithBottemSpace:height + [_chatBottemView getBottemViewHeight]];
            [self moveEmotionViewWithHeight:height originY:kScreenHeightNo64 - height isHidden:NO];
        }
        
        else {
            // 键盘
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];

            [self moveChatBottemViewWithHeight:[_chatBottemView getBottemViewHeight] originY:kScreenHeightNo64 - height - [_chatBottemView getBottemViewHeight]];
            [self moveTableViewWithBottemSpace:height + [_chatBottemView getBottemViewHeight]];
        }
    }];
}

- (void)cancelFocus
{
    [_chatBottemView registFirstRespon];
    
    [UIView animateWithDuration:0.3f animations:^{

        [self moveChatBottemViewWithHeight:kScreenHeightNo64 - [_chatBottemView getBottemViewHeight] originY:[_chatBottemView getBottemViewHeight]];
        [self moveTableViewWithBottemSpace:[_chatBottemView getBottemViewHeight]];
        [self moveEmotionViewWithHeight:[_emotionView getEmotionViewHeight] originY:kScreenHeightNo64 isHidden:YES];
    }];
}

- (void)moveTableViewWithBottemSpace:(CGFloat)bottemSpace
{
    [_messageTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, bottemSpace, 0));
    }];

    NSIndexPath * lastIndexPath = [NSIndexPath indexPathForRow:[_messageDataArr count]-1 inSection:0];
    [_messageTableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)moveChatBottemViewWithHeight:(CGFloat)viewHeight
                             originY:(CGFloat)originY
{
    _chatBottemView.frame = CGRectMake(0, originY, kScreenWidth, viewHeight);
    _chatBottemView.currentFrame = _chatBottemView.frame;
}

- (void)moveEmotionViewWithHeight:(CGFloat)emotionViewHeight
                          originY:(CGFloat)originY
                         isHidden:(BOOL)hidden
{
    _emotionView.frame = CGRectMake(0, originY, kScreenWidth, emotionViewHeight);
    _emotionView.hidden = hidden;
}

@end
