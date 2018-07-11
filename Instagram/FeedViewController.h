//
//  FeedViewController.h
//  Instagram
//
//  Created by Leah Xiao on 7/9/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
