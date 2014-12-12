#import <Preferences/Preferences.h>

#define url(z) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:z]];
#define prefsAppID CFSTR("com.sassoty.morsetexts")

@interface MorseTextsListController: PSListController {
}
@end

@implementation MorseTextsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"MorseTexts" target:self] retain];
	}
	return _specifiers;
}
-(void)openTwitter {
	url(@"http://twitter.com/Sassoty");
}
-(void)openDonate {
	url(@"http://bit.ly/sassotypp");
}
-(void)openWebsite {
	url(@"http://sassoty.com");
}
-(void)resetToDefaults {
	CFPreferencesSetValue(CFSTR("Enabled"), NULL, prefsAppID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	CFPreferencesSetValue(CFSTR("ReplaceMessageWithMorse"), NULL, prefsAppID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	CFPreferencesSetValue(CFSTR("DotLength"), NULL, prefsAppID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	CFPreferencesSetValue(CFSTR("DashLength"), NULL, prefsAppID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	CFPreferencesSetValue(CFSTR("LetterPartsLength"), NULL, prefsAppID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	CFPreferencesSynchronize(prefsAppID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	[self reloadSpecifiers];
}
@end

// vim:ft=objc
