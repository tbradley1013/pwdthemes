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
#'
#' @note This will take care of ensuring PDF/PostScript usage. The location of the
#'   font directory is displayed after the base import is complete. It is highly
#'   recommended that you install them on your system the same way you would any
#'   other font you wish to use in other programs.
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



#' Import the Public Sans font
#'
#' This function will import the public sans font to R for use in plots.
#' Public Sans is Copyright 2015 Impallari Type and licensed under the
#' SIL Open Font License, Version 1.1
#'
#' @note This will take care of ensuring PDF/PostScript usage. The location of the
#'   font directory is displayed after the base import is complete. It is highly
#'   recommended that you install them on your system the same way you would any
#'   other font you wish to use in other programs.
#'
#' @export
import_public_sans <- function(){

  public_sans_dir <- system.file("fonts", "public-sans", package = "pwdthemes")

  suppressWarnings(suppressMessages(extrafont::font_import(public_sans_dir, prompt = FALSE)))

  message(
    sprintf(
      "You should also install this font on your system if it is not already. You can find them in [%s]",
      public_sans_dir
    )
  )

}

#' @rdname PublicSans
#'
#' @description font_pub == "Public Sans"
#' @export
font_pub <- "Public Sans"

#' @rdname PublicSans
#'
#' @description font_pub_light == "Public Sans Light"
#' @export
font_pub_light <- "Publc Sans Light"

#' @rdname PublicSans
#'
#' @description font_pub_thin == "Public Sans Thin"
#' @export
font_pub_thin <- "Public Sans Thin"

#' @rdname PublicSans
#'
#' @description font_pub_black == "Public Sans Black"
#' @export
font_pub_black <- "Public Sans Black"

#' @rdname PublicSans
#'
#' @description font_pub_extrabold == "Public Sans ExtraBold"
#' @export
font_pub_extrabold <- "Public Sans ExtraBold"

#' @rdname PublicSans
#'
#' @description font_pub_extralight == "Public Sans ExtraLight"
#' @export
font_pub_etralight <- "Public Sans ExtraLight"

#' @rdname PublicSans
#'
#' @description font_pub_medium == "Public Sans Medium"
#' @export
font_pub_medium <- "Public Sans Medium"

#' @rdname PublicSans
#'
#' @description font_pub_semibold == "Public Sans SemiBold"
#' @export
font_pub_semibold <- "Public Sans SemiBold"


#' @rdname Calibri
#' @description font_cal == "Calibri"
#' @export
font_cal <- "Calibri"

#' @rdname Calibri
#' @description font_cal_light == "Calibri Light"
#' @export
font_cal_light <- "Calibri Light"


# Utility function to check if a font is available
font_check <- function(font_name, regex = TRUE){
  fonts <- extrafont::fonttable()

  if (regex){
    if (any(stringr::str_detect(fonts$FamilyName, font_name))){
      return(TRUE)
    } else {
      return(FALSE)
    }
  } else {
    if (font_name %in% fonts$FamilyName){
      return(TRUE)
    } else
      return(FALSE)
  }
}
