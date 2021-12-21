source("requirements.R")
here::here()

# Bayes Fundamentals -----
# link: https://www.datacamp.com/courses/fundamentals-of-bayesian-data-analysis-in-r

prop_model <- function (data = c(), prior_prop = c(1, 1), n_draws = 10000, 
    show_plot = TRUE) 
{
    data <- as.logical(data)
    proportion_success <- c(0, seq(0, 1, length.out = 100), 1)
    data_indices <- round(seq(0, length(data), length.out = min(length(data) + 
        1, 20)))
    post_curves <- map_dfr(data_indices, function(i) {
        value <- ifelse(i == 0, "Prior", ifelse(data[i], "Success", 
            "Failure"))
        label <- paste0("n=", i)
        probability <- dbeta(proportion_success, prior_prop[1] + 
            sum(data[seq_len(i)]), prior_prop[2] + sum(!data[seq_len(i)]))
        probability <- probability/max(probability)
        data.frame(value, label, proportion_success, probability)
    })
    post_curves$label <- fct_rev(factor(post_curves$label, levels = paste0("n=", 
        data_indices)))
    post_curves$value <- factor(post_curves$value, levels = c("Prior", 
        "Success", "Failure"))
    p <- ggplot(post_curves, aes(x = proportion_success, y = label, 
        height = probability, fill = value)) + geom_joy(stat = "identity", 
        color = "white", alpha = 0.8, panel_scaling = TRUE, size = 1) + 
        scale_y_discrete("probability density at each trial", expand = c(0.01, 0)) + scale_x_continuous("Parameter value: Proportion success") + 
        scale_fill_manual(values = hcl(120 * 2:0 + 15, 100, 65), 
            name = "", drop = FALSE, labels = c("Prior   ", "Success   ", 
                "Failure   ")) + theme_light(base_size = 18) + 
        theme(legend.position = "top")
    if (show_plot) {
        print(p)
    }
    invisible(rbeta(n_draws, prior_prop[1] + sum(data), prior_prop[2] + 
        sum(!data)))
}
data <- c()
prop_model(data)

data <- c(0,1,0,1,1,1,1, 0, 0, 0,0)
prop_model(data)

posterior_paramvalues <- prop_model(data)

# If you sample a (large enough) vector from the posterior distribution, each value will occur in proportion to how probable it is
print(posterior_paramvalues)
median(posterior_paramvalues) # .46. this is the "point estimate".
hist(posterior_paramvalues, breaks = 30, xlim = c(0, 1), col = "lavender")

# get credible interval: what values are most probable within a certain probability?
quantile(posterior_paramvalues, c(0.05, 0.95))


# Beginning Bayes -----
# link: https://www.datacamp.com/community/open-courses/beginning-bayes-in-r
library(TeachBayes)
areas <- c(2,1,2,1,2)
spinner_plot(areas)