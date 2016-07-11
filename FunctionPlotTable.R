#FunctionPlotTable.R

#Deze functie plot een tabel en geeft elke kolom een eigen kleur, gespecificeerd in colors
#koppen in kolom en rij van de tabel komen uit d (colnames & rownames) 
#inhoud van de cellen komt uit de cellen van 'd'
#marginColor bepaalt de kleur van de eerste kolom en rij met daarin de koppen
#in main staat de titel van de tabel
plot_table <- function(d, colors, marginColor,main="", text.cex=1.0)
{
  plot(c(-1,ncol(d)),c(0,nrow(d)+1), type="n", xaxt="n", yaxt="n", 
       xlab="",ylab="",main=main, bty="n")
  
  #kleur eerste rij in marginColor en vul met kolomnamen
  for (c in 1:ncol(d)) {
    rect(c-1, nrow(d), c, nrow(d) + 1, col=marginColor)
    text(c-.5,nrow(d) +.5,colnames(d)[c], cex=text.cex)
  }
  
  #kleur eerste kolom in marginColor en vul met rij-namen
  for (r in 1:nrow(d)) {
    rect(-1, r-1, 0, r, col=marginColor)
    text(-.5, r-.5,rownames(d)[nrow(d) - r + 1], cex=text.cex)
  }
  
  #vul en kleur achtergrond cellen
  for (r in 1:nrow(d))
    for (c in 1:ncol(d)) {
      rect(c-1, r-1, c, r, col=colors[c])
      text(c-.5,r-.5,d[nrow(d) - r + 1,c], cex=text.cex)
    }
}
