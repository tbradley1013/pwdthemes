#' A ggplot2 theme for PWD
#'
#'
theme_pwd <- function(base_size = 12, base_family = "Calibri"){


  if (!font_check(base_family)){
    if (font_check("Calibri")){
      warning(base_family, " is not an available font, switching to default Calibri", call. = FALSE)
      base_family <- "Calibri"
      family_light <- "Calibri Light"
    } else if (font_check("Open Sans")){
      base_family <- "Open Sans"
      family_light <- "Open Sans Light"
      warning(base_family, " is not an available font, switching to Open Sans", call. = FALSE)
    } else if (font_check("Public Sans")){
      base_family <- "Public Sans"
      family_light <- "Public Sans Light"
      warning(base_family, " is not an available font, switching to Public Sans", call. = FALSE)
    } else {
      base_family <- ""
      family_light <- ""
      warning(base_family, " is not an available font, switching to ggplot2 default", call. = FALSE)
    }
  } else {
    if (font_check(paste(base_family, "Light"))){
      family_light <- paste(base_family, "Light")
    } else {
      family_light <- base_family
    }
  }

  out <- theme_bw(
    base_size = base_size,
    base_family = base_family
  )

  out <- out %+replace%
    theme(
      panel.border = element_blank(),
      panel.grid.minor = element_blank()
    ) +
    theme(
      # general
      text = element_text(color = "#0078C8"),

      # plot
      plot.title = element_text(color = "#0078C8", face = "bold"),
      plot.subtitle = element_text(color = "#0078C8"),
      plot.caption = element_text(color = "#0078C8", family = family_light),

      # panel
      # panel.background = element_rect(fill = "#C6DAE7"),
      panel.grid.major = element_line(color = "#C6DAE7"),

      # axis
      axis.line = element_line(color = "#001A70"),
      axis.ticks = element_line(color = "#001A70"),
      axis.title = element_text(color = "#001A70", family = family_light),
      axis.text = element_text(color = "#001A70", family = family_light),

      # legend
      legend.text = element_text(color = "#001A70")
    )

  class(out) <- c("pwd_theme", class(out))

  return(out)
}


ggplot_add.pwd_theme <- function(object, plot, object_name){
  plot$theme <- ggplot2:::update_theme(plot$theme, object)
  plot$labels$title <- stringr::str_to_upper(plot$labels$title)
  plot
}


#' Replace the default color and fill options with PWD themed colors
#'
#' @rdname pwd_geoms
#'
#' @details
#' This function will overwrite default color and fill options provided
#' by ggplot2 to match PWD themes more closely. By default, this function
#' will be run when loading the pwdthemes package. It can be easily undone
#' by running the undo_pwd_geoms function.
#' @export
pwd_geoms <- function(){

  # change black to resolution blue
  replace_geom_aes_defaults("colour", "black", "#001A70")
  replace_geom_aes_defaults("fill", "black", "#001A70")

  # change grey20 to botticelli
  replace_geom_aes_defaults("colour", "grey20", "#001A70")
  replace_geom_aes_defaults("fill", "grey20", "#001A70")

  # change abline color to main PWD color
  replace_geom_aes_defaults("colour", "#3366FF", "#0078C8")

  # Change geom smooth fill color
  replace_geom_aes_defaults("fill", "grey60", "#BBDDE1")
  replace_geom_aes_defaults("fill", "grey50", "#BBDDE1")

  replace_geom_aes_defaults("fill", "grey35", "#001A70")

  replace_geom_aes_defaults("fill", "white", "#C6DAE7")


}

#' @rdname pwd_geoms
#' @export
undo_pwd_geoms <- function(){
  # change resolution blue to black
  replace_geom_aes_defaults("colour", "#001A70", "black")
  replace_geom_aes_defaults("fill", "#001A70", "black")

  # change grey20 to botticelli
  replace_geom_aes_defaults("colour", "#001A70", "grey20")
  replace_geom_aes_defaults("fill", "#001A70", "grey20")

  # change abline color to main PWD color
  replace_geom_aes_defaults("colour", "#0078C8", "#3366FF")

  # change geom smooth fill back
  replace_geom_aes_defaults("fill", "#BBDDE1", "grey60")
  replace_geom_aes_defaults("fill", "#BBDDE1", "grey50")

  replace_geom_aes_defaults("fill", "#001A70", "grey35")

  replace_geom_aes_defaults("fill", "#C6DAE7", "white")
}


# These functions were used from Stack Overflow: https://stackoverflow.com/questions/21174625/ggplot-how-to-set-default-color-for-all-geoms
# function to get the defualt geom settins for ggplot2
geom_aes_defaults <- function() {
  geom_names <- apropos("^Geom", ignore.case = FALSE)
  geoms <- mget(geom_names, env = asNamespace("ggplot2"))
  purrr::map(geoms, ~ .$default_aes)
}

# function to update ggplot2 geoms
replace_geom_aes_defaults <- function(name, old_aes, new_aes) {
  matching_geoms <-
    purrr::map(geom_aes_defaults(), name) %>%
    purrr::compact() %>%
    purrr::keep(~ !is.na(.) & . == old_aes)
  geoms <- gsub("^Geom(.*)", "\\1", names(matching_geoms))
  purrr::walk(geoms, update_geom_defaults, setNames(list(new_aes), name))
}
