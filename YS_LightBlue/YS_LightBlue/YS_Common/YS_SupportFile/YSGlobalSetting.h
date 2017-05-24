//
//  YSGlobalSetting.h
//  YS_LightBlue
//
//  Created by YJ on 17/5/23.
//  Copyright © 2017年 YJ. All rights reserved.
//

#ifndef YSGlobalSetting_h
#define YSGlobalSetting_h


//------------- Font ------------------//

#define YS_Font(value) [UIFont systemFontOfSize:value]



//------------- Color ------------------//

#define YS_Color(rVlaue, gValue, bValue) [UIColor colorWithRed:rVlaue/255.0 green:gValue/255.0 blue:bValue/255.0 alpha:1.0]

#define YS_Default_GrayColor YS_Color(200, 200, 200)
#define YS_Default_BlueColor YS_Color(29, 175, 236)


#endif /* YSGlobalSetting_h */
