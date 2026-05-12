# Contributing

Thank you for your interest in contributing to this project! Please follow the guidelines below to ensure a smooth contribution process.

## Development Setup

### 1. Clone the repository

```bash
git clone [FILL IN: Repository URL]
cd [FILL IN: Repository Name]
```

### 2. Create a virtual environment and install dependencies

```bash
make venv
source .venv_dev/bin/activate  # On Windows: .venv_dev\Scripts\activate
make install
```

The `install` target sets up Git hooks to help catch issues before committing.

### 3. Verify your setup

Run the test suite to ensure everything is working:

```bash
make test
```

## Branching Convention

- Create feature branches from `main` with descriptive names
- Use lowercase with hyphens: `feature/add-auth`, `fix/bug-in-parser`, `docs/update-readme`
- Delete branches after merging

Example:

```bash
git checkout -b feature/my-feature
```

## Development Workflow

### Code Formatting and Linting

Before committing, ensure your code is properly formatted and passes linting checks:

```bash
make format
make lint
```

Or run both in one step along with tests:

```bash
make all
```

This runs:
1. `ruff format` - Code formatting
2. `ruff check` - Linting checks
3. `mypy` - Type checking
4. `pytest` - Test suite

### Type Checking

Ensure type hints are correct:

```bash
make type-check
```

### Testing

Write tests for any new features or bug fixes. Run tests with coverage reporting:

```bash
make test
```

Tests should be placed in the `testing/` directory and follow the existing naming convention (`test_*.py`).

## Pull Request Guidelines

1. **Create a feature branch** from `main`
2. **Make small, logical commits** with clear messages
3. **Write or update tests** for your changes
4. **Run `make all`** to ensure formatting, linting, and tests pass
5. **Update documentation** if your changes affect user-facing behavior
6. **Open a pull request** with a clear title and description
7. **Ensure CI passes** before requesting review
8. **Address review feedback** promptly

### Pull Request Checklist

- [ ] Tests pass locally (`make test`)
- [ ] Code is formatted (`make format`)
- [ ] Linting passes (`make lint`)
- [ ] Type hints are correct (`make type-check`)
- [ ] Documentation is updated (if applicable)
- [ ] Commits have clear, descriptive messages

## Code of Conduct

This project is committed to providing a welcoming and inclusive environment for all contributors. Please be respectful, constructive, and professional in all interactions. We do not tolerate harassment, discrimination, or disruptive behavior of any kind.

## Questions?

If you have questions or need clarification, feel free to open an issue on the repository or reach out to the project maintainers.

Thank you for contributing!
