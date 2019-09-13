#===============================================================================
# Functions for table styling
#
# Tyler Bradley
# 2019-09-13
#===============================================================================

#'
pwd_styling <- function(kable, ...){
  if (!inherits(kable, "knitr_kable")) stop("input must be of class `knitr_kable`")

  out <- kable %>%
    kableExtra::row_spec(0, color = "white", background = "#0078C8")


  if (attr(kable, "format") == "latex"){
    out <- out %>%
      kableExtra::kable_styling(latex_options = "striped", stripe_color = "#C6DAE7", ...)
  } else {
    out <- out %>%
      kableExtra::kable_styling(bootstrap_options = "striped", ...)
  }

  return(out)
}
