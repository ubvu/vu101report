#IMPORT DATA BASES

#load xlsx-package with functions to read, write and format Excel-files formats
require(xlsx)

#import database with results questionaire from VU-participants with:
VU101<- 
  read.xlsx2('./data/101innov.xlsx',sheetName="101innov",colClasses=c(rep("character",5),rep("double",164)))
#one participant per row
#column01="ID": unieke ID per participant, toegekend door Utrecht
#column01="role": onderzoeksrol, toegekend door ons na opschonen "research_role_ifother"
#column01="research_role": onderzoeksrol, gekozen door participant uit droplist
#column01="research_role_ifother": onderzoeksrol, vrij veld, ingevuld door participant
#column01="country": ingevuld door participant, zou allemaal Netherlands moeten staan
#column01="field": numeriek tussen 1-8, ???
#column01="ArtsHumanities": discipline, gekozen door participant
#column01="EngineeringTechnology": discipline, gekozen door participant
#column01="Law": discipline, gekozen door participant    
#column01="LifeSciences": discipline, gekozen door participant
#column01="Medicine": discipline, gekozen door participant
#column01="PhysicalSciences": discipline, gekozen door participant         
#column01="SocialSciencesEconomics": discipline, gekozen door participant
#column01="firstpub": datum van eerste publicatie, ingevuld door participant (allemaal NA)
#column01="imp_dev": ??? (allemaal NA) -> MdZ: "important developments"             
#column01="supportOA": boolean:0=ondersteund Open Access niet;1=ondersteund Open Access wel
#column01="supportOS": boolean:0=ondersteund Open Science niet;1=ondersteund Open Science wel       
#after that one tool per column; #boolean in cellen: 
#0=wordt niet gebruikt door participant; 1=wordt wel gebruikt door participant
#de kolomnamen van de tools zijn gelijk aan de waarden in de kolom "Variable.name" in de Tools-database


#import database with information about the tools used in questionaire with the following information:
Tools<- 
  read.xlsx2('./data/toollist.xlsx',sheetName="UB101",colClasses=c(rep("character",4),rep("double",8)))
#column01="Variable.name": format: tool_SUBPHASE_TOOLNAME 
#column02="Description": beschrijving zoals Utrecht die aan de tool heeft gegeven
#column03="Activity": beschrijving van de subphase zoals Utrecht die aan de tool heeft gegeven, opgenomen in column01
#column04="Tool.name": naam van de tool
#column05="UB.support": boolean: 0=wordt niet door UB ondersteund; 1= wordt wel door UB ondersteund
#column06="ACTIVEPRE": boolean: 0=wordt niet gebruikt in ??? phase; 1= wordt gebruikt in ??? phase
#column07="ACTIVEDIS": boolean: 0=wordt niet gebruikt in discovery phase; 1= wordt gebruikt in discovery phase
#column08="ACTIVEANA": boolean: 0=wordt niet gebruikt in analysis phase; 1= wordt gebruikt in analysis phase
#column09="ACTIVEWRI": boolean: 0=wordt niet gebruikt in writing phase; 1= wordt gebruikt in writing phase
#column10="ACTIVEPUB": boolean: 0=wordt niet gebruikt in publication phase; 1= wordt gebruikt in publication phase
#column11="ACTIVEOUT": boolean: 0=wordt niet gebruikt in outreach phase; 1= wordt gebruikt in outreach phase
#column12="ACTIVEASS": boolean: 0=wordt niet gebruikt in assessment phase; 1= wordt gebruikt in assessment phase  
#TOEVOEGEN: hoe deze tabel kan worden gelinkt met andere tabellen 




#import database with results questionaire from all participants from OECD countries
library("openxlsx")
All101<- read.xlsx('./data/BIG101surveydata-cleanedOECD.xlsx', sheet = 1)
#import list of IDs of vu respondents
VU.IDs<- read.table("./data/survey_cleaned_data_vu-respondent-ids.txt")
