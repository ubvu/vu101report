#CreeerToolUsePerDiscipline.R


#create matrix with tool use per discipline (in rows) for each tool (in columns)
ToolUse.per.discipline.OECD<-mat.or.vec(length(Disciplines),dim(All101.nonVU.tooluse)[2])
rownames(ToolUse.per.discipline.OECD)<- Disciplines
colnames(ToolUse.per.discipline.OECD)<- colnames(All101.nonVU.tooluse)
for(j in 1:length(Disciplines))
{ 
  #selecteer alle participanten van discipline [j]
  All101.discipline<- All101.nonVU[which(All101.nonVU[,Disciplines[j]]==1),grep("tool",colnames(All101.nonVU))]
  #bereken het gebruik van elke tool door participanten van die discipline
  ToolUse.per.discipline.OECD[j,]<- colSums(All101.discipline)
}
#voeg nog een regel toe met het totale gebruik aan de VU
ToolUse.totaal.OECD<- colSums(All101.nonVU.tooluse)
ToolUse.per.discipline.OECD<- rbind(ToolUse.per.discipline.OECD,ToolUse.totaal.OECD)
rownames(ToolUse.per.discipline.OECD)[dim(ToolUse.per.discipline.OECD)[1]]<- "totaal.OECD"



respondenten.per.discipline.OECD<- mat.or.vec(length(Disciplines),0)
# vul use.per.discipline database met aantal respondenten uit die discipline
for(i in 1:length(Disciplines))
{
  respondenten.discipline.i<-All101.nonVU[which(All101.nonVU[,Disciplines[i]]==1),]
  aantal.discipline.i<- dim(respondenten.discipline.i)[1]
  respondenten.per.discipline.OECD[i]<- aantal.discipline.i
}
names(respondenten.per.discipline.OECD) <- Disciplines



