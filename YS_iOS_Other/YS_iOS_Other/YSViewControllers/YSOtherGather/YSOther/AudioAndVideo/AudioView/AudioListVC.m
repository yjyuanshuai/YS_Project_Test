//
//  LocalAudioPlayerVC.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioListVC.h"
#import "YSSongModel.h"
#import "AudioOrVideoTableViewCell.h"
#import "YSFileManager.h"
#import "AudioPlayerVC.h"

static NSString * const AudioListCellID = @"AudioListCellID";

@interface AudioListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * audioListTableView;
@property (nonatomic, strong) NSMutableArray * currentPlayList;

@end

@implementation AudioListVC
{
    AudioListType _type;
    
    NSMutableArray * _audioArr;
    NSMutableArray * _sectionTitleArr;
}

- (instancetype)initWithTitle:(NSString *)title audioListType:(AudioListType)type
{
    if (self = [super init]) {
        
        self.title = title;
        _type = type;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
    [self analysisData];
    [self obtainDataFromSandBox];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    _audioArr = [@[] mutableCopy];
    _sectionTitleArr = [@[] mutableCopy];
    
    if (_type == AudioListTypeLocalPlay_SystemSound ||
        _type == AudioListTypeLocalPlay_SystemMusic ||
        _type == AudioListTypeLocalPlay_Music) {
        
        UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"正在播放" style:UIBarButtonItemStylePlain target:self action:@selector(currentPlay)];
        self.navigationItem.rightBarButtonItem = rightBtn;
    }
}

