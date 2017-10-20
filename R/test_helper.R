#' Tool to help access internal variables to use in testthat scripts
#'
#' @param var bare name of the internal variable to be accessed.
#'
#' @return Object from internal PCCC name space (if it exists)
#'
#' @export
test_helper <- function(var) {
  # force var to be evaluted inside context of package instead of caller's environment
  eval(parse(text = deparse(substitute(var))))
}
