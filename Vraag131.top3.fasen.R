#Vraag131.top3.fasen.R


win.graph(14,7)
par(mfrow=c(2,3))
for(i in 1:length(PhaseResearchCycle))
{ 
  ##PLOTS
  par(mar = c(5,8,4,2) +0.1)

  ColNames.Phase.i <- as.character(Tools[which(Tools[,"PhaseResearchCycle"]==i),"Variable.name"])
  ToolUse.Phase.i<- ToolUse.totaal[ColNames.Phase.i]
  ToolUse.Phase.i<- ToolUse.Phase.i[order(-ToolUse.Phase.i)]
  
  #set en wrap labels voor y-as
  labs <- Tools[match(as.character(names(ToolUse.Phase.i[1:3])),Tools[,"Variable.name"]),"Tool.name"]
  wr.lab <- wrap.labels(labs, 10)
  fill <- Tools[match(as.character(names(ToolUse.Phase.i[1:3])),Tools[,"Variable.name"]),"UB.support"]
  
  # plot gebruikers top 3 in horizontale bargraph 
  barplot(ToolUse.Phase.i[1:3], main=paste(PhaseResearchCycle[i]," (3 most popular)"),xlim=c(0,max(ToolUse.totaal)),
          xlab="N tool users [filled bar=available@library]",
          cex.names=0.7,cex.main=1,horiz=T,las=1,
          names.arg=wr.lab,col=Kleuren[i],density=((fill+1)^2)*20)
}


