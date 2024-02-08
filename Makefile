PIP = .venv/bin/pip
PYTHON = .venv/bin/python
RUFF = .venv/bin/ruff
MYPY = .venv/bin/mypy
PYTEST = .venv/bin/pytest
MUTE_OUTPUT = 1>/dev/null
ALL_PYTHON_FILES := $$(git ls-files "*.py")
ALL_iPYTHON_FILES := $$(git ls-files "*.ipynb")

# Get dependencies
.PHONY: install
install: requirements.txt
	@ chmod +x ./.github/add_github_hooks.sh && ./.github/add_github_hooks.sh
	@ echo "Installing dependencies... [START]" && \
	$(PIP) install --upgrade pip $(MUTE_OUTPUT) && $(PIP) install -r requirements.txt $(MUTE_OUTPUT) && \
	echo "Installing dependencies... [FINISHED]"

# Create/Activate env; install dependencies
.PHONY: venv/bin/activate
venv/bin/activate: requirements.txt
	@ python3 -m venv .venv && \
	chmod +x .venv/bin/activate && \
	. ./.venv/bin/activate
	@ make install -s

# Activate env
.PHONY: venv
venv: venv/bin/activate
	@ . ./.venv/bin/activate

# Run main script (remove if not needed)
.PHONY: run 
run: venv
	@ $(PYTHON) hello.py

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

type-check: venv
	@ $(MYPY) $(ALL_PYTHON_FILES)

# Verify code behavior
test: venv
	@ $(PYTEST) -vv --cov-report term-missing --cov=. testing/

# Execute all steps
.PHONY: all
all: format lint test