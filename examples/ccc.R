eg_data <-
  dplyr::data_frame(id = letters,
                    dx1 = c(NA, NA, sample(get_codes(10)[["hemato_immu"]], 24)),
                    dx2 = c("A", "B", "B", sample(get_codes(10)[["gi"]], 23)),
                    dx3 = LETTERS,
                    pc1 = c("42", sample(get_codes(10)[["cvd"]], 25)),
                    pc2 = LETTERS,
                    other_col = LETTERS)

ccc(eg_data, 
    id,
    codes = dplyr::vars(dplyr::starts_with("dx"), dplyr::starts_with("pc")),
    icdv = 10)

