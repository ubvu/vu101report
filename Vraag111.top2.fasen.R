#Vraag111.top2.fasen.R

# ---- PlotTop2Fasen ----

#Plot grafieken met gebruik door tenured en non-tenured gebruikers voor top 2 tools in (totaal) gebruik per fase van de research cycle

#prepare layout panel of graphs
win.graph(15,8)
par(mfrow=c(2,3))
par(mar = c(4,4,3,1) +0.1)
#Plot figuur met overal top 2 voor elke fase van de research cycle
for(i in 1:length(PhaseResearchCycle))
{ 
  #selecteer kolommen/tools uit fase[i] van de research cycle
  ColNames.Phase.i <- as.character(Tools[which(Tools[,"PhaseResearchCycle"]==i),"Variable.name"])
  #
  PhaseResearchCycle.i<-ToolUse.per.TenureStatus[,ColNames.Phase.i]
  
  #selecteer de tool met het grootste negatieve verschil tussen de tenure groepen
  Tool.min.difference<-PhaseResearchCycle.i[,which(PhaseResearchCycle.i[3,]==min(PhaseResearchCycle.i[3,]))]
  Name.Tool.min.difference<-names(which(PhaseResearchCycle.i[3,]==min(PhaseResearchCycle.i[3,])))
  #selecteer de tool met het grootste positieve verschil tussen de tenure groepen
  Tool.max.difference<-PhaseResearchCycle.i[,which(PhaseResearchCycle.i[3,]==max(PhaseResearchCycle.i[3,]))]
  Name.Tool.max.difference<-names(which(PhaseResearchCycle.i[3,]==max(PhaseResearchCycle.i[3,])))
  #zet data van tools met grootste verschil in 1 matrix
  Extreme.differences<- cbind(Tool.min.difference,Tool.max.difference)
  #geef kolommen de juiste toolnaam
  colnames(Extreme.differences) <- c(Name.Tool.min.difference,Name.Tool.max.difference)
  
  #set en wrap labels voor y-as
  labs <- Tools[match(as.character(colnames(Extreme.differences)),Tools[,"Variable.name"]),"Tool.name"]
  wr.lab <- wrap.labels(labs, 10)
  
  #plot data Extreme.differences en gebruik hierboven gedefinieerde labelnamen 
  barplot(Extreme.differences[1:2,],beside=TRUE,horiz=T,main=PhaseResearchCycle[i],
          names.arg=wr.lab,las=1,cex.names=0.7,col=rep(Kleuren[i],2),density=c(1000,20),
          xlim=c(0,max(ToolUse.per.TenureStatus[1:2,])),
    xlab="% tool users [hatched bars: non-tenured] \n [filled bars: tenured]")
}
