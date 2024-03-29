################################################################################
#
# ripgrep
#
################################################################################

RIPGREP_VERSION = 0.7.1
RIPGREP_SITE = $(call github,BurntSushi,ripgrep,$(RIPGREP_VERSION))
RIPGREP_LICENSE = MIT

RIPGREP_DEPENDENCIES = host-cargo

RIPGREP_CARGO_ENV = CARGO_HOME=$(HOST_DIR)/share/cargo
RIPGREP_CARGO_MODE = $(if $(BR2_ENABLE_DEBUG),debug,release)

RIPGREP_BIN_DIR = target/$(RUSTC_TARGET_NAME)/$(RIPGREP_CARGO_MODE)

RIPGREP_CARGO_OPTS = \
	$(if $(VERBOSE),--verbose) \
	--jobs=$(PARALLEL_JOBS) \
	--$(RIPGREP_CARGO_MODE) \
	--target=$(RUSTC_TARGET_NAME) \
	--manifest-path=$(@D)/Cargo.toml

define RIPGREP_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(RIPGREP_CARGO_ENV) \
		cargo build $(RIPGREP_CARGO_OPTS)
endef

define RIPGREP_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/$(RIPGREP_BIN_DIR)/rg \
		$(TARGET_DIR)/usr/bin/rg
endef

$(eval $(generic-package))
