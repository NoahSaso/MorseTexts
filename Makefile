ARCHS = arm64 armv7

include theos/makefiles/common.mk

TWEAK_NAME = MorseTexts
MorseTexts_FILES = Tweak.xm MCGMorseCodeConverter.m
MorseTexts_FRAMEWORKS = AudioToolbox
MorseTexts_PRIVATE_FRAMEWORKS = AudioToolbox

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
