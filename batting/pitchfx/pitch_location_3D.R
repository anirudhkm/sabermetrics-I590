library(ggplot2)
library(plotly)

pitch_location <- function(dat, name)
{
  
  for(i in c("R","L"))
  {
    bat.dat <- dat[dat$pitcher_hand == i,]
    pitching_loc <- with(bat.dat, data.frame(a=x0,b=y0,c=z0,pitch=pitch_type,event=event))
    bat_loc <- with(bat.dat, data.frame(a=px,b=py,c=pz,pitch=pitch_type,event=event))
    trajectory <- rbind(pitching_loc, bat_loc)
    p <- with(trajectory, plot_ly(x=a, y=b, z=c, color=pitch, text=paste("Event",event),type="scatter3d",mode="markers"))
    p <- add_trace(p, x = c(0,0,0), y = c(0,50,1.4), z=c(0,8,8), text = c("Home plate","Pitchers end", "Batters end"), mode = "text", showlegend=F)
    p<-(layout(p,title=paste(name, "- Pitch location at the pitcher and batter end against", i, "handed pitcher"),xaxis=list(title="xaxis",range=c(-4,4)),yaxis=list(title="Yaxis"),zaxis=list(title="Zaxis")))
    print(p)
  }
}


dat <- read.csv("batting_data.csv", header = T)
# load the pitchers data in R

albert <- dat[dat$batter == 405395, ]
# load the data for player Albert Pujols
matt <- dat[dat$batter == 407812, ]
# load the data for the player Matt Holliday

pitch_location(albert, "Albert Pujols")
pitch_location(matt, "Matt Holliday")