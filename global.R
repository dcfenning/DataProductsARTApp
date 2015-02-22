##Global.R
library(shiny)
suppressPackageStartupMessages(library(googleVis))
#########################Getting and Cleaning Data#######################################
fdata <- read.csv("./data/fertility_data_raw.csv", header = TRUE, stringsAsFactors = FALSE)

##clean data and transform to appropriate class

##state list ClinStateCode
fdata$ClinStateCode <- as.factor(fdata$ClinStateCode)

##clean and convert columns 6-10 - Percentage of fresh nondonor cycles columns
for (i in 6:10){
  fdata[,i] <- (gsub(">","",fdata[,i], fixed = TRUE))
  fdata[,i] <- (gsub("<","",fdata[,i], fixed = TRUE))
  fdata[,i] <- as.numeric(gsub("%","",fdata[,i], fixed = TRUE))
}

##Clean and convert columns 11:20 - diagnosis columns
for (i in 11:20){
  fdata[,i] <- (gsub("<","",fdata[,i], fixed = TRUE))
  fdata[,i] <- as.numeric(gsub("%","",fdata[,i], fixed = TRUE))
}

##Clean and convert columns 30:35
for (j in 30:35){
  
  ##Clean and convert columns and split into new dataframe separated by /.... 
  fdata[,j] <- sub(fdata[,j], pattern = "\\s+", replacement = "")
  fdata[,j] <- sub(fdata[,j], pattern = "\\s+", replacement = "")                            
  
  ##split vector into list and create new split dataframe
  tmp <- strsplit(fdata[,j], split="/")
  tmpv <- NULL
  nMax <- max(sapply(tmp, length))
  tmpv <- cbind(tmpv, t(sapply(tmp, function(i) i[1:nMax])))
  splitdf <- as.data.frame(tmpv)
  colnames(splitdf) <- c("Col1", "Col2")
  splitdf$Col1 <- as.numeric(as.character(splitdf$Col1))
  splitdf$Col2 <- as.numeric(as.character(splitdf$Col2))
  
  ##set calc vector to be empty
  calc <- NULL
  
  ##if NA in column 2 then will require  calculation number per 100 cycles, then copy calculation to new calc vector
  ##Else just copy data to new calc vector
  for (i in 1:nrow(splitdf)){
    if (is.na(splitdf[i,2])) {
      calc[i] <- splitdf[i,1]
    }
    else {
      calc[i] <- round(splitdf[i,1]/splitdf[i,2],2)
    } 
  }
  
  ##bind new column to final data set
  fdata <- cbind(fdata, calc)
  colnames(fdata)[ncol(fdata)] <- paste(names(fdata)[j], "calc", sep = "")
}


##Clean and convert columns 42:77
for (j in 42:77){
  
  ##Clean and convert columns and split into new dataframe separated by /.... 
  fdata[,j] <- sub(fdata[,j], pattern = "\\s+", replacement = "")
  fdata[,j] <- sub(fdata[,j], pattern = "\\s+", replacement = "")                            
  
  ##split vector into list and create new split dataframe
  tmp <- strsplit(fdata[,j], split="/")
  tmpv <- NULL
  nMax <- max(sapply(tmp, length))
  tmpv <- cbind(tmpv, t(sapply(tmp, function(i) i[1:nMax])))
  splitdf <- as.data.frame(tmpv)
  colnames(splitdf) <- c("Col1", "Col2")
  splitdf$Col1 <- as.numeric(as.character(splitdf$Col1))
  splitdf$Col2 <- as.numeric(as.character(splitdf$Col2))
  
  ##set calc vector to be empty
  calc <- NULL
  
  ##if NA in column 2 then will require  calculation number per 100 cycles, then copy calculation to new calc vector
  ##Else just copy data to new calc vector
  for (i in 1:nrow(splitdf)){
    if (is.na(splitdf[i,2])) {
      calc[i] <- splitdf[i,1]
    }
    else {
      calc[i] <- round(splitdf[i,1]/splitdf[i,2],2)
    } 
  }
  
  ##bind new column to final data set
  fdata <- cbind(fdata, calc)
  colnames(fdata)[ncol(fdata)] <- paste(names(fdata)[j], "calc", sep = "")
}


