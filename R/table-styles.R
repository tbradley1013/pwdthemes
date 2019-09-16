#===============================================================================
# Functions for table styling
#
# Tyler Bradley
# 2019-09-13
#===============================================================================

#' Add PWD styling to kable functions
#'
#' @param kable the kable that you with to style
#' @param options the options to be passed to latex_options or bootstrap_options
#' arguments in \code{\link[kableExtra]{kable_extra}} depending on whether
#' the format is latex or html, respectively
#' @param ... additional params to be passed to \code{\link[kableExtra]{kable_styling}}
#'
#' @details
#' This function will add styling to your kable tables used in Rmarkdown
#' documents. It will add the "striped" option to the table and make the
#' background of the column names PWD blue with white font. In pdf outputs
#' it will also change the background color of the striped rows. If you
#' are knitting to an HTML document than you will need to use the
#' \code{\link[pwdthemes]{set_pwd_styling}}.
#'
#' It is important to note that if you use this function, than you must
#' pass all other arguments intended for \code{\link[kableExtra]{kable_styling}}
#' to this function. Currently, you can not use the kable_styling function
#' on a kable that it has previously been applied to.
#'
#' @export
pwd_styling <- function(kable, options = c("striped", "bordered"), ...){
  if (!inherits(kable, "knitr_kable")) stop("input must be of class `knitr_kable`")

  out <- kable %>%
    kableExtra::row_spec(0, color = "white", background = "#0078C8")


  if (attr(kable, "format") == "latex"){
    out <- out %>%
      kableExtra::kable_styling(latex_options = options, stripe_color = "#C6DAE7", ...)
  } else {
    out <- out %>%
      kableExtra::kable_styling(bootstrap_options = options, ...)
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
set_pwd_styling <- function(){
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
