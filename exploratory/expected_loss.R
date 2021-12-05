here::here()
library(abtest)

#does this make any sense? 
data <- list(y1 = 82,
             n1 = 1024, 
             y2 = 57, 
             n2 = 1009)

ab <- ab_test(data = data)
print(ab) # access with ab$post_prob, ab$bf
prob_wheel(ab)

# Expected gain/loss -----

# Once the expected loss for one of the variants drops below some threshold,
# we stop the experiment.

# https://cxl.com/blog/bayesian-ab-test-evaluation/
source("requirements.R")
here::here()

# links to https://abtestguide.com/bayesian/. results match this:
prior_prob <- c(0, .5, .5, 0)
names(prior_prob) <- c("H1", "H+", "H-", "H0")
prob_wheel(ab_test(data = data, prior_prob = prior_prob))

prior_prob <- c(0.5, 0, 0, .5)
names(prior_prob) <- c("H1", "H+", "H-", "H0")
prob_wheel(ab_test(data = data, prior_prob = prior_prob))

# outstanding: why does calc set prior to 0 for H0? do we use that or the default .5? -----

# expected value of choosing control

# expected value of choosing treatment if treatment does better
plot_posterior(x = ab, 
               hypothesis = "H+",
               what = "logor")
.24*.16 # median lift*probability
.013*.16 # worst lift*probability
.677*.16 # best lift*probability


# expected ARR value of median, worst, and best lifts

# expected value: median lift
# projected median diff over 6 months
diff <- .24*23 # median of posterior x probability
expt_runtime <- interval(lubridate::as_date("2021-11-17"), ymd(lubridate::today())) %/% days(1) # over the experiment run time (12 days)
expt_runtimes_in6mo <- 360/expt_runtime # how many 12-days are there in 6 months (360 days)
diff_over6mo <- diff*expt_runtimes_in6mo # multiply 12-day differnce over 6 months
# converted to ARR
adopter_value <- 1000 # if each adopter worth $1000:
projected_value <- diff_over6mo*adopter_value # projected value
projected_value*.16 # 26496

# 3.84% increase * probability * ARR
23*1.0384*.16*1000

# expected value: worst lift
diff <- .103*23
diff_over6mo <- diff*expt_runtimes_in6mo
projected_value <- diff_over6mo*adopter_value 
projected_value*.16 # 11371

# expected value: best lift
diff <- .677*23
diff_over6mo <- diff*expt_runtimes_in6mo
projected_value <- diff_over6mo*adopter_value 
projected_value*.16 # 74740


# expected value of choosing treatment if treatment is worse
plot_posterior(x = ab, 
               hypothesis = "H-",
               what = "logor") # median is -.15
-.14*.07 # median lift*probability
-.51*.16 # worst lift*probability
-.0006*.16 # best lift*probability

# expected ARR value of median, worst, and best lifts

# expected value: median lift
diff <-  -.14*23 
diff_over6mo <- diff*expt_runtimes_in6mo
projected_value <- diff_over6mo*adopter_value
projected_value*.07  # expected value: -6762

# expected value: worst lift
diff <-  -.51*23 
diff_over6mo <- diff*expt_runtimes_in6mo
projected_value <- diff_over6mo*adopter_value
projected_value*.07  # expected value: -24633

# expected value: best lift
diff <-  -.006*23 
diff_over6mo <- diff*expt_runtimes_in6mo
projected_value <- diff_over6mo*adopter_value
projected_value*.07  # expected value: -289

# presenting results 
#  https://static.wingify.com/gcp/wp-content/themes/vwo/images/new-website/a-b-testing/report2.svg

