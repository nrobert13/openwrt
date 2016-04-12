#
# Copyright (C) 2007-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tcpdump-mptcp
PKG_VERSION:=v0.90
PKG_RELEASE:=4.4.0

PKG_SOURCE_URL:=git://github.com/multipath-tcp/tcpdump.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_VERSION:=master

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=1

PKG_MAINTAINER:=Felix Fietkau <nbd@openwrt.org>
PKG_LICENSE:=BSD-3-Clause

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/tcpdump-mptcp/default
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpcap
  TITLE:=Network monitoring and data acquisition tool
  URL:=https://github.com/the-tcpdump-group/tcpdump
endef

define Package/tcpdump-mptcp
  $(Package/tcpdump-mptcp/default)
  VARIANT:=full
endef

define Package/tcpdump-mptcp-mini
  $(Package/tcpdump-mptcp/default)
  TITLE+= (minimal version)
  VARIANT:=mini
endef

CONFIGURE_ARGS += \
	--without-crypto

ifeq ($(CONFIG_IPV6),y)
CONFIGURE_ARGS += \
	--enable-ipv6
endif

TARGET_CFLAGS += -ffunction-sections -fdata-sections
TARGET_LDFLAGS += -Wl,--gc-sections

CONFIGURE_VARS += \
	BUILD_CC="$(TARGET_CC)" \
	HOSTCC="$(HOSTCC)" \
	td_cv_buggygetaddrinfo="no" \
	ac_cv_linux_vers=$(LINUX_VERSION) \
	ac_cv_header_rpc_rpcent_h=no \
	ac_cv_lib_rpc_main=no \
	ac_cv_path_PCAP_CONFIG=""

MAKE_FLAGS :=

ifeq ($(BUILD_VARIANT),mini)
  TARGET_CFLAGS += -DTCPDUMP_MINI
  CONFIGURE_ARGS += --disable-smb
  MAKE_FLAGS += TCPDUMP_MINI=1
endif

MAKE_FLAGS += \
	CCOPT="$(TARGET_CFLAGS)" INCLS="-I. $(TARGET_CPPFLAGS)"


define Package/tcpdump-mptcp/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/tcpdump $(1)/usr/sbin/
endef

Package/tcpdump-mptcp-mini/install = $(Package/tcpdump-mptcp/install)

$(eval $(call BuildPackage,tcpdump-mptcp))
$(eval $(call BuildPackage,tcpdump-mptcp-mini))
