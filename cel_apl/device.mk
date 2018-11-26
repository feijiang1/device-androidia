# ----------------- BEGIN MIX-IN DEFINITIONS -----------------
# Mix-In definitions are auto-generated by mixin-update
##############################################################
# Source: device/intel/project-celadon/mixins/groups/device-specific/cel_apl/product.mk
##############################################################
TARGET_BOARD_PLATFORM := project-celadon

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.rc:root/init.$(TARGET_DEVICE).rc \
    $(LOCAL_PATH)/init.recovery.rc:root/init.recovery.$(TARGET_DEVICE).rc \
    $(LOCAL_PATH)/ueventd.rc:root/ueventd.$(TARGET_DEVICE).rc \
    $(LOCAL_PATH)/fstab:root/fstab

PRODUCT_PACKAGES += android.hardware.keymaster@3.0-impl \
                    android.hardware.keymaster@3.0-service \
                    android.hardware.wifi@1.0-service \
                    android.hardware.audio@2.0-impl \
	            android.hardware.audio@2.0-service \
                    android.hardware.soundtrigger@2.0-impl \
                    android.hardware.audio.effect@2.0-impl \
                    android.hardware.broadcastradio@1.0-impl \
                    android.hardware.graphics.mapper@2.0-impl \
                    android.hardware.graphics.allocator@2.0-impl \
                    android.hardware.graphics.allocator@2.0-service

PRODUCT_PACKAGES += \
	   android.hardware.graphics.composer@2.1-impl \
	   android.hardware.graphics.composer@2.1-service \
	   android.hardware.usb@1.0-impl \
	   android.hardware.usb@1.0-service \
	   android.hardware.dumpstate@1.0-impl \
	   android.hardware.dumpstate@1.0-service

PRODUCT_COPY_FILES += $(LOCAL_PATH)/manifest.xml:vendor/manifest.xml

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += service.adb.root=1
##############################################################
# Source: device/intel/project-celadon/mixins/groups/disk-bus/auto/product.mk
##############################################################
# create primary storage symlink dynamically
PRODUCT_PACKAGES += set_storage
##############################################################
# Source: device/intel/project-celadon/mixins/groups/boot-arch/efi/product.mk
##############################################################
TARGET_UEFI_ARCH := x86_64
BIOS_VARIANT := release

$(call inherit-product,build/target/product/verity.mk)

PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/by-name/system

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/fstab:root/fstab.$(TARGET_PRODUCT) \
	frameworks/native/data/etc/android.software.verified_boot.xml:vendor/etc/permissions/android.software.verified_boot.xml

# Allow Kernelflinger to ignore the non-standard RSCI ACPI table
# to get reset and wake source from PMIC for bringup phase if
# the table reports incorrect data
KERNELFLINGER_IGNORE_RSCI := true
# OEM Unlock reporting
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	ro.oem_unlock_supported=1
# Android Kernelflinger uses the OpenSSL library to support the
# bootloader policy
KERNELFLINGER_SSL_LIBRARY := openssl


PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.frp.pst=/dev/block/by-name/persistent
##############################################################
# Source: device/intel/project-celadon/mixins/groups/wlan/iwlwifi/product.mk
##############################################################
PRODUCT_PACKAGES += \
    wificond \
    wifilogd \
    wpa_supplicant \
    wpa_cli \
    iw

PRODUCT_PACKAGES += \
  android.hardware.wifi@1.0-service

# FW and PNVM
PRODUCT_PACKAGES += \
    iwl-fw-celadon \
    iwl-nvm

# iwlwifi USC
PRODUCT_PACKAGES += \
    wifi_intel_usc

#copy iwlwifi wpa config files
PRODUCT_COPY_FILES += \
        $(INTEL_PATH_COMMON)/wlan/wpa_supplicant-common.conf:vendor/etc/wifi/wpa_supplicant.conf \
        $(INTEL_PATH_COMMON)/wlan/iwlwifi/wpa_supplicant_overlay.conf:vendor/etc/wifi/wpa_supplicant_overlay.conf \
        frameworks/native/data/etc/android.hardware.wifi.xml:vendor/etc/permissions/android.hardware.wifi.xml \
        frameworks/native/data/etc/android.hardware.wifi.direct.xml:vendor/etc/permissions/android.hardware.wifi.direct.xml


PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.wifi.softap_dualband_allow=false
##############################################################
# Source: device/intel/project-celadon/mixins/groups/kernel/gmin64/product.mk.1
##############################################################
TARGET_KERNEL_ARCH := x86_64

