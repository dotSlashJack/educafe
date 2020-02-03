# frame builder
# create series of pngs from plots that can be turned into animations
# helpful precursor tools to animation-engine.R
# by Jack Hester

#

generatePNGs <- function(list.of.plots, saveDir=getwd()){
  i = 0
  sysinf <- Sys.info()
  for(p in list.of.plots){
    #if(sysinf['sysname']=='Windows'){
    #  print('ran')
    #  name <- paste0(saveDir,'\\frame',i,'.png')
    #  print(name)
    #  png(name)
      #p
    #  dev.off()
    #}
    #else{
    #  name <- paste0(saveDir,'/frame',i,'.png')
    #  png(name)
    #  print(p)
    #  dev.off()
    #}
    name <- paste0(saveDir,'/frame',i,'.png')
    png(name)
    print(p)
    dev.off()
    i <- i+1
  }
  
  rm(name)
  rm(sysinf)
  rm(i)
  
}
