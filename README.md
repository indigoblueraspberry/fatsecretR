# fatsecretR [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![Build Status](https://travis-ci.org/wilsontom/fatsecretR.svg?branch=master)](https://travis-ci.org/wilsontom/fatsecretR) [![Build status](https://ci.appveyor.com/api/projects/status/uqtgjvys49rmpf65?svg=true)](https://ci.appveyor.com/project/wilsontom/fatsecretr) [![Coverage Status](https://coveralls.io/repos/wilsontom/fatsecretR/badge.svg?branch=master&service=github)](https://coveralls.io/github/wilsontom/fatsecretR?branch=master)

R Client for REST API access to the dietary information application FatSecret


#### Installation

```R
devtools::install_github(wilsontom/fatsecretR)

```
In order to make use of the fatsecret REST API, you must first register as an API user. After completing the [fatsecret API registration form](http://platform.fatsecret.com/api/Default.aspx?screen=r) you will be provided with a REST API Consumer Key and a REST API Shared Secret.

These two key's should remain private and not be hard-coded into any functions. At the start of each fatsecretR session the user will need to load the two key values into R.

```R
options(COMSUMER_KEY = "YourAPIKey")
options(SHARED_SECRET = "YourAPISecret")
```
