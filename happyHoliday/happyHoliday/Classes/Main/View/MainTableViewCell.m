//
//  MainTableViewCell.m
//  happyHoliday
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "MainTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MainTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *activityImage;
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UILabel *activityPrice;
@property (weak, nonatomic) IBOutlet UIButton *activityInstanceBtn;

@end

@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


//setter
- (void)setModel:(MainModel *)model{
    
    [self.activityImage sd_setImageWithURL:[NSURL URLWithString:model.image_big] placeholderImage:nil];
    
    
    self.activityName.text=model.title;
    self.activityPrice.text=model.price;
    
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
