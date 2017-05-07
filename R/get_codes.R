#' @method as.data.frame pccc_codes
as.data.frame.pccc_codes <- function(x, ...) {
  v <- attr(x, "version")

  out <- 
    Map(function(category, type)
        {
          cd <- unlist(x[category, type])

          if (length(cd))
            dplyr::data_frame(category = category, type = type, icd = cd)

        }, 
        category = rep(rownames(x), each = ncol(x)),
        type = rep(colnames(x), times = nrow(x))
        )
  dplyr::bind_rows(out)
}

#' @method as.tbl pccc_codes
as.tbl.pccc_codes <- as.data.frame.pccc_codes