//
//  postCell.h
//  Instagram
//
//  Created by Leah Xiao on 7/10/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <parseUI.h>

@interface postCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *uploadView;
@property (weak, nonatomic) IBOutlet UILabel *uploadCaption;

@end
