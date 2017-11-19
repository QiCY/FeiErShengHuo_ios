//
//  NSObject+ZJUIStyle.m
//  ZiJinLian
//
//  Created by lzy on 2017/3/18.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import "NSObject+ZJUIStyle.h"

@implementation NSObject (ZJUIStyle)

@end

@implementation UIButton (ZJUIStyle)

+(instancetype)getBtn
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    return btn;
}


-(void)setBtnFrame:(CGRect )frame   backgroundColor:(UIColor*)color  backGroundimageName:(NSString *)backGroundimageName  imageName:(NSString *)imageName  setTitle:(NSString *)title  setTitleColor:(UIColor *)TitleColor font:(UIFont *)font
{
    self.frame = frame;
    [self setBackgroundImage:[UIImage imageNamed:backGroundimageName] forState:0];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:TitleColor forState:UIControlStateNormal];
    [self setBackgroundColor:color];
    self.titleLabel.font=font;
}

@end

@implementation UITableView (ZJUIStyle)

+ (instancetype)tableView
{
    UITableView *_tableView = [[self alloc] initWithFrame:CGRectZero
                                                    style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    //隐藏滚动条
    _tableView.showsVerticalScrollIndicator = NO;
    //[_tableView setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
    
    _tableView.backgroundColor =RGB(246, 246, 246);
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    return _tableView;
}

+ (instancetype)groupTableView
{
    UITableView *_tableView = [[self alloc] initWithFrame:CGRectZero
                                                    style:UITableViewStyleGrouped];
    //隐藏滚动条
    _tableView.showsVerticalScrollIndicator = NO;
    
    //[_tableView setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
    
    _tableView.backgroundColor =RGB(246, 246, 246);
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    return _tableView;
}


////对象方法
//- (void)scrollToBottom
//{
//    NSInteger sectionCount = [self.dataSource numberOfSectionsInTableView:self];
//    NSInteger lastSectionRowCount = [self.dataSource tableView:self numberOfRowsInSection:sectionCount-1];
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastSectionRowCount-1 inSection:sectionCount-1];
//    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewRowAnimationTop animated:YES];
//}


//取消段头停留


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    CGFloat sectionHeaderHeight = 40;
//    CGFloat sectionFooterHeight = 10;
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
//    {
//        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
//    }else if (offsetY >= sectionHeaderHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight)
//    {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
//    }else if (offsetY >= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height)
//    {
//        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight), 0);
//    }
//}
//

@end

@implementation UICollectionView (ZJUIStyle)

+(instancetype)collectionViewWithFrame:(CGRect)frame setMinLineSpacing:(CGFloat)LineSpacing setMiniInteritemSpacing:(CGFloat)InsertSpacing setItemSize:(CGSize)itemCGSize setSectionInset:(UIEdgeInsets)insets
{
        UICollectionViewFlowLayout *clay = [[UICollectionViewFlowLayout alloc] init];
        [clay setMinimumLineSpacing:LineSpacing];
        [clay setMinimumInteritemSpacing:InsertSpacing];
        clay.itemSize=itemCGSize;
        clay.sectionInset = insets;
        UICollectionView *_collections=[[UICollectionView alloc]initWithFrame:frame collectionViewLayout:clay];
        _collections.backgroundColor=[UIColor clearColor];
        _collections.scrollsToTop=NO;
        _collections.scrollEnabled=NO;
        return _collections;
}
@end



@implementation NSString (ZJUIStyle)


- (BOOL)isEmptyAfterTrimmingWhitespaceAndNewlineCharacters
{
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0;
}


- (NSString *)stringByTrimmingWhitespaceAndNewlineCharacters
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding
{
    return  CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), encoding));
    
}

- (NSString *)URLEncodedString
{
    return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}

+ (NSString *)stringWithDate:(NSDate *)date dateFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *dateFormat = nil;
    if (format == nil) {
        dateFormat = @"y.MM.dd HH: mm: ss";
    } else {
        dateFormat = format;
    }
    formatter.dateFormat = dateFormat;
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSString *)stringWithMSecondsFrom1970:(NSInteger)seconds dataFormat:(NSString *)format
{
    NSDate *sentDate = [NSDate dateWithTimeIntervalSince1970:seconds/1000.f];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:sentDate];
    NSDate *localeDate = [sentDate dateByAddingTimeInterval:interval];
    return [NSString stringWithDate:localeDate dateFormat:format];
}


// 是否是邮箱
- (BOOL)conformsToEMailFormat
{
    return [self matchesRegularExpressionPattern:kEmailRegularExpression];
}


// 长度是否在一个范围之内
- (BOOL)isLengthGreaterThanOrEqual:(NSInteger)minimum lessThanOrEqual:(NSInteger)maximum
{
    return ([self length] >= minimum) && ([self length] <= maximum);
}


- (NSRange)firstRangeOfURLSubstring
{
    static NSDataDetector *dataDetector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataDetector = [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypeLink | NSTextCheckingTypeLink)
                                                       error:nil];
    });
    
    NSRange range = [dataDetector rangeOfFirstMatchInString:self
                                                    options:0
                                                      range:NSMakeRange(0, [self length])];
    return range;
}


- (NSString *)firstURLSubstring
{
    NSRange range = [self firstRangeOfURLSubstring];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    return [self substringWithRange:range];
}


