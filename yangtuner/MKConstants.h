//
//  MKConstants.h
//  yangtuner
//
//  Created by zhuwh on 16/11/6.
//  Copyright © 2016年 maikevip. All rights reserved.
//

#define MK_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define MK_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#define MK_DOWNLOAD_DIR [NSSearchPathForDirectoriesInDomains( NSDownloadsDirectory, NSUserDomainMask, YES) lastObject]
#define MK_DOWNLOAD_DIR [NSSearchPathForDirectoriesInDomains( NSDownloadsDirectory, NSUserDomainMask, YES) lastObject]
#define MK_CACHE_DIR [NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#define WeakSelf __weak typeof(self) weakSelf = self

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)

#define MK_ERROR_MSG(error) [NSString stringWithFormat:@"%s%@",__func__,[error localizedDescription]]

#define MK_COLOR_TABITEM_TEXT_SELECT RGB(229, 92, 148)
