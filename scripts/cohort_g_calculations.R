library(lavaan)
## UKB
UKB <- read.csv(".csv") # This file contains demographic information, and the cognitive test results from the 11 tests included to estimate a latent g factor 
UKB$cog_trailB_log[which(UKB$cog_trailB_log == 0)] <- NA # prepare cognitive test data
UKB$cog_prosmem[which(UKB$cog_prosmem == 2)] <- 0
UKB$brokenletters_w2[which(UKB$brokenletters_w2 < 20)] <- NA
UKB$cog_numeric_memory[which(UKB$cog_numeric_memory == -1)] <- NA
 
theUKBCogdata = data.frame(ID = UKB$ID, cog_RT_log = UKB$cog_RT_log, cog_numeric_memory = UKB$cog_numeric_memory, cog_fluid_intelligence = UKB$cog_fluid_intelligence, cog_trailB_log = UKB$cog_trailB_log, cog_matrix_pattern = UKB$cog_matrix_pattern_correct,cog_tower = UKB$cog_tower,cog_digsym = UKB$cog_digsym, cog_pairedAss = UKB$cog_pairedAss, cog_prosmem = UKB$cog_prosmem, cog_pairsmatch_incorrect_log = UKB$cog_pairsmatch_incorrect_log, cog_picturevocab = UKB$picturevocab_w2, ageMRI = UKB$ageyears_MRI/100, sex = UKB$sex)
theUKBCogdata_models <- theUKBCogdata
theUKBCogdata_models[,c(8)] <- theUKBCogdata_models[,c(8)]/10 # allows variances of different cognitive tests to be on similar scales, so that lavaan runs
theUKBCogdata_models[,c(7)] <- theUKBCogdata_models[,c(7)]/10
par(mfrow = c(1, 1))
UKBcogmodel <- 'g =~cog_RT_log +cog_numeric_memory + cog_fluid_intelligence + cog_trailB_log + cog_matrix_pattern + cog_tower + 
cog_digsym + cog_pairsmatch_incorrect_log +cog_prosmem +cog_pairedAss + cog_picturevocab
cog_RT_log ~ ageMRI + sex
cog_numeric_memory ~ ageMRI + sex
cog_fluid_intelligence ~ ageMRI + sex
cog_trailB_log ~ ageMRI + sex 
cog_matrix_pattern ~ ageMRI + sex
cog_tower ~ ageMRI + sex
cog_digsym ~ ageMRI + sex
cog_pairsmatch_incorrect_log ~ ageMRI + sex
cog_prosmem ~ ageMRI + sex
cog_pairedAss ~ ageMRI + sex
cog_picturevocab ~ ageMRI + sex
'
UKBcogfit <- sem(UKBcogmodel, data=theUKBCogdata_models, missing="fiml.x")
summary(UKBcogfit, fit.measures=TRUE, standardized=T)

GpredictUKB <- lavPredict(UKBcogfit, theUKBCogdata_models)
GpredictUKB <- cbind(theUKBCogdata$ID, GpredictUKB)
colnames(GpredictUKB) <- c("ID", "g")
GpredictUKB <- as.data.frame(GpredictUKB)
		
## STRADL
STRADL <- read.csv(".csv") # this file contains demographic information, and cognitive test scores for each STRADL participant.  
theSTRADLCogdata = data.frame(eid = STRADL$ID, age = STRADL$AgeFaceToFace, sex = STRADL$Sex, assCtr = STRADL$StudySite, mema = STRADL$mema, memdela = STRADL$memdela, digsym = STRADL$digsym, vftot = STRADL$vftot, mhv = STRADL$mhv, mrtotc = STRADL$mrtotc, logmem = STRADL$mema+STRADL$memdela)
STRADLcogmodel <- 'g =~ digsym + vftot + mhv + mrtotc + logmem 
digsym~age+sex
vftot ~age+sex
mhv~age+sex
mrtotc~age+sex
logmem~age+sex
'

STRADLcogfit <- sem(cogmodel, data = theSTRADLCogdata, missing = "fiml.x")
summary(STRADLcogfit, fit.measures=TRUE, standardized=T)

GpredictSTRADL <- lavPredict(STRADLcogfit, theSTRADLCogdata)
GpredictSTRADL <- cbind(STRADL$ID, GpredictSTRADL)
colnames(GpredictSTRADL) <- c("ID", "g")
GpredictSTRADL <- as.data.frame(GpredictSTRADL)
GpredictSTRADL$g <- as.numeric(GpredictSTRADL$g)

## LBC
LBC <- read.csv(".csv") # this file contains demographic information, and cognitive test scores for each LBC1936 participant.
theLBCCogdata <- LBC[,1:25]
LBCcogmodel <- 'g=~matrix_reasoning + block_design + spatial_span_total + NART + WTAR + 
verbal_fluency+verbal_paired_associates + logical_memory + digit_span_backward +
symbol_search + digit_symbol + inspection_time + choice_reaction_time_reflected 

matrix_reasoning ~ AgeDays + sex
block_design~ AgeDays + sex
spatial_span_total~ AgeDays + sex
NART~ AgeDays + sex
WTAR ~ AgeDays + sex
verbal_fluency~ AgeDays + sex
verbal_paired_associates~ AgeDays + sex
logical_memory~ AgeDays + sex
digit_span_backward~ AgeDays + sex
symbol_search~ AgeDays + sex
digit_symbol~ AgeDays + sex
inspection_time~ AgeDays + sex
choice_reaction_time_reflected~ AgeDays + sex

# within-domain covariances
matrix_reasoning ~~ block_design # visuospatial skills...
symbol_search ~~ digit_symbol
matrix_reasoning~~ spatial_span_total
block_design~~spatial_span_total
NART~~WTAR # crystalised...
NART~~verbal_fluency
WTAR~~verbal_fluency
verbal_paired_associates~~digit_span_backward # verbal memory...
logical_memory~~digit_span_backward
logical_memory~~verbal_paired_associates 
symbol_search~~inspection_time # processing speed...
symbol_search~~choice_reaction_time_reflected
digit_symbol~~choice_reaction_time_reflected
inspection_time~~choice_reaction_time_reflected
digit_symbol~~inspection_time
'

LBCcogfit <- sem(LBCcogmodel, data=theLBCCogdata, missing = "fiml.x")
summary(fit1, fit.measures=TRUE, standardized=T)
modificationIndices(fit1, sort = T)

GpredictLBC <- lavPredict(LBCcogfit, theLBCCogdata)
GpredictLBC <- as.data.frame(GpredictLBC)
GpredictLBC <- cbind(LBC$ID, GpredictLBC$g)
colnames(GpredictLBC) <- c("ID", "g")
GpredictLBC <- as.data.frame(GpredictLBC)
GpredictLBC$g <- as.numeric(GpredictLBC$g)

# these latent g scores, for the three cohorts, were included in the vertex-wise surfstat models
write.table(data.frame(UKB_g = GpredictUKB$g, STRADL_g = GpredictSTRADL$g, LBC1936_g = GpredictLBC$g), '.csv', sep = " ")
