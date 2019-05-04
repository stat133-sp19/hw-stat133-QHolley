context('test summary measures')

test_that('aux_mean() test', {
  
  expect_equal(aux_mean(10, 0.3), 3)
  expect_equal(aux_mean(20, 0.4), 8)
  expect_equal(aux_mean(30, 0.5), 15)
})

test_that('aux_variance() test', {
  
  expect_equal(aux_variance(10,0.3), 2.1)
  expect_equal(aux_variance(20,0.4), 4.8)
  expect_equal(aux_variance(30,0.5),7.5)
})

test_that('aux_mode() test', {
  
  expect_equal(aux_mode(10,0.3), 3)
  expect_equal(aux_mode(20,0.4), 8)
  expect_equal(aux_mode(30,0.5), 15)
})

test_that('aux_skewness() test', {
  
  expect_equal(aux_skewness(20, 0.5), 0)
  expect_equal(aux_skewness(40, 0.5), 0)
  expect_equal(aux_skewness(60, 0.5), 0)
})

test_that('aux_kurtosis() test', {
  
  expect_equal(aux_kurtosis(10, 0.5), -0.2)
  expect_equal(aux_kurtosis(20, 0.7), -0.06190476)
  expect_equal(aux_kurtosis(30, 0.9),  0.1703704)
})
