# Main.R
#
# NB: Voordat je dit script runt ga naar "Session" en kies "Set
# working directory" en vervolgens "to source file location".


#Laad alle essentiele onderdelen
source("MainBasic.R")

# Basis gegevens
# aantallen: respondenten wereld wijd, aantal VU, aantal per discipline van de VU, aantalen Carriere groepen uitgebreid, aantaal tenure / non-tenture.
# aantallen ad: aantal WP bij de uVU en VUmc in 2015/2014, aantallen per faculteit, discipline aanduiding per faculteit.



# Vraag 1.1.1
# Tool usage difference between non-tenured and tenured researchers
source(paste(getwd(),"/Vraag111.top2.fasen.R",sep=""))
source(paste(getwd(),"/Vraag111.top2.subfasen.R",sep=""))
source(paste(getwd(),"/Vraag111.AlleTools.fasen.R",sep=""))
source(paste(getwd(),"/Vraag111.AlleTools.subfasen.R",sep=""))
# [comment maurice 2016-06-17] blanco bars arceren, ziet er denk ik net even beter uit.
# [comment marijet 2016-06-21] gedaan

#Vraag 1.3.1
# Popular tools vs Library supported
source(paste(getwd(),"/Vraag131.top3.fasen.R",sep=""))
source(paste(getwd(),"/Vraag131.top3.subfasen.R",sep=""))
# [comment maurice 2016-06-22] zullen we hier ook niet alle tools laten zien? ik ben bijv benieuwd naar ORCID.
source("./Vraag131.AlleTools.subfasen.R")

#Vraag 1.3.2
# bij welke tools zie je een groot verschil tussen de VU en de rest van; Nederland, Europa, en de Wereld?
# [comment maurice 2016-06-17] het is interessant voor ons om te weten hoe we ons verhouden tot andere OECD landen.
# Er is een data set gemaakt met de OECD landen. en er is een dataset gemaakt met de UUID's van de VU en VUmc respondenten.
# in VU-improved/data mapje : inladen van de grote dataset, kolom OECD landen toevoegen (TRUE/FALSE), kolom VU en VUmc responenten toevoegen (TRUE/FALSE)
# plot maken met verschil uitersten: tool per subfasen, gearceerde bar = %VU, volle bar = %OECD. N vermelden.
#   Links tools met grootste posifieve verschil VU-EOCD, Rechts met grootste negatieve verschil VU-OECD
# eerst vor alle tools , per subfase.
# later de twee uitersten.
# [comment marjet 2016-06-21] deze plots kan ik nog niet maken. In de file staan op dit moment nog strings bij toolgebruik
# en niet 0/1 voor niet/wel gebruikt. Als deze is omgezet kan ik er mee aan de slag.
# [comment maurice 2016-06-22] welke file is dat? Oh. die van de UU... hmm. is dat niet eenvoudig zelf te vertalen? if value is "", then 0, else 1.
# ###
# Overzicht op wereldkaart: top 1 per land voor elke fase. plot op kaartje...
#
# https://developers.google.com/chart/interactive/docs/gallery/geochart#overview
# Tool usage difference between non-tenured and tenured researchers
source(paste(getwd(),"/Vraag132.AlleTools.subfasen.R",sep=""))

#Vraag2.1.1
# Welke tools worden gebruikt binnen mijn discipline per fase van het onderzoek?
# Wat zijn de frequenties: Wat is de top 1 en 3?
# Hoe is het toolgebruik verdeeld? (standaard afwijking; 10 de ne 90ste percentiel)
source(paste(getwd(),"/Vraag211.top1.tabel.R",sep=""))
source(paste(getwd(),"/Vraag211.AllDisciplines.subfasen.R",sep=""))
# [comment maurice 2016-06-23] Normaliseren: Lora Aroy gaf mee om deze aantallen relatief te maken per discipline,
# omdat het anders lijk dat in de medicine iets meer wordt gebruikt,
# maar daar hebben gewoon meer mensen de survey ingevuld.

source(paste(getwd(),"/Vraag211.PerDiscipline.subfasen.R",sep=""))
# [comment maurice 2016-06-17] ik merk dat het per discipline heel goed werkt om die losse grafieken te hebben, om een rapport per discipline op te leveren.
# daarnaast merk ik toch dat ik behoefte heb aan een overzicht, waarin je kan zien wat het toolgebruik is aan de VU, en hoezich dat per discipline verhoudt. Dus toch die gestapelde bars.
# beslten om de bars van discioe per tool naast elkaar te zetten.
# [comment marjet 2016-06-21] plot met bars van disciplines naast elkaar in script Vraag211.AllDisciplines.subfasen.R hierboven
# ik heb voor nu even de legenda op de y-as gezet. Die moet later nog in het bijschrift komen
# ik heb de kleuren gebaseerd op de kleuren van de fases + grijs. Dit kan altijd anders

# [comment maruice 2016-06-27] een losse legenda voor discipline en fases.


#Vraag2.2.2
# intention of Open Science
# Wat zijn de verschillen tussen de carri�re rollen in de mate waarin Open Science en Open Access gesteund wordt? En per discipline.
source(paste(getwd(),"/Vraag222.OAsupport.R",sep=""))
# [comment maurice 2016-06-17] Een plot erbij OS support per discipline.
# [comment marjet 2016-06-21] Klaar (hieronder)
source(paste(getwd(),"/Vraag222.OAsupport.per.discipline.R",sep=""))
# Dit is de intentie van OS


#Vraag 2.2.3:
# Proof of Open Science; translated into the actual usage of Open Science tools.
# vervolg: Zie je de mate van Open-Science-ondersteuning ook terug in de keuze van het type tool?
# [comment marjet 2016-06-21] ik denk dat je hier in de problemen komt met de groepsgrootte (zie hieronder).
# groep   geen OA support geen OS support
# Phd     42              81
# Postdocs09              19
# Profs   33              56

# Arts    09              14
# Eng     03              05
# Law     06              08
# Life    14              38
# Med     24              59
# Phys    09              08
# Soc     31              54
# Tenzij je het voor de totale groep van respondenten wilt bekijken: geen OA support (88/515), geen OS support (157/515)
# Dit is het bewijs van OS



#Shankey diagram
# https://en.wikipedia.org/wiki/Sankey_diagram
# Volg de subfasen van discovery_search tot assessment_impact en bekijk het vervolg in gebruik van elke tool.
# als hoeveel mensen / wat is de kans dat mensen gebruiken adobe reader ( in discovery_read) , als ze daarvoor Web of Science gebruiken (discovery_search)
#
# Met RAW is dit eenvoudig te maken door het inladen van een csv
# http://app.raw.densitydesign.org/
# output naar svg, png en json
#
# Andere Shankey diagram apps:
# moeten dan zelf de json aanleveren, ipv een csv.
# http://sankey-diagram-generator.acquireprocure.com/
# https://developers.google.com/chart/interactive/docs/gallery/sankey
