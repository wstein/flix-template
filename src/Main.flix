///
/// Returns the greeting for `name`.
///
/// Kept apart from `main` so there is something to test: `main` is effectful
/// and writes to the terminal, while this is pure and returns its result.
///
def greeting(name: String): String = "Hello, ${name}!"

///
/// The main entry point.
///
def main(): Unit \ IO =
    println(greeting("World"))
