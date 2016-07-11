#Vraag111.AlleTools.fasen.R


for(i in 1:length(PhaseResearchCycle))
{ 
  #Set plot margins
  win.graph(14,7)
  par(mar = c(8,6,4,1) +0.1)
  #select all tools from phase i
  ToolUse.Phase.i<-ToolUse.per.TenureStatus[,as.character(Tools[which(Tools[,"PhaseResearchCycle"]==i),"Variable.name"])]
  #sort tools from ToolUse.Phase.i by difference in tooluse between tenure-groups
  ToolUse.Phase.i<-ToolUse.Phase.i[,order(ToolUse.Phase.i[3,])]
  #define axis labels
  labs <- Tools[match(as.character(colnames(ToolUse.Phase.i)),Tools[,"Variable.name"]),"Tool.name"]
  wr.lab <- wrap.labels(labs, 15)
  #plot
  barplot(ToolUse.Phase.i[1:2,],beside=TRUE,main=PhaseResearchCycle[i],
    ylim=c(0,max(ToolUse.per.TenureStatus[1:2,])),
    names.arg=wr.lab,las=3,cex.names=0.7,col=rep(Kleuren[i],2),density=c(20,1000),
    ylab="percentage gebruikers in tenured (gekleurde bars)\n en non-tenured (open bars) groep")
}
