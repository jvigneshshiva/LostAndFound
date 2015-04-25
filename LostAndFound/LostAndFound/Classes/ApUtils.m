//
//  ApUtils.m
//  slotMachine
//
//  Created by Vikas on 03/02/12.
//  Copyright 2012 Apostek. All rights reserved.
//

#import "ApUtils.h"
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <CommonCrypto/CommonDigest.h>
#import "AdSupport/ASIdentifierManager.h"

#define SECONDS_IN_DAY 86400
#define IS_IPAD (([[UIScreen mainScreen] bounds].size.height-1024)?NO:YES)
#define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define BEACON_URL @"http://download-track.appengine.apostek.com/dtrack?appid=%@&version=%@&odin=%@&ate=%@&aid=%@"

@implementation ApUtils

static NSString  *pasteBoardName = @"com.apostek.common.unique";
static BOOL _isBannerAdPresent;


//Code to get iOS Advertising Tracking Enabled. Returns '1' if enabled, '0' otherwise
+(NSString *)getAdvertisingTrackingEnabled
{
    
    NSString *ate = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled] ? @"0" : @"1";
    return ate;
}

//Code to get iOS Advertising Identifier
+(NSString *)getAdvertisingIdentifier
{
    NSString *aid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return aid;
}

+(NSString *)getAppVerAsString
{
    [[NSBundle mainBundle] infoDictionary];
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    return ([infoDict objectForKey:@"CFBundleShortVersionString"]);
}
+(NSString *)getAppNameAsString
{
	return ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]);
}

+ (NSString*)getMACAddress
{
	int                 mib[6];
	size_t              len;
	char                *buf;
	unsigned char       *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl  *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0)
	{
		////// NSLog(@"Error: if_nametoindex error\n");
		return NULL;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
	{
		////// NSLog(@"Error: sysctl, take 1\n");
		return NULL;
	}
	
	if ((buf = malloc(len)) == NULL)
	{
		////// NSLog(@"Could not allocate memory. error!\n");
		return NULL;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0)
	{
		////// NSLog(@"Error: sysctl, take 2");
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	NSString *macAddress = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X",
                            *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	macAddress = [macAddress lowercaseString];
	free(buf);
	
	return macAddress;
}


//Code to get SHA1 of MAC Address
+ (NSString*)getOdin
{
	int                 mib[6];
	size_t              len;
	char                *buf;
	unsigned char       *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl  *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0)
	{
		////// NSLog(@"Error: if_nametoindex error\n");
        free(buf);
		return NULL;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
	{
		////// NSLog(@"Error: sysctl, take 1\n");
        free(buf);
		return NULL;
	}
	
	if ((buf = malloc(len)) == NULL)
	{
		////// NSLog(@"Could not allocate memory. error!\n");
        free(buf);
		return NULL;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0)
	{
		////// NSLog(@"Error: sysctl, take 2");
        free(buf);
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	
    //Take the SHA-1 of the MAC address
    
    CFDataRef data = CFDataCreate(NULL, (uint8_t*)ptr, 6);
    
    unsigned char messageDigest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(CFDataGetBytePtr((CFDataRef)data),
            (CC_LONG)CFDataGetLength((CFDataRef)data),
            messageDigest);
    
    CFMutableStringRef string = CFStringCreateMutable(NULL, 40);
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        CFStringAppendFormat(string,
                             NULL,
                             (CFStringRef)@"%02X",
                             messageDigest[i]);
    }
    
    CFStringLowercase(string, CFLocaleGetSystem());
    
    //// NSLog(@"ODIN-1: %@", string);
    
    free(buf);
    
    NSString *odinstring = [NSString stringWithString:(__bridge NSString *)(string)];
    CFRelease(data);
    CFRelease(string);
    
    return odinstring;
    
}

//Use mac address as Guid
+(NSString *)getGuid
{
	NSString *guid = nil;
	
	guid = [[NSUserDefaults standardUserDefaults] valueForKey:@"commonUniqueGuid"];
	
    if(!guid || [guid length] <= 0 || [guid isEqualToString:@"020000000000"])
    {
        UIPasteboard *pasteBoard = [UIPasteboard pasteboardWithName:pasteBoardName create:YES];
        pasteBoard.persistent = YES;
        
        if(![pasteBoard string])
        {
            
            CFUUIDRef udid = CFUUIDCreate(NULL);
            NSString* createdUUID = (NSString *) CFBridgingRelease(CFUUIDCreateString(NULL, udid));
            CFRelease(udid);
            
            [pasteBoard setString:createdUUID];
            [[NSUserDefaults standardUserDefaults] setValue:createdUUID forKey:@"commonUniqueGuid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        guid = [pasteBoard string];
        
    }
	return guid;
}

+(int)getDayNoFrom1970
{
	//This method will give the date as per the local time.
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
	[inputFormatter setDateFormat:@"dd-MM-yyyy"];
	NSString *refDate = @"01-01-1970";
	NSDate *date =	[inputFormatter dateFromString:refDate];
    
	NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSinceDate:date];
	double currentDay = currentTimeInterval/SECONDS_IN_DAY;
	inputFormatter = nil;
	return ceil(currentDay);
}

+(NSUInteger)getCurrentDay
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSUInteger day = [components day];
    return day;
}

+(NSUInteger)getCurrentWeekDay
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = [comps weekday]-1;
    //-2 to make sunday as the first day
    gregorian = nil;
    return weekday;
}

