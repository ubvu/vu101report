# MainBasic.R
# 
# NB: Voordat je dit script runt ga naar "Session" en kies "Set 
# working directory" en vervolgens "to source file location".


#Laad en bewerk import data en variabelen
source(paste(getwd(),"/LaadVariabelen.R",sep=""))
source(paste(getwd(),"/ImportData.R",sep=""))
source(paste(getwd(),"/BewerkImportData.R",sep=""))

#Creeer nieuwe databases
source(paste(getwd(),"/CreeerToolUsePerDiscipline.R",sep=""))
source(paste(getwd(),"/CreeerToolUsePerDisciplineOECD.R",sep=""))
source(paste(getwd(),"/CreeerToolUsePerRole.R",sep=""))
source(paste(getwd(),"/CreeerToolUsePerTenureStatus.R",sep=""))
source(paste(getwd(),"/CreeerToolUseOECDvsVU.R",sep=""))
source(paste(getwd(),"/CreeerOAsupportPerTenureStatus.R",sep=""))
source(paste(getwd(),"/CreeerOAsupportPerDiscipline.R",sep=""))

#Laad functies
source(paste(getwd(),"/FunctionWrapAxis.R",sep=""))
source(paste(getwd(),"/FunctionPlotTable.R",sep=""))
source(paste(getwd(),"/FunctionPlotDemographics.R",sep=""))
