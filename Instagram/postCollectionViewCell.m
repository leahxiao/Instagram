//
//  postCollectionViewCell.m
//  Instagram
//
//  Created by Leah Xiao on 7/11/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "postCollectionViewCell.h"

@implementation postCollectionViewCell
//postView
- (void) setPicture {
    self.postView.file = self.post.image;
    [self.postView loadInBackground];
}

@end
