//
//  SKLog.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#ifndef SKLog_h
#define SKLog_h

////  日志打印
//#ifdef DEBUG
#define  NSLog(format,...) printf("\n%s ^ ---- >  %s\n", __TIME__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//#else
//#define NSLog(...)
//#endif
//
//#define NSLogFunc NSLog(@"%s",__func__);

#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

#endif /* SKLog_h */
