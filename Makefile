ARCHS = armv7 arm64
TARGET = iphone:clang:latest:latest
THEOS_BUILD_DIR = releases
include theos/makefiles/common.mk

TWEAK_NAME = Gmornin
Gmornin_FILES = Tweak.xm
Gmornin_FRAMEWORKS = UIKit
Gmorning_FRAMEWORKS += CoreGraphics
Gmorning_FRAMEWORKS += QuartzCore
Gmorning_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
