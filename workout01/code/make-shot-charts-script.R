curry <- read.csv("stephen-curry.csv",stringsAsFactors=FALSE)
iguodala <- read.csv("andre-iguodala.csv",stringsAsFactors = FALSE)
green <- read.csv("draymond-green.csv",stringsAsFactors = FALSE)
durant <- read.csv("kevin-durant.csv",stringsAsFactors = FALSE)
klay <- read.csv("klay-thompson.csv",stringsAsFactors = FALSE)

library("ggplot2")
klay_scatterplot <- ggplot(data=klay)+geom_point(aes(x=x,y=y,color=shot_made_flag))
library("jpeg")
library("grid")
court_file <- "../image/nba-court.jpg"
court_image <- rasterGrob(readJPEG(court_file),width=unit(1,"npc"),height=unit(1,"npc"))

klay_shot_chart <- ggplot(data=klay)+annotation_custom(court_image,-250,250,-50,420)+geom_point(aes(x=x,y=y,color=shot_made_flag))+ylim(-50,420)+ggtitle('Shot Chart: Klay Thompson(2016 seaosn)')+theme_minimal()

pdf(file="../image/klay_thompson_shot_chart.pdf",width = 6.5,height = 5)
klay_shot_chart
dev.off()

curry_shot_chart <- ggplot(data=curry)+annotation_custom(court_image,-250,250,-50,420)+geom_point(aes(x=x,y=y,color=shot_made_flag))+ylim(-50,420)+ggtitle('Shot Chart: curry (2016 seaosn)')+theme_minimal()

pdf(file="../image/stephen_curry_shot_chart.pdf",width = 6.5,height = 5)
curry_shot_chart
dev.off()

green_shot_chart <- ggplot(data=curry)+annotation_custom(court_image,-250,250,-50,420)+geom_point(aes(x=x,y=y,color=shot_made_flag))+ylim(-50,420)+ggtitle('Shot Chart: green (2016 seaosn)')+theme_minimal()

pdf(file="../image/draymond_green_shot_chart.pdf",width = 6.5,height = 5)
green_shot_chart
dev.off()

durant_shot_chart <- ggplot(data=durant)+annotation_custom(court_image,-250,250,-50,420)+geom_point(aes(x=x,y=y,color=shot_made_flag))+ylim(-50,420)+ggtitle('Shot Chart: durant (2016 seaosn)')+theme_minimal()

pdf(file="../image/kevin_durant_shot_chart.pdf",width = 6.5,height = 5)
durant_shot_chart
dev.off()


iguodala_shot_chart <- ggplot(data=iguodala)+annotation_custom(court_image,-250,250,-50,420)+geom_point(aes(x=x,y=y,color=shot_made_flag))+ylim(-50,420)+ggtitle('Shot Chart: iguodala (2016 seaosn)')+theme_minimal()

pdf(file="../image/andre_iguodala_shot_chart.pdf",width = 6.5,height = 5)
iguodala_shot_chart
dev.off()

g <- ggplot(data=curry)+annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+ylim(-50,420)+
  theme_minimal()
i<- ggplot(data=iguodala)+annotation_custom(court_image,-250,250,-50,420)+geom_point(aes(x=x,y=y,color=shot_made_flag))+ylim(-50,420)+theme_minimal()
d <- ggplot(data=durant)+annotation_custom(court_image,-250,250,-50,420)+geom_point(aes(x=x,y=y,color=shot_made_flag))+ylim(-50,420)+theme_minimal()
c <- ggplot(data=curry)+annotation_custom(court_image,-250,250,-50,420)+geom_point(aes(x=x,y=y,color=shot_made_flag))+ylim(-50,420)+theme_minimal()
k <- ggplot(data=klay)+annotation_custom(court_image,-250,250,-50,420)+geom_point(aes(x=x,y=y,color=shot_made_flag))+ylim(-50,420)+theme_minimal()

library(grid)
library(gridExtra)
pdf(file="../image/gsw_shot_chart.pdf",width = 8,height = 7)
grid.arrange(g,i,d,c,k,nrow=2,ncol=3)
dev.off()

png(filename ="../image/gsw_shot_chart.png",width = 8,height = 7)
grid.arrange(g,i,d,c,k,nrow=2,ncol=3)
dev.off()
