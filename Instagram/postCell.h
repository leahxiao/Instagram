//
//  postCell.h
//  Instagram
//
//  Created by Leah Xiao on 7/10/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <parseUI.h>
#import "Post.h"
#import "FeedViewController.h"


@interface postCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *uploadView;
@property (weak, nonatomic) IBOutlet UILabel *uploadCaption;
@property (weak, nonatomic) IBOutlet UIButton *feedLikeButton;
@property (weak, nonatomic) IBOutlet PFImageView *proPicFeedView;
@property (weak, nonatomic) IBOutlet UILabel *postUserFeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDateFeedLabel;


@property (strong, nonatomic) Post *post;

@end
