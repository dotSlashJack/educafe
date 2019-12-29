# sample
# take samples from different distributions/functions
# by Jack Hester

# function dist.sampler: generate n samples 
# n is number of samples to take
# type is distribution to sample from
# seed is optional arg to set seed for consisten tresults
dist.sampler <- function(n, type, seed=FALSE){
  if(seed!=FALSE){
    set.seed(seed)
  }
  if(type=='normal'){
    
  }
  else if(type=='binomial'){
    
  }
}