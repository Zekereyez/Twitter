//
//  TweetCell.m
//  twitter
//
//  Created by Zeke Reyes on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (IBAction)didTapShare:(UIButton *)sender {
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

- (IBAction)didTapRetweet:(UIButton *)sender {
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

- (IBAction)didTapComments:(UIButton *)sender {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshData {
    // Update all the views and sets the labels to respective text
    // Name, screen name, and date update
    self.tweetAuthor.text = self.tweet.user.name;
    self.tweetUser.text = self.tweet.user.screenName;
    self.tweetDate.text = self.tweet.createdAtString;
    
    // Tweet body update
    self.textLabel.text = self.tweet.text;
    
    // Retweet and like count updates
    // Note self.tweet can be replaced with _tweet
    // think of C++ class implementation
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likeCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    
    // User profile picture update and url data
    NSString *URLString = self.tweet.user.profilePicture;
    // Removes instance of '_normal' to make url return a hd quality profile picture
    URLString = [URLString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *url = [NSURL URLWithString:URLString];
    // Setting image of profile pic to nil to prevent flickering
    self.profilePic.image = nil;
    // Setting the image of the profile pic
    [self.profilePic setImageWithURL:url];
    
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
