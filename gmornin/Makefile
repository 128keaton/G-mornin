include theos/makefiles/common.mk

BUNDLE_NAME = gmornin
gmornin_FILES = gmornin.mm
gmornin_INSTALL_PATH = /Library/PreferenceBundles
gmornin_FRAMEWORKS = UIKit
gmornin_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/gmornin.plist$(ECHO_END)
