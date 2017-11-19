//
//  NSObject+ZJUIStyle.h
//  ZiJinLian
//
//  Created by lzy on 2017/3/18.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZJUIStyle)
@end

@interface UIButton (ZJUIStyle)

+(instancetype)getBtn;

-(void)setBtnFrame:(CGRect )frame   backgroundColor:(UIColor*)color  backGroundimageName:(NSString *)backGroundimageName  imageName:(NSString *)imageName  setTitle:(NSString *)title  setTitleColor:(UIColor *)TitleColor font:(UIFont *)font;
//创建button，有背景图片,无字体
@end

@interface UITableView (ZJUIStyle)

//工厂方法
+ (instancetype)tableView;
+ (instancetype)groupTableView;

//工具方法
- (void)scrollToBottom;

@end


@interface UICollectionView (ZJUIStyle)
//工厂方法
+ (instancetype)collectionViewWithFrame:(CGRect)frame setMinLineSpacing:(CGFloat)LineSpacing setMiniInteritemSpacing:(CGFloat)InsertSpacing setItemSize:(CGSize)itemCGSize  setSectionInset: (UIEdgeInsets)insets;


@end





@interface NSString (ZJUIStyle)
- (BOOL)isEmptyAfterTrimmingWhitespaceAndNewlineCharacters;
- (NSString *)stringByTrimmingWhitespaceAndNewlineCharacters;

// 是否是邮箱
- (BOOL)conformsToEMailFormat;
// 长度是否在一个范围之内,包括范围值
- (BOOL)isLengthGreaterThanOrEqual:(NSInteger)minimum lessThanOrEqual:(NSInteger)maximum;

- (NSRange)firstRangeOfURLSubstring;
- (NSString *)firstURLSubstring;
- (NSArray *)URLSubstrings;
- (NSString *)firstMatchUsingRegularExpression:(NSRegularExpression *)regularExpression;
- (NSString *)firstMatchUsingRegularExpressionPattern:(NSString *)regularExpressionPattern;
// 注意这个是全文匹配
- (BOOL)matchesRegularExpressionPattern:(NSString *)regularExpressionPattern;
- (NSRange)rangeOfFirstMatchUsingRegularExpressionPattern:(NSString *)regularExpressionPattern;

- (NSString *)stringByReplacingMatchesUsingRegularExpressionPattern:(NSString *)regularExpressionPattern withTemplate:(NSString *)templ;

- (NSDictionary *)URLParameters;
+ (NSString *)stringWithDate:(NSDate *)date dateFormat:(NSString *)format;
+ (NSString *)stringWithMSecondsFrom1970:(NSInteger)seconds dataFormat:(NSString *)format;

// iOS7出了新的计算字符大小的方法，这里封装一下顺便少写一些参数,当然也只能算出一行的
- (CGFloat)singleLineWidthWithFont:(UIFont *)font;
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (NSRange)fullRange;
- (NSString *)pinyin;
- (NSString *)filterStringWithRegula;
+(UIColor *)getColorFromColorString:(NSString *)color;//@"#ffffff"
@end


@interface UITextField (ZJUIStyle)

- (BOOL)isEmptyAfterTrimmingWhitespaceAndNewlineCharacters;
- (void)FETextFieldStyle;
- (void)FEInputTextFieldStyle;

@end

