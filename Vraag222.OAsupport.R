#Vraag222.OAsupport.R



win.graph(14,7)
par(mfrow=c(1,2))
i=1
xx <- barplot(support.per.role[,i],xlab="carreer group",ylim=c(0,119), 
              main=paste(colnames(support.per.role)[i]," per carreer group",sep=""), 
              cex.names = 0.7,horiz=F,las=1,ylab="% support",col=Kleuren)
text(x=xx, y=support.per.role[,i],label=paste('n=',respondenten.per.rol,sep=''), 
     pos=3, cex=0.8)
i=2
xx <- barplot(support.per.role[,i],xlab="carreer group",ylim=c(0,119), 
              main=paste(colnames(support.per.role)[i]," per carreer group",sep=""), 
              cex.names = 0.7,horiz=F,las=1,ylab="% support",col=Kleuren)
text(x=xx, y=support.per.role[,i],label=paste('n=',respondenten.per.rol,sep=''), 
     pos=3, cex=0.8)
