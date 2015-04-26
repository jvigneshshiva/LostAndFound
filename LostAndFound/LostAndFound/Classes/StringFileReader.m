//
//  StringFileReader.m
//  SlotsSpinTest
//
//  Created by Subbhaash on 9/12/14.
//  Copyright (c) 2014 Subbhaash. All rights reserved.
//

#import "StringFileReader.h"
#import "ApUtils.h"

@implementation StringFileReader

+(NSString *)stringFromFieWithName:(NSString *)fileName ofType:(NSString *)fileType
{
    NSString *fileNameKey = [NSString stringWithFormat:@"%@%@",fileName,fileType];
    NSString *contentsOfFile = nil;
    BOOL isConfigFile = [fileNameKey isEqualToString:@"Config.json"];
    if(isConfigFile)// As config file needs to be fetched from last saved state
    {
        NSString *appVersion = [ApUtils getAppVerAsString];
        NSString *keyToCheckWhetherLocalConfigFileWasFetchedInCurrentAppVersion = [NSString stringWithFormat:@"wasLocalConfigFileFetchedInAppVersion%@",appVersion];
        BOOL wasLocalConfigFileFetchedInCurrentAppVersion = [[NSUserDefaults standardUserDefaults]boolForKey:keyToCheckWhetherLocalConfigFileWasFetchedInCurrentAppVersion];
        if(wasLocalConfigFileFetchedInCurrentAppVersion)
        {
            contentsOfFile = [[NSUserDefaults standardUserDefaults]valueForKey:fileNameKey];
            if(contentsOfFile != nil)
            {
                return contentsOfFile;
            }
        }
        else
        {
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:keyToCheckWhetherLocalConfigFileWasFetchedInCurrentAppVersion];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
    }
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    contentsOfFile = [NSString stringWithContentsOfFile:path
                                               encoding:NSUTF8StringEncoding
                                                  error:NULL];
    if(isConfigFile)
    {
        [[NSUserDefaults standardUserDefaults]setObject:contentsOfFile forKey:fileNameKey];//File Name should be the key so that string file can be read from user defaults
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    return  contentsOfFile;
}

@end
