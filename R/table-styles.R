#===============================================================================
# Functions for table styling
#
# Tyler Bradley
# 2019-09-13
#===============================================================================

#' Add PWD styling to kable functions
#'
#' @param kable the kable that you with to style
#' @param ... additional params to be passed to kableExtra::kable_styling
#'
#' @details
#'
#'
#' @export
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



#' Define CSS to format HTML kable
#'
#' @details
#' This function will define css in your HTML Rmarkdown document
#' that will customize the format of kable's to meet PWD style
#' guidelines. This function only needs to be called once at the beginning
#' of your Rmarkdown document and will only work with html output.
#'
#' The css makes the header of the table have a blue background with white
#' letters and the striped table have a light cyan background.
#'
#'
#' @export
set_pwd_kable <- function(){
  # define css that will format tables in PWD style for the entire HTML document
  htmltools::tags$style(htmltools::HTML("
    thead {
      background-color: #0078C8;
      color: #FFFFFF;
    }

    .table-striped>tbody>tr:nth-of-type(odd) {
      background-color: #C6DAE7;
    }
  "))
}
