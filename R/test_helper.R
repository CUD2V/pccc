#' Test Helper
#'
#' Tool to help access internal variables to use in testthat scripts, or anytime
#' access via \code{:::} would be needed.
#'
#' @param var bare name of the internal variable to be accessed.
#'
#' @return Object from internal PCCC name space (if it exists)
#'
#' @export
test_helper <- function(var) {
  .Defunct()
  # force var to be evaluted inside context of package instead of caller's environment
  eval(parse(text = deparse(substitute(var))))
}
