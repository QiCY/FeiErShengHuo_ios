//
//  FESceneOperationResultItemCell.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/25.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESceneOperationResultItemCell.h"

@interface FESceneOperationResultItemCell ()

@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic,strong) UILabel *operationLabel;
@property (nonatomic,strong) UIImageView *resultView;

@end

@implementation FESceneOperationResultItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupView
{
    [self.contentView addSubview:self.infoLabel];
    [self.contentView addSubview:self.operationLabel];
    [self.contentView addSubview:self.resultView];
    
    self.infoLabel.frame = CGRectMake(12, 0, 100, 40);
    self.operationLabel.frame = CGRectMake(MainW-12-100, 0, 100, 40);
    self.resultView.hidden = YES;
}

- (void)refreshCellWithDevice:(BLDNADevice *)device index:(NSInteger)index result:(NSInteger)result
{
    self.contentView.backgroundColor = index % 2 ? [UIColor lightGrayColor] : [UIColor whiteColor];
    
    NSString *switchState = device.state == 0 ? @"关" : @"开";
    NSString *title = [NSString stringWithFormat:@"%ld%@%@",index,device.name,switchState];
    self.infoLabel.text = title;
    
    switch (result) {
        case 0: {
            self.resultView.hidden = YES;
            self.operationLabel.frame = CGRectMake(MainW-25-10, 5, 30, 30);
            self.operationLabel.text = @"0.5s";
        }
            break;
        case 1: {
            self.resultView.hidden = NO;
            self.resultView.frame = CGRectMake(MainW-25-10, 5, 30, 30);
            self.resultView.image = [UIImage imageNamed:@"icon_complete"];
            self.operationLabel.frame = CGRectMake(MainW-12-100-40, 0, 100, 40);
            self.operationLabel.text = @"执行成功";
        }
            break;
        case 2: {
            self.resultView.hidden = NO;
            self.resultView.frame = CGRectMake(MainW-25-10, 5, 30, 30);
            self.resultView.image = [UIImage imageNamed:@"icon_refuse"];
            self.operationLabel.frame = CGRectMake(MainW-12-100-40, 0, 100, 40);
            self.operationLabel.text = @"执行失败";
        }
            break;
        default:
            break;
    }
}

- (UILabel *)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.textColor = [UIColor blackColor];
        _infoLabel.font = [UIFont systemFontOfSize:15];
        
        _infoLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _infoLabel;
}

- (UILabel *)operationLabel
{
    if (!_operationLabel) {
        _operationLabel = [[UILabel alloc] init];
        _operationLabel.backgroundColor = [UIColor clearColor];
        _operationLabel.textColor = [UIColor grayColor];
        _operationLabel.font = [UIFont systemFontOfSize:15];
        
        _operationLabel.textAlignment = NSTextAlignmentRight;
    }
    return _operationLabel;
}

- (UIImageView *)resultView
{
    if (!_resultView) {
        _resultView = [[UIImageView alloc] init];
        _resultView.layer.cornerRadius = 30/2;
        _resultView.layer.masksToBounds = YES;
    }
    return _resultView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
