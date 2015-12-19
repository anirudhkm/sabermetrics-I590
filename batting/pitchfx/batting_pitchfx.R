library(plotly)
library(ggplot2)

pitching.analysis <- function(dat, name)
{
  topKzone = 3.5; botKzone = 1.6; inKzone = -.95; outKzone = 0.95
  kZone = data.frame(x = c(inKzone, inKzone, outKzone, outKzone, inKzone),y = c(botKzone, topKzone, topKzone, botKzone, botKzone))
  
  title = paste("Batting effective of ", name, "against various types of pitches")
  g<-ggplot(dat, aes(event, fill = factor(pitch_type))) + geom_bar() + facet_grid(pitcher_hand~year) + labs(title=title)
  print(g)
  g<-ggplot() + geom_point(data=dat, aes(px,pz,size=4,col=factor(pitch_type))) + geom_path(aes(x, y), data = kZone, lty = 5) + facet_grid(pitcher_hand~event) + labs(title="Pitch location of various pitch types with corresponding events")
  print(g)
}


batting.data <- function(dat)
{
  event <- c("Single", "Double", "Triple", "Home Run")
  dat1 <- dat[dat$type == "X", ]
  dat1 <- dat1[dat1$event %in% event, ]
  dat1
}

out.data <- function(dat)
{
  
  out_event <- c("Lineout", "Groundout", "Flyout", "Forceout")
  dat <- dat[dat$type == "X",]
  dat <- dat[dat$event %in% out_event, ]
  dat
}

start.analysis <- function(player.data, name)
{
  g<-ggplot(player.data, aes(pitcher_hand,fill=factor(pitcher_hand))) + geom_bar() + facet_grid(.~year) + labs(title=paste(name,"- Frequency of pitches based on pitchers hand"))
  print(g)
  bat.dat <- batting.data(player.data)
  out.dat <- out.data(player.data)
  pitching.analysis(bat.dat, name)
  pitching.analysis(out.dat, name)
}

dat <- read.csv("batting_data.csv", header = T)
# load the pitchers data in R

albert <- dat[dat$batter == 405395, ]
# load the data for player Albert Pujols
matt <- dat[dat$batter == 407812, ]
# load the data for the player Matt Holliday

start.analysis(albert, "Albert Pujols")
start.analysis(matt, "Matt Holliday")
