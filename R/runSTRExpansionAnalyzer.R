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
#' @export
#' @importFrom shiny runApp
runSTRExpansionAnalyzer <- function() {
  dir <- system.file("shiny-scripts",
                        package = "STRExpansionAnalyzer")
  shiny::runApp(dir, display.mode = "normal")
  return()
}
