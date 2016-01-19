context("errors")

test_that("errors",
          {
            expect_error(getFoodID("beer"))
            expect_error(getFood(1265))
            expect_error(getAuth(0000))
            expect_error(getProfile(0000))
            }
          )
