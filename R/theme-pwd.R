#' A ggplot2 theme for PWD
#'
#' This function will apply a custom PWD ggplot2 theme to
#' ggplot2 objects that matches the style guidelines
#' provided by the Public Affairs division
#'
#' @param base_size the base font size
#' @param base_family the base font family
#' @param ... additional parameters to pass to \code{\link[ggplot2]{theme_bw}}
#'
#' @details
#' By default, theme_pwd will use the Calibri font as the base_family if
#' it is installed and available. Other fonts that are provided with this
#' package that can be used in this package are Open Sans and Public Sans
#'
#' The PWD style guideline specifies that the title of figures should be
#' in all capitals. This theme will convert your title to caps if you specify
#' the title using \code{\link[ggplot2]{labs}} or \code{\link[ggplot2]{ggtitle}}
#' prior to calling \code{theme_pwd}. If you want to avoid the capitalization
#' than you can call theme_pwd before labs
#'
#' @export
theme_pwd <- function(base_size = 12, base_family = "Calibri", ...){


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

  out <- ggplot2::theme_bw(base_size = base_size, base_family = base_family, ...)

  out <- out %+replace%
    ggplot2::theme(
      panel.border = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      panel.background = ggplot2::element_blank()
    ) +
    theme(
      # general
      text = ggplot2::element_text(color = "#0078C8"),

      # plot
      plot.title = ggplot2::element_text(color = "#0078C8", face = "bold"),
      plot.subtitle = ggplot2::element_text(color = "#0078C8"),
      plot.caption = ggplot2::element_text(color = "#0078C8", family = family_light),

      # panel
      # panel.background = element_rect(fill = "#C6DAE7"),
      panel.grid.major = ggplot2::element_line(color = "#C6DAE7"),

      # axis
      axis.line = ggplot2::element_line(color = "#001A70"),
      axis.ticks = ggplot2::element_line(color = "#001A70"),
      axis.title = ggplot2::element_text(color = "#001A70", family = family_light),
      axis.text = ggplot2::element_text(color = "#001A70", family = family_light),

      # legend
      legend.text = ggplot2::element_text(color = "#001A70")
    )

  class(out) <- c("pwd_theme", class(out))

  return(out)
}



#' Add PWD themes to ggplot objects
#'
#' @importFrom ggplot2 ggplot_add
#' @return a modified ggplot2 object
#' @export
ggplot_add.pwd_theme <- function(object, plot, object_name){
  plot$theme <- add_theme(plot$theme, object)
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
  purrr::walk(geoms, ggplot2::update_geom_defaults, setNames(list(new_aes), name))
}



# This function is an internal ggplot2 function used to add theme to the object
#' Modify properties of an element in a theme object
#'
#' @param t1 A theme object
#' @param t2 A theme object that is to be added to `t1`
#' @param t2name A name of the t2 object. This is used for printing
#'   informative error messages.
#' @keywords internal
add_theme <- function(t1, t2, t2name) {
  if (!is.list(t2)) { # in various places in the code base, simple lists are used as themes
    abort(glue::glue("Can't add `{t2name}` to a theme object."))
  }

  # If t2 is a complete theme or t1 is NULL, just return t2
  if (is_theme_complete(t2) || is.null(t1))
    return(t2)

  # Iterate over the elements that are to be updated
  for (item in names(t2)) {
    x <- ggplot2::merge_element(t2[[item]], t1[[item]])

    # Assign it back to t1
    # This is like doing t1[[item]] <- x, except that it preserves NULLs.
    # The other form will simply drop NULL values
    t1[item] <- list(x)
  }

  # make sure the "complete" attribute is set; this can be missing
  # when t1 is an empty list
  attr(t1, "complete") <- is_theme_complete(t1)

  # Only validate if both themes should be validated
  attr(t1, "validate") <-
    is_theme_validate(t1) && is_theme_validate(t2)

  t1
}


# check whether theme is complete
is_theme_complete <- function(x) isTRUE(attr(x, "complete", exact = TRUE))

# check whether theme should be validated
is_theme_validate <- function(x) {
  validate <- attr(x, "validate", exact = TRUE)
  if (is.null(validate))
    TRUE # we validate by default
  else
    isTRUE(validate)
}
