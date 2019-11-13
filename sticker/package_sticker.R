#===============================================================================
# Creating a hex sticker for pwdthemes
#
# Tyler Bradley
# 2019-08-30
#===============================================================================

library(hexSticker)
library(magick)

logo <- image_read("man/figures/water-logo-large-white.png")

# when this command is run it will overwrite the pwdthemes.png file. The two lines
# below it must be run to correctly size the sticker.
sticker(logo, package = "pwdthemes",
        s_x = 1, s_y = 0.85, s_width =1.5, s_height = 0.93,
        p_color = "#F37720", p_size = 20,
        h_fill = "#0078C8", h_color = "#F37720",
        h_size = 2)


pkg_sticker <- image_read("pwdthemes.png")

pkg_sticker %>% image_scale(175) %>% image_write("pwdthemes.png")
