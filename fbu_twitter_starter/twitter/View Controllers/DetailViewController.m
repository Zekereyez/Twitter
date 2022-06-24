//
//  DetailViewController.m
//  twitter
//
//  Created by Zeke Reyes on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.authorLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.dateLabel.text = self.tweet.createdAtString;
    // User profile picture and url data
    NSString *URLString = self.tweet.user.profilePicture;
    // Removes instance of '_normal' to make url return a hd quality profile picture
    URLString = [URLString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *url = [NSURL URLWithString:URLString];

    // Setting image of profile pic to nil to prevent flickering
    self.profilePic.image = nil;
    // Setting the image of the profile pic
    [self.profilePic setImageWithURL:url];
    
    // Making the rounded profile pic
    self.profilePic.layer.masksToBounds = false;
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2;
    self.profilePic.clipsToBounds = true;
    self.profilePic.layer.borderWidth = 0.05;
    
    // Tweet text info here
    self.tweetBody.text = self.tweet.text;
    
    // Retweet and Favorite Count
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoriteCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
}
- (IBAction)didTapRetweet:(id)sender {
    // If tweet is already retweeted, delete retweeted actions
    if (self.tweet.retweeted) {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            } else if (tweet) {
                NSLog(@"Successfully unretweeted the following Tweet: \n%@", tweet.text);
            }
        }];
    }
    // Tweet is not retweeted so add retweeted actions
    else {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            } else if (tweet) {
                NSLog(@"Successfully retweeted the following Tweet: \n%@", tweet.text);
            }
        }];
    }
    //Update cell UI
    [self refreshData];
}
- (IBAction)didTapFavorite:(id)sender {
    // Update the local tweet model depending on status
    // If already liked then delete liked actions
    if (self.tweet.favorited) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;

        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            } else if (tweet) {
                NSLog(@"Successfully unretweeted the following Tweet: \n%@", tweet.text);
            }
        }];

    }
    // Tweet is not already like so add like actions
    else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;

        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            } else if (tweet) {
                NSLog(@"Successfully retweeted the following Tweet: \n%@", tweet.text);
            }
        }];

    }
    // Update cell UI
    [self refreshData];
}

-(void)refreshData {
    // Update all the views and sets the labels to respective text
    // Retweet and like count updates
    // Note self.tweet can be replaced with _tweet
    // think of C++ class implementation
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoriteCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];

    // Favorite and Retweet Icons for image update
    UIImage *favoriteIcon;
    UIImage *retweetIcon;

    // Favorite Icon assignment
    if (self.tweet.favorited) {
        favoriteIcon = [UIImage imageNamed:@"favor-icon-red.png"];
    }
    else {
        favoriteIcon = [UIImage imageNamed:@"favor-icon.png"];
    }

    // Retweet Icon Assignment
    if (self.tweet.retweeted) {
        retweetIcon = [UIImage imageNamed:@"retweet-icon-green.png"];
    }
    else {
        retweetIcon = [UIImage imageNamed:@"retweet-icon.png"];
    }
    
    [self.favoriteButton setImage:favoriteIcon forState:UIControlStateNormal];
    [self.retweetButton setImage:retweetIcon forState:UIControlStateNormal];
}

@end
