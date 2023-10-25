# vertex-wise meta-analysis example, using g-volume associations. The same script structure was used for all 5 morphometry measures.
library(robumeta)
library(metafor)

mask <- read.csv('/mask.csv', header = F)

LBC20 <- read.csv('/LBC1936_fwhm20.csv', sep = ",", header = F)
LBC20vol <- LBC20[,c(1,2)]
LBC20Sa <- LBC20[,c(4,5)]
LBC20Thk <- LBC20[,c(7,8)]
LBC20Curv <- LBC20[,c(10,11)]
LBC20Sulc <- LBC20[,c(13,14)]

STRADL20 <- read.csv('/STRADL_fwhm20.csv', sep = ",", header = F)
STRADL20vol <- STRADL20[,c(1,2)]
STRADL20Sa <- STRADL20[,c(4,5)]
STRADL20Thk <- STRADL20[,c(7,8)]
STRADL20Curv <- STRADL20[,c(10,11)]
STRADL20Sulc <- STRADL20[,c(13,14)]

UKB20 <- read.csv('/UKB_fwhm20.csv', sep = ",", header = F)
UKB20vol <- UKB20[,c(1,2)]
UKB20Sa <- UKB20[,c(4,5)]
UKB20Thk <- UKB20[,c(7,8)]
UKB20Curv <- UKB20[,c(10,11)]
UKB20Sulc <- UKB20[,c(13,14)]

name_UKB <- rep("UKB", 327684)
name_STRADL <- rep("STRADL", 327684)
name_LBC <- rep("LBC", 327684)
n_UKB <- rep(36744, 327684) 
n_STRADL <- rep(1014, 327684) 
n_LBC <- rep(622, 327684)

UKBef <- UKB20vol[,1]*-1
UKBse <- UKB20vol[,2]
UKBse[which(mask == 0)] <- NA
UKBef[which(mask == 0)] <- NA

STRADLef <- STRADL20vol[,1]
STRADLse <- STRADL20vol[,2]
STRADLse[which(mask == 0)] <- NA
STRADLef[which(mask == 0)] <- NA

LBCef <- LBC20vol[,1]
LBCse <- LBC20vol[,2]
LBCse[which(mask == 0)] <- NA
LBCef[which(mask == 0)] <- NA

UKB <- cbind(name_UKB, n_UKB)
UKB <- cbind(UKB, UKBef)
UKB <- cbind(UKB, UKBse)
UKB <- cbind(UKB, rep(63.71, 327684))
UKB <- as.data.frame(UKB)
UKB[,2:5] <- sapply(UKB[,2:5], as.numeric)
colnames(UKB) <- c("name", "n", "ef", "se", "meanage")
UKB$va <- UKB$se^2

STRADL <- cbind(name_STRADL, n_STRADL)
STRADL <- cbind(STRADL, STRADLef)
STRADL <- cbind(STRADL, STRADLse)
STRADL <- cbind(STRADL, rep(59.22, 327684))
STRADL <- as.data.frame(STRADL)
STRADL[,2:5] <- sapply(STRADL[,2:5], as.numeric)
colnames(STRADL) <- c("name", "n", "ef", "se", "meanage")
STRADL$va <- STRADL$se^2

LBC <- cbind(name_LBC, n_LBC)
LBC <- cbind(LBC, LBCef)
LBC <- cbind(LBC, LBCse)
LBC <- cbind(LBC, rep(72.66, 327684))
LBC <- as.data.frame(LBC)
LBC[,2:5] <- sapply(LBC[,2:5], as.numeric)
colnames(LBC) <- c("name", "n", "ef", "se", "meanage")
LBC$va <- LBC$se^2

LBC[which(mask == 0),] <- NA
STRADL[which(mask == 0),] <- NA
UKB[which(mask == 0),] <- NA

vol_outcomes = matrix(0, 327684, 9)
volagemod_outcomes = matrix(0, 327684, 9)

for (i in 1:327684) { 
data <- rbind(UKB[i, 1:6], STRADL[i, 1:6]) 
data <- rbind(data, LBC[i,1:6]) 
data$meanage <- as.numeric(data$meanage)
	
	if (is.na(data$ef[1])) {
	vol_outcomes[i,] <- "NA"
	volagemod_outcomes[i,] <- "NA"
	} else if  (data$ef[1] ==0) {
	next
	} else {
	
	res <- rma(ef, va, data = data) 
	resmod <- rma(ef, va, mods = ~meanage, data = data)

	vol_outcomes[i,1] <- as.numeric(res[17]) # q statistic 
	vol_outcomes[i,2] <- as.numeric(res[18]) # p value for q
	vol_outcomes[i,3] <- as.numeric(res[13]) # I^2
	vol_outcomes[i,3] <- as.numeric(res[9]) # tau^2
	vol_outcomes[i,5] <- as.numeric(res[10]) # setau^2
	vol_outcomes[i,6] <- as.numeric(res$beta[1]) # beta
	vol_outcomes[i,7] <- as.numeric(res$se[1]) # se
	vol_outcomes[i,8] <- as.numeric(res$zval[1]) # z
	vol_outcomes[i,9] <- as.numeric(res$pval[1]) # p value


	volagemod_outcomes[i,1] <- as.numeric(resmod[17]) # q statistic 
	volagemod_outcomes[i,2] <- as.numeric(resmod[18]) # p value for q
	volagemod_outcomes[i,3] <- as.numeric(resmod[13]) # I^2
	volagemod_outcomes[i,3] <- as.numeric(resmod[9]) # tau^2
	volagemod_outcomes[i,5] <- as.numeric(resmod[10]) # setau^2	
	volagemod_outcomes[i,6] <- as.numeric(resmod$beta[2]) # beta
	volagemod_outcomes[i,7] <- as.numeric(resmod$se[2]) # se
	volagemod_outcomes[i,8] <- as.numeric(resmod$zval[2]) # z
	volagemod_outcomes[i,9] <- as.numeric(resmod$pval[2]) # p value


	colnames(vol_outcomes) <- c("q", "p_q", "I^2", "tau^2", "setau^2", "beta", "se", "z", "p")
	colnames(volagemod_outcomes) <- c("q", "p_q", "I^2", "tau^2", "setau^2", "beta", "se", "z", "p")
	}
}
vol_outcomes <- as.data.frame(vol_outcomes)
vol_outcomes[,1:9] <-  sapply(vol_outcomes[,1:9], as.numeric)
vol_outcomes$bhQ <- p.adjust(vol_outcomes$p, method = "BH")
write.table(vol_outcomes[,6:10], '/volmeta.csv', sep = ' ', col.names = F, row.names = F)

volagemod_outcomes <- as.data.frame(volagemod_outcomes)
volagemod_outcomes[,1:9] <-  sapply(volagemod_outcomes[,1:9], as.numeric)
volagemod_outcomes$bhQ <- p.adjust(volagemod_outcomes$p, method = "BH")
write.table(volagemod_outcomes[,6:10], '/agemodvolmeta.csv', sep = ' ', col.names = F, row.names = F)

