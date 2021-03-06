#functions not to use
#choose()
#dbinom()
#pbinom()
#qbinom()
#rbinom()


##this function is used to judge whether an input is an integer
is.wholenumber <-
  function(x, tol = .Machine$double.eps^0.5)  abs(x - round(x)) < tol



##it is a private auxiliary function to test ifan input prob is a valid probability value
check_prob <- function(prob)
{
  if (prob>=0 & prob<=1)
  {return(TRUE)}
  else {
    return("invalid prob value")
    stop()
  }
}

##it is a private auxiliary function to test if an input trials is a valid value for number of trials
check_trials <- function(trials)
{
  if (is.numeric(trials))
  {
    if (is.wholenumber(trials))
    { if (trials>=0){return(TRUE)}}}
  else{
    return("invaild  trials value")
    stop()  }
}




##it is a private auxiliary function to test if an input success is a valid value for number of successes
check_success <- function(success,trials)
{
  if (is.vector(success))
  {
    Judgee=TRUE
    judge=rep(FALSE,length(success))
    for (i in 1:length(success))
    {
      if (is.numeric(success[i]))
      {
        if (is.wholenumber(success[i]))
          
        {
          if (success[i]>=0 & success[i]<=trials) 
          {judge[i]=TRUE} 
          else if (success[i]>trials){
            return("success cannot be greater than trials")
            stop()
          }
        }
      }
      
      
    }
    if (sum(judge)==length(success))
    {return(TRUE)}
    else {return("invalid success value")}
    
  }
  else {return("invalid success value")}
}

## a function to calculate the mean of binomial distribution
aux_mean <- function(trials,prob)
{
  ans=trials*prob
  return(ans)
}

##a function to calculate the variance of binomial distribution
aux_variance <- function(trials,prob)
{
  ans=trials*prob*(1-prob)
  return(ans)
}

##a function for the mode of binomial distribution
aux_mode <- function(n,p)
{
  ans=as.integer(n*p+p)
  return(ans)
}

##a function for the skewness of binomial distribution
aux_skewness <- function(n,p)
{
  part1= 1-2*p
  part2=sqrt(n*p*(1-p))
  ans=part1/part2
  return(ans)
}


##a function fot the kurtosis of binomial distribution
aux_kurtosis <- function(n,p)
{
  part1= 1-6*p*(1-p)
  part2=n*p*(1-p)
  ans=part1/part2
  return(ans)
}


#' @title bin_choose function
#' @description it is kind of a substitution to the function choose()
#' @param n represents the trials, and k represents the times of success
#' @return it calculate the result of the choose(n,k)
#' @export


bin_choose <- function(n,k)
{
  if (sum(k[1:length(k)]>n)!=0)
  {
    return("k cannot be greater than n")
    stop()
  }
  else{
    ans=factorial(n)/(factorial(k)*factorial(n-k))
    return(ans)
  }
}


##a main function as  bin_probability()

#' @title bin_probability
#' @param success The number of successes
#' @param trials The number of trials
#' @param prob A number between 0 and 1 that expresses the probability of success
#' @description Calculates the likelihood of a binomial distribution under a certian times of success
#' @return A numeric value of probability itself
#' @export
bin_probability <- function(success,trials,prob)
{
  if (check_trials(trials)!=TRUE)
  {
    print("invalid trials")
    stop()
  }
  if (check_prob(prob)!=TRUE)
  {
    print("invalid prob")
    stop()
  }
  if (check_success(success,trials)!=TRUE)
  {
    print("invalid success")
    stop()
  }
  part1=bin_choose(trials,success[1:length(success)])
  part2=prob^(success[1:length(success)])
  part3=(1-prob)^(trials-success[1:length(success)])
  ans=part1*part2*part3
  return(ans)
}




## the function bin_distribution() is to determine the distribution of binominal
#' @title bin_distribution
#' @param trials the number of trials
#' @param prob The probability of getting a success
#' @description form a table of the probabilities under different time of success
#' @return Return a dataframe (table) of the binomial distribution
#' @export
bin_distribution <- function(trials,prob)
{
  dat <- data.frame(success=0:trials,probability=rep(0,trials+1))
  dat$probability[1:(trials+1)]=bin_probability(0:trials,trials,prob)
  class(dat) <- c("bindis","data.frame")
  return(dat)
  
}


##it is a function of the probability histogram of a binomial distribution
#plot method for the distribution binomial

#' @export
plot.bindis <- function(dt)
{
  data=dt
  barplot(height = data$probability,xlab="success",ylab="probability")
  
}



