context("oauth_params")

test_that("timestamp",
          {
          expect_true(is.numeric(TIMESTAMP()))
          expect_that(TIMESTAMP(), not(throws_error()))
          }
    )
