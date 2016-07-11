#Vraag111.top2.subfasen.R


#Plot grafieken met gebruik door tenured en non-ternued gebruikers voor top 2 tools in (totaal) gebruik per SUBfase van de research cycle

#Plot figuur met overal top 2 voor elke fase van de research cycle
for(i in 1:length(PhaseResearchCycle))
{ 
  #selecteer SubPhases behoorden bij PhaseResearchCyclie[i]
  SubPhases.Phase.i<-SubPhases[grep(PhaseResearchCycle[i],SubPhases)]
  n.rows<-ceiling(length(SubPhases.Phase.i)/2)
  win.graph(8,n.rows*4)
  par(mfrow=c(n.rows,2))
  for(j in 1:length(SubPhases.Phase.i))
  {
    #prepare layout panel of graphs
    par(mar = c(4,5,3,1) +0.1)
    #selecteer kolommen/tools uit fase[i] van de research cycle
    ColNames.SubPhase.j <- as.character(Tools[which(Tools[,"SubPhase"]==SubPhases.Phase.i[j]),"Variable.name"])
    #
    SubPhase.j<-ToolUse.per.TenureStatus[,ColNames.SubPhase.j]
    
    #selecteer de tool met het grootste negatieve verschil tussen de tenure groepen
    Tool.min.difference<-SubPhase.j[,which(SubPhase.j[3,]==min(SubPhase.j[3,]))]
    Name.Tool.min.difference<-names(which(SubPhase.j[3,]==min(SubPhase.j[3,])))
    #selecteer de tool met het grootste positieve verschil tussen de tenure groepen
    Tool.max.difference<-SubPhase.j[,which(SubPhase.j[3,]==max(SubPhase.j[3,]))]
    Name.Tool.max.difference<-names(which(SubPhase.j[3,]==max(SubPhase.j[3,])))
    #zet data van tools met grootste verschil in 1 matrix
    Extreme.differences<- cbind(Tool.min.difference,Tool.max.difference)
    #geef kolommen de juiste toolnaam
    colnames(Extreme.differences) <- c(Name.Tool.min.difference,Name.Tool.max.difference)
    
    #set en wrap labels voor y-as
    labs <- Tools[match(as.character(colnames(Extreme.differences)),Tools[,"Variable.name"]),"Tool.name"]
    wr.lab <- wrap.labels(labs, 10)
    
    #plot data Extreme.differences en gebruik hierboven gedefinieerde labelnamen 
    barplot(Extreme.differences[1:2,],beside=TRUE,horiz=T,main=SubPhases.Phase.i[j],
        names.arg=wr.lab,las=1,cex.names=0.7,col=rep(Kleuren[i],2),density=c(20,1000),
        xlim=c(0,max(ToolUse.per.TenureStatus[1:2,])),cex.lab=if(n.rows==1){0.8},
        xlab="percentage gebruikers in tenured (gekleurde bars)\n en non-tenured (open bars) groep")
  }
}
