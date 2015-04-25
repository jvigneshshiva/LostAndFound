//
//  ApUtils.h
//  slotMachine
//
//  Created by Vikas on 03/02/12.
//  Copyright 2012 Apostek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 

#define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface ApUtils : NSObject 
{
	
}

/**
 *	Returns the unique device identifier(Mac address).
 *  @note:
 *		Here we are generating the UUID once and storing in the persistance as well as pasteboard
 *		First we try to fetch from the persistance, if it is not available(Uninstall/Reinstall case) fetch from pasteboard
 *		This has been done to make sure that the same UUID is used after uninstall/reinstall, otherwise leaderboard(Slot Machine)
 *		Will not work as expected
 */
+(NSString *)getGuid;

//Code to return iOS Advertising Identifier
+(NSString *)getAdvertisingIdentifier;


//Code to get Advertising Tracking Enabled. Returns '1' if enabled, '0' otherwise
+(NSString *)getAdvertisingTrackingEnabled;

//get version number from info.plist
+(NSString *)getAppVerAsString;

//Returns the mac address of device
+ (NSString*)getMACAddress;

//Returns SHA-1 of the MAC address of device
+ (NSString*)getOdin;

//return the day no from 1 Jan 1970 in local time
+(int)getDayNoFrom1970;

// return the current date and time in GMT Format
+(NSString *)currentDateTimeInGMT;

// convert the string in MD5 format
+(NSString*)MD5:(NSString *)str;

//Current week number, week starts from monday
+(int)currentWeekNumber;

// return name of the app mentioned in info.plist
+(NSString *)getAppNameAsString;

//Disable multiple touches within a view by setting exclusive touch property true
+(void) setExclusiveTouchOnView:(UIView *) aView andSubviews:(BOOL) aBool;

// Return URL from the given APPID
+(NSString *)getURLfromAppId:(NSString *)appId;

//Return iOS version
+(NSString*)getSystemVersion;

//Return device name with model ex: iPhone1, 1
+(NSString *)platform;

//Return string representation of device, like iPhone 1G, iPad 2(Wifi), iPad2(GSM)
+(NSString *)platformString;

//return NSDate from NSString
+(NSDate *)getDateBystring:(NSString *)dateString;

//check Date range
+(BOOL)isDate:(NSDate *)date inRangeFirstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate;

//returns the difference in days between two dates
+(int)getNumberOfDaysBetweenFormerDate:(NSDate *)formerDate andLatterDate:(NSDate *)latterDate;

//returns a date object from the string in the format specified
+ (NSDate *)getDateFromString:(NSString *)dateString andDateFormat:(NSString *)dateFormat;

//returns the current date and time in GMT timezone in the format specified
+ (NSString *)currentDateTimeStringInTimeZone:(NSString *)timeZone andFormat:(NSString *)format;

//returns the frame from dictionary containing the 'originX','originY','width','height' as keys
+(CGRect)generateFrameFromDictionary:(NSDictionary*)frameDictionary;

+(NSString *)abbreviateNumberStringFromNormalNumberString:(NSString *)numberString withDecimal:(int)dec andMinimumNumberOfDigits:(int)minimumNumberOfDigits;

+(UIColor *)colorFromHexString:(NSString *)hexString;

+(UIColor*)generateColorsFromEntry:(NSDictionary*)colorsEntry;

+(void)setIsBannerAdPresent:(BOOL)isBannerAdPresent;

+(CGRect)mainScreenFrame;

+(CGRect)frameWithoutAd:(CGRect)frame;

+(NSUInteger)getCurrentDay;

+(NSUInteger)getCurrentWeekDay;

+(NSUInteger)getCurrentWeekNumber;

+(unsigned long long)numberOfSecondsFrom1970TillDate:(NSDate *)date;

+(NSDate*)lastDateOfMonthWithDate:(NSDate *)currentDate;


@end
