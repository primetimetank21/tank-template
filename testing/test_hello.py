"""Pytests for hello()"""
from hello import hello


def test_hello():
    """Tests for `hello()`"""
    assert hello() == "Hello John!"
    assert hello("Jill") == "Hello Jill!"
    assert type(hello()) == str
