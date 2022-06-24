//
//  ComposeViewController.m
//  twitter
//
//  Created by Zeke Reyes on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()
//- (IBAction)didTapTweet:(UIBarButtonItem *)sender;
- (IBAction)didTapTweet:(id)sender;
- (IBAction)didTapClose:(UIBarButtonItem *)sender;
@end


@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapClose:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

//- (IBAction)didTapTweet:(id)sender {
//    NSString *text = _tweetMessage.text;
//    [[APIManager shared]postStatusWithText:text completion:^(Tweet *tweet, NSError *error) {
//        if(error){
//            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
//        }
//        else{
//            [self.delegate didTweet:tweet];
//            NSLog(@"Compose Tweet Success!");
//        }
//    }];
//}

- (IBAction)didTapTweet:(UIBarButtonItem *)sender {
    NSString *text = _tweetMessage.text;
    [[APIManager shared]postStatusWithText:text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
    // Closes the compose view controller
//    [self dismissViewControllerAnimated:true completion:nil];
}

@end
