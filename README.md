## 一.原理

* 根据对应的语言版本,找到对应名字的bunldle,然后按key取出文字

## 二.方法介绍
```objc
// 从系统设置中首选语言的string中找key
#define NSLocalizedString(key, comment) \ [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:nil]
#define NSLocalizedStringFromTable(key, tbl, comment) \ [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:(tbl)]

// 从指定bundel的string中找key
// bundel文件名是 "en.lproj"这样的格式
// key : 对应的key
// tb1 一般是nil, 也就是strng的名字(例如: "button.string", 就传入button). 如果string不是在Localizable.strings下就要指定.
// bundel : 对应的bundel. 如果是nil,效果等同前面的方法.
// comment : 注释,给程序员看的,
#define NSLocalizedStringFromTableInBundle(key, tbl, bundle, comment) \ [bundle localizedStringForKey:(key) value:@"" table:(tbl)]
#define NSLocalizedStringWithDefaultValue(key, tbl, bundle, val, comment) \ [bundle localizedStringForKey:(key) value:(val) table:(tbl)]
```
```objc
[NSBundle bundleForClass:[self class];加载app中的所有bunle资源
```

## 四 本地化应用程序名称，这个只有一种方案：

* 点击“new file”然后在弹出窗口左侧选择IOS的resource项，在右侧就可以看到“String File”的图标。创建这个文件，命名为“InfoPlist”（一定是这个文件名） 就生成一个InfoPlist.strings文件；

* 选中InfoPlist.strings 点击 XCode-> View-> Utilities -> File Inspector,在Localization中点“+”，添加chinese （zh－Hans）类型的为简体中文，english 应该会自动添加上。然后在InfoPlish.strings 左边会多出一个三角形，点击展开后可以看到InfoPlish.strings(english)和InfoPlish.strings(chinese)两个版本的文件；

*在InfoPlish.strings(english)文件中加入：

* CFBundleDisplayName ="Program"; 其中“Program”为英文应用程序名称，同理在InfoPlish.strings(chinese)文件中加入：

* CFBundleDisplayName ="应用程序"; 其中“应用程序”为中文名称，注意：CFBundleDisplayName加不加双引号都行

* 编辑Info.plist，添加一个新的属性Application has localized display name, 设置其类型为boolean，并将其value设置为YES即

## 五
```objc
typedef enum {
LanguageTypeUnknown = 0,
LanguageTypeEnglish,
LanguageTypeSimpleChinese,
LanguageTypeTraditionalChinese,
}LanguageType;

// 全局结构体,方便取出对应语言的的bundle文件名
static struct {
LanguageType type; // 繁體
char *name;
}LanguageNameTable[] = {
{0, "zh-Hant-HK.lproj"},
{1, "zh-Hans.lproj"},
{2, "en.lproj"},
};
```
六.
![](https://github.com/cweioo01/localization/blob/master/Snip20161021_7.png)
