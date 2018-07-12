//
//  profileViewController.m
//  Instagram
//
//  Created by Leah Xiao on 7/11/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "profileViewController.h"
#import <parse/Parse.h>

@interface profileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation profileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *currUser = [PFUser currentUser];
    self.userNameProfile.text = currUser.username;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)proPicProfileTapped:(id)sender {
//    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
//    imagePickerVC.delegate = self;
//    imagePickerVC.allowsEditing = YES;
//    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//
//    [self presentViewController:imagePickerVC animated:YES completion:nil];
//
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//    else {
//        NSLog(@"Camera 🚫 available so we will use photo library instead");
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    //  Do something with the images (based on your use case)
    self.proPicImageView.image = editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
