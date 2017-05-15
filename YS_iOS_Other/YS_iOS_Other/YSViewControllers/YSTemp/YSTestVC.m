//
//  YSTestVC.m
//  YS_iOS_Other
//
//  Created by YJ on 17/3/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSTestVC.h"
#import "AFNetworking.h"
#import "YSEnDecryptionMethod.h"

@interface YSTestVC ()<UIWebViewDelegate>

@end

@implementation YSTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 3934450268064 yunda
    // 666850417506 tiantian
    
    
    /** 跳转API - 快递100
    NSString * path = @"http://www.kuaidi100.com/chaxun?com=yunda&nu=3934450268064&callbackurl=";
    NSURL * url = [[NSURL alloc] initWithString:path];
    
    UIWebView * webView = [[UIWebView alloc] init];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
     */
    
    
    /** 运单查询API - 快递100
    NSString * path2 = @"http://api.kuaidi100.com/api?id=3cdd783849ce4fd3&com=tiantian&nu=666850417506&valicode=&show=0&muti=1&order=desc";
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:path2 parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DDLogInfo(@"------ %@", responseObject);
        NSDictionary * dict = (NSDictionary *)responseObject;
        NSString * msg = dict[@"message"];
        NSString * status = dict[@"status"];
        NSString * state = dict[@"state"];
        DDLogInfo(@"\nmsg: %@ \nstatus: %@ \nstate: %@ \n", msg, status, state);
        
        NSArray * list = dict[@"data"];
        NSString * time = @"";
        NSString * content = @"";
        for (NSDictionary * numDic in list) {
            time = numDic[@"time"];
            content = numDic[@"context"];
            DDLogInfo(@"\ntime: %@ \ncontent: %@ \n", time, content);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DDLogInfo(@"------ error: %@", error.localizedDescription);
        
    }];
    */
    
    /** 快递鸟 物流追踪API */
    NSString * path3 = @"http://api.kdniao.cc/Ebusiness/EbusinessOrderHandle.aspx";
    //@"http://api.kdniao.cc/api/dist";             // 正式地址
    //@"http://testapi.kdniao.cc:8081/api/dist";    // 测试地址
    NSString * gsCode = @"YD";   // 快递公司编号
    NSString * wuliuCode = @"3934450268064"; // 快递单号
    NSString * userId = @"1281968";
    NSString * appKey = @"ae95977c-d5f9-48bb-b50b-6327c19d819a";
    
    /**/
    NSDictionary * requestDic = @{@"OrderCode":@"", @"ShipperCode":gsCode, @"LogisticCode":wuliuCode};
    NSData * requestJSONData = [NSJSONSerialization dataWithJSONObject:requestDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * requestUTF8 = @"";
    NSString * requestUTF8URL = @"";
    requestUTF8 = [[NSString alloc] initWithData:requestJSONData encoding:NSUTF8StringEncoding];
    requestUTF8URL = [requestUTF8 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * tempSign = [NSString stringWithFormat:@"%@%@", requestUTF8, appKey];
    NSString * tempSignMd5 = [YSEnDecryptionMethod encryptMD5StrForString:tempSign];
    NSString * tempSignMd5Base64 = [YSEnDecryptionMethod encryptBase64StrForString:tempSignMd5];
    NSString * sign = [tempSignMd5Base64 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSDictionary * paraDic = @{@"RequestData":requestUTF8URL,
                               @"EBusinessID":userId,
                               @"RequestType":@"1002",
                               @"DataSign":sign,
                               @"DataType":@"2"};
    
    AFHTTPSessionManager * kdniaoManager = [AFHTTPSessionManager manager];
    [kdniaoManager POST:path3 parameters:paraDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            
        }
    }];
    
    
    
    
    
    /*
    NSDictionary *sendDic = @{@"OrderCode":@"",@"ShipperCode":@"SF",@"LogisticCode":@"118954907573"};
    NSString *EBusinessID = @"1281968";//电商ID
    NSString *RequestType = @"1002";
    NSString *dataType = @"2";
    NSString *appKey = @"ae95977c-d5f9-48bb-b50b-6327c19d819a";
    NSString *path = @"http://testapi.kdniao.cc:8081/Ebusiness/EbusinessOrderHandle.aspx";
    
    NSError *error;
    //NSDictionary转换为Data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:sendDic options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        DDLogError(@"___  getJsonStringFromDic error :%@",[error localizedDescription]);
    }
    
    // NSString* jsonstr = [NSString stringWithFormat:@"{\"OrderCode\":\"\",\"ShipperCode\":\"%@\",\"LogisticCode\":\"%@\"}",@"SF",@"118954907573"];
    
    //Data转换为JSON
    NSString* jsonstr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    // NSLog(@"jsonstr = %@",jsonstr);
    
    NSString *encodeUrl = [jsonstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"encodeUrl = %@", encodeUrl);
    
    NSString *dataSignStr = [NSString stringWithFormat:@"%@%@",jsonstr,appKey];
    
    NSString *dataSignMD5 =  [self getMD5Str:dataSignStr];
    
    NSString *dataSignBase64 =  [[dataSignMD5 dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
    
    NSString *dataSignBase64URl = [dataSignBase64 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *dataSignBase64URl2 = [dataSignBase64 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"dataSignBase64URl = %@",dataSignBase64URl);
    
    // datasign = HttpUtility.UrlEncode(base64( MD5(jsonStr+keyValue, "UTF-8"),"UTF-8"),Encoding.UTF8);//把(jsonStr+AppKey)进行MD5加密，然后Base64编码，最后 进行URL(utf-8)编码
    
    //   测试接口：http://testapi.kdniao.cc:8081/Ebusiness/EbusinessOrderHandle.aspx
    //   测试电商ID==1237100，AppKey==518a73d8-1f7f-441a-b644-33e77b49d846
    
    NSDictionary *paramDic = @{@"RequestType":RequestType,@"EBusinessID":EBusinessID,@"RequestData":encodeUrl,@"DataSign":dataSignBase64URl2,@"DataType":dataType};
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
