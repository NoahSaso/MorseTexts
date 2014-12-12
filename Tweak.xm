#import <AudioToolbox/AudioServices.h>
#import "MCGMorseCodeConverter.h"

// Macros for me to use later on to make the code cleaner and easier to read
#define log(z) NSLog(@"[MorseTexts] %@", z)
#define eq(x, y) [x isEqualToString:y]

// App ID for preferences
#define appID CFSTR("com.sassoty.morsetexts")

// Vibrate method C definitions
extern "C" void AudioServicesPlaySystemSoundWithVibration(SystemSoundID inSystemSoundID, id arg, NSDictionary* vibratePattern);
extern "C" void AudioServicesStopSystemSound(SystemSoundID inSystemSoundID);

// BBBulletin class interface so the compiler knows what this is
@interface BBBulletin : NSObject
@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* message;
@property (copy, nonatomic) NSString* sectionID;
@property (retain, nonatomic) NSDate* date;
@end

static BOOL isEnabled = YES, replaceMessageWithMorse = NO;
static CGFloat dotLength = 150, dashLength = 700, letterPartsLength = 50;

static void reloadPrefs() {

    // Get preferences from file
    NSDictionary* prefs = nil;
    CFArrayRef keyList = CFPreferencesCopyKeyList(appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    if(keyList) {
        prefs = (NSDictionary *)CFPreferencesCopyMultiple(keyList, appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
        if(!prefs) {
            prefs = [NSDictionary new];
        }
        CFRelease(keyList);
    }

    // Get values I need
    isEnabled = !prefs[@"Enabled"] ? YES : [prefs[@"Enabled"] boolValue];
    replaceMessageWithMorse = !prefs[@"ReplaceMessageWithMorse"] ? NO : [prefs[@"ReplaceMessageWithMorse"] boolValue];
    dotLength = !prefs[@"DotLength"] ? 150 : [prefs[@"DotLength"] floatValue];
    dashLength = !prefs[@"DashLength"] ? 700 : [prefs[@"DashLength"] floatValue];
    letterPartsLength = !prefs[@"LetterPartsLength"] ? 50 : [prefs[@"LetterPartsLength"] floatValue];

}

%hook SBBulletinBannerController

// Fires everytime notification is added
-(void)observer:(id)observer addBulletin:(id)bulletin forFeed:(unsigned long long)feed {

    if(!isEnabled) {
        %orig;
        return;
    }

    // Only attempt this when SMS convo. I'll add more apps later (such as Kik, WhatsApp, Viber, LINE, etc. It's just a matter of sticking the app ID here, I'll probably make it customizable in Settings, but that's for later)
    //Enjoy the bundle ID of these apps. Didn't add them because I'd make a horrible mistake ;P
    //net.whatsapp.WhatsApp : com.kik.chat : com.viber (apparently) : jp.naver.line
    if([[bulletin sectionID] isEqualToString:@"com.apple.MobileSMS"]) {

    	NSArray* morseArr = [[MCGMorseCodeConverter new] convertStringToMorseCodes:[bulletin message]]; // Array of dots, dashes, and spaces to represent each letter and word

        NSString* morseCodeMessage = @"";
        for(NSString* i in morseArr)
            morseCodeMessage = [morseCodeMessage stringByAppendingString:i];
        log(morseCodeMessage);

        if(replaceMessageWithMorse)
            [bulletin setMessage:morseCodeMessage];

    	NSMutableDictionary* dict = [NSMutableDictionary new];
    	NSMutableArray* arr = [NSMutableArray new];

    	for(NSString* i in morseArr) {
    		[arr addObject:@(eq(i, kMorseCodeDitString) || eq(i, kMorseCodeDahString))]; // add YES if it's something that should vibrate, NO if it shouldn't (like on spaces)
    		if(eq(i, kMorseCodeDitString) || eq(i, kMorseCodeDahSpaceString)) {
    			[arr addObject:@(dotLength)];
    		}else { // kMorseCodeDahString and kMorseCodeDahThreeSpacesString last longer
    			[arr addObject:@(dashLength)];
    		}
            [arr addObject:@(NO)]; // Timing in between parts of letter
            [arr addObject:@(letterPartsLength)];
    	}

    	[dict setObject:arr forKey:@"VibePattern"];
    	[dict setObject:[NSNumber numberWithInt:1] forKey:@"Intensity"];

    	AudioServicesPlaySystemSoundWithVibration(kSystemSoundID_Vibrate, nil, dict);

    }

    %orig;

}

%end

%ctor {
    reloadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL,
        (CFNotificationCallback)reloadPrefs,
        CFSTR("com.sassoty.morsetexts/preferencechanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}
