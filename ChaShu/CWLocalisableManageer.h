//
//  CWLocalisableManageer.h
//  ChaShu
//
//  Created by ChenWei on 16/10/21.
//  Copyright © 2016年 cw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWLocalisableManageer : NSObject
//+ (instancetype)shareManager;

+ (void)setLanguage:(NSString *)language bundleName:(void(^)(NSBundle *bundle))BundleName;
@end
