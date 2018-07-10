//
//  PostingViewController.m
//  Instagram
//
//  Created by Leah Xiao on 7/9/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "PostingViewController.h"
#import "Post.h"

@interface PostingViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end
//imageView and captionText

@implementation PostingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cameraRequestTapped:(id)sender {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (IBAction)shareButtonTapped:(id)sender {
    [Post postUserImage:self.pictureView.image withCaption:self.captionText.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        [self dismissViewControllerAnimated:(YES) completion:nil];
    }];
    /*
     (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
     
     Post *newPost = [Post new];
     newPost.image = [self getPFFileFromImage:image];
     newPost.author = [PFUser currentUser];
     newPost.caption = caption;
     newPost.likeCount = @(0);
     newPost.commentCount = @(0);
     
     [newPost saveInBackgroundWithBlock: completion];
     }
     */
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

   //  Do something with the images (based on your use case)
    self.pictureView.image = editedImage;

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
