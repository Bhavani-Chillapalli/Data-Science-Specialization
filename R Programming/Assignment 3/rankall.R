library(tidyr)

rankall <- function(value,num) 
  
{
  
  dat <- outcome_data %>% select(`Hospital Name`,State,`Hospital 30-Day Death (Mortality) Rates from Heart Attack`,
                                 `Hospital 30-Day Death (Mortality) Rates from Heart Failure`,`Hospital 30-Day Death (Mortality) Rates from Pneumonia`)
  
  dat[,3:5] <-  lapply(dat[,3:5],as.numeric)
  
  dat <- dat %>% rename('Heart Attack' = `Hospital 30-Day Death (Mortality) Rates from Heart Attack`,'Heart Failure' = `Hospital 30-Day Death (Mortality) Rates from Heart Failure`,
                        'Pneumonia' = `Hospital 30-Day Death (Mortality) Rates from Pneumonia` )
  
  dat <- gather(dat,key = "outcome",value = "mortality", 3:5)
  
  
  t <- dat %>%  arrange(State,outcome,mortality, `Hospital Name`) %>% group_by(State,outcome)%>% mutate(rank = rank(order(State,outcome,mortality)))
   
 
  
  
  if ( num == "best") {
    x <-  t %>% filter(outcome == value,rank == 1) %>% select(State, `Hospital Name`)
    }
    else if( num == "worst") {
      t <- t %>% filter(outcome == value)
      x <- t[with(t, order(-mortality)),] %>% select(State, `Hospital Name`)
      
      
    }
    else
    {
      x <-  t %>% filter(outcome == value,rank == num) %>% select(State, `Hospital Name`)
      
      
    }
    x
  }
  
  
  
  

