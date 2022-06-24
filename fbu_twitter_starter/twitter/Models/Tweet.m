//
//  Tweet.m
//  twitter
//
//  Created by Zeke Reyes on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if (originalTweet != nil) {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            dictionary = originalTweet;
        }

        // Initialize user
        NSDictionary *user = dictionary[@"user"];
        // Create user object for unique user - alloc creates said object
        self.user = [[User alloc] initWithDictionary:user];
        
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        

        // Format and set createdAtString
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        self.createdAtString = [formatter stringFromDate:date];
        
        // Implement the formatting dates here
        NSDate *curDate = [NSDate date];
        NSTimeInterval diff = [curDate timeIntervalSinceDate:date];
                
        // String format and math for time ago functionality
        NSInteger interval = diff;
        long seconds = interval % 60;
        long minutes = (interval / 60) % 60;
        long hours = (interval / 3600);
        if(hours > 1) {
            self.createdAtString = [NSString stringWithFormat:@"%ldh", hours];
        } else if(minutes > 1) {
            self.createdAtString = [NSString stringWithFormat:@"%ldm", minutes];
        } else {
            self.createdAtString = [NSString stringWithFormat:@"%lds", seconds];
        }
    }
    return self;
}

// Factory method that will return Tweets when they are initialized with an array of Tweet dictionaries
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

@end
