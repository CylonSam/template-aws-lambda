from src.lambda_function import function

def test_function():
    assert function("Sam") == ("Let's go, Sam!")