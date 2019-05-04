context("check binomial functions")

test_that("bin_choose", {
  expect_error(bin_choose(1, 2))
  expect_error(bin_choose(4,c(1,2,5)))
  expect_equal(bin_choose(3, 2), 3)
})

test_that("bin_probability", {
  expect_equal(bin_probability(1, 2, 0.1),0.18)
  expect_equal(bin_probability(3, 6, 0.2),0.08192)
  expect_error(bin_probability(2.1, 5, 2))
})

test_that("bin_distribution", {
  expect_true(any(class(bin_distribution(7, 0.7)) == "bindis"))
  expect_true(ncol(bin_distribution(7, 0.7)) == 2)
  expect_true(nrow(bin_distribution(7, 0.7)) == 8)
})

test_that("bin_cumulative", {
  expect_true(any(class(bin_cumulative(7, 0.7)) == "bincum"))
  expect_true(any(class(bin_cumulative(7, 0.7)) == "data.frame"))
  expect_true(nrow(bin_cumulative(7, 0.7)) == 8)
})