##############################################################
# Source: device/intel/project-celadon/mixins/groups/kernel/gmin64/product.mk
##############################################################
# FIXME: Modules are copied twice in the system
# - as a flat directory where all modules are. This is the method that android's insmod is expecting modules to be
# - as a tree of modules as output by the kernel build system. This is the way hald's libkmod is expecting modules to be
# on binary kernel directories/artifactory tarballs, flat directory is stored in $(ARCH)/modules, while tree directory is stored in $(ARCH)/lib/modules
# both directories contain same data



KERNEL_MODULES_ROOT_PATH ?= vendor/lib/modules
KERNEL_MODULES_ROOT ?= $(KERNEL_MODULES_ROOT_PATH)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.vendor.boot.moduleslocation=/$(KERNEL_MODULES_ROOT_PATH)

##############################################################
# Source: device/intel/project-celadon/mixins/groups/sepolicy/permissive/product.mk
##############################################################
PRODUCT_PACKAGES += sepolicy-areq-checker
##############################################################
# Source: device/intel/project-celadon/mixins/groups/graphics/mesa/product.mk
##############################################################
# Mesa
PRODUCT_PACKAGES += \
    libGLES_mesa \
    libGLES_android

PRODUCT_PACKAGES += \
    libdrm \
    libdrm_intel \
    libsync \
    libmd

PRODUCT_PACKAGES += ufo_prebuilts

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/extra_files/graphics/drirc:system/etc/drirc


# HWComposer IA
PRODUCT_PACKAGES += \
    hwcomposer.$(TARGET_BOARD_PLATFORM)

PRODUCT_PROPERTY_OVERRIDES += \
   ro.hardware.hwcomposer=$(TARGET_BOARD_PLATFORM)

INTEL_HWC_CONFIG := $(INTEL_PATH_VENDOR)/external/hwcomposer-intel

ifeq ($(findstring _acrn,$(TARGET_PRODUCT)),_acrn)
PRODUCT_COPY_FILES += $(INTEL_HWC_CONFIG)/hwc_display_virt.ini:$(TARGET_COPY_OUT_VENDOR)/etc/hwc_display.ini
else
PRODUCT_COPY_FILES += $(INTEL_HWC_CONFIG)/hwc_display.ini:$(TARGET_COPY_OUT_VENDOR)/etc/hwc_display.ini
endif


# Mini gbm
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=$(TARGET_BOARD_PLATFORM)

PRODUCT_PACKAGES += \
    gralloc.$(TARGET_BOARD_PLATFORM)



# Mesa
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:vendor/etc/permissions/android.hardware.opengles.aep.xml

# GLES version
PRODUCT_PROPERTY_OVERRIDES += \
   ro.opengles.version=196610



##############################################################
# Source: device/intel/project-celadon/mixins/groups/widevine/L3_Gen/product.mk
##############################################################
#enable Widevine drm
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true


# There is an additional dependency on hdcpd that should be controlled
# through the content-protection mixin

PRODUCT_PACKAGES += com.google.widevine.software.drm.xml \
    com.google.widevine.software.drm \
    libdrmwvmplugin \
    libwvm \
    libdrmdecrypt \
    libwvdrmengine \
    libWVStreamControlAPI_L3 \
    libwvdrm_L3

PRODUCT_PACKAGES += android.hardware.drm@1.1-service.widevine \
                    android.hardware.drm@1.0-service \
                    android.hardware.drm@1.0-impl \
                    libwvhidl \
                    android.hardware.drm@1.1-service.clearkey

PRODUCT_PACKAGES_ENG += ExoPlayerDemo

BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 3
##############################################################
# Source: device/intel/project-celadon/mixins/groups/touch/galax7200/product.mk
##############################################################
PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:vendor/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml\
        $(INTEL_PATH_COMMON)/touch/Vendor_0eef_Product_7200.idc:system/usr/idc/Vendor_0eef_Product_7200.idc
##############################################################
# Source: device/intel/project-celadon/mixins/groups/display-density/medium/product.mk
##############################################################
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := mdpi

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.sf.lcd_density=160
##############################################################
# Source: device/intel/project-celadon/mixins/groups/media/mesa/product.mk
##############################################################
# libstagefrighthw
PRODUCT_PACKAGES += \
    libstagefrighthw

