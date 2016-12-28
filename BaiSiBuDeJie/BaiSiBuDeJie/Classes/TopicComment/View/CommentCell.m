//
//  CommentCell.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/27.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "CommentCell.h"
#import "Comment.h"
#import "UIView+CornerRadius.h"
#import "UIImageView+WebCache.h"
#import "CommentCellContentView.h"

@interface CommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UIImageView *sexIcon;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *totalLikeCountLabel;
@property (weak, nonatomic) IBOutlet CommentCellContentView *commentContentView;

@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _avatarView.cornerRadius = _avatarView.width * 0.5;
    _vipIcon.hidden = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (IBAction)onLikeButtonClick:(UIButton *)sender {
    
}

- (void)setComment:(Comment *)comment {
    if (_comment != comment) {
        _comment = comment;
        
        // 头像
        [_avatarView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"Profile_noneAvatarBg_65x65_"]];
        
        // 性别
        if ([comment.user.sex isEqualToString:@"m"]) {
            _sexIcon.image = [UIImage imageNamed:@"nan_10x10_"];
        }else {
            _sexIcon.image = [UIImage imageNamed:@"nv_10x10_"];
        }
        
        // 昵称
        NSString *username = comment.user.username;
        if (!username) {
            username = comment.user.name;
        }
        _usernameLabel.text = username;
        if (comment.user.is_vip) {
            _vipIcon.hidden = NO;
            _usernameLabel.textColor = kTopicCellUserNameVipColor;
        }else {
            _vipIcon.hidden = YES;
            _usernameLabel.textColor = TextBlueColor;
        }
        
        // 点赞总数
        _totalLikeCountLabel.text = comment.user.total_cmt_like_count;
        _totalLikeCountLabel.backgroundColor = RGB(103, 139, 176);
        if ([comment.user.total_cmt_like_count integerValue] > 999) {
            _totalLikeCountLabel.text = [NSString stringWithFormat:@"%.1fk",[comment.user.total_cmt_like_count integerValue] / 1000.0];
            _totalLikeCountLabel.backgroundColor = RGB(191, 184, 255);
        }
        // 点赞数
        _likeCountLabel.text = [NSString stringWithFormat:@"%ld",comment.like_count];
        if (comment.like_count == 0) {
            _likeCountLabel.text = @"+1";
        }
        
        // 评论内容
        self.commentContentView.frame = comment.contentViewFrame;
        self.commentContentView.comment = comment;
    }
}



@end