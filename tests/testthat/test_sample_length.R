context("My second test file")

test_that("hello world is long string", {
    expect_true(nchar(yetAnotherHelloWorld()) > 5) 
} )