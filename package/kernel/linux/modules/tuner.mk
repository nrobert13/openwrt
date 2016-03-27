#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
#filepath package/kernel/linux/modules/tuner.mk
#if you want Makefile add the below includes
#include $(TOPDIR)/rules.mk
#include $(INCLUDE_DIR)/package.mk
SUB_MENU:=Tuner

define KernelPackage/tt-ct-3650
  SUBMENU:=$(SUB_MENU)
  TITLE:=TechnoTrend CT 3650 DVB-T/C USB2.0 
  DEPENDS:=@USB_SUPPORT +kmod-nls-base +kmod-usb-core +kmod-input-core 
  KCONFIG:=CONFIG_DVB_USB_TTUSB2
  FILES:= \
	$(LINUX_DIR)/drivers/media/dvb-core/dvb-core.ko \
	$(LINUX_DIR)/drivers/media/dvb-frontends/dvb-pll.ko \
	$(LINUX_DIR)/drivers/media/rc/rc-core.ko \
	$(LINUX_DIR)/drivers/media/rc/ttusbir.ko \
	$(LINUX_DIR)/drivers/media/usb/dvb-usb/dvb-usb.ko \
	$(LINUX_DIR)/drivers/media/usb/dvb-usb/dvb-usb-ttusb2.ko \
	$(LINUX_DIR)/drivers/media/dvb-frontends/tda10023.ko \
	$(LINUX_DIR)/drivers/media/dvb-frontends/tda10048.ko \
	$(LINUX_DIR)/drivers/media/tuners/tda827x.ko
#	$(LINUX_DIR)/fs/nls/nls_base.ko \
#	$(LINUX_DIR)/drivers/usb/common/usb-common.ko \
#	$(LINUX_DIR)/drivers/usb/core/usbcore.ko \
#	$(LINUX_DIR)/drivers/input/input-core.ko 
  AUTOLOAD:=$(call AutoLoad,65,dvb-core rc-core dvb-usb tda10023 tda10048 tda827x dvb-usb-ttusb2)
#old stack
#  AUTOLOAD:=$(call AutoLoad,65,dvb-core dvb-pll rc-core ttusbir dvb-usb dvb-usb-ttusb2 tda10023 tda10048 tda827x)
endef

define KernelPackage/tt-ct-3650/description
    Kernel modules for TechnoTrend CT-3650 USB Tuner support
endef

$(eval $(call KernelPackage,tt-ct-3650))

define KernelPackage/tt-htc-hd
  SUBMENU:=$(SUB_MENU)
  TITLE:=TerraTec HTC HD DVB-T/C USB2.0 
  DEPENDS:=@USB_SUPPORT +kmod-nls-base +kmod-usb-core +kmod-input-core 
  KCONFIG:=CONFIG_VIDEO_EM28XX_DVB
  FILES:= \
	$(LINUX_DIR)/drivers/media/dvb-core/dvb-core.ko \
	$(LINUX_DIR)/drivers/media/dvb-frontends/dvb-pll.ko \
	$(LINUX_DIR)/drivers/media/rc/rc-core.ko \
	$(LINUX_DIR)/drivers/media/common/tveeprom.ko \
	$(LINUX_DIR)/drivers/media/usb/em28xx/em28xx.ko \
	$(LINUX_DIR)/drivers/media/dvb-frontends/drxk.ko \
	$(LINUX_DIR)/drivers/media/dvb-frontends/tda18271c2dd.ko \
	$(LINUX_DIR)/drivers/media/tuners/tda18271.ko \
	$(LINUX_DIR)/drivers/media/usb/em28xx/em28xx-dvb.ko \
	$(LINUX_DIR)/drivers/media/usb/em28xx/em28xx-rc.ko \
	$(LINUX_DIR)/drivers/media/v4l2-core/v4l2-common.ko \
	$(LINUX_DIR)/drivers/media/v4l2-core/videodev.ko
  AUTOLOAD:=$(call AutoLoad,65,dvb-core tveeprom videodev v4l2-common em28xx drxk tda18271c2dd tda18271 em28xx-dvb)
endef

define KernelPackage/tt-htc-hd/description
    Kernel modules for TerraTec HTC HD DVB-T/C USB2.0
endef

define KernelPackage/tt-htc-hd/install
	$(INSTALL_DIR) $(1)/lib/firmware
	$(INSTALL_DATA) $(TOPDIR)/myfiles/dvb-usb-terratec-htc-stick-drxk.fw $(1)/lib/firmware/
endef


$(eval $(call KernelPackage,tt-htc-hd))