# Media SDK and OMX IL components
PRODUCT_PACKAGES += \
    libmfxhw32 \
    libmfx_omx_core \
    libmfx_omx_components_hw

# Open source media_driver
PRODUCT_PACKAGES += i965_drv_video
PRODUCT_PACKAGES += libigfxcmrt

# Open source hdcp
PRODUCT_PACKAGES += libhdcpsdk
PRODUCT_PACKAGES += lihdcpcommon

ifeq ($(BOARD_USE_64BIT_USERSPACE),true)
PRODUCT_PACKAGES += \
    libmfxhw64
endif



PRODUCT_PACKAGES += \
    libpciaccess
##############################################################
# Source: device/intel/project-celadon/mixins/groups/public-libraries/true/product.mk
##############################################################
PRODUCT_COPY_FILES += $(LOCAL_PATH)/extra_files/public-libraries/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt
##############################################################
# Source: device/intel/project-celadon/mixins/groups/hdcpd/true/product.mk
##############################################################
# Enable media content protection services

# HDCP Daemon
PRODUCT_PACKAGES += hdcpd
##############################################################
# Source: device/intel/project-celadon/mixins/groups/codecs/configurable/product.mk
##############################################################
# Audio/video codec support.
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:vendor/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:vendor/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/extra_files/codecs/media_profiles.xml:vendor/etc/media_profiles.xml \
    $(LOCAL_PATH)/extra_files/codecs/media_codecs.xml:vendor/etc/media_codecs.xml \
    $(LOCAL_PATH)/extra_files/codecs/mfx_omxil_core.conf:vendor/etc/mfx_omxil_core.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/extra_files/codecs/media_codecs_performance_icl.xml:vendor/etc/media_codecs_performance.xml

PRODUCT_PACKAGES += \
    libasfextractor
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-logs/true/product.mk
##############################################################
ifneq ($(TARGET_BUILD_VARIANT),user)
MIXIN_DEBUG_LOGS := true
endif

ifeq ($(MIXIN_DEBUG_LOGS),true)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/extra_files/debug-logs/init.logs.rc:root/init.logs.rc
PRODUCT_PACKAGES += \
    elogs.sh \
    start_log_srv.sh \
    logcat_ep.sh
endif

ifeq ($(MIXIN_DEBUG_LOGS),true)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.vendor.service.default_logfs=apklogfs
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.vendor.intel.logger=/system/bin/logcat
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.logd.kernel.raw_message=False
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.intel.logger.rot_cnt=20
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.intel.logger.rot_size=5000
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/debug-logs
BOARD_SEPOLICY_M4DEFS += module_debug_logs=true
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/pstore/ram_dummy/product.mk
##############################################################
PRODUCT_PACKAGES += \
    pstore-clean
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-npk/true/product.mk
##############################################################
# There is a strong dependency on debug-logs; disable debug-npk if not set
ifeq ($(MIXIN_DEBUG_LOGS),true)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/extra_files/debug-npk/init.npk.rc:root/init.npk.rc \
    $(LOCAL_PATH)/extra_files/debug-npk/npk_icl.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/npk.cfg
PRODUCT_PACKAGES += \
    npk_init \
    logd2sven

endif #MIXIN_DEBUG_LOGS

# There is a strong dependency on debug-logs; disable debug-npk if not set
ifeq ($(MIXIN_DEBUG_LOGS),true)

# Enable redirection of android logs to SVENTX
LOGCATEXT_USES_SVENTX := true
BOARD_SEPOLICY_DIRS += \
    $(INTEL_PATH_SEPOLICY)/debug-npk

ifeq ($(PSTORE_CONFIG),PRAM)

# Default configuration for dumps to pstore
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.vendor.npk.cfg=none

# Increase pstore dump size to fit MSC buffers
BOARD_KERNEL_CMDLINE += \
    intel_pstore_pram.record_size=524288 \
    pstore.extra_size=524288

endif # PSTORE_CONFIG == PRAM

endif #MIXIN_DEBUG_LOGS

##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-dvc_desc/npk/product.mk
##############################################################
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += dvc_desc
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/extra_files/debug-dvc_desc/init.dvc_desc.rc:root/init.dvc_desc.rc \
        $(LOCAL_PATH)/extra_files/debug-dvc_desc/dvc_descriptors.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/dvc_descriptors.cfg
endif

##############################################################
# Source: device/intel/project-celadon/mixins/groups/bluetooth/btusb/product.mk
##############################################################
PRODUCT_PACKAGES += \
    hciconfig \
    btmon \
    hcitool

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:vendor/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:vendor/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PROPERTY_OVERRIDES += bluetooth.rfkill=1

PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-service.vbt \
    libbt-vendor \
    bt_fw_cel

PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-car-disablehfp
##############################################################
# Source: device/intel/project-celadon/mixins/groups/trusty/true/product.mk
##############################################################

KM_VERSION := 2

ifeq ($(KM_VERSION),2)
PRODUCT_PACKAGES += \
	keystore.trusty
PRODUCT_PROPERTY_OVERRIDES += \
	ro.hardware.keystore=trusty
endif

ifeq ($(KM_VERSION),1)
PRODUCT_PACKAGES += \
	keystore.${TARGET_BOARD_PLATFORM}
endif

PRODUCT_PACKAGES += \
	libtrusty \
	intelstorageproxyd \
	cp_ss \
	libinteltrustystorage \
	libinteltrustystorageinterface \
	gatekeeper.trusty \
	android.hardware.gatekeeper@1.0-impl \
	android.hardware.gatekeeper@1.0-service \

PRODUCT_PACKAGES_DEBUG += \
	intel-secure-storage-unit-test \
	gatekeeper-unit-tests \
	libscrypt_static \
	scrypt_test \

PRODUCT_PROPERTY_OVERRIDES += \
	ro.hardware.gatekeeper=trusty \
##############################################################
# Source: device/intel/project-celadon/mixins/groups/vendor-partition/true/product.mk
##############################################################
PRODUCT_VENDOR_VERITY_PARTITION := /dev/block/by-name/vendor

PRODUCT_COPY_FILES += $(LOCAL_PATH)/extra_files/vendor-partition/sh_recovery:recovery/root/vendor/bin/sh
PRODUCT_COPY_FILES += $(LOCAL_PATH)/extra_files/vendor-partition/mkshrc_recovery:recovery/root/vendor/etc/mkshrc
PRODUCT_COPY_FILES += $(LOCAL_PATH)/extra_files/vendor-partition/toolbox_recovery:recovery/root/vendor/bin/toolbox_static
PRODUCT_PACKAGES += \
     toybox_static \
     toybox_vendor \
##############################################################
# Source: device/intel/project-celadon/mixins/groups/dalvik-heap/tablet-7in-hdpi-1024/product.mk
##############################################################
#include frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heapgrowthlimit=100m \
    dalvik.vm.heapsize=174m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapmaxfree=8m
##############################################################
# Source: device/intel/project-celadon/mixins/groups/ethernet/dhcp/product.mk
##############################################################
PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.ethernet.xml:vendor/etc/permissions/android.hardware.ethernet.xml
##############################################################
# Source: device/intel/project-celadon/mixins/groups/rfkill/true/product.mk
##############################################################
PRODUCT_COPY_FILES += $(INTEL_PATH_COMMON)/rfkill/rfkill-init.sh:vendor/bin/rfkill-init.sh
##############################################################
# Source: device/intel/project-celadon/mixins/groups/audio/project-celadon/product.mk
##############################################################
# Tinyalsa
PRODUCT_PACKAGES_DEBUG += \
         tinymix \
         tinyplay \
         tinycap

# Extended Audio HALs
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    audio.usb.default \
    audio_policy.default.so \
    audio_configuration_files

# Audio HAL
PRODUCT_PACKAGES += \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.audio@2.0-impl \
    android.hardware.audio@2.0-service

PRODUCT_PROPERTY_OVERRIDES += audio.safemedia.bypass=true
##############################################################
# Source: device/intel/project-celadon/mixins/groups/camera-ext/ext-camera-only/product.mk
##############################################################
# Camera: Device-specific configuration files. Supports only External USB camera, no CSI support
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.external.xml:vendor/etc/permissions/android.hardware.camera.external.xml \
    $(LOCAL_PATH)/extra_files/camera-ext/external_camera_config.xml:vendor/etc/external_camera_config.xml

# External camera service
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-external-service \
                    android.hardware.camera.provider@2.4-impl

# Only include test apps in eng or userdebug builds.
PRODUCT_PACKAGES_DEBUG += TestingCamera
##############################################################
# Source: device/intel/project-celadon/mixins/groups/usb/host+acc/product.mk
##############################################################
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:vendor/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:vendor/etc/permissions/android.hardware.usb.host.xml

# usb accessory
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

