@Test
def testGreeting(): Unit \ Assert =
    Assert.assertEq(expected = "Hello, World!", greeting("World"))

@Test
def testGreetingUsesTheGivenName(): Unit \ Assert =
    Assert.assertEq(expected = "Hello, Flix!", greeting("Flix"))

@Test
def testGreetingWithEmptyName(): Unit \ Assert =
    Assert.assertEq(expected = "Hello, !", greeting(""))
