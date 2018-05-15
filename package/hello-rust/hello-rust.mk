################################################################################
#
# hello-rust
#
################################################################################

HELLO_RUST_VERSION = 0.1.1
HELLO_RUST_SITE = $(HOME)/src/hello-rust
HELLO_RUST_SITE_METHOD = local
HELLO_RUST_LICENSE = Public Domain

HELLO_RUST_DEPENDENCIES = host-cargo

HELLO_RUST_CARGO_ENV = CARGO_HOME=$(HOST_DIR)/usr/share/cargo
HELLO_RUST_CARGO_MODE = $(if $(BR2_ENABLE_DEBUG),debug,release)

HELLO_RUST_CARGO_OPTS = \
	$(if $(VERBOSE),--verbose) \
	--jobs=$(PARALLEL_JOBS) \
	--$(HELLO_RUST_CARGO_MODE) \
	--target=$(RUSTC_TARGET_NAME) \
	--manifest-path=$(@D)/Cargo.toml

HELLO_RUST_BIN_DIR = target/$(RUSTC_TARGET_NAME)/$(HELLO_RUST_CARGO_MODE)

define HELLO_RUST_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(HELLO_RUST_CARGO_ENV) \
		cargo build $(HELLO_RUST_CARGO_OPTS)
endef

define HELLO_RUST_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/$(HELLO_RUST_BIN_DIR)/hello-rust \
		$(TARGET_DIR)/usr/bin/hello-rust
endef

$(eval $(generic-package))
