//
//  OnePickerViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OnePickerViewController.h"

@interface OnePickerViewController()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UITableView * pickerTableView;
@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, strong) UIDatePicker * datePicker;
@property (nonatomic, strong) UIPickerView * singlePicker;
@property (nonatomic, strong) UIPickerView * mulPicker;
@property (nonatomic, strong) UIPickerView * relyMulPicker;

@end

@implementation OnePickerViewController
{
    NSArray * _pickerArr;
    NSArray * _singlePickerArr;
    
    NSArray * _mulPickerArrOne;
    NSArray * _mulPickerArrTwo;
    
    NSDictionary * _relyDic;
    NSArray * _relyMulPickerArr;    //
    NSArray * _relyMulPickerArr2;   //
    NSArray * _relyMulPickerArrOne;
    NSArray * _relyMuPickerArrTwo;
    NSArray * _relyMulPickerArrThree;
}

- (void)viewDidLoad
{
    self.title = @"Picker";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _pickerArr = @[@"时间", @"单选择", @"多选择", @"依赖多选"];
    
    _singlePickerArr = @[@"单选择一", @"单选择二", @"单选择三", @"单选择四", @"单选择五", @"单选择六", @"单选择七"];
    
    _mulPickerArrOne = @[@"多选一", @"多选二", @"多选三", @"多选四", @"多选五", @"多选六"];
    _mulPickerArrTwo = @[@"多选一", @"多选二", @"多选三", @"多选四", @"多选五", @"多选六"];
    
    _relyMulPickerArr = @[@"依赖多选一", @"依赖多选二", @"依赖多选三"];
    _relyMulPickerArrOne = @[@"1-1", @"1-2", @"1-3", @"1-4", @"1-5", @"1-6"];
    _relyMuPickerArrTwo = @[@"2-1", @"2-2", @"2-3"];
    _relyMulPickerArrThree = @[@"3-1", @"3-2", @"3-3", @"3-4"];
    _relyMulPickerArr2 = _relyMulPickerArrOne;
    _relyDic = @{@"依赖多选一":_relyMulPickerArrOne, @"依赖多选二":_relyMuPickerArrTwo, @"依赖多选三":_relyMulPickerArrThree};
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(sure)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    [self initUI];
}

- (void)initUI
{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 64 + 10, self.view.frame.size.width - 20, 40)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.textColor = [UIColor blackColor];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.userInteractionEnabled = NO;
    [self.view addSubview:_textField];
    
    [self initTableView];
    [self initPickerView];
}

- (void)initTableView
{
    _pickerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_textField.frame), self.view.frame.size.width, self.view.frame.size.height - _textField.frame.size.height) style:UITableViewStylePlain];
    _pickerTableView.delegate = self;
    _pickerTableView.dataSource = self;
    [self.view addSubview:_pickerTableView];
}

- (void)initPickerView
{
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 200)];
    _datePicker.hidden = YES;
    _datePicker.backgroundColor = [UIColor orangeColor];
    _datePicker.minimumDate = [NSDate date];
    _datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:7 * 24 * 60 * 60];
    [_datePicker setDate:[NSDate date] animated:NO];
    [self.view addSubview:_datePicker];
    
    _singlePicker = [[UIPickerView alloc] initWithFrame:_datePicker.frame];
    _singlePicker.hidden = YES;
    _singlePicker.backgroundColor = [UIColor yellowColor];
    _singlePicker.delegate = self;
    _singlePicker.dataSource = self;
    [self.view addSubview:_singlePicker];
    
    _mulPicker = [[UIPickerView alloc] initWithFrame:_datePicker.frame];
    _mulPicker.hidden = YES;
    _mulPicker.backgroundColor = [UIColor redColor];
    _mulPicker.delegate = self;
    _mulPicker.dataSource = self;
    [self.view addSubview:_mulPicker];
    
    _relyMulPicker = [[UIPickerView alloc] initWithFrame:_datePicker.frame];
    _relyMulPicker.hidden = YES;
    _relyMulPicker.backgroundColor = [UIColor greenColor];
    _relyMulPicker.delegate = self;
    _relyMulPicker.dataSource = self;
    [self.view addSubview:_relyMulPicker];
}

