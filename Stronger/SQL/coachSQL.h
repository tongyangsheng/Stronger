//
//  coachSQL.h
//  Stronger
//
//  Created by game98 on 2019/5/16.
//  Copyright © 2019 童阳升. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sqlite3.h"
#import "coachModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface coachSQL : NSObject
{
    sqlite3 *db;
}

+(coachSQL *)shareManager;

-(coachModel *)searchWithUserId:(coachModel *)model;

-(int)insert:(coachModel *)model;
-(int)deleteData:(coachModel *)model;

-(NSArray *)load;
-(NSArray *)reloadData:(coachModel *)model;

@end

NS_ASSUME_NONNULL_END