##############################################################
# Source: device/intel/project-celadon/mixins/groups/usb-gadget/configfs/product.mk
##############################################################
ifeq ($(TARGET_BUILD_VARIANT),user)
# Enable Secure Debugging
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1

ifeq ($(BUILD_FOR_CTS_AUTOMATION),true)
PRODUCT_COPY_FILES += $(INTEL_PATH_COMMON)/usb-gadget/adb_keys:root/adb_keys
endif #BUILD_FOR_CTS_AUTOMATION == true
endif #TARGET_BUILD_VARIANT == user

# Add Intel adb keys for userdebug/eng builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_COPY_FILES += $(INTEL_PATH_COMMON)/usb-gadget/adb_keys:root/adb_keys
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/device-type/car/product.mk
##############################################################
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/car_core_hardware.xml:vendor/etc/permissions/car_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.type.automotive.xml:vendor/etc/permissions/android.hardware.type.automotive.xml \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:vendor/etc/permissions/android.hardware.screen.landscape.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:vendor/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.broadcastradio.xml:vendor/etc/permissions/android.hardware.broadcastradio.xml \
    frameworks/native/data/etc/android.software.activities_on_secondary_displays.xml:vendor/etc/permissions/android.software.activities_on_secondary_displays.xml \
    $(INTEL_PATH_COMMON)/framework/android.software.cant_save_state.xml:vendor/etc/permissions/android.software.cant_save_state.xml

# Make sure vendor car product overlays take precedence than google definition
# under packages/services/Car/car_product/overlay/
PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/device-type/overlay-car
$(call inherit-product, packages/services/Car/car_product/build/car.mk)

PRODUCT_PACKAGES += \
    radio.fm.default \
    CarSettings \
    VmsPublisherClientSample \
    VmsSubscriberClientSample \

PRODUCT_PACKAGES += android.hardware.automotive.vehicle.intel@2.0-service \
    android.hardware.automotive.audiocontrol@1.0-service.intel

VEHICLE_HAL_PROTO_TYPE := google-emulator
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-tools/true/product.mk
##############################################################
PRODUCT_PACKAGES_DEBUG += \
    AndroidTerm \
    libjackpal-androidterm4 \
    peeknpoke \
    pytimechart-record \
    lspci \
    llvm-symbolizer
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-crashlogd/true/product.mk
##############################################################
ifeq ($(MIXIN_DEBUG_LOGS),true)
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/extra_files/debug-crashlogd/init.crashlogd.rc:root/init.crashlogd.rc \
	$(call add-to-product-copy-files-if-exists,$(LOCAL_PATH)/extra_files/debug-crashlogd/ingredients.conf:$(TARGET_COPY_OUT_VENDOR)/etc/ingredients.conf) \
	$(call add-to-product-copy-files-if-exists,$(LOCAL_PATH)/extra_files/debug-crashlogd/crashlog.conf:$(TARGET_COPY_OUT_VENDOR)/etc/crashlog.conf)
PRODUCT_PACKAGES += crashlogd \
	dumpstate_dropbox.sh
endif

ifeq ($(MIXIN_DEBUG_LOGS),true)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.crashlogd.data_quota=50

CRASHLOGD_LOGS_PATH := "/data/logs"
CRASHLOGD_APLOG := true
CRASHLOGD_FULL_REPORT := true
CRASHLOGD_MODULE_MODEM ?= true
CRASHLOGD_USE_SD := false
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-coredump/true/product.mk
##############################################################
ifeq ($(MIXIN_DEBUG_LOGS),true)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/extra_files/debug-coredump/init.coredump.rc:root/init.coredump.rc
endif

ifeq ($(MIXIN_DEBUG_LOGS),true)
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/coredump
# Enable core dump for eng builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.core.enabled=1
else
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.core.enabled=0
endif
CRASHLOGD_COREDUMP := true
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-phonedoctor/true/product.mk
##############################################################
ifeq ($(MIXIN_DEBUG_LOGS),true)
PRODUCT_PACKAGES += crash_package
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/fota/true/product.mk
##############################################################
# Enable FOTA for non user builds
PRODUCT_PACKAGES_DEBUG += AFotaApp

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.fota.ota_stream=disabled

AFOTAAPP_EULA_PATH := 
AFOTAAPP_LOG_LEVEL := DEBUG
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/fota
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/memtrack/true/product.mk
##############################################################
# memtrack HAL
PRODUCT_PACKAGES += \
        memtrack.$(TARGET_BOARD_PLATFORM) \
	android.hardware.memtrack@1.0-service \
	android.hardware.memtrack@1.0-impl
