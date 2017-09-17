# helpers.r contains functions for the app

## function for upper percentile
percentile.profile <- function(input.data, selected.percentile, variable.name) {
  profile.2 <- aggregate(
    input.data$Total ~ input.data$hour,
    FUN = quantile,
    probs = selected.percentile / 100
    
  )
  names(profile.2) <- c("Hour", variable.name)
  return(profile.2)
}