##Clean and convert columns 84:107
for (j in 84:107){
  
  ##Clean and convert columns and split into new dataframe separated by /.... 
  fdata[,j] <- sub(fdata[,j], pattern = "\\s+", replacement = "")
  fdata[,j] <- sub(fdata[,j], pattern = "\\s+", replacement = "")                            
  
  ##split vector into list and create new split dataframe
  tmp <- strsplit(fdata[,j], split="/")
  tmpv <- NULL
  nMax <- max(sapply(tmp, length))
  tmpv <- cbind(tmpv, t(sapply(tmp, function(i) i[1:nMax])))
  splitdf <- as.data.frame(tmpv)
  colnames(splitdf) <- c("Col1", "Col2")
  splitdf$Col1 <- as.numeric(as.character(splitdf$Col1))
  splitdf$Col2 <- as.numeric(as.character(splitdf$Col2))
  
  ##set calc vector to be empty
  calc <- NULL
  
  ##if NA in column 2 then will require  calculation number per 100 cycles, then copy calculation to new calc vector
  ##Else just copy data to new calc vector
  for (i in 1:nrow(splitdf)){
    if (is.na(splitdf[i,2])) {
      calc[i] <- splitdf[i,1]
    }
    else {
      calc[i] <- round(splitdf[i,1]/splitdf[i,2],2)
    } 
  }
  
  ##bind new column to final data set
  fdata <- cbind(fdata, calc)
  colnames(fdata)[ncol(fdata)] <- paste(names(fdata)[j], "calc", sep = "")
}

##Clean and convert columns 114:131
for (j in 114:131){
  
  ##Clean and convert columns and split into new dataframe separated by /.... 
  fdata[,j] <- sub(fdata[,j], pattern = "\\s+", replacement = "")
  fdata[,j] <- sub(fdata[,j], pattern = "\\s+", replacement = "")                            
  
  ##split vector into list and create new split dataframe
  tmp <- strsplit(fdata[,j], split="/")
  tmpv <- NULL
  nMax <- max(sapply(tmp, length))
  tmpv <- cbind(tmpv, t(sapply(tmp, function(i) i[1:nMax])))
  splitdf <- as.data.frame(tmpv)
  colnames(splitdf) <- c("Col1", "Col2")
  splitdf$Col1 <- as.numeric(as.character(splitdf$Col1))
  splitdf$Col2 <- as.numeric(as.character(splitdf$Col2))
  
  ##set calc vector to be empty
  calc <- NULL
  
  ##if NA in column 2 then will require  calculation number per 100 cycles, then copy calculation to new calc vector
  ##Else just copy data to new calc vector
  for (i in 1:nrow(splitdf)){
    if (is.na(splitdf[i,2])) {
      calc[i] <- splitdf[i,1]
    }
    else {
      calc[i] <- round(splitdf[i,1]/splitdf[i,2],2)
    } 
  }
  
  ##bind new column to final data set
  fdata <- cbind(fdata, calc)
  colnames(fdata)[ncol(fdata)] <- paste(names(fdata)[j], "calc", sep = "")
}

############################INPUTS###########################################
##Column names where calculations were not performed on the stats
nocalcstats <- c("FshNDCycle","FshNDEmbryosRate","FshNDTransfers","FshNDPregnancies")

##Age range: <35, 35-37, 38-40, 41-42, 43-44, >44
age <- list("<35"=1,"35-37"=2,"38-40"=3,"41-42"=4,"43-44"=5,">44"=6)

state_list <- levels(fdata$ClinStateCode)
# df_state_list <- as.data.frame(state_list)
# colnames(df_state_list) <- "State_Name"

fstats_list <- list("Number of Cycles"="FshNDCycle","% of cancellations"="FshNDCansRate","Number of embryos transferred"="FshNDEmbryosRate",
                    "% of embryos transferred resulting in implantation"="FshNDImplant","% of elective single embryo transfer"="FshNDeSETRate",
                    "% of cycles resulting in Singleton live births"="FshNDSnglLBRate","% of cycles resulting in Triplets or more live births"="FshNDTripLBRate",
                    "% of cyles resulting in Live births"="FshNDLvBirthsRate","% of cycles resulting in pregnancy"="FshNDPregRate","Number of transfers"="FshNDTransfers",
                    "% of transfers resulting in Singleton live births"="FshNDSnglLB_TransRate","% of transfers resulting in Triplets or more live births"="FshNDTripLB_TransRate",
                    "% of transfers resulting in Live births"="FshNDLvBirths_TransRate","% of transfers resulting in Pregnancies"="FshNDTransPregRate",
                    "Number of pregnancies"="FshNDPregnancies","% of pregnancies resulting in Singleton live births"="FshNDSnglLB_PregRate",
                    "% of pregnancies resulting in Triplets or more live births"="FshNDTripLBRate","% of pregnancies resulting in Live births"="FshNDLvBirths_PregRate")

##getting state codes from ISO list
# states_ISO <- read.csv("./data/state_codes.csv", header = TRUE, stringsAsFactors = FALSE)
# merdata <- merge(df_state_list, states_ISO, by = "State_Name", all.x = TRUE)
