//
//  SQLManager.h
//  Stronger
//
//  Created by 童阳升 on 2017/11/21.
//  Copyright © 2017年 童阳升. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "sqlite3.h"
@interface SQLManager : NSObject
{
    sqlite3 *db;
}

+(SQLManager *)shareManager;

-(UserModel *)searchWithUserId:(UserModel *)model;

-(int)insert:(UserModel *)model;

-(NSArray *)load;
-(NSArray *)reloadData:(UserModel *)model;
@end
