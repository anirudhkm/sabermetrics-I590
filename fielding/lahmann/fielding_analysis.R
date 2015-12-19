library(plotly)
library(ggplot2)

fielding_analysis <- function(dat)
{
  g<-ggplot(dat, aes(yearID, PO)) + geom_bar(stat="identity") + facet_grid(Name~POS) + ylab("Number of putouts") + labs(title="Number of putouts vs years across various positions")
  g<-ggplotly()
  print(g)
  # putout analysis for various players
  
  g<- ggplot(dat, aes(yearID, E/(E+A))) + geom_point() + geom_line() +facet_grid(Name~POS) + ylab("Error percentage") + labs(title="Error percent vs years across various positions")
  g<-ggplotly()
  print(g)
  # analysis the error percent
  
  g<- ggplot(dat, aes(yearID, DP)) + geom_bar(stat="identity") +facet_grid(Name~POS) + ylab("Number of Double play") + labs(title="Double play vs years across various positions")
  g<-ggplotly()
  print(g)
  # analysis the double play
}


dat <- read.csv("Fielding.csv", header = T)
dat <- dat[dat$playerID %in% c("pujolal01", "hollima01"),]
dat$Name <- ifelse(dat$playerID == "pujolal01", "Albert Pujols", "Matt Holliday")

fielding_analysis(dat)