//
//  TopicVideoView.m
//  BaiSiBuDeJie
//
//  Created by zhong on 16/12/22.
//  Copyright © 2016年 Xz Studio. All rights reserved.
//

#import "TopicVideoView.h"
#import "TopicLayout.h"
#import "UIImageView+WebCache.h"
#import "BSVideoBrowse.h"

@interface TopicVideoView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *placeholder;
@property (nonatomic, strong) UIButton *playVideoButton;
@property (nonatomic, strong) UIImageView *videoBottomCover;
@property (nonatomic, strong) UILabel *videoPlayCountLabel; // 播放次数
@property (nonatomic, strong) UILabel *videoTimeLabel; // 视频时长
@end

@implementation TopicVideoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _placeholder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageBackground_75x15_"]];
        
        
        _imageView = [[UIImageView alloc] init];
//        _imageView.contentMode = UIViewContentModeScaleAspectFill;
//        _imageView.clipsToBounds = YES;
        
        _playVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playVideoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_playVideoButton setImage:[UIImage imageNamed:@"video-play_71x71_"] forState:UIControlStateNormal];
        [_playVideoButton addTarget:self action:@selector(playVideoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        _videoBottomCover = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_time_bar_shadow_50x40_"]];
        
        _videoPlayCountLabel = [[UILabel alloc] init];
        _videoPlayCountLabel.textColor = kTopicCellVideoTextColor;
        _videoPlayCountLabel.font = [UIFont systemFontOfSize:kTopicCellVideoTextFontSize];
        
        _videoTimeLabel = [[UILabel alloc] init];
        _videoTimeLabel.textColor = kTopicCellVideoTextColor;
        _videoTimeLabel.font = [UIFont systemFontOfSize:kTopicCellVideoTextFontSize];
        
        
        [self addSubview:_placeholder];
        [self addSubview:_imageView];
        [self addSubview:_playVideoButton];
        [self addSubview:_videoBottomCover];
        [self addSubview:_videoPlayCountLabel];
        [self addSubview:_videoTimeLabel];
    }
    return self;
}

- (void)setLayout:(TopicLayout *)layout {
    
    _layout = layout;
    
    _placeholder.frame = layout.videoPlaceholderFrame;
    _imageView.frame = layout.videoImageViewFrame;
    _playVideoButton.frame = layout.playVideoButtonFrame;
    _videoBottomCover.frame = layout.videoBottomCoverFrame;
    _videoPlayCountLabel.frame = layout.videoPlayCountLabelFrame;
    _videoTimeLabel.frame = layout.videoTimeLabelFrame;
    
    _videoPlayCountLabel.text = layout.videoPlayCountText;
    _videoTimeLabel.text = layout.videoTimeText;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:layout.topic.video.thumbnail[0]] placeholderImage:nil];
    
}

- (void)playVideoButtonClick {
    BSVideoBrowse *videoBrowse = [[BSVideoBrowse alloc] initWithTopicLayout:_layout];
    [videoBrowse showFromView:self];
}


@end
