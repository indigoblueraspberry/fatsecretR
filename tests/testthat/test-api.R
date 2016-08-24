context("api")

test_that("api",
          {
          consumer_key <- readRDS("../../token.rds")
          options(CONSUMER_KEY = consumer_key)
          secret <- readRDS("../../secret.rds")
          options(SHARED_SECRET = secret)

          expect_error(getFoodID("beer"))
          expect_error(getFood(1265))
          expect_error(getAuth(0000))
          expect_error(getProfile(0000))

          expect_error(getFood("bber"))

          expect_true(is.data.frame(getFood("beer")))
         # expect_true(is.data.frame(getFoodID(7682)))


          }
)
