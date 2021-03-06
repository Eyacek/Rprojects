#Healthy Teacher Q's


#Import Relevant Packages

library(knitr)
library(ggplot2)
library(tidyr)
library(plyr)
library(dplyr)
library(nhanesA)

#Merge NHANES 2007-2009
OCP_E2007 <- nhanes('OCQ_E')
OCP_F2009 <- nhanes('OCQ_F')
Diet2007 <- nhanes('DBQ_E')
Diet2009 <- nhanes('DBQ_F')
TEACHERS2007 <- filter(OCP_E2007, OCD231 == 15 & OCD241 == 8 )
TEACHERS2009 <- filter(OCP_F2009, OCD231 == 15 & OCD241 == 8 )
TEACHERS2007 <- merge(TEACHERS2007, Diet2007)
TEACHERS2009 <- merge(TEACHERS2009, Diet2009)
commoncols <- intersect(colnames(TEACHERS2007), colnames(TEACHERS2009))
teacherCombine<- 
  rbind(
    subset(TEACHERS2007, select = commoncols), 
    subset(TEACHERS2009, select = commoncols)
  )

healthyDietQ <- as.data.frame(table(teacherCombine$DBQ700))
healthyDietQ$Var1 <- c("Excellent","Very good", "Good", "Fair", "Poor")
ggplot(healthyDietQ, aes(x=Var1, y = Freq*100/288)) + geom_bar(stat="identity" , fill = "sky blue")+
  geom_text(aes(label = sprintf("%.2f%%", Freq/sum(Freq) * 100)), vjust = -.5)+ labs(title = "How healthy is your diet?", x = "Rating(1-5)", y = "PCT")
  
healthyDietQ2007 <- as.data.frame(table(TEACHERS2007$DBQ700))
healthyDietQ2007$Var1 <- c("Excellent","Very good", "Good", "Fair", "Poor")
ggplot(healthyDietQ2007, aes(x=Var1, y = Freq*100/288)) + geom_bar(stat="identity" , fill = "sky blue")+
  geom_text(aes(label = sprintf("%.2f%%", Freq/sum(Freq) * 100)), vjust = -.5)+ labs(title = "How healthy is your diet?", x = "Rating(1-5)", y = "PCT")

healthyDietQ2009 <- as.data.frame(table(TEACHERS2009$DBQ700))
healthyDietQ2009$Var1 <- c("Excellent","Very good", "Good", "Fair" )
ggplot(healthyDietQ2009, aes(x=Var1, y = Freq*100/288)) + geom_bar(stat="identity" , fill = "sky blue")+
  geom_text(aes(label = sprintf("%.2f%%", Freq/sum(Freq) * 100)), vjust = -.5)+ labs(title = "How healthy is your diet?", x = "Rating(1-5)", y = "PCT")
