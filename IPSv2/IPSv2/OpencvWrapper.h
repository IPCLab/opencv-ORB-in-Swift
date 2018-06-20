//
//  OpencvWrapper.h
//  IPSv2
//
//  Created by 邱嵩傑 on 2018/4/28.
//  Copyright © 2018年 邱嵩傑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UiKit.h>

@interface OpencvWrapper : NSObject
+(UIImage*) getdescriptors:(UIImage*)picture;
//+(void) bow:(NSMutableArray *)array newphoto:(UIImage*) photo;
@end
