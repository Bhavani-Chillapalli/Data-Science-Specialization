library(tidyr)

rankhospital <- function(state,value,num) 
  
{
  
  dat <- outcome_data %>% select(`Hospital Name`,State,`Hospital 30-Day Death (Mortality) Rates from Heart Attack`,
                                 `Hospital 30-Day Death (Mortality) Rates from Heart Failure`,`Hospital 30-Day Death (Mortality) Rates from Pneumonia`)
  
  dat[,3:5] <-  lapply(dat[,3:5],as.numeric)
  
  dat <- dat %>% rename('Heart Attack' = `Hospital 30-Day Death (Mortality) Rates from Heart Attack`,'Heart Failure' = `Hospital 30-Day Death (Mortality) Rates from Heart Failure`,
                        'Pneumonia' = `Hospital 30-Day Death (Mortality) Rates from Pneumonia` )
  
  dat <- gather(dat,key = "outcome",value = "mortality", 3:5)
  
  
if (!state %in% dat$State) {
  
  stop("invalid state")
  
} else if(!value %in% dat$outcome) {
  
  stop("invalid outcome")
  
} else {
  
  t <- dat %>% filter(State == state,outcome == value) %>% select(`Hospital Name`,mortality) 
  t <- t %>% arrange(mortality, `Hospital Name`)
  
  if ( num == "best") {
    output <- t[1,1]
  }
  else if( num == "worst") {
    t <- t %>% arrange(desc(mortality), `Hospital Name`)
    output <- t[1,1]
  }
  else
  {
  output <- t[num,1]
  
  }
  output
}


    
}   
  
  
