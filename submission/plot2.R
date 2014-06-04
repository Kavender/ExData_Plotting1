###download and upzip the file in current working directory
#otherwishe use "file.choose()" to find the file location

power=read.table("household_power_consumption.txt",header=TRUE,sep=";")
dim(power)             #2075259  9
head(power)
subpower=power[power$Date %in% c("1/2/2007","2/2/2007"), ]
dim(subpower)          #2880    9

#transform the data type of Date & Time, create a new var called datetime

subpower[[1]]<-as.Date(subpower[[1]],format="%d/%m/%Y")
datetime<-paste(subpower$Date,subpower$Time)
datetime<-strptime(datetime,format='%Y-%m-%d %H:%M:%S')
subpower<-cbind(subpower,datetime)
head(subpower)

#Plot2
png(file="plot2.png",width=480,height=480,units="px")
with(subpower,plot(datetime,as.numeric(as.character(subpower$Global_active_power)),
                   xlab="",ylab="Global Active Power (kilowatts)",type="l")
     )
dev.off()
