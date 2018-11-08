# dbbench

`dbbench` uses [`microbenchmark`](https://github.com/joshuaulrich/microbenchmark) to benchmark arbitrary functions against a list of [`DBI`](https://github.com/r-dbi/DBI) connections.

## Installation

You can install the development version of `dbbench` from GitHub with:

``` r
library(remotes)
install_github("blairj09/dbbench")
```

## Example

The main component of `dbbench` is `benchmark_db()`, which takes a named list of `DBI` connections and an arbitrary function (`f()`) that takes a valid `DBI` connection as its first argument. Additional arguments are passed to `microbenchmark`.

``` r
db_cons <- list(
  sql_server = DBI::dbConnect(odbc::odbc(), "SQL Server (DSN)"),
  teradata = DBI::dbConnect(odbc::odbc(), "Teradata (DSN)")
)

write_cars <- function(con) {
  DBI::dbWriteTable(con, "cars_test", mtcars, overwrite = TRUE)
}

results <- benchmark_db(db_cons, write_cars, times = 5)
```

## Future Development

This package is admittedly thin at the moment. It also stands to reason that `microbenchmark` is likely not the best method for benchmarking database performance from within R.
