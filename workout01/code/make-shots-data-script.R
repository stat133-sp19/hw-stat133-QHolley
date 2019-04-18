##title:the r code for the shots-data-summary and relative files
##description: it is about the the third part of workout01
##inputs:the inputs are 5 row materials
##outputs: the outputs includes andre_iguodala.txt,draymond_green,kevin_durant.txt,klay_thompson.txt
##stephen_curry.txt,shots_data.csv,shots-data-summary.txt

curry <- read.csv("stephen-curry.csv",stringsAsFactors=FALSE)
iguodala <- read.csv("andre-iguodala.csv",stringsAsFactors = FALSE)
green <- read.csv("draymond-green.csv",stringsAsFactors = FALSE)
durant <- read.csv("kevin-durant.csv",stringsAsFactors = FALSE)
klay <- read.csv("klay-thompson.csv",stringsAsFactors = FALSE)

cnameC <- paste0(colnames(curry),"_curry")
colnames(curry) <- cnameC

cnameI <- paste0(colnames(iguodala),"_iguodala")
colnames(iguodala) <- cnameI

cnameG <- paste0(colnames(green),"_green")
colnames(green) <- cnameG

cnameD <- paste0(colnames(durant),"_durant")
colnames(durant) <- cnameD

cnameK <- paste0(colnames(klay),"_klay")
colnames(klay) <- cnameK

for(i in 1:length(curry$shot_made_flag_curry) ){
  if(curry$shot_made_flag_curry[i]=="y"){curry$shot_made_flag_curry[i]="shot_yes"}
  else{if(curry$shot_made_flag_curry[i]=="n"){curry$shot_made_flag_curry[i]="shot_no"}}
}

for(i in 1:length(durant$shot_made_flag_durant) ){
  if(durant$shot_made_flag_durant[i]=="y"){durant$shot_made_flag_durant[i]="shot_yes"}
  else{if(durant$shot_made_flag_durant[i]=="n"){durant$shot_made_flag_durant[i]="shot_no"}}
}

for(i in 1:length(green$shot_made_flag_green) ){
  if(green$shot_made_flag_green[i]=="y"){green$shot_made_flag_green[i]="shot_yes"}
  else{if(green$shot_made_flag_green[i]=="n"){green$shot_made_flag_green[i]="shot_no"}}
}
for(i in 1:length(iguodala$shot_made_flag_iguodala) ){
  if(iguodala$shot_made_flag_iguodala[i]=="y"){iguodala$shot_made_flag_iguodala[i]="shot_yes"}
  else{if(iguodala$shot_made_flag_iguodala[i]=="n"){iguodala$shot_made_flag_iguodala[i]="shot_no"}}
}

for(i in 1:length(klay$shot_made_flag_klay) ){
  if(klay$shot_made_flag_klay[i]=="y"){klay$shot_made_flag_klay[i]="shot_yes"}
  else{if(klay$shot_made_flag_klay[i]=="n"){klay$shot_made_flag_klay[i]="shot_no"}}
}


curry$minute_curry <- curry$period_curry*12-curry$minutes_remaining_curry
durant$minute_durant <- durant$period_durant*12-durant$minutes_remaining_durant
green$minute_green <- green$period_green*12-green$minutes_remaining_green
iguodala$minute_iguodala <- iguodala$period_iguodala*12-iguodala$minutes_remaining_iguodala
klay$minute_klay <- klay$period_klay*12-klay$minutes_remaining_klay

sink(file = '../output/andre_iguodala.txt')
summary(iguodala)
sink()

sink(file = '../output/draymond_green.txt')
summary(green)
sink()

sink(file = '../output/kevin_durant.txt')
summary(durant)
sink()

sink(file = '../output/klay_thompson.txt')
summary(klay)
sink()

sink(file = '../output/stephen_curry.txt')
summary(curry)
sink()

curry1 <- read.csv("stephen-curry.csv",stringsAsFactors=FALSE)
curry2 <- c(colnames(curry1),"minutes")
colnames(curry) <- curry2
colnames(green) <- curry2
colnames(klay) <- curry2
colnames(durant) <- curry2
colnames(iguodala) <- curry2


bindd <- rbind(curry,green,klay,iguodala,durant)
write.csv(bindd,file="shots_data.csv")

sink(file = '../output/shots-data-summary.txt')
summary(bindd)
sink()