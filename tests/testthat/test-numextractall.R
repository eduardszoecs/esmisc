context("numextractall")


test_that('numextractall works', {
  expect_equal(numextractall('1 2 3'), c(1, 2, 3))
  expect_equal(numextractall('1,2,3'), c(1, 2, 3))
  expect_equal(numextractall('1;2,3 4'), c(1, 2, 3, 4))
  expect_equal(numextractall('1;2,3 4,46'), c(1, 2, 3, 4, 46))
})

