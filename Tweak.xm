#import <AudioToolbox/AudioServices.h>
#import "MCGMorseCodeConverter.h"

#define log(z) NSLog(@"[MorseTexts] %@", z)
#define eq(x, y) [x isEqualToString:y]

void AudioServicesPlaySystemSoundWithVibration(SystemSoundID inSystemSoundID, id arg, NSDictionary* vibratePattern);
void AudioServicesStopSystemSound(SystemSoundID inSystemSoundID);

@interface BBBulletin : NSObject
@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* message;
@property (copy, nonatomic) NSString* sectionID;
@property (retain, nonatomic) NSDate* date;
@end

%hook SBLockScreenNotificationListController

-(void)_updateModelAndViewForAdditionOfItem:(id)arg1 {

	%orig;

	BBBulletin* bulletin = MSHookIvar<BBBulletin *>(arg1, "_activeBulletin");

    if([[bulletin sectionID] isEqualToString:@"com.apple.MobileSMS"]) {

    	NSArray* morseArr = [[MCGMorseCodeConverter new] convertStringToMorseCodes:[bulletin message]];

    	NSMutableDictionary* dict = [NSMutableDictionary new];
    	NSMutableArray* arr = [NSMutableArray new];

    	for(NSString* i in morseArr) {
    		[arr addObject:@(eq(i, kMorseCodeDitString) || eq(i, kMorseCodeDahString))];
    		if(eq(i, kMorseCodeDitString) || eq(i, kMorseCodeDahSpaceString)) {
    			[arr addObject:@(100)];
    		}else {
    			[arr addObject:@(300)];
    		}
    	}

    	[dict setObject:arr forKey:@"VibePattern"];
    	[dict setObject:[NSNumber numberWithInt:1] forKey:@"Intensity"];

    	//AudioServicesPlaySystemSoundWithVibration(kSystemSoundID_Vibrate, nil, dict);

    }

}

%end
