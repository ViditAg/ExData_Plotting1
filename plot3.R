# Date for which plots are made
StartDate<-'2007-02-01' 
EndDate<-'2007-02-02'
StartDate<-as.Date(StartDate,format='%Y-%m-%d')
EndDate<-as.Date(EndDate,format='%Y-%m-%d')
## File name
file <- "household_power_consumption.txt"
## Create connection
con <- file(description=file, open="r")
# scan one line from the text file
tmp1 <- scan(file=con,what=character(), nlines=1, quiet=TRUE)
# write first line which is column names to another text file 
write(tmp1, file = "data.txt")
# read the original text data file till you reach the dates you need
repeat {
  tmp <- scan(file=con,what=character(), nlines=1, quiet=TRUE)
  # extract date which is the first element after splitting by ;
  Datecut<-as.Date(strsplit(tmp,";")[[1]][1],format="%d/%m/%Y")
  # break out once you reach StartDate
  if (Datecut==StartDate){
    break;
  }
}
# loop over the dates you need
while(Datecut %in% c(StartDate,EndDate)){
  # append datat to new text file created above that has columns
  write(tmp, file = "data.txt",append=TRUE)
  tmp <- scan(file=con,what=character(), nlines=1, quiet=TRUE)
  Datecut<-as.Date(strsplit(tmp,";")[[1]][1],format="%d/%m/%Y")
}
# remember to close the connection
close(con)
# now read data from the new text file created by above steps
Data<-read.table('data.txt',header=TRUE,sep=";")
ymax<-max(c(max(Data$Sub_metering_1),max(Data$Sub_metering_2),max(Data$Sub_metering_3)))
# png graphical device for plot1
png(file="plot3.png")
# Plot multiple lines graph that matches the one given for plot3
with(Data,plot(Sub_metering_1,type="l",col='black',ylab="Energy sub metering",xlab="",xaxt="n",ylim=c(0, ymax)))
par(new=T)
with(Data,plot(Sub_metering_2,type="l",col='red',ylab="Energy sub metering",xlab="",xaxt="n",ylim=c(0, ymax)))
par(new=T)
with(Data,plot(Sub_metering_3,type="l",col='blue',ylab="Energy sub metering",xlab="",xaxt="n",ylim=c(0, ymax)))
axis(1, at=c(1,1440,2880), labels=c('Thu','Fri','Sat'))
legend("topright",lty=1,col=c("black",'red','blue'),legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
# close the graphical device
dev.off()
