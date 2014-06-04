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

#Plot3
png(file="plot3.png",width=480,height=480,units="px")
with(subpower,
      plot(datetime,as.numeric(as.character(subpower$Sub_metering_1)),xlab="",ylab="Energy sub metering",type="n")
     
     )
      lines(datetime,as.numeric(as.character(subpower$Sub_metering_1)),col="black")
      lines(datetime,as.numeric(as.character(subpower$Sub_metering_2)),col="red")
      lines(datetime,as.numeric(as.character(subpower$Sub_metering_3)),col="blue")
      
      legend("topright",names(subpower)[7:9],lty=1,col=c("black","red","blue"))

dev.off()

