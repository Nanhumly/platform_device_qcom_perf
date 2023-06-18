#
# Copyright (C) 2021-2023 Miku UI
#
# SPDX-License-Identifier: Apache-2.0
#

# AV Service
PRODUCT_PACKAGES += \
    libavservices_minijail \
    libavservices_minijail.vendor

# Boost Framework
PRODUCT_PACKAGES += MikuBoostFrameworkOverlay

# Perf 
PRODUCT_BOOT_JARS += \
    QPerformance \
    UxPerformance

PRODUCT_PACKAGES += \
    vendor.qti.hardware.perf@2.2.vendor \
    vendor.qti.hardware.perf@2.3

# Perf (TensorFlow)
PRODUCT_PACKAGES += libtflite

# Perf Configs
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/platform/$(TARGET_BOARD_PLATFORM),$(TARGET_COPY_OUT_VENDOR)/etc)

# Permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/permissions/com.qualcomm.qti.Performance.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.qualcomm.qti.Performance.xml \
    $(LOCAL_PATH)/permissions/com.qualcomm.qti.UxPerformance.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.qualcomm.qti.UxPerformance.xml

# PSI
PRODUCT_PACKAGES += libpsi.vendor

# Service Tracker
PRODUCT_PACKAGES += vendor.qti.hardware.servicetracker@1.2.vendor

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0 \
    android.hardware.thermal@2.0.vendor \

# Perf props
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.perf-hal.ver=2.2 \
    ro.vendor.extension_library=libqti-perfd-client.so \
    ro.vendor.perf.scroll_opt=1 \
    ro.vendor.qspm.enable=true \
    vendor.power.pasr.enabled=false

ifeq ($(call is-board-platform-in-list, kona lahaina),true)
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.beluga.p=0x3 \
    ro.vendor.beluga.c=0x4800 \
    ro.vendor.beluga.s=0x900 \
    ro.vendor.beluga.t=0x240
endif

# Disable IOP HAL for select platforms.
ifeq ($(call is-board-platform-in-list, msm8937 msm8953 msm8998 qcs605 sdm660 sdm710),true)
PRODUCT_PACKAGES += vendor.qti.hardware.iop@2.0-service-disable.rc
endif

# Disable the poweropt service for <5.4 platforms.
ifneq ($(call is-board-platform-in-list, lahaina holi),true)
PRODUCT_PACKAGES += poweropt-service-disable.rc
endif

# Get non-open-source specific aspects
$(call inherit-product, vendor/qcom/perf/perf-vendor.mk)
