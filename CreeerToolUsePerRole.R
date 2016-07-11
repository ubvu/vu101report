#CreeerToolUsePerRole.R


#maak database met carrieregroep in rijen en tool-gebruik in kolommen
ToolUse.per.role<- mat.or.vec(length(ResearchRoles),dim(VU101.tooluse)[2])
colnames(ToolUse.per.role)<- colnames(VU101.tooluse)
rownames(ToolUse.per.role)<- ResearchRoles
# maak vector voor aantal deelnemers per carrieregroep
Participants.per.role<- mat.or.vec(length(ResearchRoles),0)
# vul ToolUse.per.role database met percentage gebruik van elke tool binnen elke carrieregroep
for(i in 1:length(ResearchRoles))
{
  #selecteer alle participanten met role[i]
  VU101.role<-VU101[which(VU101[,"role"]==ResearchRoles[i]),]
  #selecteer alleen kolommen met informatie over tools
  VU101.role<-VU101.role[,grep("tool",colnames(VU101.role))]
  #bereken het percentage gebruik voor elke tool in role[i]
  ToolUse.per.role[i,]<- (colSums(VU101.role)/dim(VU101.role)[1])*100
  #bewaar het aantal participanten per rol
  Participants.per.role[i]<- dim(VU101.role)[1]
}


respondenten.per.rol<- mat.or.vec(length(roles),0)
# vul use.per.role database met percentage gebruik van elke tool binnen elke carrieregroep
for(i in 1:length(roles))
{
  respondenten.rol.i<-VU101[which(VU101[,"role"]==roles[i]),"role"]
  aantal.rol.i<- length(respondenten.rol.i)
  respondenten.per.rol[i]<- aantal.rol.i
}
names(respondenten.per.rol) <- roles
