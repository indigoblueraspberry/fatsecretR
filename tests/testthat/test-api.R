context("api")

test_that("api",
          {
          load("tokens.rda")
          options(CONSUMER_KEY = token)
          options(SHARED_SECRET = secret)

          expect_error(getFoodID("beer"))
          expect_error(getFood(1265))
          expect_error(getAuth(0000))
          expect_error(getProfile(0000))

          expect_error(getFood("bber"))

          expect_true(is.data.frame(getFood("beans")))
          expect_true(is.data.frame(getFood("baked beans")))
          expect_true(is.matrix(getFoodID(7682)))

          req_list <- makeRequest(callback = "oob")
          expect_true(is.list(req_list))

          }
)
