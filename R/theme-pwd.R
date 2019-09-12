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

      # panel
      # panel.background = element_rect(fill = "#C6DAE7"),
      panel.grid.major = element_line(color = "#C6DAE7"),

      # axis
      axis.line = element_line(color = "#001A70"),
      axis.ticks = element_line(color = "#001A70"),
      axis.title = element_text(color = "#001A70", family = family_light),
      axis.text = element_text(color = "#001A70", family = family_light)
    )

  class(out) <- c("pwd_theme", class(out))

  return(out)
}


ggplot_add.pwd_theme <- function(object, plot, object_name){
  plot$theme <- ggplot2:::update_theme(plot$theme, object)
  plot$labels$title <- stringr::str_to_upper(plot$labels$title)
  plot
}
