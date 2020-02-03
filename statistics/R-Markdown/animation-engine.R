# animation engine
# functions that turn r graphics into images and animations
# by Jack Hester

# sort items built with the frame in ascending numerical order
sort.frame.files <- function(list){
  list <- list.files("D:\\math_animations\\R_tests\\normal_pngs", pattern="*.png$", full.names = T)
  tmp <- c() # sorted list to return
  
  # gather the first and number
  first <- strsplit(list[1], "frame")
  
  prefix <- first[[1]][1] # get directory where file is
  
  first <- first[[1]][2]
  
  first <- strsplit(first, ".png")
  first <- first[[1]][1]
  
  last <- strsplit(list[length(list)], "frame")
  last <- last[[1]][2]
  last <- strsplit(last, ".png")
  
  first <- as.numeric(as.character(first))
  last <- as.numeric(as.character(last))
  
  print(prefix)
  for(i in first:last){
    s <- paste0(prefix,"frame",i,".png")
    tmp <- c(tmp, s)
  }
  remove(first)
  remove(last)
  remove(prefix)
  remove(s)
  return(tmp)
}

# gif 
# imgpath is path to images (defaults to working directory)
# savename is the path and file name to save to (must end in .gif)
# fps_val is fps of gif
# very slow, but generates higher quality gif than pngs_to_gif below
pngs_to_hq_gif <- function(imgpath=getwd(), savename='animation.gif',fps_val=4){
  list.files(path=imgpath, pattern = "*.png$") %>% 
    sort.int() %>%
    map(image_read) %>%
    image_join() %>%
    image_animate(fps=fps_val) %>%
    image_write(savename)
  print(paste0('Wrote out your animation to: ', savename))
}

# use this gif creation routine if you don't need every frame (MUCH faster)
fast.pngs.to.gif <- function(imgpath=getwd(), savename='animation.gif'){
  png_files <- list.files(imgpath, pattern = ".*png$", full.names = TRUE)
  gifski(png_files, gif_file = savename, delay = 1)
}

# mp4
# imgpath is path to images (defaults to working directory)
# savename is the path and file name to save to (must end in .mp4)
pngs.to.mp4 <- function(imgpath=getwd(), savename='animation.mp4'){
  imgs <- list.files(imgpath, pattern="*.png$", full.names = T)
  imgs <- sort.frame.files(imgs)
  saveVideo({
    for(img in imgs){
      im <- magick::image_read(img)
      plot(as.raster(im))
    }  
  }, video.name = savename, res=72) #TODO: make the quality and framereate better
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

# create gif from png files
# png files need to end in n.png where n is a sequential, increasing set of numbers that indicate the order of frames
# imgpath is path to images (defaults to working directory)
# savename is the path and file name to save to (must end in .mp4)
# frame.rate is the framerate you want for the mp4 (defaults to 4, may want to try 10)
pngs_to_gif <- function(imgpath=getwd(), savename='animation.gif', frame.rate=4){
  imgs <- list.files(imgpath, pattern="*.png$", full.names = T)
  imgs <- sort.frame.files(imgs)
  av::av_encode_video(imgs, output=savename, framerate=frame.rate)
  print(paste0('Wrote out your animation to: ', savename))
}

# create mp4 from png files
# png files need to end in n.png where n is a sequential, increasing set of numbers that indicate the order of frames
# imgpath is path to images (defaults to working directory)
# savename is the path and file name to save to (must end in .mp4)
# frame.rate is the framerate you want for the mp4 (defaults to 4, may want to try 10)
pngs_to_mp4 <- function(imgpath=getwd(), savename='animation.mp4', frame.rate=4){
  imgs <- list.files(imgpath, pattern="*.png$", full.names = T)
  imgs <- sort.frame.files(imgs)
  av::av_encode_video(imgs, output=savename, framerate=frame.rate)
  print(paste0('Wrote out your animation to: ', savename))
}
