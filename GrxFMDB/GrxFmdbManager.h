//
//  GrxFmdbManager.h
//  GrxFMDB
//
//  Created by grx on 2021/4/14.
//

#import <Foundation/Foundation.h>
#import <fmdb/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface GrxFmdbManager : NSObject
@property(nonatomic,strong)FMDatabase *db;
+ (GrxFmdbManager *)shared;
/**1.使用FMDBbase类创建数据库*/
-(void)createrDB;
/**2.插入数据*/
-(void)insertToTable:(NSString *)sqlStr;
/**3.删除数据*/
-(void)deleteFromTable:(NSString *)sqlStr;
/**4.更新数据*/
-(void)updataFromTable:(NSString *)sqlStr;
/**4.查询数据*/
-(void)selectFromTable:(NSString *)sqlStr;
@end

NS_ASSUME_NONNULL_END