- (void)sure
{
    if (_datePicker.hidden == NO) {
        
        NSDate * selectedDate = [_datePicker date];
        
        NSDateFormatter * formetter = [[NSDateFormatter alloc] init];
        formetter.timeStyle = kCFDateFormatterShortStyle;
        formetter.dateStyle = NSDateFormatterMediumStyle;
        formetter.dateFormat = @"yy-MM-dd HH:mm:ss";
        
        NSString * dateStr = [formetter stringFromDate:selectedDate];
        _textField.text = dateStr;
        _datePicker.hidden = YES;
        
    } else if (_singlePicker.hidden == NO) {
        
        NSInteger selectedRow = [_singlePicker selectedRowInComponent:0];
        NSString * singleStr = [_singlePickerArr objectAtIndex:selectedRow];
        _textField.text = singleStr;
        _singlePicker.hidden = YES;
        
    } else if (_mulPicker.hidden == NO) {
        
        NSInteger selectedRowOne = [_mulPicker selectedRowInComponent:0];
        NSInteger selectedRowTwo = [_mulPicker selectedRowInComponent:1];
        NSString * oneStr = [_mulPickerArrOne objectAtIndex:selectedRowOne];
        NSString * twoStr = [_mulPickerArrTwo objectAtIndex:selectedRowTwo];
        _textField.text = [NSString stringWithFormat:@"%@ - %@", oneStr, twoStr];
        _mulPicker.hidden = YES;
        
    } else if (_relyMulPicker.hidden == NO) {
        
        NSInteger selectedRowOne = [_relyMulPicker selectedRowInComponent:0];
        NSInteger selectedRowTwo = [_relyMulPicker selectedRowInComponent:1];
        NSString * oneStr = [_relyMulPickerArr objectAtIndex:selectedRowOne];
        NSString * twoStr = [_relyMulPickerArr2 objectAtIndex:selectedRowTwo];
        _textField.text = [NSString stringWithFormat:@"%@ - %@", oneStr, twoStr];
        _relyMulPicker.hidden = YES;
        
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_pickerArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_id = @"CELL_ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    cell.textLabel.text = _pickerArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        _datePicker.hidden = NO;
        _singlePicker.hidden = YES;
        _mulPicker.hidden = YES;
        _relyMulPicker.hidden = YES;
        
    } else if (indexPath.row == 1) {
        
        _singlePicker.hidden = NO;
        _datePicker.hidden = YES;
        _mulPicker.hidden = YES;
        _relyMulPicker.hidden = YES;

        
    } else if (indexPath.row == 2) {
        
        _mulPicker.hidden = NO;
        _datePicker.hidden = YES;
        _singlePicker.hidden = YES;
        _relyMulPicker.hidden = YES;

        
    } else if (indexPath.row == 3) {
        
        _relyMulPicker.hidden = NO;
        _datePicker.hidden = YES;
        _singlePicker.hidden = YES;
        _mulPicker.hidden = YES;
        
    }
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == _singlePicker) {
        return 1;
    } else if (pickerView == _mulPicker) {
        return 2;
    } else if (pickerView == _relyMulPicker) {
        return 2;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == _singlePicker) {
        return [_singlePickerArr count];
    } else if (pickerView == _mulPicker) {
        if (component == 0) {
            return [_mulPickerArrOne count];
        }
        return [_mulPickerArrTwo count];
    } else if (pickerView == _relyMulPicker) {
        if (component == 0) {
            return [_relyMulPickerArr count];
        }
        return [_relyMulPickerArr2 count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == _singlePicker) {
        return [_singlePickerArr objectAtIndex:row];
    } else if (pickerView == _mulPicker) {
        if (component == 0) {
            return [_mulPickerArrOne objectAtIndex:row];
        }
        return [_mulPickerArrTwo objectAtIndex:row];
    } else if (pickerView == _relyMulPicker) {
        if (component == 0) {
            return [_relyMulPickerArr objectAtIndex:row];
        }
        return [_relyMulPickerArr2 objectAtIndex:row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == _relyMulPicker) {
        if (component == 0) {
            NSString * selectedStr = [_relyMulPickerArr objectAtIndex:row];
            NSArray * arr = _relyDic[selectedStr];
            _relyMulPickerArr2 = arr;
            [_relyMulPicker selectRow:0 inComponent:1 animated:YES];
            [_relyMulPicker reloadComponent:1];
        }
    }
}

@end
