//
//  ViewController.m
//  GrxFMDB
//
//  Created by grx on 2021/4/14.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 创建数据库和表 */
    [[GrxFmdbManager shared]createrDB];
    /** 插入数据 */
    NSDate *begin = [NSDate date];
    [[GrxFmdbManager shared]insertToTable:@""];
    NSDate *end = [NSDate date];
    NSTimeInterval time = [end timeIntervalSinceDate:begin];
    NSLog(@"在事务中执行插入任务 所需要的时间 = %f",time);
    /** 删除数据 */
//    NSString *sqlStr1 = @"delete from 't_student' where ID = 110";
//    [[GrxFmdbManager shared]deleteFromTable:sqlStr1];
    /** 更新数据 */
//    NSString *sqlStr2 = @"update 't_student' set name = '张三' where ID = 110";
//    [[GrxFmdbManager shared]updataFromTable:sqlStr2];
    /** 查询数据 */
//    NSString *sqlStr3 = @"select * from 't_student' where ID = 110";
//    [[GrxFmdbManager shared]selectFromTable:sqlStr3];
}


@end
