library(tidyr)

best <- function(state,value) 
  
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
  
  t <- dat %>% filter(State == state,outcome == value)%>% select(`Hospital Name`,mortality) %>% mutate(rank = rank(mortality)) %>% filter(rank == 1)
  output <- t$`Hospital Name`
  output
  
 
  
}

}