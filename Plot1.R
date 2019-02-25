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
# png graphical device for plot1
png(file="plot1.png")
# Plot histogram that matches the one given for plot1
hist(Data$Global_active_power,col='red',xlab="Global Active Power (kilowatts)",main='Global Active Power')
# close the graphical device
dev.off()
