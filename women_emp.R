#Datasettet inneholder informasjon om generøsiteten av forldrepermisjonsordninger og må endres til yrkesdeltakelse i 24 OECD-land i 2021
# Foreldrepermisjonene varierer mellom land. 
# For å gjøre ulike landers rettigheter sammenlignbare presenteres permisjonsordningers gunstighet
# ved hjelp av "full rate equivalent":
# Uker med 100% støtte  = Foreldrepermisjonens varighet i uker * utbetalingssats (i prosent av gjennomsnittlig inntekt) 

library(tidyverse)
library(grid)
library(readr) 
library(reshape2)
library(gridExtra)

women<-read.csv2("https://uit-sok-2008-h22.github.io/Assets/women.csv")

women$tot_full_rate<-as.numeric(women$tot_full_rate)
women$fem_emp_rate_0_2<-as.numeric(women$fem_emp_rate_0_2)
women$fem_emp_rate_6_14<-as.numeric(women$fem_emp_rate_6_14)


library(ggplot2)
women%>%
  ggplot(aes(x=tot_full_rate,y=fem_emp_rate_0_2))+
  geom_point()+
  ylim(0, 100)+
  labs(x ="Uker med 100% støtte", y = "Yrkesdeltakelse blant mødre\n hvis yngste barn er 0-2 år")+
  geom_smooth(method=lm, se=FALSE) -> kids_0_2

women%>%
  ggplot(aes(x=tot_full_rate,y=fem_emp_rate_6_14))+
  geom_point()+
  ylim(0, 100)+
  labs(x ="Uker med 100% støtte", y = "Yrkesdeltakelse blant mødre\n hvis yngste barn er 6-14 år")+
  geom_smooth(method=lm, se=FALSE) -> kids_6_14

library(gridExtra)
library(grid)
grid.arrange(kids_0_2,kids_6_14, nrow = 1,  top = textGrob("Sammenhengen mellom foreldrepermisjons lengde og\n mødres yrkesdeltakelse etter yngste barns alder",gp=gpar(fontsize=15 ,font=3)))
