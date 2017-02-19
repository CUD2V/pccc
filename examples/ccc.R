eg_data <-
  dplyr::data_frame(id = letters,
                    dx1 = c(NA, NA, sample(dxc("hemato_immu", 10), 24)),
                    dx2 = sample(dxc("malignancy", 10), 26),
                    dx3 = LETTERS,
                    pc1 = sample(pcc("cvd", 10), 26),
                    pc2 = LETTERS,
                    other_col = LETTERS)

ccc(eg_data, id,
    dx_cols = dplyr::vars(dplyr::starts_with('dx')),
    pc_cols = dplyr::vars(dplyr::starts_with("pc"))) 
