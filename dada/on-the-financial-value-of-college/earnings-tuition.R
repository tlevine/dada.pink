library(ggplot2)
library(reshape2)
library(scales)

# tuition <- c(europe = 5e4,
#              us.public = 8e4,
#              us.private = 2e5)
years.invested <- 65 - 20 # the nominal working life
stock.market.return <- 1.068 # from Greenstone & Looney, 2011

lifetime.earnings <- c(
  engineering = 2e6,
  all.majors = 1.16e6,
  early.childhood.education = 8e5
)

college <- data.frame(
  investment = 'College',
  label.x = 1.8e5,
  earnings.intercept = unname(lifetime.earnings),
  earnings.slope = 0,
  full.investment = paste0('College median\n(',
                           sub('\\.', ' ', names(lifetime.earnings)), ')')
)

not.college <- data.frame(
  investment = 'Stock market',
  stock.market.return = c(1.050, 1.065, 1.080),
  label.x = c(1.6e5, 1.4e5, 1e5),
  earnings.intercept = 0
)
not.college$earnings.slope <- not.college$stock.market.return ^ years.invested
not.college$full.investment <- paste0(
  'Stock market\n(',
  round(100 * (not.college$stock.market.return - 1), 1),
  '% annual return)')
not.college$stock.market.return <- NULL

alternatives <- rbind(college, not.college)
p <- ggplot(alternatives) +
  scale_color_manual(values = c('grey60', 'grey20'),
                     name = 'Investment type') +
  theme_minimal() +
  theme(title = element_text(face = 'bold')) +
  scale_x_continuous('Cost of college (today dollars)',
                     limits = c(5e4, 2e5), labels = dollar) +
  scale_y_continuous('Earnings (today dollars)',
                     limits = c(5e5, 4e6), labels = dollar) +
  geom_abline(aes(intercept = earnings.intercept,
                  slope = earnings.slope,
                  color = investment,
                  group = full.investment)) +
  geom_text(aes(x = label.x,
                y = earnings.intercept + earnings.slope * label.x,
                color = investment,
                vjust = -.2 - (earnings.slope / 12),
                lineheight = .8,
                label = full.investment))

p.tom <- p +
  aes(x = 1e5, y = 1.15e6) +
  geom_point(color = '#fe57a1', size = 20) +
  geom_text(color = 'white', label = 'Tom')

ppplot <- function(plot, filename) ggsave(filename = filename,
                                          plot = plot,
                                          width = 8, height = 6,
                                          units = 'in', dpi = 200)
ppplot(p + ggtitle('Predicted return on college and stock market investments'),
       'projected-earnings.png')
ppplot(p.tom +
         ggtitle("Tom's college expenses and his predicted lifetime earnings"),
       'tom.png')
