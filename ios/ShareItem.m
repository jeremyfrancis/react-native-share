//
//  ShareItem.m
//  RNShare
//
//  Created by Jeremy Francis on 4/8/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareItem.h"

@implementation ShareItem

- (id)item {
    if([self.activityType isEqualToString:UIActivityTypeMail]) {
        NSMutableString *emailMod = [self.placeholderItem copy];
        NSArray *lines = [emailMod componentsSeparatedByString:@"\n"];
        NSString *previousLine = @"";
        for(NSString *line in lines) {
            if([line containsString:@"http"]) {
                NSString *lineMod = [[[[@"<a href=\"" stringByAppendingString:previousLine] stringByAppendingString:@"\">"] stringByAppendingString:line] stringByAppendingString:@"</a><br><br>"];
                [emailMod replaceOccurrencesOfString:previousLine withString:@"" options:0 range:NSMakeRange(0,[emailMod length])];
                [emailMod replaceOccurrencesOfString:line withString:lineMod options:0 range:NSMakeRange(0,[emailMod length])];
            }
            previousLine = line;
        }
        return [[[@"<html><p>*</p>" stringByAppendingString:emailMod] stringByAppendingString:@"</html>"] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    return [self.placeholderItem stringByAppendingString:@"THIS IS PROOF"];
}

@end
