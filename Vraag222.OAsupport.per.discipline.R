#Vraag222.OAsupport.R



win.graph(14,7)
par(mar = c(8,6,4,1) +0.1)
par(mfrow=c(1,2))

i=1
xx <- barplot(OAsupport.per.discipline[,i],ylim=c(0,119), 
        main=paste(colnames(OAsupport.per.discipline)[i]," per discipline",sep=""),
        cex.names = 0.7,horiz=F,las=2,ylab="percentage support",col=Kleuren.disciplines)
text(x=xx, y=OAsupport.per.discipline[j,i],label=paste('n=',respondenten.per.discipline,sep=''), 
 pos=3, cex=0.8)

i=2
xx <- barplot(OAsupport.per.discipline[,i],ylim=c(0,119), 
        main=paste(colnames(OAsupport.per.discipline)[i]," per discipline",sep=""), 
        cex.names = 0.7,horiz=F,las=2,ylab="percentage support",col=Kleuren.disciplines)
text(x=xx, y=OAsupport.per.discipline[j,i],label=paste('n=',respondenten.per.discipline,sep=''), 
 pos=3, cex=0.8)
