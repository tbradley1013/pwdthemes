# Creating PWD color palette

# defining PWD colors
pwd_colors <- c(
  # main
  `blue` = "#0078C8",

  # dark colors
  `persian green` = "#00B388",
  `cerulean` = "#00B5E2",
  `genoa` = "#25786C",
  `jelly bean` = "#2887A1",
  `resolution blue` = "#001A70",
  `butterfly bush` = "#5F468F",

  # bright colors
  `tango` = "#F37720",
  `punch` = "#E45036",
  `puce` = "#D98894",
  `wattle` = "#C6CE47"


  # # light main accents
  # `pear` = "#DBE442",
  # `ziggurat` = "#B8DDE1",
  # `botticelli` = "#C6DAE7",
  #
  # # dark highlights
  #
  # `burnt sienna` = "#F26C51",
  # `blue marguerite` = "#7474C1",
  #
  # # light highlights
  # `grandis` = "#FDD086",
  # `zinnwaldite` = "#ECC3B2",
  # `gray suit` = "#C6C4D2",
  #
  # # dark map
  # `muddy waters` = "#B9975B",
  # `trendy green` = "#76881D",
  #
  # # light map
  # `primrose` = "#F1EB9C",
  # `pine glade` = "#BFCC80"
)

#' Function to extract PWD colors as hex codes
#'
#' @param ... Character names of pwd_colors
#'
pwd_cols <- function(...){
  cols <- c(...)

  if (is.null(cols)) return(pwd_colors)

  return(pwd_colors[cols])
}


pwd_palettes <- list(
  # `main` = pwd_cols("blue", "persian green", "cerulean",
  #                   "resolution blue", "pear", "ziggurat",
  #                   "botticelli"),

  `main` = pwd_cols("blue", "tango", "persian green", "punch",
                    "cerulean", "butterfly bush", "resolution blue",
                    "puce", "jelly bean", "wattle", "genoa"),

  `primary` = pwd_cols("blue", "persian green", "cerulean", "resolution blue",
                         "butterfly bush", "jelly bean", "genoa"),


  `highlight` = pwd_cols("tango", "punch",
                          "puce", "wattle")

  # `highlights_dark` = pwd_cols("tango", "burnt sienna", "blue marguerite"),
  #
  # `highlights_light` = pwd_cols("grandis", "zinnwaldite", "gray suit"),
  #
  # `map` = pwd_cols("muddy waters", "trendy green",
  #                  "primrose", "pine glade"),

  # `map_dark` = pwd_cols("muddy waters", "trendy green"),
  #
  # `map_light` = pwd_cols("primrose", "pine glade"),

  # `dark` = pwd_cols("blue", "persian green", "cerulean",
  #                   "resolution blue", "tango", "burnt sienna",
  #                   "blue marguerite"),
  #
  # `light` = pwd_cols("blue", "pear", "ziggurat",
  #                    "botticelli", "grandis", "zinnwaldite",
  #                    "gray suit"),
  #
  # `full` = pwd_cols("blue", "persian green", "cerulean",
  #                   "resolution blue", "pear", "ziggurat",
  #                   "botticelli", "tango", "burnt sienna",
  #                   "blue marguerite", "grandis", "zinnwaldite",
  #                   "gray suit")
)


#' Return function to interpolate a PWD color palette
#'
#' @param palette Character name of palette in pwd_palettes
#' @param reverse Logical, if TRUE the palette is reversed
#' @param ... Additional arguments to pass to colorRampPalette
#'
#' @rdname pwd_pal
#'
#' @details This function will create a function to interpolate
#' different PWD color palettes. Its main argument, \code{palette},
#' takes any one of the following options: main, main_dark, main_light,
#' highlights, highlights_dark, highlights_light, map, map_dark,
#' map_light, dark, light, or full.
#'
#' To see what these different palette types look like, use the
#' \code{view_pwd_palette(...)} function. You can pass the palette
#' you wish to view and the number of colors you want to see what
#' that palette will look like.
#'
#'
#' @export
pwd_pals <- function(palette = "main", reverse = FALSE, ...){
  if (!(palette %in% names(pwd_palettes))) {
    warning(
      "Palette specified is not a valid PWD palette type! Default palette will be used.",
      "Please select from the following: ",
      paste(names(pwd_palettes), collapse = ", "),
      call. = FALSE
    )
    palette <- "main"
  }

  pal <- pwd_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  return(grDevices::colorRampPalette(pal, ...))
}


#' @describeIn pwd_pal Return figure with selected PWD color palette
#'
#' @param n number of desired levels in palette
#' @param show_hex logical, if TRUE (default), the hex code will be printed
#' for each color. If a large n is specified, it is recommended to set this
#' to false, as the hex codes become unreadable if n > 100
#'
#' @export
view_pwd_palette <- function(palette = "main", n = NULL, show_hex = TRUE){
  if (is.null(n)){
    n <- length(pwd_palettes[[palette]])
  }

  cols <- pwd_pals(palette)(n)

  palette_name <- stringr::str_to_title(palette) %>%
    stringr::str_replace("_", " ")

  n_seq <- seq_along(cols)
  image(n_seq, 1, as.matrix(n_seq), col = cols,
        xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n",
        main = paste(palette_name, "palette for PWD, with", n, "levels"))

  if (show_hex) text(n_seq, 1, cols, col = "white", srt = 90)

}



#' Color scale constructor for PWD colors
#'
#' @param palette Character name of palette in pwd_palettes
#' @param reverse logical, if TRUE the palette is reversed
#' @param discrete logical, if TRUE (default) the color aesthetic
#' is treated as discrete
#' @param ... Additional parameters to be passed to either
#' \code{ggplot2::discrete_scale} or \code{ggplot2::scale_color_gradientn},
#' depending on whehter discrete is TRUE or FALSE
#'
#' @rdname scale_pwd
#' @export
scale_color_pwd <- function(palette = "main", reverse = FALSE,
                            discrete = TRUE, ...){
  pal <- pwd_pals(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("colour", paste0("pwd_", palette),
                            palette = pal, ...)
  } else {
    ggplot2::scale_color_gradientn(colours = pal(256), ...)
  }
}


#' @rdname scale_pwd
#' @export
scale_colour_pwd <- scale_color_pwd


#' @rdname scale_pwd
#' @export
scale_fill_pwd <- function(palette = "main", reverse = FALSE,
                           discrete = TRUE, ...){
  pal <- pwd_pals(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("pwd_", palette),
                            palette = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }
}
