# Plot Themes
# by Jack Hester
# contains functions to set color schemes for plots

source("colors.R") #requires colors.R file for certain color schemes

# set color scheme for plot command (par)
set.plot.colorscheme <- function(scheme) {
  default.par <- par()
  if (scheme=='dark'){ #  black background, white labels/text/axes
    par(bg="black", col.main='white', col.lab='white', col.axis='white', col='white')
  }
  #TODO: add more colorscheme options
  #else if(){
  #  
  #}
}

# configure ggplot theme with user provided color scheme
# Usage:
#   theme <- set.ggplot.colorscheme(scheme, gridOn)
#   ggplot(...) + theme()
set.ggplot.colorscheme <- function(scheme, gridOn=TRUE){
  if(scheme=="dark"){
    x <- theme(
      panel.background = element_rect(fill = "black", color = "white",
                                      size = 1, linetype = "solid"),
      plot.background = element_rect(fill = "black"),
      title = element_text(color='white'),
      axis.title = element_text(color="white"),
      axis.text = element_text(color="white"),
      axis.ticks = element_line(color="white"),
      legend.background = element_rect(color="white")
      
    )
    #TODO: set border to white and labels to white
  }
  
  if(gridOn!=TRUE){
    x$panel.grid.minor <- element_blank()
    x$panel.grid.major <- element_blank()
  }
  
  return(x)
  rm(x)

}