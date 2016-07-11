#CreeerToolUsePerDiscipline.R


#create matrix with tool use per discipline (in rows) for each tool (in columns)
ToolUse.per.discipline<-mat.or.vec(length(Disciplines),dim(VU101.tooluse)[2])
rownames(ToolUse.per.discipline)<- Disciplines
colnames(ToolUse.per.discipline)<- colnames(VU101.tooluse)
for(j in 1:7)
{ 
  #selecteer alle participanten van discipline [j]
  VU101.discipline<- VU101[which(VU101[,Disciplines[j]]==1),grep("tool",colnames(VU101))]
  #bereken het gebruik van elke tool door participanten van die discipline
  ToolUse.per.discipline[j,]<- colSums(VU101.discipline)
}
#voeg nog een regel toe met het totale gebruik aan de VU
ToolUse.totaal<- colSums(VU101.tooluse)
ToolUse.per.discipline<- rbind(ToolUse.per.discipline,ToolUse.totaal)
rownames(ToolUse.per.discipline)[dim(ToolUse.per.discipline)[1]]<- "totaal.VU"



respondenten.per.discipline<- mat.or.vec(length(Disciplines),0)
# vul use.per.discipline database met aantal respondenten uit die discipline
for(i in 1:length(Disciplines))
{
  respondenten.discipline.i<-VU101[which(VU101[,Disciplines[i]]==1),]
  aantal.discipline.i<- dim(respondenten.discipline.i)[1]
  respondenten.per.discipline[i]<- aantal.discipline.i
}
names(respondenten.per.discipline) <- Disciplines



