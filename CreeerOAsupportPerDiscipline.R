#CreeerOAsupportPerDiscipline.R


OAsupport.per.discipline<- mat.or.vec(length(Disciplines),dim(VU101[,grep("support",colnames(VU101))])[2])
colnames(OAsupport.per.discipline)<- colnames(VU101[,grep("support",colnames(VU101))])
rownames(OAsupport.per.discipline)<- Disciplines
for(i in 1:length(Disciplines))
{
  tmp<-VU101[which(VU101[,Disciplines[i]]==1),grep("support",colnames(VU101))]
  OAsupport.per.discipline[i,]<- (colSums(tmp)/dim(tmp)[1])*100
}
