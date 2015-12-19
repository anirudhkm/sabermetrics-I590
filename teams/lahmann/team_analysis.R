library(ggplot2)
library(plotly)
library(gridExtra)

pythagorean.formula <- function(dat)
{
  dat$wp <- with(dat, (R^2)/(R^2+RA^2))
  dat
}

team.analysis <- function(dat)
{
  
  d <- dat[dat$DivWin != "",]
  g1<-ggplot(d, aes(yearID, DivWin, col=factor(name))) + geom_point(size=3) + facet_grid(.~name) + xlab("Division winner result") + ylab("Count") + labs(title="Bar graph of Division winning result")
  # Result of winning in division league
  
  d <- dat[dat$WCWin != "",]
  g2<-ggplot(d, aes(yearID, WCWin, col=factor(name))) + geom_point(size=3) + facet_grid(.~name) + xlab("Wild card winner") + ylab("Count") + labs(title="Bar graph of Wild card winner result")
  # Result of winning in wild card
  
  d <- dat[dat$LgWin != "",]
  g3<-ggplot(d, aes(yearID, LgWin, col=factor(name))) + geom_point(size=3) + facet_grid(.~name) + xlab("League winner result") + ylab("Count") + labs(title="Bar graph of League winning result")
  # Result of winning in league
  
  d <- dat[dat$WSWin != "",]
  g4<-ggplot(d, aes(yearID, WSWin, col=factor(name))) + geom_point(size=3) + facet_grid(.~name) + xlab("World series result") + ylab("Count") + labs(title="Bar graph of World series result")
  # Result of winning in world series
  grid.arrange(g1, g2, g3, g4, ncol = 2)
  # arrange four graph in a page
  
  ggplot(dat, aes(yearID, Rank, col=factor(name))) + geom_point(size=3) + facet_grid(.~name) + xlab("Years") + ylab("Rank") + labs(title="Rank Vs years") + coord_cartesian(ylim=c(0.5,10.5)) + scale_y_continuous(breaks=seq(0,11,1))
  # rank of the teams for each year
}

winning.analysis <- function(dat)
{
  
  g1<-ggplot(dat, aes(yearID, W/L, color=factor(name))) + geom_point() + stat_smooth() + facet_grid(.~name) + xlab("Year") + ylab("Win-Loss ratio") + labs(title="Win-Loss ratio")
  print(g1)
  # win-loss ratio
  
  g1<-ggplot(dat, aes(yearID, wp, color=factor(name))) + geom_point() + stat_smooth() + facet_grid(.~name) + xlab("Year") + ylab("Winning Percentage") + labs(title="Winning percent Vs Year")
  print(g1)
  # winning percentage vs year
    
  g1<-ggplot(dat, aes(yearID, H/AB, color=factor(name))) + geom_point() + stat_smooth() + facet_grid(.~name) + xlab("Year") + ylab("HIts per Atbats") + labs(title="HIts per Atbats Vs Year")
  # Hits per atbats Vs years
  
  g2<-ggplot(dat, aes(yearID, SO/AB, color=factor(name))) + geom_point() + stat_smooth() + facet_grid(.~name) + xlab("Year") + ylab("Strikeout per Atbats") + labs(title="Strikeouts per Atbats Vs Year")
  # Strikeout per atbats Vs years
  grid.arrange(g1, g2, nrow = 2)
  
  g1<-ggplot(dat, aes(yearID, ERA, color=factor(name))) + geom_point() + stat_smooth() + facet_grid(.~name) + xlab("Year") + ylab("Earned Run Average") + labs(title="Earned Run Average Vs Year")
  print(g1)
  # winning percentage vs run differential
  
  g1<-ggplot(dat, aes(SHO, SV, color=factor(name))) + geom_point() + stat_smooth() + facet_grid(.~name) + xlab("Shut-Outs") + ylab("Save") + labs(title="Save Vs Shut-Out")
  print(g1)
  # Save Vs Shut-out
  
  g1<-ggplot(dat, aes(yearID, E, color=factor(name))) + geom_point() + stat_smooth() + facet_grid(.~name) + xlab("Year") + ylab("Fielding Errors") + labs(title="Fielding Error Vs Year")
  print(g1)
  #ggplotly()
  # winning percentage vs run differential
  
}


dat <- read.csv("Teams.csv", header = T)
dat <- dat[dat$teamID %in% c("BOS","NYA"),]
dat$name <- ifelse(dat$teamID == "BOS", "Boston Red Sox", "New York Yankees")
dat <- pythagorean.formula(dat)


team.analysis(dat)
winning.analysis(dat)