"""Tests for src/hello.py"""

from typing import cast

import pytest

from src.hello import hello as hello_func
from src.hello import main


@pytest.mark.parametrize(
    "name, expected_output",
    [
        ("John", "Hello John!"),
        ("Jill", "Hello Jill!"),
        ("", "Hello John!"),
        (None, "Hello John!"),
        (5, "Hello 5!"),
        (5.0, "Hello 5.0!"),
        (True, "Hello True!"),
    ],
)
def test_hello(name: str, expected_output: str) -> None:
    assert all(
        [
            hello_func(name=name) == expected_output,
            isinstance(hello_func(name=name), str),
        ]
    )


def test_main() -> None:
    return_val: None = cast(None, main())
    assert return_val is None
