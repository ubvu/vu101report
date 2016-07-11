#CreeerOAsupportOECDvsVU.R


#create matrix with tool use per discipline (in rows) for each tool (in columns)
ToolUse.OECDvsVU<-mat.or.vec(2,dim(All101.nonVU.tooluse)[2])
rownames(ToolUse.OECDvsVU)<- c("OECD","VU")
colnames(ToolUse.OECDvsVU)<- colnames(All101.nonVU.tooluse)
#bereken het gebruik van elke tool in OECD-landen (excl. VU) en aan de VU
ToolUse.OECDvsVU[1,]<- colSums(All101.nonVU.tooluse)
ToolUse.OECDvsVU[2,]<- colSums(All101.VU.tooluse)


# vul use.per.discipline database met aantal respondenten uit die discipline
respondenten.OECDvsVU<- c(dim(All101.nonVU)[1],dim(All101.VU)[1])
names(respondenten.per.discipline) <- rownames(ToolUse.OECDvsVU)

