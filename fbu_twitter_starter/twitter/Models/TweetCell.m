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

- (IBAction)didTapLike:(UIButton *)sender {
}
- (IBAction)didTapFavorite:(id)sender {
    // Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    // TODO: Update cell UI
    // TODO: Send a POST request to the POST favorites/create endpoint
}

- (IBAction)didTapRetweet:(UIButton *)sender {
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
    
}

@end
