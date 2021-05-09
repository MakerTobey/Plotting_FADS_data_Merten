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
setwd("/Users/twenzel/Documents/AnnaP-Experiment-Results/4. B. vulgatus sort/21.02.18 sort")
df = read.table("vulgatus 1 @21.02.2018_14_15_03.txt", header=FALSE, skip=22, dec=",")

setwd("/Users/twenzel/Documents/AnnaP-Experiment-Results/4. B. vulgatus sort/020318 sort 2")
df = read.table("vulgatus 2 @28.02.2018_15_09_46.txt", header=FALSE, skip=22, dec=",")

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
df_cut<-df[100:120199,]
df_cut<-df[100:145099,]
# df_cut <- df #if data is not to be trimmed

## plotting with hex-bin density function with bin size control + color palette
ggplot(df_cut, aes(x = V2, y = V6)) +
  geom_hex(bins = 150) +
  scale_fill_continuous(type = "viridis", guide = guide_colorbar(barheight = 25), trans = "log")+
  theme_bw() +
  
  # applying max and min value to the axes
  ylim(0, 1.5) +
  xlim(0, 0.25) +
  
  # labels for the axes
  labs(y = "width") +
  labs(x = "fluorescence (green)") +
  
  # Adjust binning values according to experiment notes
  geom_hline(yintercept = 0.0)+
  geom_vline(xintercept = 0.1)+
  geom_hline(yintercept = 1.0, linetype = "longdash")+
  geom_vline(xintercept = 0.25, linetype = "longdash")

# output of total droplets and positive droplets (within bin)
dim(df_cut["V2"])[1]
pop<-which(df_cut["V2"]>0.1 & df_cut["V2"]<0.27 & df_cut["V6"]<1)
length(pop)
length(pop)/dim(df_cut["V2"])[1]

    # Adjust binning values according to experiment notes
#   geom_hline(yintercept = 0.0)+
#   geom_vline(xintercept = 0.1)+
#   geom_hline(yintercept = 1.2, linetype = "longdash")+
#   geom_vline(xintercept = 0.2, linetype = "longdash")
#
## output of total droplets and positive droplets (within bin)
# dim(df_cut["V2"])[1]
# pop<-which(df_cut["V2"]>0.1 & df_cut["V2"]<0.20 & df_cut["V6"]<1.2)
# length(pop)
# length(pop)/dim(df_cut["V2"])[1]
