library(ggplot2)
library(reshape2)

# tuition <- c(europe = 5e4,
#              us.public = 8e4,
#              us.private = 2e5)
tuition <- seq(5e4, 2e5, 5e4)
years.invested <- 65 - 20 # the nominal working life
stock.market.return <- 1.068 # from Greenstone & Looney, 2011
tuition.earnings <- tuition * stock.market.return ^ years.invested

investments <- data.frame(
  tuition = tuition,
  tuition.earnings = tuition.earnings,
  salary.earnings = 1.16e6
)

ggplot(investments) +
  aes(x = 
