#CreeerToolUsePerTenureStatus.R


#maak database met twee carrieregroepen (not-tenured/tenured) in rijen en tools in kolommen
ToolUse.per.TenureStatus<- mat.or.vec(length(TenureStatus),dim(VU101.tooluse)[2])
colnames(ToolUse.per.TenureStatus)<- colnames(VU101.tooluse)
rownames(ToolUse.per.TenureStatus)<- TenureStatus
# maak vector voor aantal deelnemers per carrieregroep
Participants.TenureStatus<- mat.or.vec(length(TenureStatus),0)

# vul ToolUse.per.role database met percentage gebruik van elke tool binnen non-tenured groep
VU101.Nontenured<-VU101[which(VU101[,"role"]%in%ResearchRoles[1:2]),]
VU101.Nontenured<-VU101.Nontenured[,grep("tool",colnames(VU101.Nontenured))]
ToolUse.per.TenureStatus[2,]<- (colSums(VU101.Nontenured)/dim(VU101.Nontenured)[1])*100
Participants.TenureStatus[2]<- dim(VU101.Nontenured)[1]

# vul ToolUse.per.role database met percentage gebruik van elke tool binnen tenured groep
VU101.Tenured<-VU101[which(VU101[,"role"]==ResearchRoles[3]),]
VU101.Tenured<-VU101.Tenured[,grep("tool",colnames(VU101.Tenured))]
ToolUse.per.TenureStatus[1,]<- (colSums(VU101.Tenured)/dim(VU101.Tenured)[1])*100
Participants.TenureStatus[1]<- dim(VU101.Tenured)[1]

#calculate (absolute) difference between usage in each carreergroup
Difference.in.use <- ToolUse.per.TenureStatus[1,]-ToolUse.per.TenureStatus[2,]
#add difference to ToolUse.per.TenureStatus-database
ToolUse.per.TenureStatus<- rbind(ToolUse.per.TenureStatus,Difference.in.use)
#sort ToolUse.per.TenureStatus by (absolute) difference
ToolUse.per.TenureStatus<- ToolUse.per.TenureStatus[,order(-ToolUse.per.TenureStatus[3,])]
