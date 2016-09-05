context("internals")

test_that("internals",
          {
        load("tokens.rda")
        options(CONSUMER_KEY = token)
        options(SHARED_SECRET = secret)

        expect_true(is.numeric(TIMESTAMP()))
        expect_true(is.character(RNDSTR(10)))
        expect_error(RNDSTR("abc"))
        expect_error(TIMESTAMP(123))

        expect_true(is.list(root_base_string()))

        expect_true(is.list(root_base_string3L(getOption("CONSUMER_KEY"), url = "http://www.fatsecret.com/oauth/request_token",
                           params = paste("ouath_callback", "oob", sep = "="))))

        expect_error(getAccToken("code", getOption("CONSUMER_KEY"), getOption("SHARED_SECRET")))

        }
      )


