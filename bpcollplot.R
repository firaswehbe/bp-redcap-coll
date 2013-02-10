# Erase Workspace and read the most recent data 
# (need to run the Python script first or you can
# download and save the spreadsheet locally, but 
# you will have to name the file and variables correctly
rm=(list=ls())
a = read.csv("bpcoll_current.csv",stringsAsFactors=FALSE)
# Note that bptime column will be treated as POSIXct class so 
# multiple measurements during the same day are ordered correctly
bpcoll = data.frame(bptime=strptime(a$timestamp,'%Y-%m-%d %H:%M'),sbp=a$sbp,dbp=a$dbp)
# Initialize to a png device, you can modify the resolution.
# I am optimizing for mobile screen - not sure if 640 x 480 is best
png(filename="bpcoll_current.png",width=640,height=480)
plot(sbp~bptime,data=bpcoll,ylim=c(50,200),type="o",ylab="",xlab="",col="blue",lwd=3)
lines(dbp~bptime,data=bpcoll,col="blue",lwd=3,type="o")
abline(h=c(seq(50,200,10)))
abline(h=c(seq(50,200,50)),lwd=3)
# High blood pressure is considered systolic bp > 140; diastolic > 90
# Mark those thresholds with red lines
abline(h=c(90,140),lwd=2,col="red")
title(main="Systolic and Diastolic Blood Pressure")
dev.off()
