#import <AudioToolbox/AudioServices.h>
#import "MCGMorseCodeConverter.h"

// Macros for me to use later on to make the code cleaner and easier to read
#define log(z) NSLog(@"[MorseTexts] %@", z)
#define eq(x, y) [x isEqualToString:y]

// Vibrate method C definitions
void AudioServicesPlaySystemSoundWithVibration(SystemSoundID inSystemSoundID, id arg, NSDictionary* vibratePattern);
void AudioServicesStopSystemSound(SystemSoundID inSystemSoundID);

// BBBulletin class interface so the compiler knows what this is
@interface BBBulletin : NSObject
@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* message;
@property (copy, nonatomic) NSString* sectionID;
@property (retain, nonatomic) NSDate* date;
@end

%hook SBLockScreenNotificationListController

// Fires everytime notification is added
-(void)_updateModelAndViewForAdditionOfItem:(id)arg1 {

	%orig;

	BBBulletin* bulletin = MSHookIvar<BBBulletin *>(arg1, "_activeBulletin");

    // Only attempt this when SMS convo. I'll add more apps later (such as Kik, WhatsApp, Viber, LINE, etc. It's just a matter of sticking the app ID here, I'll probably make it customizable in Settings, but that's for later)
    //Enjoy the bundle ID of these apps. Didn't add them because I'd make a horrible mistake ;P
    //net.whatsapp.WhatsApp : com.kik.chat : com.viber (apparently) : jp.naver.line
    if([[bulletin sectionID] isEqualToString:@"com.apple.MobileSMS"]) {

    	NSArray* morseArr = [[MCGMorseCodeConverter new] convertStringToMorseCodes:[bulletin message]]; // Array of dots, dashes, and spaces to represent each letter and word

    	NSMutableDictionary* dict = [NSMutableDictionary new];
    	NSMutableArray* arr = [NSMutableArray new];

    	for(NSString* i in morseArr) {
    		[arr addObject:@(eq(i, kMorseCodeDitString) || eq(i, kMorseCodeDahString))]; // add YES if it's something that should vibrate, NO if it shouldn't (like on spaces)
    		if(eq(i, kMorseCodeDitString) || eq(i, kMorseCodeDahSpaceString)) {
    			[arr addObject:@(100)];
    		}else { // kMorseCodeDahString and kMorseCodeDahThreeSpacesString last longer
    			[arr addObject:@(300)];
    		}
    	}

    	[dict setObject:arr forKey:@"VibePattern"];
    	[dict setObject:[NSNumber numberWithInt:1] forKey:@"Intensity"];

        // Won't link even though the framework is in the makefile for public and private frameworks :/ wat?
    	//AudioServicesPlaySystemSoundWithVibration(kSystemSoundID_Vibrate, nil, dict);

    }

}

%end
