#install.packages("dplyr")
library(dplyr)

virion_data <- read.csv("question-5-data/Cui_etal2014.csv")
ncol(virion_data)
nrow(virion_data)

virion_data$log_volume <- log(virion_data$Virion.volume..nm.nm.nm.)
virion_data$bases <- (virion_data$Genome.length..kb.) * 1
virion_data$log_bases <- log(virion_data$bases)

model1 <- lm(log_volume ~ log_bases, data = virion_data)
summary(model1)


ggplot(data = virion_data, aes(x=log_bases, y=log_volume)) + 
  geom_point() +
  xlab("log [Genome length (kb)]") + 
  ylab("log [Virion volume (nm3)]") +
  geom_smooth(method = 'lm') +
  theme_minimal() +
  theme(panel.border = element_rect(color = "black", fill = NA, size = 1))
