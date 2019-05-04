---
output:
  github_document:
    html_preview: false
---

```{r, echo = FALSE, message = FALSE}
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
```



## General Idea ##
The package `"binomial"` includes all kinds of functions that can nicely simulate the binomial distribution

## Create one variable  ##

that is establish one `binomial variable` object with the function `bin_variable()`:

```{r setup}
library(binomial)
```

```{r}
var1 <- bin_variable(trials=10,prob=0.4)
var1
```
The function bin_variable() takes two argument, in which trails means the overall times over successful times

```{r}
summary(var1)
```
The `summary()` can takes one binomial random variable as paramaters, and present a nicely-formed table of function measures

## Measures of Binomial Random Variables ＃＃

There are 5 measuring functions in this package. 

 `bin_mean()`: calculate the mean of binomial random variable
 `bin_variance()`: calculate the variance of binomial random variable
 `bin_mode()`: calculate the mode of binomial random variable
 `bin_skewness()`: calculate the skewness of binomial random variable
 `bin_kurtosis()`: calculate the kurtosis of binomial random variable


```{r}
aux_mean(10, 0.3)
aux_variance(10, 0.3)
aux_mode(10, 0.3)
aux_skewness(10, 0.3)
aux_kurtosis(10, 0.3)
```


## Binomial dirstributions and cumulative　　


Ｔhe package contains two main functions `bin_cumulative()`. `bin_distribution()` , which export a table that show the success,probability, cumulative regarding binomial distribution.

```{r}
df1 <- bin_distribution(10, 0.3)
df1
df2 <- bin_cumulative(10, 0.3)
df2
```


Also, using the function `plot()` to create plots of the binomial distribution and cumulative.

```{r}
plot(df1)
plot(df2)
```