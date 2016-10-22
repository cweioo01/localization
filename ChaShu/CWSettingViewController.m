//
//  CWSettingViewController.m
//  ChaShu
//
//  Created by ChenWei on 16/10/21.
//  Copyright © 2016年 cw. All rights reserved.
//
#import "CWSettingViewController.h"
#import <Foundation/Foundation.h>
#import "CWLocalisableManageer.h"

//static struct {
//    int type; // 繁體
//    char *name;
//}LanguageNameTable[] = {
//    {0, "zh-Hant-HK.lproj"},
//    {1, "zh-Hans.lproj"},
//    {2, "en.lproj"},
//};

typedef NS_ENUM(NSInteger,LanguageType) {
    LanguageTypeSimple = 0,
    LanguageTypeUnsimple,
    LanguageTypeEnglish,
};

// 全局结构体,方便取出对应语言的的bundle文件名
static struct {
    LanguageType type; // 繁體
    char *name;
}LanguageNameTable[] = {
    {LanguageTypeUnsimple, "zh-Hant-HK.lproj"},
    {LanguageTypeSimple, "zh-Hans.lproj"},
    {LanguageTypeEnglish, "en.lproj"},
};

// 全局變量記錄當前的語言設置,默认为LanguageTypeUnsimple
NSString *currentLanguage = @"LanguageTypeUnsimple";
// 偏好设置中记录语言设置的key
NSString *LanguageStoreKey = @"LanguageStoreKey";

@interface CWSettingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *unsimplifiedLanguageBtn;
@property (weak, nonatomic) IBOutlet UIButton *simpleLanguageBtn;
@property (weak, nonatomic) IBOutlet UIButton *EnglishLanguageBtn;
@property (strong, nonatomic) UIButton *selectedLanguageBtn;

@property (weak, nonatomic) IBOutlet UIButton *resetPassword;
@property (weak, nonatomic) IBOutlet UIButton *toggleCount;
@property (weak, nonatomic) IBOutlet UIButton *exitLogin;

@end


@implementation CWSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    // 设置文字
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageStoreKey];
    [self setLanguage:string];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 切换语言 */
- (IBAction)toggleLanguage:(UIButton *)btn {
    // 1.重复点击,直接返回
    if (btn.tag == self.selectedLanguageBtn.tag ) return;
    
    LanguageType type = (LanguageType)btn.tag;
    NSString *language = nil;
    switch (type) {
        case LanguageTypeUnsimple:
            language = [NSString stringWithFormat:@"%s", LanguageNameTable[LanguageTypeUnsimple].name];
            break;
        case LanguageTypeSimple:
            language = [NSString stringWithFormat:@"%s", LanguageNameTable[LanguageTypeSimple].name];
            break;
        case LanguageTypeEnglish:
            language = [NSString stringWithFormat:@"%s", LanguageNameTable[LanguageTypeEnglish].name];
            break;
        default:
            language = nil;
            break;
    }
    [self setLanguage:language];
    self.selectedLanguageBtn = btn;
}

- (void)setLanguage:(NSString *)language {
    if (language == [[NSUserDefaults standardUserDefaults] objectForKey:LanguageStoreKey]) return;
    
    [CWLocalisableManageer setLanguage:language bundleName:^void(NSBundle *bundel) {
        
        [self.unsimplifiedLanguageBtn setTitle:NSLocalizedStringFromTableInBundle(@"Unsimple", nil, bundel, nil) forState:UIControlStateNormal];
        [self.simpleLanguageBtn setTitle:NSLocalizedStringFromTableInBundle(@"Simple", nil, bundel, nil) forState:UIControlStateNormal];
        [self.EnglishLanguageBtn setTitle:NSLocalizedStringFromTableInBundle(@"English", nil, bundel, nil) forState:UIControlStateNormal];
        
        [self.resetPassword setTitle:NSLocalizedStringFromTableInBundle(@"resetPassword", nil, bundel, nil) forState:UIControlStateNormal];;
        [self.toggleCount setTitle:NSLocalizedStringFromTableInBundle(@"toggleCount", nil, bundel, nil) forState:UIControlStateNormal];
        
        [self.exitLogin setTitle:NSLocalizedStringFromTableInBundle(@"exitLogin", nil, bundel, nil) forState:UIControlStateNormal];
        
        //
        [[NSUserDefaults standardUserDefaults] setObject:language forKey:LanguageStoreKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    
    
//    [CWLocalisableManageer setLanguageWithName:languageName completeBlock:^NSString *{
//      NSString *path =  [[NSBundle mainBundle] pathForResource:languageName ofType:nil];
//        NSBundle *bundel = [NSBundle bundleWithPath:path];
//       
//        // 如果bundel为空就利用mainBundle加载系统首选的语言
//        if (bundel == nil) {
//            bundel = [NSBundle mainBundle];
//        }
//        
//        [self.unsimplifiedLanguageBtn setTitle:NSLocalizedStringFromTableInBundle(@"Unsimple", nil, bundel, nil) forState:UIControlStateNormal];
//        [self.simpleLanguageBtn setTitle:NSLocalizedStringFromTableInBundle(@"Simple", nil, bundel, nil) forState:UIControlStateNormal];
//        [self.EnglishLanguageBtn setTitle:NSLocalizedStringFromTableInBundle(@"English", nil, bundel, nil) forState:UIControlStateNormal];
//        
//        [self.resetPassword setTitle:NSLocalizedStringFromTableInBundle(@"resetPassword", nil, bundel, nil) forState:UIControlStateNormal];;
//        [self.toggleCount setTitle:NSLocalizedStringFromTableInBundle(@"toggleCount", nil, bundel, nil) forState:UIControlStateNormal];
//        
//        [self.exitLogin setTitle:NSLocalizedStringFromTableInBundle(@"exitLogin", nil, bundel, nil) forState:UIControlStateNormal];
//        
//        
//        // 从主bundle中 Buttons.string.
////        [self.exitLogin setTitle:NSLocalizedStringFromTableInBundle(@"exitLogin", @"Buttons",  [NSBundle mainBundle], nil) forState:UIControlStateNormal];
//        
//       ;
//        // 告知更新成功.
//        return languageName;
//    }];
}

@end