- (void)createTableView
{
    _audioListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _audioListTableView.delegate = self;
    _audioListTableView.dataSource = self;
    _audioListTableView.tableFooterView = [UIView new];
    [self.view addSubview:_audioListTableView];
    
    [_audioListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    MASAttachKeys(_audioListTableView);
    
    [_audioListTableView registerClass:[AudioOrVideoTableViewCell class] forCellReuseIdentifier:AudioListCellID];
}

- (void)analysisData
{
    if (_type == AudioListTypeWeb ||
        _type == AudioListTypeLocalPlay_Music) {
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"YS_iOS_Audio" ofType:@"plist"];
        NSArray * arr = [NSArray arrayWithContentsOfFile:path];
        
        for (NSDictionary * dict in arr) {
            
            NSString * groupName = dict[@"name"];
            [_sectionTitleArr addObject:groupName];
            
            NSArray * listDictArr = dict[@"songs"];
            NSMutableArray * groupSongs = [@[] mutableCopy];
            for (NSDictionary * songDict in listDictArr) {
                YSSongModel * model = [[YSSongModel alloc] initWithWebSongDic:songDict];
                [groupSongs addObject:model];
            }
            
            [_audioArr addObject:groupSongs];
        }
        
        [_audioListTableView reloadData];
    }
    else if (_type == AudioListTypeLocalPlay_SystemMusic) {
    
    }
    else if (_type == AudioListTypeLocalPlay_SystemSound) {
        
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_audioArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_type == AudioListTypeLocalPlay_SystemSound ||
        _type == AudioListTypeLocalPlay_Music ||
        _type == AudioListTypeLocalPlay_SystemMusic) {
        
        if ([_audioArr count] > 0) {
            if (section < [_audioArr count] - 1) {
                return [_audioArr[section] count];
            }
            return [_audioArr[section] count] + 1;
        }
        return 0;
    }
    return [_audioArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == AudioListTypeLocalPlay_SystemSound ||
        _type == AudioListTypeLocalPlay_Music ||
        _type == AudioListTypeLocalPlay_SystemMusic) {
        
        NSArray * sectionArr = _audioArr[indexPath.section];
        if (indexPath.row < [sectionArr count]) {
            
            AudioOrVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AudioListCellID];
            YSSongModel * songModel = sectionArr[indexPath.row];
            [cell setCellContent:CellTypeAudio model:songModel];
            return cell;
        }
        else {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL_ID"];
            }
            cell.textLabel.text = @"清除本地音频文件";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }
        
        return nil;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * sectionArr = _audioArr[indexPath.section];
    if (indexPath.row < [sectionArr count]) {
        return 60;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitleArr[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (_type) {
        case AudioListTypeLocalPlay_SystemSound:
        {
            
        }
            break;
        case AudioListTypeLocalPlay_Music:
        {
            NSArray * sectionArr = _audioArr[indexPath.section];
            if (indexPath.row < [sectionArr count]) {
                
                [self storeCurrentPlayList:indexPath.section];
                
                AudioPlayerVC * audioPlayVC = [AudioPlayerVC defaultAudioVC];
                audioPlayVC.currentIndex = indexPath.row;
                [self.navigationController pushViewController:audioPlayVC animated:YES];
                
            }
            else {
                // 清除沙盒音频文件
                BOOL deleteAll = [YSFileManager deleteAllFileOrDirectInDirect:sbMedia_AudioDir];
                if (deleteAll) {
                    DDLogInfo(@"---------- 文件删除成功！");
                }
                else {
                    DDLogInfo(@"---------- 文件删除失败！");
                }
            }
        }
            break;
        case AudioListTypeLocalPlay_SystemMusic:
        {
            
        }
            break;
        case AudioListTypeLoaclMake:
        {
            
        }
            break;
        case AudioListTypeWeb:
        {
            
        }
            break;
    }
}

#pragma mark - 点击事件
- (void)currentPlay
{
    AudioPlayerVC * audioPlayVC = [AudioPlayerVC defaultAudioVC];
    [self.navigationController pushViewController:audioPlayVC animated:YES];
}

#pragma mark - 文件
- (void)obtainDataFromSandBox
{
    switch (_type) {
        case AudioListTypeLocalPlay_SystemSound:
        {
            
        }
            break;
        case AudioListTypeLocalPlay_Music:
        {
            
            // 将本地音频文件 写入沙盒
            [YSFileManager createDirectToPath:sbMedia_AudioDir];
            
            for (NSArray * groupArr in _audioArr) {
                for (YSSongModel * songModel in groupArr) {
                    NSData * songData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:songModel.name ofType:songModel.expandType]];
                    
                    NSString * songPath = [NSString stringWithFormat:@"%@.%@", songModel.name, songModel.expandType];
                    
                    if ([YSFileManager fileHasExist:[sbMedia_AudioDir stringByAppendingPathComponent:songPath]]) {
                        DDLogInfo(@"----------- 文件已存在");
                    }
                    else
                    {
                        [YSFileManager writeData:songData toFile:[sbMedia_AudioDir stringByAppendingPathComponent:songPath]];
                    }
                }

            }
            // 创建 歌曲分组 plist
            [YSFileManager createFiletoDes:sbMedia_AudioGroupPlist];

        }
            break;
        case AudioListTypeLocalPlay_SystemMusic:
        {
            
        }
            break;
        case AudioListTypeLoaclMake:
        {
            
        }
            break;
        case AudioListTypeWeb:
        {
            
        }
            break;
    }
}

- (void)storeCurrentPlayList:(NSInteger)section
{
    // 当前播放列表
    NSArray * sectionSongs = _audioArr[section];

    if (!_currentPlayList) {
        _currentPlayList = [@[] mutableCopy];
    }
    [_currentPlayList removeAllObjects];
    
    for (YSSongModel * model in sectionSongs) {
        NSData * songData = [NSKeyedArchiver archivedDataWithRootObject:model];
        [_currentPlayList addObject:songData];
    }
    
    if ([_currentPlayList count] > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:_currentPlayList] forKey:UserAudioPlayList];
    }
    
    // 歌曲分组 plist
    NSArray * webPlistArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"YS_iOS_Audio" ofType:@"plist"]];
    [webPlistArr writeToFile:sbMedia_AudioGroupPlist atomically:YES];
}


@end
