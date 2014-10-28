context("test my setup")

test_that("Hello World is success.", {
    expect_equal(yetAnotherHelloWorld(), "Hello, World!")    
})

test_that("Hello World matches.", {
    expect_match(yetAnotherHelloWorld(), "Hello")    
})