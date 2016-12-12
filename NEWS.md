#### v 0.1.0

- Commonly used API methods (`foods.search`, `food.get`) implemented
- Helper functions for 3-Legged Authentication
- Successfully builds on Travis and AppVeyor
- Vignette detailing use of implemented methods
- No `ERRORS` or `WARNINGS` after `R CMD check`

### v 0.1.0 - Reformat

Version 0.1.0 (12.12.2016) is a major reformat. The version number has remained at 0.1.0; to signify a new starting
point in the development of this package.

#### Main Changes
- `S4` classes are used to store base information during each API request
- All FatSecret RESTful API methods are implemented _via_ a single method
