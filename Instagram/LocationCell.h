//
//  LocationCell.h
//  Instagram
//
//  Created by Leah Xiao on 7/13/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


//@property (strong, nonatomic) NSDictionary *location;


- (void)updateWithLocation:(NSDictionary *)location;


@end
