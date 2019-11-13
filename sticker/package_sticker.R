#===============================================================================
# Creating a hex sticker for pwdthemes
#
# Tyler Bradley
# 2019-08-30
#===============================================================================

library(hexSticker)
library(magick)
library(ggplot2)

logo <- image_read("man/figures/water-logo-large-white.png")

# sticker_pal <- pwdthemes:::pwd_palettes$full[c(4, 1, 8, 6)]
# # sticker_pal <- pwdthemes:::pwd_palettes$full[c(8,4, 6, 3)]
# pal_seq <- seq_along(sticker_pal)
# image(pal_seq, 1, as.matrix(pal_seq), col = sticker_pal,
#       xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n")
#
#
# png(file = "sticker/theme-background.png")
# image(pal_seq, 1, as.matrix(pal_seq), col = sticker_pal,
#       xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n")
# dev.off()


p <- ggplot() +
  geom_hexagon(size = 1, fill = "pink", color = "#001A70") +
  ggplot2::theme_void()

ggsave("sticker/blank-hex.png", plot = p, width = 1.73, height = 2, units = "in")

blank_hex <- image_read("sticker/blank-hex.png")
blank_hex <- blank_hex %>%
  image_transparent(color = "pink")


# theme_back <- image_read("sticker/theme-background.png")
# theme_back_crop <- theme_back %>% image_background("black") %>%  image_crop(geometry = "390x345+60+60")

sticker_back <- image_append(
  c(
    image_blank(173, 600, "#001A70"),
    image_blank(173, 600, "#0078C8"),
    image_blank(173, 600, "#F37720")
  )
) %>%
  image_composite(image_scale(logo, "235"), offset = "+142+350") %>%
  image_composite(blank_hex)


# comb_image <- image_composite(theme_back_crop, image_scale(logo, 200), offset = "+87+200")
#
#
# sticker_back <- image_composite(image_scale(theme_back_crop, 350), blank_hex) %>%
#   image_crop(geometry = "260x300+0+0") %>%
#   image_transparent("white") %>%
#   image_scale("600") %>%
#   image_composite(image_scale(logo, 275), offset = "+162+375")
# when this command is run it will overwrite the pwdthemes.png file. The two lines
# below it must be run to correctly size the sticker.
sticker(sticker_back,
        package = "pwdthemes",
        s_x = 0.99,
        s_y = 1.01,
        s_width =2.2,
        s_height = 2.2,
        # p_color = "#F37720",
        p_color = "white",
        p_size = 20,
        h_fill = "#0078C8",
        h_color = "white",
        h_size = 2)


pkg_sticker <- image_read("pwdthemes.png")

pkg_sticker

pkg_sticker %>% image_write("sticker/pwdthemes-large.png")

pkg_sticker %>% image_scale(175) %>% image_write("pwdthemes.png")
