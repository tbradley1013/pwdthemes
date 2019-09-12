.onAttach <- function(libname, pkgname) {

  if (.Platform$OS.type == "windows")  { # nocov start
    if (interactive()) packageStartupMessage("Registering Windows fonts with R")
    extrafont::loadfonts("win", quiet = TRUE)
  }

  if (interactive()){
    pwd_geoms()
    packageStartupMessage("The default ggplot2 color and fill options are being overridden in favor of PWD colors. This can be undone by running pwdthemes::undo_pwd_goems()")
  }


}
