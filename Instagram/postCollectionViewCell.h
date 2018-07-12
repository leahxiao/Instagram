//
//  postCollectionViewCell.h
//  Instagram
//
//  Created by Leah Xiao on 7/11/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface postCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postView;
@property (nonatomic) Post *post;

//postView
- (void) setPicture;

@end
