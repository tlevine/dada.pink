library(ggplot2)
library(reshape2)
library(scales)

# tuition <- c(europe = 5e4,
#              us.public = 8e4,
#              us.private = 2e5)
tuition <- c(5e4, 2e5)
years.invested <- 65 - 20 # the nominal working life
stock.market.return <- 1.068 # from Greenstone & Looney, 2011

college <- data.frame(
  tuition = rep(tuition, each = 3)
)
college$stock.market.return <- c(1.050, 1.065, 1.080)
college$earnings <- college$tuition * college$stock.market.return ^ years.invested
college$investment <- paste0('Stock market (',
                             college$stock.market.return - 1,
                             '% return)')
college$stock.market.return <- NULL

alternatives <- rbind(college, data.frame(
  tuition = tuition,
  investment = 'College',
  earnings = 
)
p <- ggplot(college) +
  aes(x = tuition, y = earnings, group = factor(stock.market.return)) +
  scale_x_continuous('Cost of college (today dollars)',
    limits = c(0, 2e5), labels = dollar) +
  scale_y_continuous('Earnings (today dollars)',
    limits = c(0, 2e6), labels = dollar) +
  geom_line() +
  geom_hline(yintercept = salary.earnings, linetype = 'dotted')
