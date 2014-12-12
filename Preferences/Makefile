ARCHS = arm64 armv7

include theos/makefiles/common.mk

BUNDLE_NAME = MorseTexts
MorseTexts_FILES = MorseTexts.mm
MorseTexts_INSTALL_PATH = /Library/PreferenceBundles
MorseTexts_FRAMEWORKS = UIKit
MorseTexts_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/MorseTexts.plist$(ECHO_END)
