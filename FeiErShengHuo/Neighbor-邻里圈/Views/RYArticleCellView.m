//
//  RYArticleCellView.m
//  CCICPhone
//
//  Created by apple on 15/6/23.
//  Copyright (c) 2015年 Ruyun. All rights reserved.
//

#import "RYArticleCellView.h"

#import "UIImageView+WebCache.h"

@implementation RYArticleCellView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = 3;
        [self addSubview:bgView];
        
        self.titLbl = [[UILabel alloc] initWithFrame:CGRectMake(16, 16,MainW-96, 36)];
        _titLbl.font = [UIFont systemFontOfSize:16.f];
        _titLbl.numberOfLines = 0;
        _titLbl.lineBreakMode = NSLineBreakByWordWrapping;
        _titLbl.textColor = [UIColor whiteColor];
        [self addSubview:_titLbl];
        
        self.articleImg = [[UIImageView alloc] init];
        _articleImg.frame = CGRectMake(16, self.frame.size.height-84, 68, 68);
        [self addSubview:_articleImg];
        
        self.sumaryLbl = [[UILabel alloc] initWithFrame:CGRectMake(92, _articleImg.frame.origin.y, frame.size.width-108, 68)];
        _sumaryLbl.font = [UIFont systemFontOfSize:13.f];
        _sumaryLbl.textColor = [UIColor colorWithWhite:1.0 alpha:0.4];
        _sumaryLbl.numberOfLines = 0;
        [self addSubview:_sumaryLbl];
    }
    return self;
}

-(void)setUpArticleModel:(FEDynamicModel *)dymodel
{
//    if ((dymodel && dymodel.article) || (dymodel && dymodel.dynamicRef.article)) {
//        RYDynamicArticleModel *curArticelModel = nil;
//        if (dymodel.article) {
//            curArticelModel = dymodel.article;
//        }else{
//            curArticelModel = dymodel.dynamicRef.article;
//        }
//        //标题
//        NSString *titStr = curArticelModel.title;
//        _titLbl.text = titStr;
//        NSDictionary *ttattribute = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
//        CGSize ttsizef = [titStr boundingRectWithSize:CGSizeMake(_titLbl.frame.size.width, 40) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:ttattribute context:nil].size;
//        _titLbl.frame = CGRectMake(16, 16, _titLbl.frame.size.width, ttsizef.height+2);
//        
//        //简介
//        NSString *sumStr = curArticelModel.summary;
//        _sumaryLbl.text = sumStr;
//        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
//        CGSize sizef = [sumStr boundingRectWithSize:CGSizeMake(_sumaryLbl.frame.size.width, 68) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//        _sumaryLbl.frame = CGRectMake(92, _articleImg.frame.origin.y, _sumaryLbl.frame.size.width, sizef.height+2);
//        
//        //WithPlaceholderImage:[UIImage imageNamed:@"pic_def"]
//        if (curArticelModel.cover.length) {
//            NSString *ustr = [curArticelModel.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            [_articleImg sd_setImageWithURL:[NSURL URLWithString:ustr] placeholderImage:[UIImage imageNamed:@"pic_def"]];
//        }
//    }
}

@end
