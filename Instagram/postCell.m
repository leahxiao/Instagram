//
//  postCell.m
//  Instagram
//
//  Created by Leah Xiao on 7/10/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "postCell.h"



@implementation postCell
// uploadView, uoloadCaption
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)feedLikeButtonTapped:(id)sender {
    NSLog(@"%@", sender);
    if([self.post[@"liked"] isEqual:@YES]){
        self.post[@"liked"] = @NO;
        int numLiked = [self.post.likeCount intValue];
        self.post.likeCount = [NSNumber numberWithInteger:(numLiked - 1) ];
        [self.post saveInBackgroundWithBlock:nil];
        UIImage *image = [UIImage imageNamed:@"favor-icon"];
        [self.feedLikeButton setImage:image forState:UIControlStateNormal];
        [self.feedLikeButton setTitle:[NSString stringWithFormat:@"%@", self.post.likeCount] forState:UIControlStateNormal];
    }
    
    else{
        self.post[@"liked"] = @YES;
        int numLiked = [self.post.likeCount intValue];
        self.post.likeCount = [NSNumber numberWithInteger:(numLiked + 1) ];
        [self.post saveInBackgroundWithBlock:nil];
            UIImage *image = [UIImage imageNamed:@"favor-icon-red"];
        [self.feedLikeButton setImage:image forState:UIControlStateNormal];
        [self.feedLikeButton setTitle:[NSString stringWithFormat:@"%@", self.post.likeCount] forState:UIControlStateNormal];
    };
}





@end
