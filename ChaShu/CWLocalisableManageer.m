//
//  CWLocalisableManageer.m
//  ChaShu
//
//  Created by ChenWei on 16/10/21.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "CWLocalisableManageer.h"

@implementation CWLocalisableManageer
+ (instancetype)shareManager {
  static  CWLocalisableManageer *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CWLocalisableManageer alloc] init];
    });
    return manager;
}

+ (void)setLanguage:(NSString *)language bundleName:(void(^)(NSBundle *))BundleName {
    NSString *path =  [[NSBundle mainBundle] pathForResource:language ofType:nil];
    
    NSBundle *bundel = [NSBundle bundleWithPath:path];
    // 如果bundel为空就利用mainBundle加载系统首选的语言
    if (bundel == nil) {
        bundel = [NSBundle mainBundle];
    }
    BundleName(bundel);
}
@end
