/*
101 Innovations
===============
 - Cleaning the raw survey data
 - export as Stata file and csv file
*/

if c(os)=="MacOSX"	{
	cd "/Volumes/HDD/SURFdrive/UBVU/101 Innovations/101-Innovations/"
}
else	{
	cd "C:/Users/mzn203/surfdrive/UBVU/101 Innovations/101-Innovations/"
}

// ===================================== Prepare cleaned free entries file =====
// =============================================================================
insheet using "VU101innovations-cleaned-free-text-joined-rows.csv", ///
	clear names delim(",")

rename v1 ID
drop if mi(ID)

ds, has(varlabel "Please specify*")
local keeplist `r(varlist)'
d `keeplist', f

keep ID `keeplist'

rename pleasespecifytheothertoolsthatyo tool_search_other2
lab var tool_search_other "Search literature: other"

rename pleasespecifytheothertoolswaysth tool_access_other2
lab var tool_access_other "Access to literature: other"

rename v39 tool_alert_other2
lab var tool_alert_other "Get alerts: other"

rename v48 tool_read_other2
lab var tool_read_other "Read/view/annotate: other"

rename v57 tool_analysis_other2
lab var tool_analysis_other "Analyze data: other"

rename v66 tool_share_other2
lab var tool_share_other "Share protocols: other"

rename v75 tool_write_other2
lab var tool_write_other "Write manuscript: other"

rename v84 tool_ref_other2
lab var tool_ref_other "Reference management: other"

rename v93 tool_archpub_other2
lab var tool_archpub_other "Archive publications: other"

rename v102 tool_archcode_other2
lab var tool_archcode_other "Archive code: other"

rename v111 tool_submit_other2
lab var tool_submit_other "Where to submit: other"

rename v120 tool_pub_other2
lab var tool_pub_other "Publication channel: other"

rename v129 tool_archpres_other2
lab var tool_archpres_other "Archive presentations: other"

rename v138 tool_pop_other2
lab var tool_pop_other "Popular communication: other"

rename pleasespecifytheotherresearcherp tool_profile_other2
lab var tool_profile_other2 "Researcher profile: other"

rename v156 tool_review_other2
lab var tool_review_other "Peer review: other"

rename v165 tool_impact_other2
lab var tool_impact_other "Measure impact: other"

qui ds *_other2
foreach vv of varlist `r(varlist)'	{
	split `vv', parse(",")
}

order *, seq

compress
tempfile free_entry
save `free_entry'

// ========================================================= Demographics =====
// =============================================================================
import excel using "Survey 101 innovations VU.xlsx", sheet("dataset") firstrow clear

rename A ID
drop if mi(ID)

rename Whatisyourresearchrole research_role
lab var research_role "Q1: What is your research role?"

rename Pleasefillinyourresearchrol* research_role_ifother
lab var research_role_ifother "Q2: What is your research role? (if Q1=other)"

// In <research_role_ifother> staat een aantal rollen die voor onze bedoelingen (denk ik)
// wel tot de standaard rollen behoren
gen role=research_role
lab var role "What is your research_role? (cleaned)"
replace role="PhD student" if inlist(research_role_ifother, "Pulmonologist - PhD researcher", ///
	"Researcher (perhaps PhD student in the future)", "Junior onderzoeker", "Junior Researcher", ///
	"Assistant researcher")
replace role="Postdoc" if inlist(research_role_ifother, "researcher (with PhD, but not as a postdoc)")

rename Whatisthecountryofyourcurr* country
lab var country "Q3: What is the country of your current or last affiliation?"

replace PhysicalSciences="1" if PhysicalSciences=="Physical Sciences"
replace PhysicalSciences="0" if mi(PhysicalSciences)
destring PhysicalSciences, replace

replace  EngineeringTechnology ="1" if  EngineeringTechnology =="Engineering & Technology"
replace  EngineeringTechnology ="0" if  mi(EngineeringTechnology)
destring EngineeringTechnology, replace

replace LifeSciences="1" if LifeSciences=="Life Sciences"
replace LifeSciences="0" if mi(LifeSciences)
destring LifeSciences, replace

replace Medicine="1" if Medicine=="Medicine"
replace Medicine="0" if mi(Medicine)
destring Medicine, replace