+(NSUInteger)getCurrentWeekNumber

{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    gregorian.firstWeekday = 2; // Sunday = 1, Saturday = 7
    NSDateComponents *components = [gregorian components:NSWeekOfYearCalendarUnit fromDate:today];
    NSUInteger weekOfYear = [components weekOfYear];
    return weekOfYear;
}

//Deepesh Samant 23/05/2013
//this method is use to check the date comes under the start and end date
+(BOOL)isDate:(NSDate *)date inRangeFirstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate {
    return [date compare:firstDate] == NSOrderedDescending && [date compare:lastDate]  == NSOrderedAscending;
}

+(NSDate *)getDateBystring:(NSString *)dateString
{
    NSArray *dateArray = [dateString componentsSeparatedByString:@"/"];
    
    NSDateComponents* dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear: [[dateArray objectAtIndex:2] intValue]];
    [dateComponents setMonth: [[dateArray objectAtIndex:1] intValue]];
    [dateComponents setDay: [[dateArray objectAtIndex:0] intValue]];
    [dateComponents setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* date = [calendar dateFromComponents: dateComponents];
    // NSLog(@"%@",date);
    return date;
}

//Saurabh Mudgal 9th May 2012,
// this function will return a string of Date and Time in GMT Format.
+(NSString *)currentDateTimeInGMT
{
	NSDateFormatter *formatter=nil;
	NSString        *dateString=nil;
	
	formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeZone:[NSTimeZone timeZoneWithName: @"EST5EDT"]];
	// hack create a new method for it
    //	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    //     [NSTimeZone timeZoneWithName: @"PST"];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	dateString = [formatter stringFromDate:[NSDate date]];
    
	formatter = nil;
	return dateString;
}

+(NSString*)MD5:(NSString *)str
{
	// Create pointer to the string as UTF8
	const char *ptr = [str UTF8String];
	
	// Create byte array of unsigned chars
	unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
	
	// Create 16 byte MD5 hash value, store in buffer
	CC_MD5(ptr, (int)strlen(ptr), md5Buffer);
	
	// Convert MD5 value in the buffer to NSString of hex values
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x",md5Buffer[i]];
	
	return output;
}

+(int)currentWeekNumber
{
	//week day should start from Monday, thats why we are using the calender instead of dateformatter "%w"
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	int currentWeek = (int)[gregorian ordinalityOfUnit:NSWeekCalendarUnit inUnit:NSYearCalendarUnit forDate:[NSDate date]];  //current week number
	gregorian = nil;
	return currentWeek;
}


+(void) setExclusiveTouchOnView:(UIView *) aView andSubviews:(BOOL) aBool{
    for(UIView* v in aView.subviews)
    {
        [ApUtils setExclusiveTouchOnView:v andSubviews:aBool];
    }
    [aView setExclusiveTouch:aBool];
}

+(NSString *)getURLfromAppId:(NSString *)appId
{
	NSString *pushNewAppURL = [NSString stringWithFormat:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@&mt=8",appId];
	return pushNewAppURL;
}

+(NSString*)getSystemVersion
{
	return [[UIDevice currentDevice] systemVersion];
}


+(NSString *)platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+(NSString *)platformString
{
    NSString *platform = [ApUtils platform];
	if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"VerizoniPhone4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPodTouch1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad2(WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad2(GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad2(CDMA)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

+(CGRect)generateFrameFromDictionary:(NSDictionary*)frameDictionary
{
    float originX = [[frameDictionary objectForKey:@"originX"] floatValue];
    float originY = [[frameDictionary objectForKey:@"originY"] floatValue];
    float width = [[frameDictionary objectForKey:@"width"] floatValue];
    float height = [[frameDictionary objectForKey:@"height"] floatValue];
    CGRect frame = CGRectMake(originX, originY, width, height);
    return frame;
}


+ (NSString *)currentDateTimeStringInTimeZone:(NSString *)timeZone andFormat:(NSString *)format
{
	NSDateFormatter *formatter=nil;
	NSString        *dateString=nil;
	formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:timeZone]];
	[formatter setDateFormat:format];
	dateString = [formatter stringFromDate:[NSDate date]];
	formatter = nil;
	return dateString;
}

