round.POSIXct <- function(x, units = c("mins", "5 mins", "10 mins", "15 
mins", "quarter hours", "30 mins", "half hours", "hours")){
  if(is.numeric(units)) units <- as.character(units)
  units <- match.arg(units)
  r <- switch(units,
              "mins" = 60,
              "5 mins" = 60*5,
              "10 mins" = 60*10,
              "15 mins"=, "quarter hours" = 60*15,
              "30 mins"=, "half hours" = 60*30,
              "hours" = 60*60
  )
                  H <- as.integer(format(x, "%H"))
                  M <- as.integer(format(x, "%M"))
                  S <- as.integer(format(x, "%S"))
                  D <- format(x, "%Y-%m-%d")
                  secs <- 3600*H + 60*M + S
                  as.POSIXct(round(secs/r)*r, origin=D)
}

# (x <- Sys.time() + 1:10*60)
# round(x, "5 mins")
