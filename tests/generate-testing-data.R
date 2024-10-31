# code used to setup and store data for tests #################################
devtools::load_all()

icd9_test_result <- ccc(pccc::pccc_icd9_dataset[, c(1:21)],
                        id      = id,
                        dx_cols = dplyr::starts_with("dx"),
                        pc_cols = dplyr::starts_with("pc"),
                        icdv    = 9)
icd10_test_result <- ccc(pccc::pccc_icd10_dataset[, c(1:21)],
                         id      = id,
                         dx_cols = dplyr::starts_with("dx"),
                         pc_cols = dplyr::starts_with("pc"),
                         icdv    = 10)
random_data_test_result <- ccc(data.frame(id = letters[1:3],
                                          dx1 = c('sadcj89sa', '1,2.3.4,5', 'sdf 9'),
                                          pc1 = c('da89v#$%', ' 90v_', 'this is a super long string compared to standard ICD codes and shouldnt break anything - if it does, the world will come to an end... Ok, so maybe not, but that means I need to fix something in this package.'),
                                          other_col = LETTERS[1:3]),
                               id      = id,
                               dx_cols = dplyr::starts_with("dx"),
                               pc_cols = dplyr::starts_with("pc"),
                               icdv    = 9) # should be all non-matches for CCCs regardless of version
usethis::use_data(icd9_test_result, icd10_test_result, random_data_test_result,
                  internal = TRUE,
                  overwrite = TRUE)
