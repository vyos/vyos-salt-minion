TMPL_DIR := templates-cfg
OP_TMPL_DIR := templates-op

.PHONY: interface_definitions
.ONESHELL:
interface_definitions:
	mkdir -p $(TMPL_DIR)

	find $(CURDIR)/interface-definitions/ -type f | xargs -I {} $(CURDIR)/scripts/build-command-templates {} $(CURDIR)/schema/interface_definition.rng $(TMPL_DIR) || exit 1
	
	# XXX: delete top level node.def's that now live in other packages
	rm -f $(TMPL_DIR)/service/node.def

.PHONY: op_mode_definitions
.ONESHELL:
op_mode_definitions:
	mkdir -p $(OP_TMPL_DIR)

	find $(CURDIR)/op-mode-definitions/ -type f | xargs -I {} $(CURDIR)/scripts/build-command-op-templates {} $(CURDIR)/schema/op-mode-definition.rng $(OP_TMPL_DIR) || exit 1

.PHONY: all
all: clean interface_definitions op_mode_definitions

.PHONY: clean
clean:
	rm -rf $(TMPL_DIR)/*
	rm -rf $(OP_TMPL_DIR)/*
