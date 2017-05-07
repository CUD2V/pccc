eg_data <-
  dplyr::data_frame(id = letters,
                    dx1 = c(NA, NA, sample(get_codes(10)[["hemato_immu", "dx"]], 24)),
                    dx2 = sample(get_codes(10)[["gi", "dx"]], 26),
                    dx3 = LETTERS,
                    pc1 = sample(get_codes(10)[["cvd", "pc"]], 26),
                    pc2 = LETTERS,
                    other_col = LETTERS)

ccc(eg_data, 
    id,
    dx_cols = dplyr::vars(dplyr::starts_with('dx')),
    pc_cols = dplyr::vars(dplyr::starts_with("pc")),
    icdv = 10)

