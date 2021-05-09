## INFO
# this code is used to read a the data recorded by "sorting and analysis" program (LabView) on the 
# workstations of the Merten Lab at EMBL, and create scater plots

## NEEDED LIBRARIES
library(MASS)
library(ggplot2)
library(viridis)
theme_set(theme_bw(base_size = 16))

# DATA IMPORT
# set the working directory to the data

##plot 1 (1:50)
setwd("/Users/twenzel/Documents/AnnaP-Experiment-Results/2B. B. subtilis 1 in 50 FALk 2B/01.02.2018")
df = read.table("50 @31.01.2018_10_56_13.txt", header=FALSE, skip=22, dec=",") #with df_cut<-df[100:470000,]

##plot 2 (1:100)
setwd("/Users/twenzel/Documents/AnnaP-Experiment-Results/1A. B. subtilis 1 in 100 FALk 1A/12-13.12.17")
df = read.table("100 @12.12.2017_09_34_39.txt", header=FALSE, skip=22, dec=",") # with df_cut<-df[100:220000,]

##plot 3 (1:250)
setwd("/Users/twenzel/Documents/AnnaP-Experiment-Results/3. B. subtilis 1 in 250 FALk 04A/sort 17.01.18")
df = read.table("250 @17.01.2018_10_08_50.txt", header=FALSE, skip=22, dec=",") #use df_cut<-df[100:315000,]

# convert datatype
head(df)
df[, 1] <- as.numeric(as.character( df[, 1] ))
df[, 2] <- as.numeric(as.character( df[, 2] ))
df[, 3] <- as.numeric(as.character( df[, 3] ))
df[, 4] <- as.numeric(as.character( df[, 4] ))
df[, 5] <- as.numeric(as.character( df[, 5] ))
df[, 6] <- as.numeric(as.character( df[, 6] ))
df[, 7] <- as.numeric(as.character( df[, 7] )) 
# trimm data for easy calculations and plotting
df_cut<-df[100:470000,]
df_cut<-df[100:220000,]
df_cut<-df[100:315000,]
# df_cut <- df #if data does not have to be trimmed

## plotting with hex-bin density function with bin size control + color palette
ggplot(df_cut, aes(x = V2, y = V6)) +
  geom_hex(bins = 150) +
  scale_fill_continuous(type = "viridis", guide = guide_colorbar(barheight = 25), trans = "log")+
  theme_bw() +
  
  # applying max and min value to the axes
  ylim(0, 1.5) +
  xlim(0, 0.35) +
  
  # labels for the axes
  labs(y = "width") +
  labs(x = "fluorescence (green)") +
  
#   # Adjust binning values according to experiment notes
#   geom_hline(yintercept = 0.0)+
#   geom_vline(xintercept = 0.12)+
#   geom_hline(yintercept = 1.24, linetype = "longdash")+
#   geom_vline(xintercept = 0.35, linetype = "longdash")
# 
# # output of total droplets and positive droplets (within bin)
# dim(df_cut["V2"])[1]
# pop<-which(df_cut["V2"]>0.12 & df_cut["V2"]<0.35 & df_cut["V6"]<1.24)
# length(pop)
# length(pop)/dim(df_cut["V2"])[1]

#   # Adjust binning values according to experiment notes
#   geom_hline(yintercept = 0.0)+
#   geom_vline(xintercept = 0.09)+
#   geom_hline(yintercept = 1, linetype = "longdash")+
#   geom_vline(xintercept = 0.25, linetype = "longdash")
#  
# # output of total droplets and positive droplets (within bin)
# dim(df_cut["V2"])[1]
# pop<-which(df_cut["V2"]>0.09 & df_cut["V2"]<0.25 & df_cut["V6"]<1)
# length(pop)
# length(pop)/dim(df_cut["V2"])[1]

  # Adjust binning values according to experiment notes
  geom_hline(yintercept = 0.0)+
  geom_vline(xintercept = 0.15)+
  geom_hline(yintercept = 1.48, linetype = "longdash")+
  geom_vline(xintercept = 0.35, linetype = "longdash")

# output of total droplets and positive droplets (within bin)
dim(df_cut["V2"])[1]
pop<-which(df_cut["V2"]>0.15 & df_cut["V2"]<0.35 & df_cut["V6"]<1.48)
length(pop)
length(pop)/dim(df_cut["V2"])[1]