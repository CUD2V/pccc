library(pccc)

x <- tryCatch(test_helper(), error = function(e) e)
stopifnot(inherits(x, "error"))
stopifnot(grepl(".test_helper.\ is defunct\\.", x$message))
