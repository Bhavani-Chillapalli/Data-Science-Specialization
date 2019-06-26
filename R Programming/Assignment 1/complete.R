
complete <- function( directory, id = 1:332 ) {
  
 
  
  filesInDir <- paste( directory, as.character(list.files( directory )), sep = "/")
  
  
  
 
  count_nobs <- rep( 0, length(id))
  
  
  

  
  x <- 1
  
  for( i in id) {
    

    
    dataInFile <- read.csv(filesInDir[i])
    
    
    

    
    count_nobs[x] <- sum(complete.cases(dataInFile))
    
    x <- x + 1
    
  }
  
  

  
  completeRowCount <- data.frame( id = id, nobs = count_nobs)
  
  

  
  completeRowCount
  
}

