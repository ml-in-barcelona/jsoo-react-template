project_name = jsoo-react-template
DUNE = opam exec -- dune
opam_file = $(project_name).opam

.DEFAULT_GOAL := help

.PHONY: help
help: ## Print this help message
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}';
	@echo "";

.PHONY: create-switch
create-switch:
	opam switch create . 4.13.1 --deps-only

.PHONY: init
init: setup-git-hooks install ## Configure everything to develop this repository in local

.PHONY: setup-git-hooks
setup-git-hooks: ## Configure git to point githooks in .githooks folder
	git config core.hooksPath .githooks

.PHONY: install
install: all ## Install development dependencies
	opam install . --deps-only --with-test

.PHONY: deps
deps: $(opam_file) ## Alias to update the opam file and install the needed deps

.PHONY: build
build: ## Build the project
	$(DUNE) build @@default

.PHONY: start
start: all ## Serve the application with a local HTTP server
	cd demo && yarn start

.PHONY: clean
clean: ## Clean build artifacts and other generated files
	$(DUNE) clean

.PHONY: format
format: ## Format the codebase with ocamlformat
	$(DUNE) build @fmt --auto-promote

.PHONY: format-check
format-check: ## Checks if format is correct
	$(DUNE) build @fmt

.PHONY: watch
watch: ## Watch for the filesystem and rebuild on every change
	$(DUNE) build @@default --watch

$(opam_file): dune-project ## Update the package dependencies when new deps are added to dune-project
	opam exec -- dune build @install        # Update the $(project_name).opam file
