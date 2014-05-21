//
//  WPQUtilities.m
//  EditorTest
//
//  Created by Matt Bumgardner on 5/21/14.
//  Copyright (c) 2014 Automattic, Inc. All rights reserved.
//

#import "WPQUtilities.h"

@implementation WPQUtilities

+ (void)clenseHTML:(NSString **)htmlParam_p
{
    *htmlParam_p = [*htmlParam_p stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    *htmlParam_p = [*htmlParam_p stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    *htmlParam_p = [*htmlParam_p stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    *htmlParam_p = [*htmlParam_p stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
}


@end
