######
#
# This function we use to plot demographics
# input is the title, column labels, column values
# output is a horizontal graph
#
# For example fill these variables
# plot_main <- c("respondents: geographical groups")
# plot_labels <- c("World Wide", "OECD", "Netherlands", "VU&VUmc")
# plot_values <- c(20663, 15752, 2041, 531)
# plot_colors <- cm.colors(length(plot_values))
#
# call the function
# demographicsplot(plot_main, plot_labels, plot_values, plot_colors)
#
######


demographicsplot <- function(plot_main, plot_labels, plot_values, plot_colors){
  size <- barplot(rev(plot_values),
                  horiz=TRUE,
                  names.arg=rev(plot_labels),
                  las=2,
                  cex.names = 0.7,
                  cex.axis = 0.7,
                  col=rev(plot_colors),
                  main = plot_main, font.main = 1
  )

  plotwithtext <- text(plot_values,
                       rev(size),
                       labels=plot_values,
                       xpd=TRUE,
                       cex = 0.7,
                       col="darkblue")

  return(plotwithtext)

}
