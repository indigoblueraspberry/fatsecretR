#### v 0.1.0

- Passes `R CMD check` with `1 NOTE`

  ```  
  * checking dependencies in R code ... NOTE
Namespace in Imports field not imported from: ‘bitops’
  All declared Imports should be used.
```

  Listing `bitops` as an Import is a temporary solution to stop the Windows AppVeyor builds from failing.
