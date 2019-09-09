# Create functions to call PWD report templates

#' Creates PWD Report
#'
#' @export
pwd_report <- function(...){
  pdf_document_format("pwd-report", ...)
}

#' Creates PWD Memo
#'
#' @export
pwd_memo <- function(...){
  pdf_document_format("pwd-memo", ...)
}

#' Creates PWD Meeting Agenda
#'
#' @export
pwd_meeting_agenda <- function(...){
  pdf_document_format("pwd-meeting-agenda", ...)
}

pdf_document_format <- function(
  format, template = find_resource(format, 'template.tex'), ...
) {
  fmt <- rmarkdown::pdf_document(..., template = template, latex_engine = "lualatex")
  fmt$inherits <- "pdf_document"
  fmt
}


find_resource <- function(template, file = 'template.tex') {
  res <- system.file(
    "rmarkdown", "templates", template, "resources", file, package = "pwdthemes"
  )
  if (res == "") stop(
    "Couldn't find template file ", template, "/resources/", file, call. = FALSE
  )
  res
}
