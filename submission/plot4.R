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

#plot4
##the legend of The third plot do not have border!!

png(file="plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2),mar=c(4,4,2,1))
with(subpower,{
     plot(datetime,as.numeric(as.character(subpower$Global_active_power)),
                   xlab="",ylab="Global Active Power (kilowatts)",type="l")

     plot(datetime,as.numeric(as.character(subpower$Voltage)),
                   ylab="Voltage",type="l")


    plot(datetime,as.numeric(as.character(subpower$Sub_metering_1)),xlab="",ylab="Energy sub metering",type="n")
      lines(datetime,as.numeric(as.character(subpower$Sub_metering_1)),col="black")
      lines(datetime,as.numeric(as.character(subpower$Sub_metering_2)),col="red")
      lines(datetime,as.numeric(as.character(subpower$Sub_metering_3)),col="blue") 
      legend("topright",names(subpower)[7:9],lty=1,bty='n',col=c("black","red","blue"))

     plot(datetime,as.numeric(as.character(subpower$Global_reactive_power)),
                   ylab="Global_reactive_power",type="l")
    })
dev.off()
