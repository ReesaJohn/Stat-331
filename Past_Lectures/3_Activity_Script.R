divide_and_round <- function(nums){
  
  my_mean <- min(nums,na.rm = TRUE)
  divided <- nums/my_mean
  rounded <- round(divided)
  rounded
  
}

no_nines_or_twelves <-function(num){
  
  check <-!(num%%9==0|num%%12==0)
  check
  
}

every_other <- function(vec, start = 1){
  new_vec = c()
  for(i in seq(start,length(vec),2)){ 
    new_vec <- c(new_vec,vec[i])
  }
  
  new_vec
  
}

