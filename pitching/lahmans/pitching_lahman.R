library(ggplot2)
library(plotly)

parameters_calculation <- function(dat)
{
 
  dat$FIP = (13*dat$HR + 3*dat$BB + dat$SO)/(dat$IP)
  dat
}


runs_analysis <- function(dat)
{
  p<-with(dat, plot_ly(x=yearID, y=R, group=Name,text=paste("Games played",G)))
  print(layout(p,title="Runs given vs years", xaxis=list(title="Year"), yaxis = list(title="Runs given")))
  # plot the number of runs given
}

pitching_analysis <- function(dat)
{
  g<-ggplot(dat,aes(yearID, (R/IP))) + geom_point()+stat_smooth()+ xlab("Year") + ylab("Runs per IP") + labs(title="Runs per IP Vs Years") +facet_grid(.~Name)+theme(legend.position = "none")
  print(ggplotly(g))
  # Runs per innings pitched
  
  g<-ggplot(dat,aes(yearID, (HR/IP))) + geom_point()+stat_smooth()+ xlab("Year") + ylab("HR/IP") + labs(title="HR/IP Vs Years") +facet_grid(.~Name)+theme(legend.position = "none")
  print(ggplotly(g))
  # home run per innings pitched
  
  g<-ggplot(dat,aes(yearID, (W/G))) + geom_point() + stat_smooth()+ xlab("Year") + ylab("Win percent") + labs(title="Win percent Vs Years") +facet_grid(.~Name)+theme(legend.position = "none")
  print(ggplotly(g))
  # see the win percent ratio pattern
  
  g<-ggplot(dat,aes(yearID, (SO/BB))) + geom_point()+stat_smooth()+ xlab("Year") + ylab("SO/BB") + labs(title="Strikeout per Atbats Vs Years") +facet_grid(.~Name)+theme(legend.position = "none")
  print(ggplotly(g))
  # strikeout per atbats
  
  g<-ggplot(dat,aes(yearID, (SO/IP))) + geom_point()+stat_smooth()+ xlab("Year") + ylab("SO/IP") + labs(title="Strikeout per Inning pitched Vs Years") +facet_grid(.~Name)+theme(legend.position = "none")
  print(ggplotly(g))
  # strikeout per atbats
  
  g<-ggplot(dat,aes(yearID, BAOpp)) + geom_point()+stat_smooth()+ xlab("Year") + ylab("Opposition batting avg") + labs(title="Opposition batting avg Vs Years") +facet_grid(.~Name)+theme(legend.position = "none")
  print(ggplotly(g))
  # opposition batting average 
  
  g<-ggplot(dat,aes(yearID, ERA)) + geom_point()+stat_smooth()+ xlab("Year") + ylab("Earned run avg") + labs(title="Earned run avg Vs Years") +facet_grid(.~Name)+theme(legend.position = "none")
  print(ggplotly(g))
  # Earned run average
  
  g<-ggplot(dat,aes(yearID, FIP)) + geom_point()+stat_smooth()+ xlab("Year") + ylab("Field Independent Pitches") + labs(title="FIP Vs Years") +facet_grid(.~Name)+theme(legend.position = "none")
  print(ggplotly(g))
  # Field independent pitching
}


dat <- read.csv("Pitching.csv", header = T)
pitchers <- read.csv("pitchers.csv", header = T)
dat <- dat[dat$playerID %in% pitchers$Lahmann,]
dat$Name <- ifelse(dat$playerID == "neshepa01", "Pat Neshak", "Randy Choate")
dat <- dat[dat$yearID > 2005, ]
dat <- parameters_calculation(dat)
runs_analysis(dat)
pitching_analysis(dat)