library(plotly)
library(ggplot2)

parameters_calculation <- function(dat)
{
  OBP = (dat$H+dat$BB+dat$HBP)/(dat$AB+dat$BB+dat$HBP+dat$SF)
  dat$OBP = OBP
  # Calculcate on base slugging
  
  SLG = (dat$H + 2*dat$X2B + 3*dat$X3B + 4*dat$HR)/(dat$AB)
  dat$SLG = SLG
  # Calculate slugging average
  dat
}

runs_analysis <- function(dat)
{
  p<-with(dat, plot_ly(x=yearID, y=R, group=Name,text=paste("Games played",G)))
  p1 <- (layout(p,title="Runs vs years", xaxis=list(title="Year"), yaxis = list(title="Runs")))
  print(p1)
  # plot the number of runs scored
  
  p<-with(dat, plot_ly(x=yearID, y=RBI, group=Name,text=paste("Games played",G)))
  p2 <- (layout(p,title="RBI vs years", xaxis=list(title="Year"), yaxis = list(title="RBI")))
  print(p2)
  # plot the number of runs scored
  
  p<-plot_ly(dat, x = AB, y = Name,mode = "markers", color = X2B, size = X2B, opacity = X2B,text=paste("Year",yearID))
  p3 <- (layout(p,title="Correlation of doubles with atbats", xaxis=list(title="Atbats"), yaxis = list(title="Player")))
  print(p3)
  # see the no of the doubles per runs scored trend
  
  p<-plot_ly(dat, x = AB, y = Name,mode = "markers", color = X3B, size = X3B, opacity = X3B,text=paste("Year",yearID))
  p4<-(layout(p,title="Correlation of triples with atbats", xaxis=list(title="Atbats"), yaxis = list(title="Player")))
  print(p4)
  # see the no of the doubles per runs scored trend
  
}

batting_analysis <- function(dat)
{
  g<-ggplot(dat,aes(yearID, (H/AB))) + geom_point()+stat_smooth()+ xlab("Year") + ylab("Batting Average") + labs(title="Batting Average Vs Years") +facet_grid(.~Name, scales="free")+theme(legend.position = "none")
  g1<-(ggplotly(g))
  print(g1)
  # see the batting average trend for players
  
  g<-ggplot(dat,aes(yearID, (HR/AB))) + geom_point()+stat_smooth()+ xlab("Year") + ylab("Home run per atbats") + labs(title="Home run per atbats Vs Years") +facet_grid(.~Name, scales="free")+theme(legend.position = "none")
  g2<-(ggplotly(g))
  print(g2)
  # see the home run per atbats for players
  
  g<-ggplot(dat,aes(yearID, SO/AB)) + geom_point()+stat_smooth()+ xlab("Year") + ylab("Strikeout per atbats") + labs(title="Strikeout per atbats Vs Years") +facet_grid(.~Name, scales="free")+theme(legend.position = "none")
  g3<-(ggplotly(g))
  print(g3)
  # see the on base slugging trend for players
  
  g<-ggplot(dat,aes(yearID, (HR/AB)/(SO/AB))) + geom_point()+stat_smooth()+ xlab("Homerun per At bat") + ylab("Strikeout per atbats") + labs(title="Correlation between Home run and Atbat") +facet_grid(.~Name, scales="free")+theme(legend.position = "none")
  g4<-(ggplotly(g))
  print(g4)
  # Correlation between home run and atbats
  
  g<-ggplot(dat,aes(OBP, SLG)) + geom_point()+stat_smooth()+ xlab("On base percentage") + ylab("Slugging percentage") + labs(title="Slugging percentage Vs On base percentage") +facet_grid(.~Name, scales="free")+theme(legend.position = "none")
  g5<-(ggplotly(g))
  print(g5)
  # OBP-SLG graph
  
  g<-ggplot(dat,aes(yearID, SB/(SB+CS))) + geom_point()+stat_smooth()+ xlab("Year") + ylab("Stolen base percent") + labs(title="Stolen base percent Vs Years") +facet_grid(.~Name, scales="free")+theme(legend.position = "none")
  g6<-(ggplotly(g))
  print(g6)
  # see the on base slugging trend for players
  
}

dat <- read.csv("Batting.csv", header = T)
bat <- read.csv("batters.csv", header = T)
dat <- dat[dat$playerID %in% bat$Lahmann, ]
dat$Name <- ifelse(dat$playerID == "hollima01", "Matt Holliday", "Albert Pujols")

dat <- parameters_calculation(dat)
# function call
runs_analysis(dat)
batting_analysis(dat)
