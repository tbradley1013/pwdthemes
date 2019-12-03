#===============================================================================
# Creating a hex sticker for pwdthemes
#
# Tyler Bradley
# 2019-08-30
#===============================================================================

library(hexSticker)
library(magick)
library(ggplot2)
library(showtext)

logo <- image_read("man/figures/water-logo-large-white.png")

# p <- ggplot() +
#   geom_hexagon(size = 0.75, fill = "pink", color = "#001A70") +
#   ggplot2::theme_void() +
#   theme(
#     plot.background = element_rect(fill = "black")
#   )
#
# ggsave("sticker/blank-hex.png", plot = p, width = 1.73, height = 2, units = "in")

blank_hex <- image_read("sticker/blank-hex.png")
blank_hex <- blank_hex %>%
  image_transparent(color = "pink")


# theme_back <- image_read("sticker/theme-background.png")
# theme_back_crop <- theme_back %>% image_background("black") %>%  image_crop(geometry = "390x345+60+60")

sticker_back <- image_append(
  c(
    image_blank(129.75, 600, "#001A70"),
    image_blank(129.75*2, 600, "#0078C8"),
    image_blank(129.75, 600, "#F37720")
  )
) %>%
  image_composite(image_scale(logo, "235"), offset = "+142+350") %>%
  image_composite(blank_hex) %>%
  image_crop("510x590+10+10") %>%
  image_transparent("black")


font_add_google("Open Sans", "open_sans")

# when this command is run it will overwrite the pwdthemes.png file. The two lines
# below it must be run to correctly size the sticker.
sticker(sticker_back,
        package = "pwdthemes",
        s_x = 1.015,
        s_y = 0.99,
        s_width =2.18,
        s_height = 2.18,
        # p_color = "#F37720",
        p_family = "open_sans",
        p_color = "white",
        p_size = 20,
        p_y = 1.25,
        h_fill = "#0078C8",
        h_color = "white",
        h_size = 2)


pkg_sticker <- image_read("pwdthemes.png")

pkg_sticker

pkg_sticker %>% image_write("sticker/pwdthemes-large.png")

pkg_sticker %>% image_scale(175) %>% image_write("pwdthemes.png")
