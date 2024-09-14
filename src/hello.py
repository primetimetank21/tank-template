def hello(name: str = "John") -> str:
    """Say hello to `name`"""
    is_invalid_name: bool = any(
        [name is None, isinstance(name, str) and len(name) == 0]
    )

    if is_invalid_name:
        name = "John"

    phrase: str = f"Hello {name}!"
    print(phrase)
    return phrase


def main() -> None:
    """Code Entrypoint"""
    if __name__ == "__main__": # pragma: no cover
        hello()


main()
