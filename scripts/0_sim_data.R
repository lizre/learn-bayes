# setup and import data
source("requirements.R")
here::here()

groups = 2 # how many experimental groups
demo_data <- fabricatr::fabricate(
  person_identifier = add_level(
    N = 500, 
    group = sample((1:groups), N, replace = T), # 
    continuous_var_num = round(rnorm(N, 12, 3), 2), # like $ spent
    continuous_var_int = as.integer(rnorm(N, 5, 1)), # like # of something purchased
    binary_var = draw_binary(N = N, prob = 0.25)
  ))
readr::write_csv(data, "data/demo_data.csv")
