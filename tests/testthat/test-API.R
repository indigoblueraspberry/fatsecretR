context("API")

test_that("API",
          {
          load("tokens.rda")
          expect_true(isS4(fatsecret))

          expect_true(isS4(new("fatsecret")))
          expect_true(isS4(new("fatsecret3L")))

          APIkeys(fatsecret, token, secret)

          expect_error(APIkeys(fatsecret, 012345, secret))
          expect_error(APIkeys(fatsecret, token, 012345))

          # test main API methods

          expect_true(is.data.frame(fatsecretR(fatsecret, "getFood", "beer")))
          expect_true(is.data.frame(fatsecretR(fatsecret, "getFood", "baked+beans")))
          expect_true(is.data.frame(fatsecretR(fatsecret, "getFoodID", "1265")))


          expect_error(fatsecretR(fatsecret, "getFood", "bber"))
          expect_error(fatsecretR(fatsecret, "getFoodID", "0000"))


          # test internals
          timeob <- TimeStamp(fatsecret)
          expect_true(is.character(fatsecret@timestamp))

          nonceob <- OauthNonce(fatsecret)
          expect_true(is.character(fatsecret@nonce))


          # test 3-Legged Authentication

          newAuth("SteveFrench")
          expect_true(isS4(SteveFrench))
          APIkeys(SteveFrench, token, secret)

          SteveFrench <- RequestAuthorisation(SteveFrench, params = "oob")

          expect_true(is.character(SteveFrench@request_token))
          expect_true(is.character(SteveFrench@request_secret))
          expect_true(is.character(SteveFrench@user_request_url))


          expect_true(is.data.frame(fatsecretR(fatsecret, "getFoodEntry", "2016-12-20",
                                               SteveFrenchToken, SteveFrenchSecret)))
          expect_true(is.data.frame(fatsecretR(fatsecret, "getFoodEntry", "2016-12-19",
                                               SteveFrenchToken, SteveFrenchSecret)))
          expect_error(fatsecretR(fatsecret, "getFoodEntry", "2016-12-21",
                                               SteveFrenchToken, SteveFrenchSecret))

          }
)

