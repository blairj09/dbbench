#' Benchmark database(s) against a given function
#'
#' @param connections A named list of DBI connections
#' @param f Function to benchmark. Should take DBI connection as an argument
#' @param ... Arguments passed to microbenchmark
#'
#' @importFrom rlang expr
#' @export
benchmark_db <- function(connections, f, ...) {
  # Build list of unevaluated expressions (f(con))
  mb_list <- lapply(connections, function(con) rlang::expr(f(UQ(con))))

  # Pass list to microbenchmark
  microbenchmark::microbenchmark(list = mb_list, ...)
}
