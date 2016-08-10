#BEWERK GEIMPORTEERDE DATABASES

#verwijder tool-kolommen met vrije tekst (te herkennen aan "other" in kolomnaam)
VU101<- VU101[,-grep("other",colnames(VU101))]


#VU101-database: selecteer alleen kolommen met toolgebruik en store in VU101.tooluse
VU101.tooluse<-VU101[,grep("tool",colnames(VU101))]
#resultaat is een database met alleen de tools die worden bevraagd in de VU-enquete
#kolommen met participanten-informatie uit de VU101 database zijn verwijderd


#Tools-database: vervang boolean 1/0 die aangeeft of tool bij bepaalde onderzoekfase hoort, met nummer voor phase, startend bij discovery-phase
for(i in 7:dim(Tools)[2])
{
  Tools[which(Tools[,i]==1),i]<-i-6
}
#voeg een kolom toe met de fase van de research cycle
#een tool wordt altijd aan slechts 1 onderzoeksfase toegekend (wordt een tool in meerdere fasen gebruikt dan komt die meerdere keren in de lijst -in de rijen- voor) dus de som van alle fasen is het fasenummer
Tools<-cbind(Tools,rowSums(Tools[,7:12]))
colnames(Tools)[dim(Tools)[2]]<-"PhaseResearchCycle"
#verwijder tools-rijen die in de VU101-database vrije tekst bevatten (deze hebben "other" in de kolomnaam)
Tools<- Tools[-grep("other",Tools[,"Variable.name"]),]


#maak een lijst van de subfasen, de "activiteiten" die binnen een onderzoeksfase
#worden onderscheiden
SubPhases<- c()
for(i in 1: dim(Tools)[1])
{
  Name.SubPhase<-strsplit(sub("tool_",'',Tools[i,'Variable.name']),'_',fixed=T)[[1]][1]
  SubPhase.and.Phase<-
    paste(PhaseResearchCycle[Tools[i,'PhaseResearchCycle']],'_',Name.SubPhase,sep='')
  SubPhases<-c(SubPhases,SubPhase.and.Phase)
}
SubPhases<-unique(SubPhases)
#sorteer SubPhases op fasen van de research cycle
Order.SubPhases<-c()
for(i in 1:length(SubPhases))
{
  Phase.i<-strsplit(SubPhases[i],'_')[[1]][1]
  Order.SubPhases<- c(Order.SubPhases,which(PhaseResearchCycle==Phase.i))
}
SubPhases<-SubPhases[order(Order.SubPhases)]


#Tools-database: voeg een kolom toe met de fase van de research cycle
#Maak hiervoor eerst een vector met daarin PhaseResearchCycle_SubPhase
Tools.SubPhase.Column<- c()
for(i in 1:dim(Tools)[1])
{
  #determine in which phase of research cycle tool i is used
  Phase.i<- PhaseResearchCycle[Tools[i,"PhaseResearchCycle"]]
  #determine in which subphase tool i is attributed to
  #remove 'tool_'
  SubPhase.and.toolname.i<- sub("tool_",'',Tools[i,"Variable.name"])
  #select everything in front of underscore
  SubPhase.i<-strsplit(SubPhase.and.toolname.i,'_')[[1]][1]
  #glue Phase and Subphase for tool i
  Phase.SubPhase.i<- paste(Phase.i,SubPhase.i,sep='_')
  #add Phase.SubPhase.i to Tools.Subphase.Column
  Tools.SubPhase.Column<- c(Tools.SubPhase.Column,Phase.SubPhase.i)
}
#Bind new vector with Phase_SubPhase to Tools
Tools<-cbind(Tools,Tools.SubPhase.Column)
#add name for new column
colnames(Tools)[dim(Tools)[2]]<- "SubPhase"


#verwijder tool-kolommen met vrije tekst (te herkennen aan "other" in kolomnaam)
All101<- All101[,-grep("other",colnames(All101))]
#verwijder tool-kolommen met language tekst (deze zijn grotendeels leeg en geven NA - te herkennen aan "lang" in kolomnaam)
All101<- All101[,-grep("lang",colnames(All101))]

##splits All101-database(OECD) in VU en non-vu
All101.nonVU<- All101[which(All101[,'ID']%in%VU.IDs[,1]==F),]
All101.VU<- All101[which(All101[,'ID']%in%VU.IDs[,1]),]
#All101-databases: selecteer alleen kolommen met toolgebruik en store in All101.X.tooluse
All101.nonVU.tooluse<-All101.nonVU[,grep("tool",colnames(All101.nonVU))]
All101.VU.tooluse<-All101.VU[,grep("tool",colnames(All101.VU))]
#resultaat is een database met alleen de tools die worden bevraagd in de VU-enquete
#kolommen met participanten-informatie uit de VU101 database zijn verwijderd
#converteer matrix naar numeric matrix
All101.nonVU.tooluse<-data.matrix(All101.nonVU.tooluse)
All101.VU.tooluse<-data.matrix(All101.VU.tooluse)