#' @title bin_cumulative
#' @param trials for the time of success
#' @param prob for the probability of success
#' @description it forms a data frame that both the probability distribution and the cumulative probability
#' @return a data frame with two clss
#' @export 

bin_cumulative <- function(trials,prob)
{
  dat <- data.frame(success=0:trials,probability=rep(0,trials+1))
  dat$probability[1:(trials+1)]=bin_probability(0:trials,trials,prob)
  dat$cumulative=cumsum(dat$probability)
  class(dat) <- c("bincum","data.frame")
  return(dat)
  
}

#' @export
#method for plotting the bin_cumulative
plot.bincum <- function(dt)
{
  
  if (any(class(dt) == "bincum"))
  {
  data=dt
  plot(x=data$success,y=data$cumulative,type="o",xlab="successes",ylab="probability")
  }
  
}


#' @title bin_variable
#' @description it invokes check funtion
#' @param trials for the time of success
#' @param prob for the probability of success
#' @return it returns an object of class "binvar"
#' @export
#' @examples bin_variable(5,0.5)

bin_variable <- function(trials,prob)
{
  check_trials(trials)
  check_prob(prob)
  ls = list(trials,prob)
  names(ls)= c("trials","probabilities")
  class(ls) <- c("binvar","list")
  return(ls)
}


#method print binvar
#' @export

print.binvar <- function(ls)
{
  if(any(class(ls) == "binvar"))
    {
  cat(' "Binomial variable" \n\n')
  cat('Paramaters \n')
  cat("- number of trials:",ls$trials,"\n")
  cat("- prob of success: ",ls$prob,"\n")
  
  }
  
}



#' @export
summary.binvar <- function(ls)
  {
  if(any(class(ls) == "binvar"))
    {
      t = ls$trials
      p = ls$prob
      dt = data.frame(
      "trials" = t,
      "prob" = p,
      "mean" = aux_mean(t, p),
      "variance" = aux_variance(t, p),
      "mode" = aux_mode(t, p),
      "skewness" = aux_skewness(t, p),
      "kurtosis" = aux_kurtosis(t, p)
    )
    class(dt) = c("summary.binvar")
    return(dt)
  }
}

#' @export
print.summary.binvar <- function(ls)
  {
  if(any(class(ls) == "summary.binvar"))
    {
    cat("Binomial variable", "\n", "\n", "Parameters", "\n")
    cat("- number of trials: ", ls$trials, "\n" )
    cat("- prob of success : ", ls$prob, "\n", "\n")
    cat("Measures", "\n", "- mean    : ", ls$mean, "\n")
    cat("- variance: ", ls$variance,"\n")
    cat("- mode    : ", ls$mode, "\n")
    cat("- skewness: ", ls$skewness,"\n")
    cat("- kurtosis: ", ls$kurtosis,"\n")
  }
}


##Main functions
#Main Functions
#' @title bin_mean
#' @param trials The number of trials
#' @param prob The number of successes
#' @description Calculates the expected value of a binomial distribution
#' @return A number
#' @export
bin_mean <- function(trials,prob)
{
  check_trials(trials)
  check_prob(prob)
  return(aux_mean(trials,prob))
}


#' @title bin_variance
#' @param trials The number of trials
#' @param prob The number of successes
#' @description Calculates the variance of a binomial distribution
#' @return A number
#' @export
bin_variance <- function(trials,prob)
{
  check_trials(trials)
  check_prob(prob)
  return(aux_mean(trials,prob))
}


#' @title bin_mode
#' @param trials The number of trials
#' @param prob The number of successes
#' @description Calculates the most likely number of successes in a binomial distribution
#' @return A number
#' @export
bin_mode <- function(trials,prob)
{
  check_trials(trials)
  check_prob(prob)
  return(aux_mode(trials,prob))
}


#' @title bin_skewness
#' @param trials The number of trials
#' @param prob The number of successes
#' @description Calculates the asymmetry of the probability distribution of a random variable about its mean
#' @return A number
#' @export
bin_skewness <- function(trials,prob)
{
  check_trials(trials)
  check_prob(prob)
  return(aux_skewness(trials,prob))
}


#' @title bin_kurtosis
#' @param trials The number of trials
#' @param prob The number of successes
#' @description Calculates the 'tailedness' of a probability distribution of a random variable
#' @return A number
#' @export
bin_kurtosis <- function(trials,prob)
{
  check_trials(trials)
  check_prob(prob)
  return(aux_kurtosis(trials,prob))
}