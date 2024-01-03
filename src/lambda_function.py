def handler(event, context):
    result = function("my bro")
    print(result)

# Separating the function from the handler allows us to test the logic of the function
def function(title: str):
    return f"Let's go, {title}!"
