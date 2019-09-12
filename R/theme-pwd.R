#' A ggplot2 theme for PWD
#'
#'
theme_pwd <- function(base_size = 12, base_family = "Calibri"){

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
      text = element_text(color = "#0078C8"),
      axis.line = element_line(color = "#001A70"),
      axis.ticks = element_line(color = "#001A70"),
      # axis.line = element_line(color = "#C6DAE7"),
      plot.title = element_text(color = "#0078C8", face = "bold"),
      plot.subtitle = element_text(color = "#0078C8"),
      # panel.background = element_rect(fill = "#C6DAE7"),
      panel.grid.major = element_line(color = "#C6DAE7"),
      # axis.title = element_text(color = "#0078C8"),
      axis.title = element_text(color = "#001A70"),
      axis.text = element_text(color = "#001A70")
    )
}
