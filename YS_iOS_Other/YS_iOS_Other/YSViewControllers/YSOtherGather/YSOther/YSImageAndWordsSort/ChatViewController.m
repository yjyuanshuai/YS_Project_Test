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
@property (nonatomic, strong) NSMutableArray * messageDataArr;

@end

@implementation ChatViewController
{
    ChatViewSuperCell * _menuShowCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
    [self createEmoView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self cancelFocusWithAnimation:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

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
    _menuShowCell = nil;
    
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
    _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeightNo64 - 85) style:UITableViewStylePlain];
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _messageTableView.estimatedRowHeight = 100;
//    _messageTableView.rowHeight = UITableViewAutomaticDimension;
//    _messageTableView.showsVerticalScrollIndicator = NO;
    _messageTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_messageTableView];

    [_messageTableView registerClass:[ChatViewTextMsgCell class] forCellReuseIdentifier:ChatViewTextMsgCellID];
    
//    [_messageTableView setTransform:CGAffineTransformMakeRotation(-M_PI)];      // 倒置
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelFocusWithAnimation:)];
    [_messageTableView addGestureRecognizer:tapGesture];
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
    [self cancelFocusWithAnimation:YES];
}

#pragma mark - ChatBottemViewDelegate
- (void)showFunctionViewWithTag:(FunctionType)functionType
{
    if (functionType == FunctionType_Emotion) {
        
        [self focusMoveKeybordOrFunctionView:0.3 animationCurve:nil moveHeight:[_emotionView getEmotionViewHeight] functionType:FunctionType_Emotion];
        
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
            [_messageDataArr addObject:model];
            [_messageTableView reloadData];
            NSIndexPath * lastIndexPath = [NSIndexPath indexPathForRow:[_messageDataArr count]-1 inSection:0];
            [_messageTableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            // 3 清除输入
            [_chatBottemView clearChatText];
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
    [cell setChatMsgCell:_messageDataArr[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{  
    CGFloat height = 0;
    ChatMsgModel * model = _messageDataArr[indexPath.row];
    if (model.msgType == ChatMsgTypeText) {
        height = [ChatViewTextMsgCell getChatViewTableViewHeight:_messageDataArr[indexPath.row]];
    }
    return height;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _menuShowCell = [tableView cellForRowAtIndexPath:indexPath];

    UIMenuController * menu = [UIMenuController sharedMenuController];
    UIMenuItem * deleteItem = [[UIMenuItem alloc] initWithTitle:@"cus删除" action:@selector(deleteMenu:)];
    UIMenuItem * copyItem = [[UIMenuItem alloc] initWithTitle:@"cus粘贴" action:@selector(copyMenu:)];
    [menu setMenuItems:@[deleteItem, copyItem]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MenuWillShow) name: UIMenuControllerWillShowMenuNotification object:nil];

    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return YES;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{

}

- (void)MenuWillShow
{
    if (_menuShowCell) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillShowMenuNotification object:nil];
        [[UIMenuController sharedMenuController] setTargetRect:_menuShowCell.msgBgBtn.frame inView:_menuShowCell];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];  // 若这句不加，menu还是加在cell边缘。
    }
}

- (void)MenuWillHidden
{
    [[UIMenuController sharedMenuController] setMenuItems:nil];
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
            CGFloat ChatBottemViewHeight = kScreenHeightNo64 - [_chatBottemView getBottemViewHeight] - height;
            [self moveChatBottemViewWithOriginY:ChatBottemViewHeight];
            [self moveTableViewWithBottemSpace:height];
            [self moveEmotionViewWithHeight:height originY:kScreenHeightNo64 - height isHidden:NO];
        }
        
        else {
            // 键盘
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];

            [self moveChatBottemViewWithOriginY:kScreenHeightNo64 - height - [_chatBottemView getBottemViewHeight]];
            [self moveTableViewWithBottemSpace:height];
        }

    }];
}

- (void)cancelFocusWithAnimation:(BOOL)animation
{
    [_chatBottemView registFirstRespon];

    if (animation) {
        [UIView animateWithDuration:0.5 animations:^{

            [self moveChatBottemViewWithOriginY:kScreenHeightNo64 - [_chatBottemView getBottemViewHeight]];
            [self moveTableViewWithBottemSpace:0];
            [self moveEmotionViewWithHeight:[_emotionView getEmotionViewHeight] originY:kScreenHeightNo64 isHidden:YES];
        }];
    }
    else {
        [self moveChatBottemViewWithOriginY:kScreenHeightNo64 - [_chatBottemView getBottemViewHeight]];
        [self moveTableViewWithBottemSpace:0];
        [self moveEmotionViewWithHeight:[_emotionView getEmotionViewHeight] originY:kScreenHeightNo64 isHidden:YES];
    }
}

- (void)moveTableViewWithBottemSpace:(CGFloat)funHeight
{
    CGFloat bottemSpace = funHeight + [_chatBottemView getBottemViewHeight];
    _messageTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeightNo64 - bottemSpace);

    if ([_messageDataArr count] > 0) {
        NSIndexPath * lastIndexPath = [NSIndexPath indexPathForRow:[_messageDataArr count]-1 inSection:0];
        [_messageTableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

- (void)moveChatBottemViewWithOriginY:(CGFloat)originY
{
    _chatBottemView.frame = CGRectMake(0, originY, kScreenWidth, [_chatBottemView getBottemViewHeight]);
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
