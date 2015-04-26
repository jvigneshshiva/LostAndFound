//
//  JsonReader.m
//  SlotsSpinTest
//
//  Created by Subbhaash on 9/12/14.
//  Copyright (c) 2014 Subbhaash. All rights reserved.
//

#import "JsonReader.h"
#import "StringFileReader.h"
#import "NSString+JSON.h"

@implementation JsonReader

+(id)jsonObjectFromFileWithName:(NSString *)fileName;
{
    NSString *contentsOfFile = [StringFileReader stringFromFieWithName:fileName ofType:@".json"];
    return [contentsOfFile jsonValue];
}

@end
