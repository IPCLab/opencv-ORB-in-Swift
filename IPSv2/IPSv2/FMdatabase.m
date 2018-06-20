//
//  FMdatabase.m
//  IPSv2
//
//  Created by 邱嵩傑 on 2018/6/4.
//  Copyright © 2018年 邱嵩傑. All rights reserved.
//

#import "FMdatabase.h"
#import "FMDB.h"
#import "pictureData.h"


@implementation FMdatabase


+(NSMutableArray*)getData{
    NSMutableArray *imagedata = [[NSMutableArray alloc]init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"research" ofType:@"db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    FMResultSet *dataLists = [db executeQuery:@"select * from Data"];
    
    while([dataLists next]){
        pictureData *imageData = [[pictureData alloc]init];
        
        imageData->picture_ID = [dataLists intForColumn:@"id"];
        imageData->picture_Image =[dataLists dataForColumn:@"image"];
        
        [imagedata addObject:imageData];
    }
    
    
    return imagedata;
}
@end
