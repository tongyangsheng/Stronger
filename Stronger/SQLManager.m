//
//  SQLManager.m
//  Stronger
//
//  Created by 童阳升 on 2017/11/21.
//  Copyright © 2017年 童阳升. All rights reserved.
//

#import "SQLManager.h"

@implementation SQLManager
#define  kNameFile (@"MachineAppiontment.sqlite")

static SQLManager *manager=nil;

+(SQLManager *)shareManager{
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
    NSLog(@"数据库地址是：%@",writetablePath);
    if(sqlite3_open([writetablePath UTF8String], &db)!=SQLITE_OK)
    {//SQLITE_OK表示打开成功
        //失败
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败1");
    }else{
        char *err;
        NSString *createSQL=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS AppiontmentTable(idUserNumber INT PRIMARY KEY,userName TEXT,machineType TEXT,machineId,date TEXT,place TEXT,time TEXT);"];
        if(sqlite3_exec(db, [createSQL UTF8String], NULL, NULL, &err)!=SQLITE_OK)
        {
            //失败
            sqlite3_close(db);
            NSAssert1(NO, @"建表失败！%s", err);
        }
        sqlite3_close(db);
    }
    }
-(UserModel *)searchWithUserId:(UserModel *)model;{
    NSString *path=[self applicationDocumentsDirectoryFile];
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败2");
    }else
    {
       NSString *qsql=@"SELECT idUserNumber,userName,machineType,machineId,data,place,time FROM AppiontmentTable where idUserNumber = ?";
        
        sqlite3_stmt *statement;//用户对象
        //   1.数据库对象
        //     2.SQL语句
        //     3.执行语句长度 -1:全部长度
        //     4.语句对象
        //     5.没有执行语句部分
        if(sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL)==SQLITE_OK)
        {
            //进行按主键查询
            NSString *idUserNumber=model.idUserNumber;
            /*
             1. 语句对象
             2. 参数开始执行的序号
             3. 绑定的值
             4. 绑定字符串的长度
             5. 指针 NULL
             */
            sqlite3_bind_text(statement, 1, [idUserNumber UTF8String], -1, NULL);
            //返回值代表查出（SQLITE_ROW）
            if(sqlite3_step(statement)==SQLITE_ROW)
            {
                //提取数据
            /*
             1. 语句对象
             2. 字段索引
             */
                char *idUserNumber          = (char *)sqlite3_column_text(statement, 0);
            //转换到OC可以接受
            NSString *idUserNumberStr   = [[NSString alloc]initWithUTF8String:idUserNumber];
            
            char *userName           = (char *)sqlite3_column_text(statement, 1);
            
            NSString *userNameStr    = [[NSString alloc]initWithUTF8String:userName];
            
            char *machineType        = (char *)sqlite3_column_text(statement, 2);
            
            NSString *machineTypeStr = [[NSString alloc]initWithUTF8String:machineType];
            
            char *machineId         = (char *)sqlite3_column_text(statement, 3);
            
            NSString *machineIdStr    =  [[NSString alloc]initWithUTF8String:machineId];
            
            char *date        = (char *)sqlite3_column_text(statement, 4);
            
            NSString *dateStr    =  [[NSString alloc]initWithUTF8String:date];
            
            char *  place       = (char *)sqlite3_column_text(statement, 5);
            
            NSString *placeStr    =  [[NSString alloc]initWithUTF8String:place];
            
            char *time        = (char *)sqlite3_column_text(statement, 6);
            
            NSString *timeStr    =  [[NSString alloc]initWithUTF8String:time];
            
            
            UserModel *model  =  [[UserModel alloc]init];
            
            model.idUserNumber  = idUserNumberStr;
            model.userName  = userNameStr;
            model.machineType= machineTypeStr;
            model.machineId = machineIdStr;
            model.date=dateStr;
            model.place=placeStr;
            model.time=timeStr;
            
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
-(int)insert:(UserModel *)model{
    NSString *path=[self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        //失败
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败3");
    }else{
        NSString *sql=@"INSERT OR REPLACE INTO AppiontmentTable (idUserNumber,userName,machineType,machineId,date,place,time) VALUES(?,?,?,?,?,?,?)";
        //预处理
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [model.idUserNumber UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.userName UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [model.machineType UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 4, [model.machineId UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 5, [model.date UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 6, [model.place UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 7, [model.time UTF8String], -1, NULL);
            
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
        NSString *sql=@"select * from AppiontmentTable order by idUserNumber";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL)==SQLITE_OK) {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                //提取数据
                /*
                 1. 语句对象
                 2. 字段索引
                 */
                char *idUserNumber          = (char *)sqlite3_column_text(statement, 0);
                //转换到OC可以接受
                NSString *idUserNumberStr   = [[NSString alloc]initWithUTF8String:idUserNumber];
                
                char *userName           = (char *)sqlite3_column_text(statement, 1);
                
                NSString *userNameStr    = [[NSString alloc]initWithUTF8String:userName];
                
                char *machineType        = (char *)sqlite3_column_text(statement, 2);
                
                NSString *machineTypeStr = [[NSString alloc]initWithUTF8String:machineType];
                
                char *machineId         = (char *)sqlite3_column_text(statement, 3);
                
                NSString *machineIdStr    =  [[NSString alloc]initWithUTF8String:machineId];
                
                char *date        = (char *)sqlite3_column_text(statement, 4);
                
                NSString *dateStr    =  [[NSString alloc]initWithUTF8String:date];
                
                char *  place       = (char *)sqlite3_column_text(statement, 5);
                
                NSString *placeStr    =  [[NSString alloc]initWithUTF8String:place];
                
                char *time        = (char *)sqlite3_column_text(statement, 6);
                
                NSString *timeStr    =  [[NSString alloc]initWithUTF8String:time];
                
                UserModel *model=[[UserModel alloc]init];
                
                model.idUserNumber  = idUserNumberStr;
                model.userName  = userNameStr;
                model.machineType= machineTypeStr;
                model.machineId = machineIdStr;
                model.date=dateStr;
                model.place=placeStr;
                model.time=timeStr;
                
                [reloadData addObject:model];
            }
            return reloadData;
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}
-(NSArray *)reloadData:(UserModel *)model{
    NSMutableArray *reloadData = [NSMutableArray array];
    NSString *path=[self applicationDocumentsDirectoryFile];
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败2");
    }else
    {
        NSString *qsql=@"SELECT * FROM AppiontmentTable";
        
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
                char *idUserNumber          = (char *)sqlite3_column_text(statement, 0);
                //转换到OC可以接受
                NSString *idUserNumberStr   = [[NSString alloc]initWithUTF8String:idUserNumber];
                
                char *userName           = (char *)sqlite3_column_text(statement, 1);
                
                NSString *userNameStr    = [[NSString alloc]initWithUTF8String:userName];
                
                char *machineType        = (char *)sqlite3_column_text(statement, 2);
                
                NSString *machineTypeStr = [[NSString alloc]initWithUTF8String:machineType];
                
                char *machineId         = (char *)sqlite3_column_text(statement, 3);
                
                NSString *machineIdStr    =  [[NSString alloc]initWithUTF8String:machineId];
                
                char *date        = (char *)sqlite3_column_text(statement, 4);
                
                NSString *dateStr    =  [[NSString alloc]initWithUTF8String:date];
                
                char *  place       = (char *)sqlite3_column_text(statement, 5);
                
                NSString *placeStr    =  [[NSString alloc]initWithUTF8String:place];
                
                char *time        = (char *)sqlite3_column_text(statement, 6);
                
                NSString *timeStr    =  [[NSString alloc]initWithUTF8String:time];
                
                UserModel *model=[[UserModel alloc]init];
                
                model.idUserNumber  = idUserNumberStr;
                model.userName  = userNameStr;
                model.machineType= machineTypeStr;
                model.machineId = machineIdStr;
                model.date=dateStr;
                model.place=placeStr;
                model.time=timeStr;
                
                [reloadData addObject:model];
            }
            return reloadData;
        }
        
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}
@end
