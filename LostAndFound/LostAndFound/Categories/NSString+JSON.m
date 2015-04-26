//
//  NSString+JSON.m
//  SlotMachine
//
//  Created by Subbhaash on 9/20/14.
//  Copyright (c) 2014 Apostek. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

-(id)jsonValue
{
    NSData* jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonError = nil;
    id jsonValue = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
    return jsonValue;
}

@end
