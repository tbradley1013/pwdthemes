#===============================================================================
# Functions to import fonts - These functions are modelled after the hrbrthemes
# package
#
# Tyler Bradley
# 2019-09-10
#===============================================================================

#' Import the Open Sans Font
#'
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

font_os <- "Open Sans"


font_os_light <- "Open Sans Light"

font_os_extrabold <- "Open Sans ExtraBold"

font_os_semibold <- "Open Sans SemiBold"
