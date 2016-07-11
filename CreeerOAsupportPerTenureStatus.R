#CreeerOAsupportPerTenureStatus.R


support.per.role<- mat.or.vec(length(roles),dim(VU101[,grep("support",colnames(VU101))])[2])
colnames(support.per.role)<- colnames(VU101[,grep("support",colnames(VU101))])
rownames(support.per.role)<- c("PhD student","Postdoc","Professoren","Librarian")
for(i in 1:length(roles))
{
  tmp<-VU101[which(VU101[,"role"]==roles[i]),grep("support",colnames(VU101))]
  support.per.role[i,]<- (colSums(tmp)/dim(tmp)[1])*100
}
