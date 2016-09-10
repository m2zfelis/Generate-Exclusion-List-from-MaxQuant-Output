library(reshape2)
library(ggplot2)
library(RColorBrewer)
library(scales)
library(gplots)
library(topGO)
library(dplyr)
library(igraph)
source("/Users/tly/Documents/Current R Analyses/R library/TLfun.R")
setwd(dir="~/Documents/Current Projects/FACS Mitotic Substages/SumMit/MS Data/Triplicate/")
options(stringsAsFactors=FALSE)

#read-in template for exclusion list
exclusion_template <- read.csv("Mass List Table.csv", check.names = F)
#read in msms file
msms <- read.delim("exclusion_1/msms.txt")
#remove dupes
msms_nodupes <- msms[!duplicated(msms[,c("Sequence", "Modifications")]),]
#define the PT experiments to generate the exclusion list
TMT_PTid <- "PT6421"
#create a new table filtered for specific PT id
msms_PTid <- msms_nodupes[grep(TMT_PTid, msms_nodupes$Raw.file),]


#create a new table filtered for specific raw file


for(this.raw in unique(msms_PTid$Raw.file)) {
  msms_this.raw <- msms_PTid[grep(this.raw, msms_PTid$Raw.file),]
  
  TMT_6plex_massmod <- 229.162932
  
  rt_width <- 7
  msms_this.raw$m.z_TMT <- msms_this.raw$m.z + (TMT_6plex_massmod/msms_this.raw$Charge)
  msms_this.raw$start <- msms_this.raw$Retention.time - rt_width
  msms_this.raw$end <- msms_this.raw$Retention.time + rt_width
  msms_this.raw$end[msms_this.raw$end>140] <- 140
  
  exclusion_list <- msms_this.raw[,c("m.z_TMT", "Charge", "Modified.sequence", "start", "end")]
  colnames(exclusion_list) <- colnames(exclusion_template)
  write.table(exclusion_list, file = paste0(this.raw, "_exclusionlist.csv"), quote = F, sep = ",", row.names = F)
}