+ (NSDate *)getDateFromString:(NSString *)dateString andDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:dateFormat];
    NSDate *date =    [inputFormatter dateFromString:dateString];
    inputFormatter = nil;
    return date;
}

+ (int)getNumberOfDaysBetweenFormerDate:(NSDate *)formerDate andLatterDate:(NSDate *)latterDate
{
    NSDateComponents *components;
    components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit
                                                 fromDate: formerDate toDate: latterDate options: 0];
    return (int)[components day];
}

+(NSString *)abbreviateNumberStringFromNormalNumberString:(NSString *)numberString withDecimal:(int)dec andMinimumNumberOfDigits:(int)minimumNumberOfDigits
{
    int maximumUnAbbreviatedBaseValue = pow(10,minimumNumberOfDigits-1);
    long long num = [numberString longLongValue];
    NSString *abbrevNum = @"";
    if(num > maximumUnAbbreviatedBaseValue-1)
    {
        double number = (float)num;
        NSArray *abbrev = @[NSLocalizedString(@"K",@"Abbreviation for Thousand"),
                            NSLocalizedString(@"MN",@"Abbreviation for Million"), NSLocalizedString(@"BN",@"Abbreviation for Billion")];
        for (int i = (int)abbrev.count - 1; i >= 0; i--)
        {
            // Convert array index to "1000", "1000000", etc
            int size = pow(10,(i+1)*3);
            if(size <= number)
            {
                // Here, we multiply by decPlaces, round, and then divide by decPlaces.
                // This gives us nice rounding to a particular decimal place.
                number /= size;
                if(number == roundf(number))
                {
                    dec = 0;
                }
                NSString *numberString = [NSString stringWithFormat:@"%.*lf",dec,number];
                abbrevNum = [NSString stringWithFormat:@"%@%@", numberString, [abbrev objectAtIndex:i]];
            }
        }
        if([abbrevNum isEqualToString:@""])
        {
            abbrevNum = numberString;
        }
    }
    else
    {
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
        [numFormatter setUsesGroupingSeparator:YES];
        [numFormatter setGroupingSeparator:@","];
        [numFormatter setGroupingSize:3];
        abbrevNum = [numFormatter stringFromNumber:[NSNumber numberWithLongLong:num]];
        numFormatter = nil;
    }
    return abbrevNum;
}

+(UIColor *)colorFromHexString:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3)
    {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6)
    {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+(UIColor*)generateColorsFromEntry:(NSDictionary*)colorsEntry
{
    UIColor * color;
    if (colorsEntry == nil)
    {
        color = [UIColor clearColor];
    }
    else
    {
        float red = [[colorsEntry objectForKey:@"red"] intValue];
        float green = [[colorsEntry objectForKey:@"green"] intValue];
        float blue = [[colorsEntry objectForKey:@"blue"] intValue];
        float alpha = [[colorsEntry objectForKey:@"alpha"] floatValue];
        color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
    }
    return color;
}

+(void)setIsBannerAdPresent:(BOOL)isBannerAdPresent
{
    _isBannerAdPresent = isBannerAdPresent;
}

+(float)getAdViewHeight
{
    return (IS_IPAD)?90:50;
}

+(CGRect)mainScreenFrame
{
    CGRect mainScreenFrame = [UIScreen mainScreen].bounds;
    return [self frameWithoutAd:mainScreenFrame];
}

+(CGRect)frameWithoutAd:(CGRect)frame
{
    if(_isBannerAdPresent)
    {
        frame = CGRectMake(0, 0, frame.size.width, frame.size.height - [self getAdViewHeight]);
    }
    return frame;
}

+(UIImage *)imageCapturedInView:(UIView *)view inFrame:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedImage;
}

+(unsigned long long)numberOfSecondsFrom1970TillDate:(NSDate *)date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *referenceDate = [dateFormatter dateFromString:@"01/01/1970"];

    unsigned long long numberOfSecondsFrom1970TillDate = [date timeIntervalSinceDate:referenceDate];
    return numberOfSecondsFrom1970TillDate;
}

+(NSDate*)lastDateOfMonthWithDate:(NSDate *)currentDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:currentDate]; // Get necessary date components
    
    // set last of month
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    NSDate *lastDateOfMonth = [calendar dateFromComponents:comps];
    return lastDateOfMonth;
}


@end
