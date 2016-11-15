//
//  MKApi.h
//  yangtuner
//
//  Created by zhuwh on 2016/11/8.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#ifndef MKApi_h
#define MKApi_h

#define MK_ERROR_MSG(error) [NSString stringWithFormat:@"%s%@",__func__,[error localizedDescription]]
typedef void (^API_CALLBACK)(BOOL isSuccess, id message);

#endif /* MKApi_h */
