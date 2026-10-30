include $(TOPDIR)/rules.mk
PKG_NAME:=luci-theme-zona
PKG_VERSION:=1.1.1
PKG_RELEASE:=1
PKG_LICENSE:=Apache-2.0
PKGARCH:=all
include $(INCLUDE_DIR)/package.mk
define Package/luci-theme-zona
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=luci-theme-zona
  DEPENDS:=+luci-base
endef
define Build/Compile
endef
define Package/luci-theme-zona/install
	$(CP) ./root/* $(1)/
endef
$(eval $(call BuildPackage,luci-theme-zona))
