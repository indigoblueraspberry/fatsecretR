context("ouath_params")

test_that("random_string",
          {
          expect_true(is.character(RNDSTR(10)))
          expect_that(RNDSTR(10), not(throws_error()))
          }
    )
