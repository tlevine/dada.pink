library(ggplot2)
library(reshape2)
library(scales)

# tuition <- c(europe = 5e4,
#              us.public = 8e4,
#              us.private = 2e5)
tuition <- c(0, 2e5)
years.invested <- 65 - 20 # the nominal working life
stock.market.return <- 1.068 # from Greenstone & Looney, 2011

lifetime.earnings <- c(
  engineering = 2e6,
  all.majors = 1.16e6,
  early.childhood.education = 8e5
)

college <- data.frame(
  tuition = rep(tuition, length(lifetime.earnings)),
  Investment = 'College',
  full.investment = paste0('Lifetime earnings (median ',
                           sub('\\.', ' ', names(lifetime.earnings)), ')'),
  earnings = unname(lifetime.earnings)
)

not.college <- data.frame(
  tuition = rep(tuition, each = 3),
  Investment = 'Stock market'
)
not.college$stock.market.return <- c(1.050, 1.065, 1.080)
not.college$earnings <- not.college$tuition *
                        not.college$stock.market.return ^
                        years.invested
not.college$full.investment <- paste0(
  'Stock market (',
  round(100 * (not.college$stock.market.return - 1), 1),
  '% annual return)')
not.college$stock.market.return <- NULL

alternatives <- rbind(college, not.college)
p <- ggplot(alternatives) +
  aes(x = tuition, y = earnings, group = full.investment,
      linetype = Investment) +
  scale_x_continuous('Cost of college (today dollars)', labels = dollar) +
  scale_y_continuous('Earnings (today dollars)', labels = dollar) +
  geom_line()

p.tom <- p +
  geom_point(x = 1e5, y = 1.15e6, color = '#fe57a1', size = 5)
