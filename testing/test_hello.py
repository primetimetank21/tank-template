"""Pytests for src/hello.py"""

from typing import cast
import pytest
from src.hello import hello as hello_func, main


@pytest.mark.parametrize(
    "name, expected_output",
    [
        ("John", "Hello John!"),
        ("Jill", "Hello Jill!"),
        ("", "Hello John!"),
        (None, "Hello John!"),
    ],
)
def test_hello(name: str, expected_output: str) -> None:
    """Tests for `hello()`"""
    assert all(
        [
            hello_func(name=name) == expected_output,
            isinstance(hello_func(name=name), str),
        ]
    )


def test_main() -> None:
    return_val: None = cast(None, main())
    assert return_val is None
