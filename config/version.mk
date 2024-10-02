PRODUCT_VERSION_MAJOR = 4
PRODUCT_VERSION_MINOR = 0
GENESIS_VERSION_TAG := Verve

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

GENESIS_BUILDTYPE := UNOFFICIAL

ifeq ($(GENESIS_OFFICIAL), true)
     GENESIS_BUILDTYPE := OFFICIAL
endif

GENESIS_VERSION := GenesisOS-$(GENESIS_VERSION_TAG)-v$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(CURRENT_DEVICE)-$(GENESIS_BUILDTYPE)-$(shell date -u +%Y%m%d-%H%M)

GENESIS_DISPLAY_VERSION := $(GENESIS_VERSION_TAG)-v$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)

# LineageOS version properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.genesis.version=$(GENESIS_VERSION) \
    ro.genesis.display.version=$(GENESIS_DISPLAY_VERSION) \
    ro.genesis.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.genesis.releasetype=$(GENESIS_BUILDTYPE) \
    ro.modversion=$(GENESIS_VERSION)

# Signing
ifeq (user,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard .android-certs/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := .android-certs/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard .android-certs/verity.pk8))
PRODUCT_VERITY_SIGNING_KEY := .android-certs/verity
endif
ifneq (,$(wildcard .android-certs/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := .android-certs/otakey.x509.pem
endif
endif
