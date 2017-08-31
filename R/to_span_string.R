to_span_string <- function(x){
  if (x[1] == x[2]) {
    result <- paste0(x[1], "LR")
  } else
  {
    result <- paste0(x[1], "L", x[2], "R")
  }
  return(result)
}