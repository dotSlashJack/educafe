# animation engine
# functions that turn r graphics into images and animations
# by Jack Hester

# gif 
# imgpath is path to images (defaults to working directory)
# savename is the path and file name to save to (must end in .gif)
png.to.gif <- function(imgpath=getwd(), savename='animation.gif'){
  list.files(path=imgpath, pattern = "*.png") %>% 
    map(image_read) %>%
    image_join() %>%
    image_animate(fps=20) %>%
    image_write(savename)
  print(paste0('Wrote out your animation to: ', savename))
}

# mp4
# imgpath is path to images (defaults to working directory)
# savename is the path and file name to save to (must end in .mp4)
png.to.mp4 <- function(imgpath=getwd(), savename='animation.mp4'){
  imgs <- list.files(path=imgpath, pattern="*.png")
  saveVideo({
    for(img in imgs){
      im <- magick::image_read(img)
      plot(as.raster(im))
    }  
  }, video.name = savename) #TODO: make the quality and framereate better
  rm(imgs)
  print(paste0('Wrote out your animation to: ', savename))
}

# create gganimation of ggplot with some defaults and save gif
# savename is path and file name, must end in .gif
animate.and.save.ggplot <- function(plot, savename){
  a<-animate(plot, fps=30, res=50, renderer=gifski_renderer())
  anim_save(filename=savename, animation=a)
  rm(a)
  print(paste0('Wrote out your animation to: ', savename))
}
