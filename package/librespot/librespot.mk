################################################################################
#
# librespot
#
################################################################################

LIBRESPOT_VERSION = 9d9c3117ed87e751a240ce2ff1d57cf17bf0b27f
LIBRESPOT_SITE = $(call github,librespot-org,librespot,$(LIBRESPOT_VERSION))

LIBRESPOT_DEPENDENCIES = host-cargo host-rustc pulseaudio

LIBRESPOT_CARGO_ENV = CARGO_HOME=$(HOST_DIR)/share/cargo
LIBRESPOT_CARGO_MODE = $(if $(BR2_ENABLE_DEBUG),debug,release)

LIBRESPOT_BIN_DIR = target/$(RUSTC_TARGET_NAME)/$(LIBRESPOT_CARGO_MODE)

LIBRESPOT_CARGO_OPTS = \
	$(if $(VERBOSE),--verbose) \
	--jobs=$(PARALLEL_JOBS) \
	--$(LIBRESPOT_CARGO_MODE) \
	--target=$(RUSTC_TARGET_NAME) \
	--manifest-path=$(@D)/Cargo.toml \
	--no-default-features \
	--features pulseaudio-backend

define LIBRESPOT_BUILD_CMDS
    $(TARGET_MAKE_ENV) CC=$(TARGET_CC) $(LIBRESPOT_CARGO_ENV) \
	cargo build $(LIBRESPOT_CARGO_OPTS)
endef

define LIBRESPOT_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/$(LIBRESPOT_BIN_DIR)/librespot \
	$(TARGET_DIR)/usr/bin/librespot
endef

$(eval $(generic-package))
