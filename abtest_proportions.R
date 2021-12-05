source("requirements.R")
here::here()

# https://rdrr.io/cran/abtest/man/ab_test.html 

# get data -----
# write some proportions
data <- list(y1 = 82,
n1 = 1024, 
y2 = 57, 
n2 = 1009)

# or use demo data
demo_data <- readr::read_csv("data/demo_data.csv")
demo_data <- list(y1 = demo_data$binary_var[demo_data$group==1],
                  n1 = length(demo_data$group[demo_data$group==1]), 
                  y2 = demo_data$binary_var[demo_data$group==2], 
                  n2 = length(demo_data$group[demo_data$group==2]))


# Hypothesis testing  -----
ab <- ab_test(data = data)
print(ab) # access with ab$post_prob, ab$bf
prob_wheel(ab)
# plot_sequential(ab) #over time/cases


# Parameter estimation -----
plot_posterior(x = ab, what = "logor")
plot_posterior(x = ab, what = "p1p2") # 15% lift == median absolute risk (i.e., p2 − p1)
plot_posterior(x = ab, what = "arisk")
plot_posterior(x = ab, what = "rrisk")


# Doesn't need power analysis, but probabilities are mush at just .1 of total N -----
data_mini <- list(y1 = enabled_workflow$orgs_running_actions[enabled_workflow$variation=="control"]*.1,
  n1 = all_visitors$`_col1`[all_visitors$variation=="control"]*.1, 
  y2 = enabled_workflow$orgs_running_actions[enabled_workflow$variation=="treatment"]*.1, 
  n2 = all_visitors$`_col1`[all_visitors$variation=="treatment"]*.1)

ab_mini <- ab_test(data = data_mini)
print(ab_mini)
prob_wheel(ab_mini)
