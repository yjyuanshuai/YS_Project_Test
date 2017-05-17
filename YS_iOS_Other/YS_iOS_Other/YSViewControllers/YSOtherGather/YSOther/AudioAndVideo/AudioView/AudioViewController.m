//
//  AudioViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioViewController.h"
#import "AudioListVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AudioPlayerVC.h"
#import "YSSongModel.h"

@interface AudioViewController () <UITableViewDataSource, UITableViewDelegate, MPMediaPickerControllerDelegate>

@property (nonatomic, strong) UITableView * audioTableView;

@end

@implementation AudioViewController
{
    NSMutableArray * _localAudiosArr;
    NSMutableArray * _webAudiosArr;
    
    NSMutableArray * _sectionTitleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createAudioTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"音频";
    
    _webAudiosArr = [@[@"网络"] mutableCopy];
    
    _localAudiosArr = [@[@"SystemSoundServices", @"AVAudioPlayer", @"MPMediaPickerController"] mutableCopy];
    
    _sectionTitleArr = [@[@"本地音频播放", @"音频录制", @"网络音频播放"] mutableCopy];
}

- (void)createAudioTableView
{
    _audioTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _audioTableView.delegate = self;
    _audioTableView.dataSource = self;
    _audioTableView.showsVerticalScrollIndicator = NO;
    _audioTableView.tableFooterView = [UIView new];
    _audioTableView.rowHeight = UITableViewAutomaticDimension;
    _audioTableView.estimatedRowHeight = 44;
    _audioTableView.tableFooterView = [UIView new];
    [self.view addSubview:_audioTableView];
    
    [_audioTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    MASAttachKeys(_audioTableView);
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitleArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_localAudiosArr count];
    }
    else if (section == 1) {
        return 1;
    }
    else if (section == 2) {
        return [_webAudiosArr count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_id = @"CELL_ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = _localAudiosArr[indexPath.row];
        return cell;
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = @"录制音频";
        return cell;
    }
    else if (indexPath.section == 2) {
        cell.textLabel.text = _webAudiosArr[indexPath.row];
        return cell;
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitleArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
        {
            AudioListType type = AudioListTypeLocalPlay_SystemSound;
            
            switch (indexPath.row) {
                case 0:
                {
                    type = AudioListTypeLocalPlay_SystemSound;

                    AudioListVC * makeAudioVC = [[AudioListVC alloc] initWithTitle:_localAudiosArr[indexPath.row] audioListType:type];
                    [self.navigationController pushViewController:makeAudioVC animated:YES];
                }
                    break;
                case 1:
                {
                    type = AudioListTypeLocalPlay_Music;

                    AudioListVC * makeAudioVC = [[AudioListVC alloc] initWithTitle:_localAudiosArr[indexPath.row] audioListType:type];
                    [self.navigationController pushViewController:makeAudioVC animated:YES];
                }
                    break;
                case 2:
                {
                    type = AudioListTypeLocalPlay_LibraryMusic;

                    MPMediaPickerController * mpMediaPick = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
                    mpMediaPick.delegate = self;
                    mpMediaPick.prompt = @"从音乐库中选取播放音乐";
                    mpMediaPick.allowsPickingMultipleItems = YES;    // 是否允许一次选多个
                    [self presentViewController:mpMediaPick animated:YES completion:nil];
                }
                    break;
                    
            }
        }
            break;
            
        case 1:
        {
            AudioListVC * makeAudioVC = [[AudioListVC alloc] initWithTitle:_sectionTitleArr[indexPath.section] audioListType:AudioListTypeLoaclMake];
            [self.navigationController pushViewController:makeAudioVC animated:YES];
        }
            break;

        case 2:
        {
            AudioListVC * webAudioVC = [[AudioListVC alloc] initWithTitle:_sectionTitleArr[indexPath.section] audioListType:AudioListTypeWeb];
            [self.navigationController pushViewController:webAudioVC animated:YES];
        }
            break;

    }
}

#pragma mark - MPMediaPickerControllerDelegate
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    NSMutableArray * itemArr = [NSMutableArray array];
    for (MPMediaItem * item in [mediaItemCollection items]) {
        YSSongModel * model = [[YSSongModel alloc] init];
        model.url = [NSString stringWithFormat:@"%@", [item valueForProperty:MPMediaItemPropertyAssetURL]];
        model.name = [item valueForProperty:MPMediaItemPropertyTitle];
        [itemArr addObject:model];
    }
    AudioPlayerVC * audioPlayerVC = [AudioPlayerVC defaultAudioVC];
    [audioPlayerVC setAudioType:AudioListTypeLocalPlay_LibraryMusic audioList:itemArr currentIndex:0];
    [self.navigationController pushViewController:audioPlayerVC animated:YES];
    [mediaPicker dismissViewControllerAnimated:NO completion:^{

    }];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [mediaPicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
