context("geomean")

x <- c(1, 10, 100)
gx <- geomean(x)

test_that('geomean works', {
  expect_is(gx, "numeric")
  expect_equal(length(gx), 1)
  expect_equal(gx, 10)
})