- (NSArray *)URLSubstrings
{
    static NSDataDetector *dataDetector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataDetector = [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypeLink | NSTextCheckingTypeLink)
                                                       error:nil];
    });
    
    NSArray *matches = [dataDetector matchesInString:self
                                             options:0
                                               range:NSMakeRange(0, [self length])];
    NSMutableArray *substrings = [NSMutableArray arrayWithCapacity:[matches count]];
    for (NSTextCheckingResult *result in matches) {
        [substrings addObject:[result.URL absoluteString]];
    }
    return [NSArray arrayWithArray:substrings];
}


- (NSString *)firstMatchUsingRegularExpression:(NSRegularExpression *)regularExpression
{
    NSRange range = [regularExpression rangeOfFirstMatchInString:self
                                                         options:0
                                                           range:NSMakeRange(0, [self length])];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    return [self substringWithRange:range];
}


- (NSString *)firstMatchUsingRegularExpressionPattern:(NSString *)regularExpressionPattern
{
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regularExpressionPattern
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:nil];
    return [self firstMatchUsingRegularExpression:regularExpression];
}


- (BOOL)matchesRegularExpressionPattern:(NSString *)regularExpressionPattern
{
    NSRange fullRange = NSMakeRange(0, [self length]);
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regularExpressionPattern
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:nil];
    NSRange range = [regularExpression rangeOfFirstMatchInString:self
                                                         options:0
                                                           range:fullRange];
    if (NSEqualRanges(fullRange, range)) {
        return YES;
    }
    return NO;
}


- (NSRange)rangeOfFirstMatchUsingRegularExpressionPattern:(NSString *)regularExpressionPattern
{
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regularExpressionPattern
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:nil];
    NSRange range = [regularExpression rangeOfFirstMatchInString:self
                                                         options:0
                                                           range:NSMakeRange(0, [self length])];
    return range;
}


- (NSString *)stringByReplacingMatchesUsingRegularExpressionPattern:(NSString *)regularExpressionPattern withTemplate:(NSString *)templ
{
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regularExpressionPattern
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:nil];
    NSString *string = [regularExpression stringByReplacingMatchesInString:self
                                                                   options:0
                                                                     range:NSMakeRange(0, [self length])
                                                              withTemplate:templ];
    return string;
}


- (NSDictionary *)URLParameters
{
    NSString *urlString = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSRange rangeOfQuestionMark = [urlString rangeOfString:@"?" options:NSBackwardsSearch];
    if (rangeOfQuestionMark.location == NSNotFound) {
        return nil;
    }
    
    NSString *parametersString = [urlString substringFromIndex:(rangeOfQuestionMark.location + 1)];
    NSArray *pairs = [parametersString componentsSeparatedByString:@"&"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:[pairs count]];
    for (NSString *aPair in pairs) {
        NSArray *keyAndValue = [aPair componentsSeparatedByString:@"="];
        if ([keyAndValue count] == 2) {
            [parameters setObject:keyAndValue[1] forKey:keyAndValue[0]];
        }
    }
    return parameters;
}


- (CGFloat)singleLineWidthWithFont:(UIFont *)font;
{
    return ceilf([self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MIN) options:0 attributes:@{NSFontAttributeName:font} context:nil].size.width);
    
}

- (NSString *)filterStringWithRegula
{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    NSString *retStr = [[self componentsSeparatedByCharactersInSet:doNotWant] componentsJoinedByString:@""];
    return retStr;
}


- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 5;//默认行间距 设置为5 吧
    NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};//,
    CGSize sizef = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return ceilf(sizef.height);
}


- (NSRange)fullRange
{
    return NSMakeRange(0, self.length);
}

//- (NSString *)pinyin
//{
//    NSString *pinyin = @"";
//    for (int i = 0; i < [self length]; i++) {
//        pinyin = [pinyin stringByAppendingFormat:@"%c",
//                  pinyinFirstLetter([self characterAtIndex:i])];
//    }
//    return pinyin;
//}

+(UIColor *)getColorFromColorString:(NSString *)color
{
    NSMutableString *rtStr = [[NSMutableString alloc] initWithString:color];
    // 转换成标准16进制数
    [rtStr replaceCharactersInRange:[rtStr rangeOfString:@"#" ] withString:@"0x"];
    // 十六进制字符串转成整形。
    long colorLong = strtoul([rtStr cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R = (colorLong & 0xff0000 )>>16;
    int G = (colorLong & 0x00ff00 )>>8;
    int B =  colorLong & 0x0000ff;
    //string转color
    UIColor *wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    return wordColor;
}
@end

@implementation UITextField (ZJUIStyle)

- (BOOL)isEmptyAfterTrimmingWhitespaceAndNewlineCharacters
{
    return self.text == nil || [self.text isEmptyAfterTrimmingWhitespaceAndNewlineCharacters];
}

- (void)FETextFieldStyle
{
    [self setValue:GLOBAL_LITTLE_FONT_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    self.textColor = GLOBAL_BIG_FONT_COLOR;
    [self setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    self.tintColor = GLOBAL_COLOR_LAN;
}

- (void)FEInputTextFieldStyle
{
    self.textAlignment = NSTextAlignmentRight;
    self.returnKeyType = UIReturnKeyDone;
    [self setValue:GLOBAL_LITTLE_FONT_COLOR forKeyPath:@"_placeholderLabel.textColor"];
    self.textColor = GLOBAL_LITTLE_FONT_COLOR;
    [self setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    self.tintColor = GLOBAL_COLOR_LAN;
    self.font = [UIFont systemFontOfSize:14];
    self.layer.cornerRadius=5;
    self.layer.masksToBounds=YES;
    self.backgroundColor=[UIColor whiteColor];
    
    
    
}


@end




