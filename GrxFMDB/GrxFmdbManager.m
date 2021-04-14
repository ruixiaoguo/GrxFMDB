//
//  GrxFmdbManager.m
//  GrxFMDB
//
//  Created by grx on 2021/4/14.
//

#import "GrxFmdbManager.h"
@implementation GrxFmdbManager
+ (GrxFmdbManager *)shared{
    static GrxFmdbManager *object = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object = [[GrxFmdbManager alloc]init];
    });
    return object;
}

//==========================创建数据库=========================
-(void)createrDB{
    //1.创建database路径
        NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath = [docuPath stringByAppendingPathComponent:@"test.db"];
        NSLog(@"!!!dbPath = %@",dbPath);
         //2.创建对应路径下数据库
        self.db = [FMDatabase databaseWithPath:dbPath];
        //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
        [self.db open];
        if (![self.db open]) {
            NSLog(@"db open fail");
            return;
        }
        NSString *sql = @"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL)";
        //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            NSLog(@"create table success");
            
        }
        [self.db close];
}

//==========================插入数据到表=========================
-(void)insertToTable:(NSString *)sqlStr{
    [self.db open];
    //1.开启事务
    [self.db beginTransaction];
    BOOL rollBack = NO;
    @try {
    //2.在事务中执行任务
        for (int i = 0; i< 500; i++) {
            int ID = i+1;
            NSString *name = [NSString stringWithFormat:@"小米_%d",i+1];
            NSString *phone = [NSString stringWithFormat:@"1589%d",i+10];
            int sorse = i+100;
            NSString *sqlStr = [NSString stringWithFormat:@"insert into 't_student' (ID,name,phone,score) values(%d,'%@','%@',%d)",ID,name,phone,sorse];
            BOOL result = [self.db executeUpdate:sqlStr];
                if (result) {
                    NSLog(@"insert into 't_studet' success");
                } else {
                    NSLog(@"insert into 't_studet' fail");
                }
        }
    }
    @catch(NSException *exception) {
    //3.在事务中执行任务失败，退回开启事务之前的状态
            rollBack = YES;
            [self.db rollback];
        }
        @finally {
    //4. 在事务中执行任务成功之后
            rollBack = NO;
            [self.db commit];
        }
    [self.db close];

}
//==========================删除数据=========================
-(void)deleteFromTable:(NSString *)sqlStr{
    [self.db open];
    BOOL result = [self.db executeUpdate:sqlStr];
        if (result) {
            NSLog(@"delete from 't_studet' success");
        } else {
            NSLog(@"delete from 't_studet' fail");
        }
    [self.db close];
}

//==========================更新数据=========================
-(void)updataFromTable:(NSString *)sqlStr{
    [self.db open];
    BOOL result = [self.db executeUpdate:sqlStr];
        if (result) {
            NSLog(@"updata from 't_studet' success");
        } else {
            NSLog(@"updata from 't_studet' fail");
        }
    [self.db close];
}

//==========================查询数据=========================
-(void)selectFromTable:(NSString *)sqlStr{
    [self.db open];
    FMResultSet *result = [self.db executeQuery:sqlStr];
    NSMutableArray *arr = [NSMutableArray array];
        while ([result next]) {
            NSMutableArray *arrchil = [NSMutableArray array];

            NSString * ID = [NSString stringWithFormat:@"%d",[result intForColumn:@"ID"]];
            NSString *name = [result stringForColumn:@"name"];
            NSString *phone = [result stringForColumn:@"phone"];
            NSString * score = [NSString stringWithFormat:@"%d",[result intForColumn:@"score"]];
            [arrchil addObject:ID];
            [arrchil addObject:name];
            [arrchil addObject:phone];
            [arrchil addObject:score];
            [arr addObjectsFromArray:arrchil];
        }
    NSLog(@"从数据库查询到的人员 %@",arr);

    [self.db close];
}
@end
