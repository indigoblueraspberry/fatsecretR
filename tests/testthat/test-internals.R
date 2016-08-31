context("internals")

test_that("internals",
          {
        expect_true(is.numeric(TIMESTAMP()))
        expect_true(is.character(RNDSTR(10)))
        expect_error(RNDSTR("abc"))
        expect_error(TIMESTAMP(123))
          }
        )