##############################################################
# Source: device/intel/project-celadon/mixins/groups/lights/true/product.mk
##############################################################
# Lights HAL
BOARD_SEPOLICY_DIRS += \
    $(INTEL_PATH_SEPOLICY)/light

PRODUCT_PACKAGES += lights.$(TARGET_BOARD_PLATFORM) \
    android.hardware.light@2.0-service \
    android.hardware.light@2.0-impl

##############################################################
# Source: device/intel/project-celadon/mixins/groups/telephony/default/product.mk
##############################################################
# product.mk common to Telephony disabled platforms
PRODUCT_COPY_FILES += \
    $(INTEL_PATH_VENDOR)/featsetclass_tel/telephony/all/apns-conf.xml:system/etc/old-apns-conf.xml

# Inherit from common Open Source Telephony product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_VENDOR)/featsetclass_tel/telephony/overlay_none
PRODUCT_PROPERTY_OVERRIDES += \
    ro.radio.noril=true
##############################################################
# Source: device/intel/project-celadon/mixins/groups/midi/true/product.mk
##############################################################
# MIDI support
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:vendor/etc/permissions/android.software.midi.xml
##############################################################
# Source: device/intel/project-celadon/mixins/groups/art-config/true/product.mk
##############################################################
# This is needed to enable silver art optimizer.
VENDOR_ART_PATH ?= $(INTEL_PATH_VENDOR)/art-extension

PRODUCT_PACKAGES_TESTS += \
    art-run-tests \
    libarttest \
    libnativebridgetest \
    libart-gtest
##############################################################
# Source: device/intel/project-celadon/mixins/groups/cpuset/autocores/product.mk
##############################################################
PRODUCT_PACKAGES += \
    config_cpuset.sh

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/extra_files/cpuset/config_cpuset.sh:vendor/bin/config_cpuset.sh
##############################################################
# Source: device/intel/project-celadon/mixins/groups/filesystem_config/common/product.mk
##############################################################
PRODUCT_PACKAGES += \
	fs_config_files \
	fs_config_dirs

##############################################################
# Source: device/intel/project-celadon/mixins/groups/load_modules/true/product.mk
##############################################################
PRODUCT_PACKAGES += load_modules.sh
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-kernel/true/product.mk
##############################################################
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/extra_files/debug-kernel/init.kernel.rc:root/init.kernel.rc
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/thermal/default/product.mk
##############################################################
# Default
# Thermal Hal
PRODUCT_PACKAGES += thermal.default \
                    android.hardware.thermal@1.0-service \
                    android.hardware.thermal@1.0-impl
##############################################################
# Source: device/intel/project-celadon/mixins/groups/aosp_carrier-config/default/product.mk
##############################################################
EXT_IMS_PACKAGES_SRC_FILES_PATH ?= $(INTEL_PATH_VENDOR)/featsetclass_tel/telephony/carrier/imsstub/packages/apps/Settings/src
INTEL_FEATURE_TELEPHONYPROVIDER ?= $(INTEL_PATH_VENDOR)/featsetclass_tel/telephony/carrier/custom_TelephonyProvider/packages/providers/TelephonyProvider
INTEL_FEATURE_CONTACTS ?= $(INTEL_PATH_VENDOR)/featsetclass_tel/telephony/carrier/EnhancedContacts/src
INTEL_FEATURE_CONTACTSCOMMON ?= $(INTEL_PATH_VENDOR)/featsetclass_tel/telephony/carrier/EnhancedContactsCommon/src
INTEL_FEATURE_CONTACTSPROVIDER ?= $(INTEL_PATH_VENDOR)/featsetclass_tel/telephony/carrier/EnhancedContactsProvider/src
INTEL_FEATURE_ENHANCEDDIALER ?= $(INTEL_PATH_VENDOR)/featsetclass_tel/telephony/carrier/EnhancedDialer/src
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-unresponsive/default/product.mk
##############################################################
ifneq ($(TARGET_BUILD_VARIANT),user)

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.sys.dropbox.max_size_kb=4096

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.sys.dump.binder_stats.uiwdt=1
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.sys.dump.binder_stats.anr=1

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.sys.dump.peer_depth=3

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.sys.dump.stacks_timeout=1500

endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/jack/default/product.mk
##############################################################
ANDROID_COMPILE_WITH_JACK := false
# ------------------ END MIX-IN DEFINITIONS ------------------
