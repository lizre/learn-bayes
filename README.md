# Start using Bayes

## Foundations

[McElreath stat rethinking](https://xcelab.net/rm/statistical-rethinking/), at least ch 1 and 2
- [video](https://github.com/rmcelreath/statrethinking_winter2019) lectures at github and [youtube](https://www.youtube.com/channel/UCNJK6_DZvcMqNSzQdEkzvzA/playlists?app=desktop)
- [translation into ggplot, tidyverse and brms](https://bookdown.org/connect/#/apps/1850/access): also ch 1 and 2

Psychonomic Bulletin & Review Volume 25, Issue 1, February 2018 all about bayes: [https://link.springer.com/journal/13423/25/1/page/2](https://link.springer.com/journal/13423/25/1/page/2)



## Step 1: In browser
http://www.sumsar.net/best_online/

Model comparison

Online Bayes-factor calculators include those by Rouder and colleagues at http://pcl.missouri.edu/bayesfactor and by Dienes at http://tinyurl.com/DienesBayesFactor

Datacamp
https://www.datacamp.com/courses/fundamentals-of-bayesian-data-analysis-in-r
https://www.datacamp.com/community/open-courses/beginning-bayes-in-r

## Step 2: GUIs

JASP https://jasp-stats.org/
	Workshop: https://osf.io/fscqm/files/
frequentist and Bayesian analyses with pull-down menus
GUI to R, using BayesFactor package
Examples in JASP (wagenmakers)
https://link.springer.com/article/10.3758/s13423-017-1323-7

Jamovi’s JSQ library for Bayesian methods https://www.jamovi.org/
It’s a “port” of JASP… as such, cannot export code (because JASP doesn’t not export code)


## Step 3: use R
Read software comparison (all in R) 
https://rpubs.com/lindeloev/bayes_factors

Ones tried/demo'd in this repo
BayesFactor
https://richarddmorey.github.io/BayesFactor/
https://github.com/richarddmorey/BayesFactor

[Brms](https://github.com/paul-buerkner/brms)
- [Doing Bayesian Data Analysis in brms and the tidyverse](https://bookdown.org/ajkurz/DBDA_recoded/)

Ones I haven't tried
[rstan](https://www.datacamp.com/courses/bayesian-regression-modeling-with-rstanarm), [rjags](https://www.datacamp.com/courses/bayesian-modeling-with-rjags), bain package ([Tutorial in Psych Methods](https://pdfs.semanticscholar.org/7922/4d659b68e53eba7709d3de7e1d0b1a94e1d8.pdf?_ga=2.59178477.1552064804.1575474191-1459868884.1561058546); [this](https://www.researchgate.net/publication/331029513_A_Tutorial_on_Testing_Hypotheses_Using_the_Bayes_Factor), [BAS](https://github.com/merliseclyde/BAS):
relatively new package which includes many “default priors” which can be specified using a single argument

## Reporting and plotting

- Try to make figure(s) using JASP figure R code
- Or use bayesplot package https://rdrr.io/cran/bayesplot/
- Or use geoms/lay on ggplot, in tidybayes package
- https://github.com/mjskay/tidybayes
- See tidybayes as applied to correlation here  https://solomonkurz.netlify.com/post/bayesian-correlations-let-s-talk-options/
- Reporting examples at https://osf.io/6eqx5/
