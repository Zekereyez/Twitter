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

- (IBAction)didTapClose:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

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
}

@end
