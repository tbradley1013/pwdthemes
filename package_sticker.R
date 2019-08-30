#===============================================================================
# Creating a hex sticker for pwdthemes
#
# Tyler Bradley
# 2019-08-30
#===============================================================================

library(hexSticker)
library(magick)

logo <- image_read("man/figures/water-logo-large-white.png")

pkg_sticker <- sticker(logo, package = "pwdthemes", p_family = "BrixSansRegular",
                       s_x = 1, s_y = 0.85, s_width =1.5, s_height = 0.93,
                       p_color = "#F37720", p_size = 20,
                       h_fill = "#0078C8", h_color = "#F37720",
                       h_size = 2)


pkg_sticker
