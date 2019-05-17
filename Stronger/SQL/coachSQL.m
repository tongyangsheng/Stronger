//
//  coachSQL.m
//  Stronger
//
//  Created by game98 on 2019/5/16.
//  Copyright © 2019 童阳升. All rights reserved.
//

#import "coachSQL.h"

@implementation coachSQL

#define  kNameFile (@"coach.sqlite")

static coachSQL *manager=nil;

+(coachSQL *)shareManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager=[[self alloc]init];
        [manager creatDataBaseTableIfNeeded];
    });
    return manager;
}

-(NSString *)applicationDocumentsDirectoryFile
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths firstObject];
    NSString *filePath=[documentDirectory stringByAppendingPathComponent:kNameFile];
    return filePath;
}
-(void)creatDataBaseTableIfNeeded{
    NSString *writetablePath=[self applicationDocumentsDirectoryFile];
    NSLog(@"教练数据库地址是：%@",writetablePath);
    if(sqlite3_open([writetablePath UTF8String], &db)!=SQLITE_OK)
    {//SQLITE_OK表示打开成功
        //失败
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败1");
    }else{
        char *err;
        NSString *createSQL=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS coachTable(coachID INT PRIMARY KEY,coachName TEXT,coachClass TEXT,coachPlace TEXT,coachTime TEXT);"];
        if(sqlite3_exec(db, [createSQL UTF8String], NULL, NULL, &err)!=SQLITE_OK)
        {
            //失败
            sqlite3_close(db);
            NSAssert1(NO, @"建表失败！%s", err);
        }
        sqlite3_close(db);
    }
}

