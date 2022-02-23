# pwdthemes 0.1.8 (2022-02-23)

* added ability to change font size of headers for PWD Report LaTeX template

# pwdthemes 0.1.7 (2022-02-15)

* Updated pwd palettes to match the recommended palettes from PWD's Public Affairs office
* Removed lualatex as the forced latex engine for PWD Rmarkdown templates


# pwdthemes 0.1.6

* Resorted to default Rmarkdown font and removed dependency for the fontspec LaTeX package as it was causing a lot of issues with knitting for various reports

# pwdthemes 0.1.5

* Removed Calibri font due to issues with deployment to Connect server. Calibri is only available on Windows. Switched to Arial

# pwdthemes 0.1.4

* Add csl pandoc formatting to each of the rmarkdown templates

# pwdthemes 0.1.3

* Fixing namespace issues with `theme_pwd`

# pwdthemes 0.1.2

* Fixed issue with reliance on ggplot2 internal functions

# pwdthemes 0.1.1 

* Added pkgdown site

# pwdthemes 0.1.0

* Added ggplot2 theme named `theme_pwd`
* Added Rmarkdwon templates for PWD Reports, Memos, and Meeting Agendas
* Migrated the `scale_*_pwd` functions from `wqr`
* Added a `NEWS.md` file to track changes to the package.
