//
//  TSTheme.m
//  Rainbow rectangles
//
//  Created by Mac on 28.03.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSTheme.h"

@implementation TSTheme

+ (TSTheme *) sharedManager {
    
    static TSTheme *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TSTheme alloc] init];
    });
    return manager;
}


@end
