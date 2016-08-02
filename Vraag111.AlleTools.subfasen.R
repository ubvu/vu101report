

for(i in 1:length(PhaseResearchCycle))
{ 
  # Print heading
  par(mar = c(6,6,4,1) +0.1)
  #selecteer SubPhases behoorden bij PhaseResearchCyclie[i]
  SubPhases.Phase.i<-SubPhases[grep(PhaseResearchCycle[i],SubPhases)]
  n.rows<-ceiling(length(SubPhases.Phase.i)/2)
  win.graph(14,n.rows*4)
  par(mfrow=c(n.rows,2))
  for(j in 1:length(SubPhases.Phase.i))
  {
    par(mar = c(6,6,4,1) +0.1)
    #selecteer kolommen/tools uit fase[i] van de research cycle
    ColNames.SubPhase.j <- as.character(Tools[which(Tools[,"SubPhase"]==SubPhases.Phase.i[j]),"Variable.name"])
    #selecteer tools van subphase j uit phase i in ToolUse.per.TenureStatus
    ToolUse.Subphase.j<-ToolUse.per.TenureStatus[,ColNames.SubPhase.j]
    
    #sort tools from ToolUse.Subphase.j by difference in tooluse between tenure-groups
    ToolUse.Subphase.j<-ToolUse.Subphase.j[,order(-ToolUse.Subphase.j[3,])]
    #define axis labels
    labs <- Tools[match(as.character(colnames(ToolUse.Subphase.j)),Tools[,"Variable.name"]),"Tool.name"]
    wr.lab <- wrap.labels(labs, 10)
    #plot
    barplot(ToolUse.Subphase.j[1:2,],beside=TRUE,main=SubPhases.Phase.i[j],
            names.arg=wr.lab,las=3,cex.names=0.7,col=rep(Kleuren[i],2),density=c(1000,20),
            ylim=c(0,max(ToolUse.per.TenureStatus[1:2,])),cex.lab=if(n.rows==1){0.8},
            ylab="[filled bars: tenured] \n [hatched bars: non-tenured] \n % tool users")
  }
}