replace SocialSciencesEconomics ="1" if SocialSciencesEconomics =="Social Sciences & Economics"
replace SocialSciencesEconomics ="0" if mi(SocialSciencesEconomics)
destring SocialSciencesEconomics, replace

replace Law ="1" if Law =="Law"
replace Law ="0" if mi(Law)
destring Law, replace

replace ArtsHumanities ="1" if ArtsHumanities =="Arts & Humanities"
replace ArtsHumanities ="0" if mi(ArtsHumanities)
destring ArtsHumanities, replace

local fields PhysicalSciences EngineeringTechnology LifeSciences ///
	Medicine SocialSciencesEconomics Law ArtsHumanities
foreach ff of local fields	{
	assert inlist(`ff',0,1)
}

cap drop nfields
egen nfields=rowtotal(`fields')
lab var nfields "Number of fields"

cap drop field
gen field=.
lab var field "Research Field"
lab def field 1 "Physical Sciences", replace
lab def field 2 "Engineering & Technology", add
lab def field 3 "Life Sciences", add
lab def field 4 "Medicine", add
lab def field 5 "Social Sciences and Economics", add
lab def field 6 "Law", add
lab def field 7 "arts and Humanities", add
lab def field 8 "Multiple", add
lab val field field

replace field=1 if PhysicalSciences==1 & nfields==1
replace field=2 if EngineeringTechnology==1 & nfields==1
replace field=3 if LifeSciences==1 & nfields==1
replace field=4 if Medicine==1 & nfields==1
replace field=5 if SocialSciencesEconomics==1 & nfields==1
replace field=6 if Law==1 & nfields==1
replace field=7 if ArtsHumanities==1 & nfields==1
replace field=8 if nfields>1

rename Fromwhichyeardatesyourfirst firstpub
lab var firstpub "Year of first publication"

// ========================================================= Search tools =====
// =============================================================================

rename GoogleScholar tool_search_gs
replace tool_search_gs="1" if tool_search_gs=="Google Scholar"
replace tool_search_gs="0" if mi(tool_search_gs)
destring tool_search_gs, replace
lab var tool_search_gs "Search literature: Google Scholar"

rename WebofScience tool_search_wos
replace tool_search_wos="1" if tool_search_wos=="Web of Science"
replace tool_search_wos="0" if mi(tool_search_wos)
destring tool_search_wos, replace
lab var tool_search_wos "Search literature: Web of Science"

rename Scopus tool_search_scopus
replace tool_search_scopus="1" if tool_search_scopus=="Scopus"
replace tool_search_scopus="0" if mi(tool_search_scopus)
destring tool_search_scopus, replace
lab var tool_search_scopus "Search literature: Scopus"

rename Mendeley tool_search_mendeley
replace tool_search_mendeley="1" if tool_search_mendeley=="Mendeley"
replace tool_search_mendeley="0" if mi(tool_search_mendeley)
destring tool_search_mendeley, replace
lab var tool_search_mendeley "Search literature: Mendeley"

rename WorldCat tool_search_worldcat
replace tool_search_worldcat="1" if tool_search_worldcat=="WorldCat"
replace tool_search_worldcat="0" if mi(tool_search_worldcat)
destring tool_search_worldcat, replace
lab var tool_search_worldcat "Search literature: WorldCat"

rename PubMed tool_search_pubmed
replace tool_search_pubmed="1" if tool_search_pubmed=="PubMed"
replace tool_search_pubmed="0" if mi(tool_search_pubmed)
destring tool_search_pubmed, replace
lab var tool_search_pubmed "Search literature: PubMed"

rename Paperity tool_search_paperity
replace tool_search_paperity="1" if tool_search_paperity=="Paperity"
replace tool_search_paperity="0" if mi(tool_search_paperity)
destring tool_search_paperity, replace
lab var tool_search_paperity "Search literature: Paperity"

foreach tt of varlist tool_search_*	{
	assert inlist(`tt',0,1)
}

drop andalsoothers

rename Pleasespecifytheothertools* tool_search_other
lab var tool_search_other "Search literature: other"

// ========================================================= Access tools =====
// =============================================================================

rename Institutionalaccess tool_access_institutional
lab var tool_access_institutional "Access to literature: Institutional Access"
replace tool_access_institutional="1" if tool_access_institutional=="Institutional access"
replace tool_access_institutional="0" if mi(tool_access_institutional)
destring tool_access_institutional, replace

rename Payperviewonpublisherplatfo* tool_access_ppv
lab var tool_access_ppv "Access to literature: pay per view on publisher platform"
replace tool_access_ppv="1" if tool_access_ppv=="Pay per view on publisher platform"
replace tool_access_ppv="0" if mi(tool_access_ppv)
destring tool_access_ppv, replace

local varname tool_access_resgate
rename ResearchGate `varname'
lab var `varname' "Access to literature: ResearchGate"
replace `varname'="1" if `varname'=="ResearchGate"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_access_res4life
rename Research4Life `varname'
lab var `varname' "Access to literature: Research4Life"
replace `varname'="1" if `varname'=="Research4Life"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_access_oabutton
rename OpenAccessButton `varname'
lab var `varname' "Access to literature: Open Access Button"
replace `varname'="1" if `varname'=="Open Access Button"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_access_deepdyve
rename Deepdyve `varname'
lab var `varname' "Access to literature: Deepdyve"
replace `varname'="1" if `varname'=="Deepdyve"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_access_author
rename Emailtheauthor `varname'
lab var `varname' "Access to literature: directly from author"
replace `varname'="1" if `varname'=="E-mail the author"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop AC

rename AD tool_access_other
lab var tool_access_other "Access to literature: other"

// ========================================== Alert/recommendations tools =====
// =============================================================================

local varname tool_alert_gs
rename AE `varname'
lab var `varname' "Get alerts: Google Scholar"
replace `varname'="1" if `varname'=="Google Scholar"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_alert_toc
rename JournalTOCs `varname'
lab var `varname' "Get alerts: Journal TOCs"
replace `varname'="1" if `varname'=="JournalTOCs"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_alert_browzine
rename Browzine `varname'
lab var `varname' "Get alerts: Browzine"
replace `varname'="1" if `varname'=="Browzine"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_alert_mendeley
rename AH `varname'
lab var `varname' "Get alerts: Mendeley"
replace `varname'="1" if `varname'=="Mendeley"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_alert_f1000
rename F1000Prime `varname'
lab var `varname' "Get alerts: F1000 Prime"
replace `varname'="1" if `varname'=="F1000 Prime"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_alert_sparrho
rename Sparrho `varname'
lab var `varname' "Get alerts: Sparrho"
replace `varname'="1" if `varname'=="Sparrho"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_alert_resgate
rename AK `varname'
lab var `varname' "Get alerts: Research Gate"
replace `varname'="1" if `varname'=="ResearchGate"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop AL

rename AM tool_alert_other
lab var tool_alert_other "Get alerts: other"

// ============================================= Read/view/annotate tools =====
// =============================================================================

local varname tool_read_acro
rename AcrobatReader `varname'
lab var `varname' "Read/view/annotate: Acrobat Reader"
replace `varname'="1" if `varname'=="Acrobat Reader"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_read_html
rename usingHTMLview `varname'
lab var `varname' "Read/view/annotate: HTML view"
replace `varname'="1" if `varname'=="using HTML view"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_read_iannotate
rename iAnnotate `varname'
lab var `varname' "Read/view/annotate: iAnnotate"
replace `varname'="1" if `varname'=="iAnnotate"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_read_readcube
rename ReadCube `varname'
lab var `varname' "Read/view/annotate: ReadCube"
replace `varname'="1" if `varname'=="ReadCube"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_read_utopia
rename UtopiaDocs `varname'
lab var `varname' "Read/view/annotate: UtopiaDocs"
replace `varname'="1" if `varname'=="UtopiaDocs"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_read_mendeley
rename AS `varname'
lab var `varname' "Read/view/annotate: Mendeley"
replace `varname'="1" if `varname'=="Mendeley"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_read_hypothesis
rename Hypothesis `varname'
lab var `varname' "Read/view/annotate: Hypothes.is"
replace `varname'="1" if `varname'=="Hypothes.is"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop AU

rename AV tool_read_other
lab var tool_read_other "Read/view/annotate: other"

// ======================================================= Analysis tools =====
// =============================================================================

local varname tool_analysis_r
rename R `varname'
lab var `varname' "Analyze data: R"
replace `varname'="1" if `varname'=="R"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_analysis_spss
rename SPSS `varname'
lab var `varname' "Analyze data: SPSS"
replace `varname'="1" if `varname'=="SPSS"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_analysis_matlab
rename Matlab `varname'
lab var `varname' "Analyze data: Matlab"
replace `varname'="1" if `varname'=="Matlab"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_analysis_excel
rename Excel `varname'
lab var `varname' "Analyze data: Excel"
replace `varname'="1" if `varname'=="Excel"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_analysis_ipython
rename iPythonNotebook `varname'
lab var `varname' "Analyze data: iPython Notebook"
replace `varname'="1" if `varname'=="iPython Notebook"
replace `varname'="0" if mi(`varname')
destring `varname', replace

// Is this tool really different from R?
local varname tool_analysis_ropen
rename ROpenSci `varname'
lab var `varname' "Analyze data: R Open Science"
replace `varname'="1" if `varname'=="ROpenSci"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_analysis_dhbox
rename DHbox `varname'
lab var `varname' "Analyze data: DHbox"
replace `varname'="1" if `varname'=="DHbox"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop BD

rename BE tool_analysis_other
lab var tool_analysis_other "Analyze data: other"

// ========================================================== Share tools =====
// =============================================================================

local varname tool_share_osf
rename OpenScienceFramework `varname'
lab var `varname' "Share protocols: Open Science Framework"
replace `varname'="1" if `varname'=="Open Science Framework"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_share_myexp
rename myExperiment `varname'
lab var `varname' "Share protocols: myExperiment"
replace `varname'="1" if `varname'=="myExperiment"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_share_benchling
rename BenchLing `varname'
lab var `varname' "Share protocols: BenchLing"
replace `varname'="1" if `varname'=="BenchLing"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_share_protocolsio
rename Protocolsio `varname'
lab var `varname' "Share protocols: Protocols.io"
replace `varname'="1" if `varname'=="Protocols.io"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_share_benchfly
rename Benchfly `varname'
lab var `varname' "Share protocols: Benchfly"
replace `varname'="1" if `varname'=="Benchfly"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_share_scipro
rename ScientificProtocols `varname'
lab var `varname' "Share protocols: Scientific Protocols"
replace `varname'="1" if `varname'=="Scientific Protocols"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_share_protocolonline 
rename ProtocolOnline `varname'
lab var `varname' "Share protocols: Protocol Online"
replace `varname'="1" if `varname'=="Protocol Online"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop BM

rename BN tool_share_other
lab var tool_share_other "Share protocols: other"

// ======================================================== Writing tools =====
// =============================================================================

local varname tool_write_word
rename Word `varname'
lab var `varname' "Write manuscript: MS word"
replace `varname'="1" if `varname'=="Word"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_write_gdocs
rename GoogleDriveDocs `varname'
lab var `varname' "Write manuscript: Google Drive/Docs"
replace `varname'="1" if `varname'=="Google Drive/Docs"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_write_authorea
rename Authorea `varname'
lab var `varname' "Write manuscript: Authorea"
replace `varname'="1" if `varname'=="Authorea"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_write_latex
rename LaTeX `varname'
lab var `varname' "Write manuscript: LaTeX"
replace `varname'="1" if `varname'=="LaTeX"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_write_scrivener
rename Scrivener `varname'
lab var `varname' "Write manuscript: Scrivener"
replace `varname'="1" if `varname'=="Scrivener"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_write_overleaf
rename OverleafWriteLaTeX `varname'
lab var `varname' "Write manuscript: Overleaf"
replace `varname'="1" if `varname'=="Overleaf (=WriteLaTeX)"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_write_scalar
rename Scalar `varname'
lab var `varname' "Write manuscript: Scalar"
replace `varname'=1 if string(`varname')=="Scalar"
replace `varname'=0 if mi(`varname')
destring `varname', replace

drop BV

rename BW tool_write_other
lab var tool_write_other "Write manuscript: other"

// ====================================================== Reference tools =====
// =============================================================================

local varname tool_ref_endnote
rename EndNote `varname'
lab var `varname' "Reference management: EndNote"
replace `varname'="1" if `varname'=="EndNote"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_ref_zotero
rename Zotero `varname'
lab var `varname' "Reference management: Zotero"
replace `varname'="1" if `varname'=="Zotero"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_ref_refworks
rename RefWorks `varname'
lab var `varname' "Reference management: RefWorks"
replace `varname'="1" if `varname'=="RefWorks"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_ref_mendeley
rename CA `varname'
lab var `varname' "Reference management: Mendeley"
replace `varname'="1" if `varname'=="Mendeley"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_ref_papers
rename Papers `varname'
lab var `varname' "Reference management: Papers"
replace `varname'="1" if `varname'=="Papers"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_ref_refme
rename REfME `varname'
lab var `varname' "Reference management: REfME"
replace `varname'="1" if `varname'=="REfME"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_ref_citavi
rename Citavi `varname'
lab var `varname' "Reference management: Citavi"
replace `varname'="1" if `varname'=="Citavi"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop CE

rename CF tool_ref_other
lab var tool_ref_other "Reference management: other"

// ====================================== Archive/share publications tools =====
// =============================================================================

local varname tool_archpub_arxiv
rename arXiv `varname'
lab var `varname' "Archive publications: arXiv"
replace `varname'="1" if `varname'=="arXiv"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archpub_pubmed
rename PubMedCentral `varname'
lab var `varname' "Archive publications: PubMed Central"
replace `varname'="1" if `varname'=="PubMed Central"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archpub_institrepo
rename Institutionalrepository `varname'
lab var `varname' "Archive publications: Institutional repository"
replace `varname'="1" if `varname'=="Institutional repository"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archpub_bioRxiv
rename bioRxiv `varname'
lab var `varname' "Archive publications: bioRxiv"
replace `varname'="1" if `varname'=="bioRxiv"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archpub_isharewp
rename Ishareworkingpapers `varname'
lab var `varname' "Archive publications: I share working papers"
replace `varname'="1" if `varname'=="I share working papers"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archpub_resgate
rename CL `varname'
lab var `varname' "Archive publications: ResearchGate"
replace `varname'="1" if `varname'=="ResearchGate"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archpub_ssrn
rename SSRN `varname'
lab var `varname' "Archive publications: SSRN"
replace `varname'="1" if `varname'=="SSRN"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop CN

rename CO tool_archpub_other
lab var tool_archpub_other "Archive publications: other"

// ============================================== Archive/share code tools =====
// =============================================================================

local varname tool_archcode_github
rename GitHub `varname'
lab var `varname' "Archive code: GitHub"
replace `varname'="1" if `varname'=="GitHub"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archcode_figshare
rename Figshare `varname'
lab var `varname' "Archive code: FigShare"
replace `varname'="1" if `varname'=="Figshare"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archcode_zenodo
rename Zenodo `varname'
lab var `varname' "Archive code: Zenodo"
replace `varname'="1" if `varname'=="Zenodo"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archcode_dryad
rename Dryad `varname'
lab var `varname' "Archive code: Dryad"
replace `varname'="1" if `varname'=="Dryad"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archcode_dataverse
rename Dataverse `varname'
lab var `varname' "Archive code: Dataverse"
replace `varname'="1" if `varname'=="Dataverse"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archcode_pangaea
rename Pangaea `varname'
lab var `varname' "Archive code: Pangaea"
replace `varname'="1" if `varname'=="Pangaea"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archcode_bitbucket
rename BitBucket `varname'
lab var `varname' "Archive code: BitBucket"
replace `varname'="1" if `varname'=="BitBucket"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop CW

rename CX tool_archcode_other
lab var tool_archcode_other "Archive code: other"

// ========================================================== Impact tools =====
// =============================================================================

local varname tool_submit_jcr
rename JCRimpactfactors `varname'
lab var `varname' "Where to submit: JCR (impact factors)"
replace `varname'="1" if `varname'=="JCR (impact factors)"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_submit_doaj
rename DOAJ `varname'
lab var `varname' "Where to submit: DOAJ"
replace `varname'="1" if `varname'=="DOAJ"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_submit_scopus
rename DA `varname'
lab var `varname' "Where to submit: Scopus"
replace `varname'="1" if `varname'=="Scopus"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_submit_sherpa
rename SherpaRomeo `varname'
lab var `varname' "Where to submit: Sherpa Romeo"
replace `varname'="1" if `varname'=="Sherpa Romeo"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_submit_qoam
rename QOAM `varname'
lab var `varname' "Where to submit: QOAM"
replace `varname'="1" if `varname'=="QOAM"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_submit_sci
rename SCImagoJournalRank `varname'
lab var `varname' "Where to submit: SCImago Journal Rank"
replace `varname'="1" if `varname'=="SCImago Journal Rank"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_submit_journalysis
rename Journalysis `varname'
lab var `varname' "Where to submit: Journalysis"
replace `varname'="1" if `varname'=="Journalysis"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop DF

rename DG tool_submit_other
lab var tool_submit_other "Where to submit: other"

// ===================================================== Publication tools =====
// =============================================================================

local varname tool_pub_topictrad
rename Topicaljournaltraditionalpub* `varname'
lab var `varname' "Publication channel: Topical journal, traditional"
replace `varname'="1" if `varname'=="Topical journal (traditional publisher)"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pub_topicoa
rename TopicaljournalOApublisher `varname'
lab var `varname' "Publication channel: Topical journal, OA"
replace `varname'="1" if `varname'=="Topical journal (OA publisher)"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pub_megatrad
rename Megajournaltraditionalpublish* `varname'
lab var `varname' "Publication channel: Mega journal, traditional"
replace `varname'="1" if `varname'=="Megajournal (traditional publisher)"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pub_megaoa
rename MegajournalOApublisher `varname'
lab var `varname' "Publication channel: Mega journal, OA"
replace `varname'="1" if `varname'=="Megajournal (OA publisher)"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pub_dataj
rename Datajournal `varname'
lab var `varname' "Publication channel: Data journal"
replace `varname'="1" if `varname'=="Data journal"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pub_winnower
rename Winnower `varname'
lab var `varname' "Publication channel: Winnower"
replace `varname'="1" if `varname'=="Winnower"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pub_f1000
rename F1000Research `varname'
lab var `varname' "Publication channel: F1000Research"
replace `varname'="1" if `varname'=="F1000Research"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop DO

rename DP tool_pub_other
lab var tool_pub_other "Publication channel: other"

// =========================== Archive/share posters & presentations tools =====
// =============================================================================

local varname tool_archpres_speakerdeck
rename Speakerdeck `varname'
lab var `varname' "Archive presentations: Speakerdeck"
replace `varname'="1" if `varname'=="Speakerdeck"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archpres_slideshare
rename Slideshare `varname'
lab var `varname' "Archive presentations: Slideshare"
replace `varname'="1" if `varname'=="Slideshare"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archpres_f1000
rename F1000Posters `varname'
lab var `varname' "Archive presentations: F1000Posters"
replace `varname'="1" if `varname'=="F1000Posters"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archpres_sop
rename ScienceOpenPosters `varname'
lab var `varname' "Archive presentations: Science Open Posters"
replace `varname'=1 if string(`varname')=="ScienceOpenPosters"
replace `varname'=0 if mi(`varname')
destring `varname', replace

local varname tool_archpres_figshare
rename DU `varname'
lab var `varname' "Archive presentations: Figshare"
replace `varname'="1" if `varname'=="Figshare"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archpres_zenodo
rename DV `varname'
lab var `varname' "Archive presentations: Zenodo"
replace `varname'="1" if `varname'=="Zenodo"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_archpres_vimeo
rename Vimeo `varname'
lab var `varname' "Archive presentations: Vimeo"
replace `varname'="1" if `varname'=="Vimeo"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop DX

rename DY tool_archpres_other
lab var tool_archpres_other "Archive presentations: other"

// =========================================== Popular communication tools =====
// =============================================================================

local varname tool_pop_wiki
rename Wikipedia `varname'
lab var `varname' "Popular communication: Wikipedia"
replace `varname'="1" if `varname'=="Wikipedia"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pop_resblog
rename ResearchBloggingorg `varname'
lab var `varname' "Popular communication: ResearchBlogging.org"
replace `varname'="1" if `varname'=="ResearchBlogging.org"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pop_wordpress
rename Wordpress `varname'
lab var `varname' "Popular communication: Wordpress"
replace `varname'="1" if `varname'=="Wordpress"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pop_kudos 
rename Kudos `varname'
lab var `varname' "Popular communication: Kudos"
replace `varname'="1" if `varname'=="Kudos"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pop_famelab
rename FameLab `varname'
lab var `varname' "Popular communication: FameLab"
replace `varname'="1" if `varname'=="FameLab"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pop_pos
rename PintofScience `varname'
lab var `varname' "Popular communication: Pint of Science"
replace `varname'="1" if `varname'=="Pint of Science"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_pop_twit
rename Twitter `varname'
lab var `varname' "Popular communication: Twitter"
replace `varname'="1" if `varname'=="Twitter"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop EG

rename EH tool_pop_other
lab var tool_pop_other "Popular communication: other"

// ============================================== Researcher profile tools =====
// =============================================================================
   
local varname tool_profile_gsc
rename GoogleScholarCitations `varname'
lab var `varname' "Researcher profile: Google Scholar Citations"
replace `varname'="1" if `varname'=="Google Scholar Citations"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_profile_resgate
rename EJ `varname'
lab var `varname' "Researcher profile: ResearchGate"
replace `varname'="1" if `varname'=="ResearchGate"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_profile_orcid
rename ORCID `varname'
lab var `varname' "Researcher profile: ORCID"
replace `varname'="1" if `varname'=="ORCID"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_profile_academia 
rename Academiaedu `varname'
lab var `varname' "Researcher profile: Academia.edu"
replace `varname'="1" if `varname'=="Academia.edu"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_profile_resid
rename ResearcherID `varname'
lab var `varname' "Researcher profile: ResearcherID"
replace `varname'="1" if `varname'=="ResearcherID"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_profile_instit
rename Profilepageatowninstitution `varname'
lab var `varname' "Researcher profile: Profile page at own institution"
replace `varname'="1" if `varname'=="Profile page at own institution"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_profile_msw
rename MyScienceWork `varname'
lab var `varname' "Researcher profile: My Science Work"
replace `varname'="1" if `varname'=="My Science Work"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop EP

rename Pleasespecifytheotherresearc* tool_profile_other
lab var tool_profile_other "Researcher profile: other"

// ========================================================== Review tools =====
// =============================================================================

local varname tool_review_pos
rename PeerageofScience `varname'
lab var `varname' "Peer review: Peerage of Science"
replace `varname'="1" if `varname'=="Peerage of Science"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_review_publons
rename Publons `varname'
lab var `varname' "Peer review: Publons"
replace `varname'="1" if `varname'=="Publons"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_review_pubmed
rename PubMedCommons `varname'
lab var `varname' "Peer review: PubMed Commons"
replace `varname'="1" if `varname'=="PubMed Commons"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_review_pubpeer 
rename PubPeer `varname'
lab var `varname' "Peer review: PubPeer"
replace `varname'=1 if string(`varname')=="PubPeer"
replace `varname'=0 if mi(`varname')
destring `varname', replace

local varname tool_review_papercritic
rename PaperCritic `varname'
lab var `varname' "Peer review: PaperCritic"
replace `varname'="1" if `varname'=="PaperCritic"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_review_rubriq
rename RubriQ `varname'
lab var `varname' "Peer review: RubriQ"
replace `varname'="1" if `varname'=="RubriQ"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_review_ak
rename AcademicKarma `varname'
lab var `varname' "Peer review: Academic Karma"
replace `varname'="1" if `varname'=="Academic Karma"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop EY

rename EZ tool_review_other
lab var tool_review_other "Peer review: other"

// ============================================== Impact measurement tools =====
// =============================================================================

local varname tool_impact_jcr
rename JCRimpactfactor `varname'
lab var `varname' "Measure impact: JCR (impact factor)"
replace `varname'="1" if `varname'=="JCR (impact factor)"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_impact_altmet
rename Altmetric `varname'
lab var `varname' "Measure impact: Altmetric"
replace `varname'="1" if `varname'=="Altmetric"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_impact_scopus
rename FC `varname'
lab var `varname' "Measure impact: Scopus"
replace `varname'="1" if `varname'=="Scopus"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_impact_is
rename ImpactStory `varname'
lab var `varname' "Measure impact: ImpactStory"
replace `varname'="1" if `varname'=="ImpactStory"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_impact_plos
rename PLoSarticlelevelmetrics `varname'
lab var `varname' "Measure impact: PLoS article level metrics"
replace `varname'="1" if `varname'=="PLoS article level metrics"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_impact_wos
rename FF `varname'
lab var `varname' "Measure impact: Web of Science"
replace `varname'="1" if `varname'=="Web of Science"
replace `varname'="0" if mi(`varname')
destring `varname', replace

local varname tool_impact_hpop
rename HarzingPublishorPerish `varname'
lab var `varname' "Measure impact: Harzing Publish or Perish"
replace `varname'="1" if `varname'=="Harzing Publish or Perish"
replace `varname'="0" if mi(`varname')
destring `varname', replace

drop FH

rename FI tool_impact_other
lab var tool_impact_other "Measure impact: other"

// =============================================== Language specific tools =====
// =============================================================================
// all empty
drop Languagespecifictool*

// ======================================== Most important development etc =====
// =============================================================================
local varname imp_dev
rename Whatdoyouthinkwillbethemo `varname'
lab var `varname' "Most important development in scholarly communication"


local varname supportOA
rename DoyousupportthegoalofOpen `varname'
cap drop _tmp
gen _tmp=0 if supportOA=="I don't know" | mi(supportOA)
replace _tmp=-1 if supportOA=="No"
replace _tmp=1 if supportOA=="Yes"
drop supportOA
rename _tmp supportOA
lab var `varname' "Do you support Open Access?"

local varname supportOS
rename DoyousupportthegoalsofOpen `varname'
cap drop _tmp
gen _tmp=0 if supportOS=="I don't know" | mi(supportOS)
replace _tmp=-1 if supportOS=="No"
replace _tmp=1 if supportOS=="Yes"
drop supportOS
rename _tmp supportOS
lab var `varname' "Do you support Open Science?"

// ================================= Merge with cleaned free entry fields ======
// =============================================================================
compress
merge 1:1 ID using `free_entry', nogen assert(3)

// Search tools
replace tool_search_wos=1 if regexm(tool_search_other2, "Web of Science")
replace tool_search_pubmed=1 if regexm(tool_search_other2, "Pubmed")
drop tool_search_other2*

// Access tools
replace tool_access_institutional=1 if regexm(tool_access_other2, "University Libraries")
replace tool_access_institutional=1 if regexm(tool_access_other2, "Inter-library Loan")

// alert tools
replace tool_alert_toc=1 if regexm(tool_alert_other2, "e-mail alert (JournalTOCs)")
replace tool_alert_toc=1 if regexm(tool_alert_other2, "Newsletter from specific journals")
replace tool_alert_toc=1 if regexm(tool_alert_other2, "Newsletters from specific journals")

// analysis tools
replace tool_analysis_ipython=1 if regexm(tool_alert_other2, "Python")

// writing tools
replace tool_write_gdocs=1 if regexm(tool_write_other2, "Google Docs")

// Publication archive
replace tool_archpub_institrepo=1 if regexm(tool_archcode_other2, "Institutional repository")
replace tool_archpub_institrepo=1 if regexm(tool_archcode_other2, "Metis")

// Code archive
replace tool_submit_jcr=1 if regexm(tool_submit_other2, "Impact Factors")

// profile
replace tool_profile_instit=1 if regexm(tool_profile_other2, "Institutional staff overviews (department/faculty)")

// ======================================================== Save and exit ======
// =============================================================================
drop source Language 
drop *_other2?
qui ds *_other
foreach vv of varlist `r(varlist)'	{
	cap drop _tmp
	rename `vv' `vv'_orig
	lab var `vv'_orig "`: var l `vv'_orig' (original data)"
	cap rename `vv'2 `vv' 
	
}

qui ds, has(type string)
foreach vv of varlist `r(varlist)'	{
	replace `vv'=trim(itrim(`vv'))
}
order *, seq
order ID role research_role research_role_ifother country field
drop nfields
compress
save "101innov.dta", replace
outsheet using "101innov.csv", delim(";") replace
export excel using "101innov.xlsx", nolabel replace

local line=c(linesize)
set linesize 90
cap log close codebook
log using codebook.log, replace name(codebook)
codebook
log close codebook
set linesize `line'

exit
