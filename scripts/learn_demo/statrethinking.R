source("requirements.R")
here::here()


# Tidyverse translation: https://bookdown.org/connect/#/apps/1850/access

# counting ways to produce the data
t %>% 
  select(p_1:p_4) %>% 
  mutate(p                      = seq(from = 0, to = 1, by = .25),
         `ways to produce data` = c(0, 3, 8, 9, 0)) %>% 
  mutate(plausibility           = `ways to produce data` / sum(`ways to produce data`))

# grid approximation with 1000 parameter values -----
p_grid = seq(from=0, to = 1, length.out=1000)
plot(p_grid)
prior = rep(1,1000) # prior: prob is 1 for all 1000 values of p
plot(prior)
prob_data <- dbinom(6, size = 9, prob = p_grid)
plot(prob_data)
posterior = prob_data * prior
posterior = prob_data * prior / sum(posterior)
plot(posterior)
# sampling from the posterior
samples <- sample (p_grid, prob = posterior, size = 10000, replace = T)  
  # p grid = parameter values (eg, proportion water) to approximate over. 
plot(samples) # look at this one like youre looking at a hill from above sideways
plot(density(samples))

# grid approximation with only 20 parameter values -----
p_grid = seq(from=0, to = 1, length.out=20)
plot(p_grid)
prior = rep(1,20) # prior: prob is 1 for all 20 values of p
plot(prior)
prob_data <- dbinom(6, size = 9, prob = p_grid)
plot(prob_data)
posterior = prob_data * prior
posterior = prob_data * prior / sum(posterior)
plot(posterior)
# sampling from the posterior
samples <- sample (p_grid, prob = posterior, size = 10000, replace = T)  
  # p grid = parameter values (eg, proportion water) to approximate over. 
plot(samples) # look at this one like youre looking at a hill from above sideways
plot(density(samples))
  # doesnt look as good as the example with 1000 grid values

# quadratic approximation -----

# Apply the quadratic approximation to the globe tossing data with rethinking::map().
globe_qa <-
  rethinking::map(
    alist(
      w ~ dbinom(9, p),  # binomial likelihood
      p ~ dunif(0, 1)    # uniform prior
    ), 
    data = list(w = 6))

# display summary of quadratic approximation
precis(globe_qa)


# Percentile vs HPDI intervals ----
rethinking::PI(samples, prob = .05)
rethinking::HPDI(samples, prob = .05)

# posterior predictive distribution -----
# simulate water counts based on posterior distribution: if we drew 9 waters again, what does our model predict for how many waters we will get this time?
nw <- rbinom(10000, size = 9, prob = samples)
    # samples are proportions water drawn from posterior
plot(nw)
median(nw) # predicts 6 waters
plot(density(nw))

  
# demo paper using this package -----
# McElreath Statistical Relearning package: see Will Gervais’ code:
#  Paper: http://journal.sjdm.org/18/18228/jdm18228.html
#CRT and religious belief, rating strength in belief in God or gods from 0 (definitely does not exist) to 100 (definitely exists).
#Bayesian hierarchical (multilevel) model (fit by the R package from McElreath, 2016, version 1.59)		
#Data and code: https://osf.io/v53c4/files/
#Paper: 
  #https://journals.sagepub.com/doi/full/10.1177/1948550617707015
#Estimate atheism prevalence rates
#Data and Code: https://osf.io/4q85g/
 