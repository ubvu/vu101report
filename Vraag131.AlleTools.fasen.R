#Vraag131.top3.fasen.R


for(i in 1:length(PhaseResearchCycle))
{ 
  ColNames.Phase.i <- as.character(Tools[which(Tools[,"PhaseResearchCycle"]==i),"Variable.name"])
  ToolUse.Phase.i<- ToolUse.totaal[ColNames.Phase.i]
  ToolUse.Phase.i<- ToolUse.Phase.i[order(-ToolUse.Phase.i)]

  ##PLOTS
  win.graph(width=length(ColNames.Phase.i)/1.5,height=7)
  par(mar = c(8,8,4,2) +0.1)
  
  #set en wrap labels voor y-as
  labs <- Tools[match(as.character(names(ToolUse.Phase.i)),Tools[,"Variable.name"]),"Tool.name"]
  wr.lab <- wrap.labels(labs, 20)
  fill <- Tools[match(as.character(names(ToolUse.Phase.i)),Tools[,"Variable.name"]),"UB.support"]
  
  # plot gebruikers top 3 in horizontale bargraph 
  barplot(ToolUse.Phase.i, main=PhaseResearchCycle[i],ylim=c(0,max(ToolUse.totaal)),las=2,
          ylab="Aantal gebruikers: Top 3 van alle respondenten\n(dichte arcering=UB support)",
          cex.names=0.7,cex.main=1,names.arg=wr.lab,col=Kleuren[i],density=((fill+1)^2)*20)
}


