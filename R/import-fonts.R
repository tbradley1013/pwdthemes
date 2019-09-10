#===============================================================================
# Functions to import fonts - These functions are modelled after the hrbrthemes
# package
#
# Tyler Bradley
# 2019-09-10
#===============================================================================

#' Import the Open Sans Font
#'
#' This function will import the open sans font package so that it
#' can be used in R plots. This font is licensed under the Apache
#' License Version 2.0 http://www.apache.org/licenses/
#'
#' @export
import_open_sans <- function(){

  open_sans_dir <- system.file("fonts", "open-sans", package = "pwdthemes")

  suppressWarnings(suppressMessages(extrafont::font_import(open_sans_dir, prompt = FALSE)))

  message(
    sprintf(
      "You should also install this font on your system if it is not already. You can find them in [%s]",
      open_sans_dir
    )
  )

}

#' @rdname OpenSans
#'
#' @description font_os == "Open Sans"
#' @export
font_os <- "Open Sans"

#' @rdname OpenSans
#' @description font_os_light == "Open Sans Light"
#' @export
font_os_light <- "Open Sans Light"

#' @rdname OpenSans
#' @description font_os_extrabold == "Open Sans ExtraBold"
#' @export
font_os_extrabold <- "Open Sans ExtraBold"

#' @rdname OpenSans
#'
#' @description font_os_semibold == "Open Sans SemiBold"
#' @export
font_os_semibold <- "Open Sans SemiBold"



#' Import the
#'
import_public_sans <- function(){

  public_sans_dir <- system.file("fonts", "public-sans", package = "pwdthemes")

  suppressWarnings(suppressMessages(extrafont::font_import(public_sans_dir, prompt = FALSE)))

  message(
    sprintf(
      "You should also install this font on your system if it is not already. You can find them in [%s]",
      open_sans_dir
    )
  )

}
