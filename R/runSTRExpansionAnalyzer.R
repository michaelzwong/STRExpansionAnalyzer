#' Launch Shiny App for STRExpansionAnalyzer
#'
#' @return No return value.
#'
#' @examples
#' \dontrun{
#' runSTRExpansionAnalyzer()
#' }
#'
#' @author Michael Wong, \email{michaelz.wong@mail.utoronto.ca}
#'
#' @references
#' Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson
#' (2020). shiny: Web Application Framework for R. R package version 1.5.0.
#' https://CRAN.R-project.org/package=shiny
#'
#' @export
#' @importFrom shiny runApp
runSTRExpansionAnalyzer <- function() {
  dir <- system.file("shiny-scripts",
                        package = "STRExpansionAnalyzer")
  shiny::runApp(dir, display.mode = "normal")
  return()
}
