#Vraag211.top1.tabel.R

#construct matrix voor output meest gebruikte tool in tabelvorm
top1.discipline <- mat.or.vec(length(Disciplines), length(PhaseResearchCycle))
colnames(top1.discipline) <- PhaseResearchCycle
rownames(top1.discipline) <- Disciplines
#vul top1.discipline met meest gebruikte tool per discipline per researchphase

for(i in 1:length(PhaseResearchCycle))
{ 
  #select all tools from phase i
  ToolUse.Phase.i<-ToolUse.per.discipline[,as.character(Tools[which(Tools[,"PhaseResearchCycle"]==i),"Variable.name"])]
  for(j in 1:length(Disciplines))
  { 
    #sorteer gebruik tools phase i in discipline j
    ToolUse.Phasei.Disciplinej<- ToolUse.Phase.i[j,order(-ToolUse.Phase.i[j,])]
    #zet naam meest gebruikte tool in top1.discipline cell [j,i]
    Name.Most.Used<- Tools[match(as.character(names(ToolUse.Phasei.Disciplinej[1])),Tools[,"Variable.name"]),"Tool.name"]
    top1.discipline[j,i]<- as.character(Name.Most.Used)
  }
}
  

colors <- matrix(Kleuren,nrow=length(Disciplines),ncol=length(PhaseResearchCycle))

win.graph(14,7)
par(mar=c(0,0,1,0))
plot_table(top1.discipline, Kleuren, "gray",main="Most popular tool in a research phase for a discipline", text.cex=0.8)


