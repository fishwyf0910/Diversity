setwd("E:\\Rworkspace\\diversity")

library(openxlsx)
library(reshape2)
library(vegan)

herb.data <- read.xlsx("diversity-input.xlsx")

herb.mat <- acast(herb.data, 
             formula = plotname ~ species , 
             value.var = "abundance", 
             fill = 0)

# Shannon-Wiener指数
Shannon.Wiener <- diversity(herb.mat, index = "shannon")

# Simpson指数
Simpson <- diversity(herb.mat, index = "simpson")

# Inverse Simpson指数
Inverse.Simpson <- diversity(herb.mat, index = "inv")

# 物种累计数
S <- specnumber(herb.mat)
plot(S)

# Pielou均匀度指数
Pielou <- Shannon.Wiener/log(S)

# Simpson丰富度
Simpson_evenness<- Inverse.Simpson/S

#合并，导出
report=cbind(Shannon.Wiener, Simpson , Inverse.Simpson, Pielou, Simpson_evenness)
write.table(report,file="diversity-output.xlsx",sep="\t",col.names=NA)
