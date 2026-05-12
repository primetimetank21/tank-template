.DEFAULT_GOAL := all

# Variables
DEV = 1
VENV_NAME = .venv

ifeq ($(DEV), 1)
    VENV_NAME = .venv_dev
    UV_SYNC_EXTRAS = --extra dev
else
    VENV_NAME = .venv
    UV_SYNC_EXTRAS =
endif

UV = uv
PYTHON = $(VENV_NAME)/bin/python
RUFF = $(VENV_NAME)/bin/ruff
MYPY = $(VENV_NAME)/bin/mypy
PYTEST = $(VENV_NAME)/bin/pytest
MUTE_OUTPUT = 1>/dev/null
PYTHON_ENTRY_POINT = src/hello.py
ALL_PYTHON_FILES := $$(git ls-files "*.py")
ALL_iPYTHON_FILES := $$(git ls-files "*.ipynb")

# .env variables
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

# Get dependencies
.PHONY: install
install:
	@ echo "Installing dependencies... [START]"
	@ UV_PROJECT_ENVIRONMENT=$(VENV_NAME) $(UV) sync $(UV_SYNC_EXTRAS) $(MUTE_OUTPUT)
	@ echo "Installing dependencies... [FINISHED]"

# Create/Activate env; install dependencies
.PHONY: venv/bin/activate
venv/bin/activate:
	@ test -d $(VENV_NAME) || $(UV) venv $(VENV_NAME)
	@ make install -s

# Activate env
.PHONY: venv
venv: venv/bin/activate

# Delete env
.PHONY: delete_venv
delete_venv:
	@ rm -rf $(VENV_NAME)

# Run main script (remove if not needed)
.PHONY: run 
run: venv $(PYTHON_ENTRY_POINT)
	@ $(PYTHON) $(PYTHON_ENTRY_POINT)

# Format code for consistency
.PHONY: format
format: venv
	$(RUFF) format $(ALL_PYTHON_FILES)
	$(RUFF) format $(ALL_iPYTHON_FILES)

# Check code for any potential issues
.PHONY: lint
lint: venv
	$(RUFF) check $(ALL_PYTHON_FILES)
	$(MYPY) $(ALL_PYTHON_FILES)

# Check type-hints
.PHONY: type-check
type-check: venv
	@ $(MYPY) $(ALL_PYTHON_FILES)

# Verify code behavior
.PHONY: test
test: venv
	@ $(PYTEST) -vv --cov-report term-missing --cov=. tests/

# Clean up and remove cache files
.PHONY: clean
clean:
	@ find . -type f -name "*.py[co]" -delete -o -type d -name "__pycache__" -delete
	@ dirs=".mypy_cache .pytest_cache .ruff_cache"; \
	for dir in $$dirs; do \
		rm -rf "$$dir"; \
	done
	@ rm .coverage

# Execute all steps
.PHONY: all
all: format lint test