-(coachModel *)searchWithUserId:(coachModel *)model;{
    NSString *path=[self applicationDocumentsDirectoryFile];
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败2");
    }else
    {
        NSString *qsql=@"SELECT coachID,coachName,coachClass,coachPlace,coachTime FROM coachTable where coachID = ?";
        
        sqlite3_stmt *statement;//用户对象
        //   1.数据库对象
        //     2.SQL语句
        //     3.执行语句长度 -1:全部长度
        //     4.语句对象
        //     5.没有执行语句部分
        if(sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            //进行按主键查询
            NSString *coachID=model.coachID;
            /*
             1. 语句对象
             2. 参数开始执行的序号
             3. 绑定的值
             4. 绑定字符串的长度
             5. 指针 NULL
             */
            sqlite3_bind_text(statement, 1, [coachID UTF8String], -1, NULL);
            //返回值代表查出（SQLITE_ROW）
            if(sqlite3_step(statement)==SQLITE_ROW)
            {
                //提取数据
                /*
                 1. 语句对象
                 2. 字段索引
                 */
                char *coachID          = (char *)sqlite3_column_text(statement, 0);
                //转换到OC可以接受
                NSString *coachIDStr   = [[NSString alloc]initWithUTF8String:coachID];
                
                char *coachName          = (char *)sqlite3_column_text(statement, 1);
                
                NSString *coachNameStr    = [[NSString alloc]initWithUTF8String:coachName];
                
                char *coachClass        = (char *)sqlite3_column_text(statement, 2);
                
                NSString *coachClassStr = [[NSString alloc]initWithUTF8String:coachClass];
                
                char *coachPlace         = (char *)sqlite3_column_text(statement, 3);
                
                NSString *coachPlaceStr    =  [[NSString alloc]initWithUTF8String:coachPlace];
                
                char *coachTime        = (char *)sqlite3_column_text(statement, 4);
                
                NSString *coachTimeStr    =  [[NSString alloc]initWithUTF8String:coachTime];
                
              
                
                
                coachModel *model  =  [[coachModel alloc]init];
                
                model.coachID  = coachIDStr;
                model.coachName  = coachNameStr;
                model.coachClass= coachClassStr;
                model.coachPlace = coachPlaceStr;
                model.coachTime=coachTimeStr;
               
                
                sqlite3_finalize(statement);
                sqlite3_close(db);
                
                return model;
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}

-(int)insert:(coachModel *)model{
    NSString *path=[self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        //失败
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败3");
    }else{
        NSString *sql=@"INSERT OR REPLACE INTO coachTable (coachID,coachName,coachClass,coachPlace,coachTime) VALUES(?,?,?,?,?)";
        //预处理
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [model.coachID UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.coachName UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [model.coachClass UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 4, [model.coachPlace UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 5, [model.coachTime UTF8String], -1, NULL);
            
            
            if(sqlite3_step(statement)!=SQLITE_DONE){
                NSAssert(NO, @"插入数据失败");
            }
            sqlite3_finalize(statement);
            sqlite3_close(db);
        }
    }
    
    return 0;
}

-(NSArray *)load{
    NSMutableArray *reloadData = [NSMutableArray array];
    NSString *path=[self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        //失败
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败4");
    }else{
        NSString *sql=@"select * from coachTable order by coachID";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                //提取数据
                /*
                 1. 语句对象
                 2. 字段索引
                 */
                char *coachID          = (char *)sqlite3_column_text(statement, 0);
                //转换到OC可以接受
                NSString *coachIDStr   = [[NSString alloc]initWithUTF8String:coachID];
                
                char *coachName          = (char *)sqlite3_column_text(statement, 1);
                
                NSString *coachNameStr    = [[NSString alloc]initWithUTF8String:coachName];
                
                char *coachClass        = (char *)sqlite3_column_text(statement, 2);
                
                NSString *coachClassStr = [[NSString alloc]initWithUTF8String:coachClass];
                
                char *coachPlace         = (char *)sqlite3_column_text(statement, 3);
                
                NSString *coachPlaceStr    =  [[NSString alloc]initWithUTF8String:coachPlace];
                
                char *coachTime        = (char *)sqlite3_column_text(statement, 4);
                
                NSString *coachTimeStr    =  [[NSString alloc]initWithUTF8String:coachTime];
                
              
                
                coachModel *model=[[coachModel alloc]init];
                
                model.coachID  = coachIDStr;
                model.coachName = coachNameStr;
                model.coachClass= coachClassStr;
                model.coachPlace = coachPlaceStr;
                model.coachTime=coachTimeStr;
                
                
                [reloadData addObject:model];
            }
            return reloadData;
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}
-(NSArray *)reloadData:(coachModel *)model{
    NSMutableArray *reloadData = [NSMutableArray array];
    NSString *path=[self applicationDocumentsDirectoryFile];
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败2");
    }else
    {
        NSString *qsql=@"SELECT * FROM coachTable";
        
        sqlite3_stmt *statement;//用户对象
        //   1.数据库对象
        //     2.SQL语句
        //     3.执行语句长度 -1:全部长度
        //     4.语句对象
        //     5.没有执行语句部分
        if(sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            //进行按主键查询
            
            /*
             1. 语句对象
             2. 参数开始执行的序号
             3. 绑定的值
             4. 绑定字符串的长度
             5. 指针 NULL
             */
            //返回值代表查出（SQLITE_ROW）
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                //提取数据
                /*
                 1. 语句对象
                 2. 字段索引
                 */
                char *coachID          = (char *)sqlite3_column_text(statement, 0);
                //转换到OC可以接受
                NSString *coachIDStr   = [[NSString alloc]initWithUTF8String:coachID];
                
                char *coachName          = (char *)sqlite3_column_text(statement, 1);
                
                NSString *coachNameStr    = [[NSString alloc]initWithUTF8String:coachName];
                
                char *coachClass        = (char *)sqlite3_column_text(statement, 2);
                
                NSString *coachClassStr = [[NSString alloc]initWithUTF8String:coachClass];
                
                char *coachPlace         = (char *)sqlite3_column_text(statement, 3);
                
                NSString *coachPlaceStr    =  [[NSString alloc]initWithUTF8String:coachPlace];
                
                char *coachTime        = (char *)sqlite3_column_text(statement, 4);
                
                NSString *coachTimeStr    =  [[NSString alloc]initWithUTF8String:coachTime];
                
                coachModel *model=[[coachModel alloc]init];
                
                model.coachID  = coachIDStr;
                model.coachName = coachNameStr;
                model.coachClass= coachClassStr;
                model.coachPlace = coachPlaceStr;
                model.coachTime=coachTimeStr;
                
                
                [reloadData addObject:model];
            }
            return reloadData;
        }
        
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}
//
-(int)deleteData:(coachModel *)model
{
    
    NSString *path=[self applicationDocumentsDirectoryFile];
    
    if(sqlite3_open([path UTF8String], &db)!=SQLITE_OK){
        sqlite3_close(db);
        NSLog(@"打开失败");
    }
    else{
        NSString *sql=@"delete from coachTable where coachID = ?";
        
        sqlite3_stmt *statement;
        NSLog(@"删除方法");
        if(sqlite3_prepare_v2(db,[sql UTF8String], -1,&statement, NULL)==SQLITE_OK){
            sqlite3_bind_text( statement, 1, [model.coachID UTF8String], -1, NULL);
            
            if(sqlite3_step(statement)!=SQLITE_DONE ){
                NSLog(@"删除失败");
            }
            sqlite3_finalize(statement);
            sqlite3_close(db);
        }
    }
    return 0;
}


@end
