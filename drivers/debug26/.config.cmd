deps_config := \
	mips.8172/Config.in \
	mips.ev64420/Config.in \
	mips.bonito/Config.in \
	i386/Config.in \
	Config.in

.config include/config.h: $(deps_config)

$(deps_config):
