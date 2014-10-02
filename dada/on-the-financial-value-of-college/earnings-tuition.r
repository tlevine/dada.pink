library(ggplot2)
library(reshape2)
library(scales)

years.invested <- 65 - 20 # the nominal working life
stock.market.return <- 1.068 # from Greenstone & Looney, 2011

lifetime.earnings <- c(
  engineering = 2e6,
  all.majors = 1.19e6,
  early.childhood.education = 8e5
)

college <- data.frame(
  investment = 'College',
  label.x = 1.8e5,
  earnings.intercept = unname(lifetime.earnings),
  earnings.slope = 0,
  full.investment = paste0('College median\n(',
                           gsub('\\.', ' ', names(lifetime.earnings)), ')')
)

not.college <- data.frame(
  investment = 'Stock market',
  stock.market.return = c(1.050, 1.065),
  label.x = c(1.55e5, 1.4e5),
  earnings.intercept = 0
)
not.college$earnings.slope <- not.college$stock.market.return ^ years.invested
not.college$full.investment <- paste0(
  'Stock market\n(',
  round(100 * (not.college$stock.market.return - 1), 1),
  '% annually after inflation)')
not.college$stock.market.return <- NULL

alternatives <- rbind(college, not.college)
p.base <- ggplot(alternatives) +
  scale_color_manual(values = c('grey60', 'grey20'),
                     name = 'Investment type') +
  theme_minimal() +
  theme(title = element_text(face = 'bold'),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank()) +
  scale_x_continuous('Cost of college (today dollars)',
                     limits = c(0, 2e5), labels = dollar) +
  scale_y_continuous('Earnings (today dollars)',
                     limits = c(0, 4e6), labels = dollar)

p.predictions <- p.base +
  geom_abline(aes(intercept = earnings.intercept,
                  slope = earnings.slope,
                  color = investment,
                  group = full.investment)) +
  geom_text(aes(x = label.x,
                y = earnings.intercept + earnings.slope * label.x,
                color = investment,
                vjust = -.2 - (earnings.slope / 12),
                lineheight = .8,
                label = full.investment)) +
  ggtitle('Predicted return on college and stock market investments')

p.tom.expenses <- p.base + geom_vline(xintercept = 1e5) +
  ggtitle("Tom spent $100,000 on college.")

p.tom.predictions <- p.base + geom_hline(yintercept = 1.19e6) +
  ggtitle('Since Tom has a major in a multidisciplinary science,\nwe predict that he will earn $1.19 million in his life.')

p.tom.both <- p.base +
                geom_vline(xintercept = 1e5) +
                geom_hline(yintercept = 1.15e6) +
                aes(x = 1e5, y = 1.19e6) +
                geom_point(color = '#fe57a1', size = 20) +
                geom_text(color = 'white', label = 'Tom') +
                ggtitle("Tom's college expenses and predicted earnings.")

p.tom.comparison <- p.predictions +
  aes(x = 1e5, y = 1.19e6) +
  geom_point(color = '#fe57a1', size = 20) +
  geom_text(color = 'white', label = 'Tom') +
  ggtitle("How Tom's investment compares to alternatives")

ppplot <- function(plot, filename) ggsave(filename = filename,
                                          plot = plot,
                                          width = 8, height = 6,
                                          units = 'in', dpi = 200)
ppplot(p.predictions, 'general-predictions.png')
ppplot(p.tom.expenses, 'tom-expenses.png')
ppplot(p.tom.predictions, 'tom-predictions.png')
ppplot(p.tom.both, 'tom-both.png')
ppplot(p.tom.comparison, 'tom-comparison.png')
