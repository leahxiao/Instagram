//
//  profileViewController.h
//  Instagram
//
//  Created by Leah Xiao on 7/11/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface profileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *proPicImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameProfile;


@end
