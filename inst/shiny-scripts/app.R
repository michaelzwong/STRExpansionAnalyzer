library(shiny)

ui <- fluidPage(
  # App title
  headerPanel("STR Expansion Analyzer"),

  # Sidebar panel for inputs
  sidebarPanel(
    # Specify the standard deviation to calculate motifs
    numericInput(inputId="sd",
                 label="Z-Score (Max: 3)",
                 value=0.1,
                 min=0,
                 max=3,
                 step=0.05),

    selectInput(inputId="plotType",
                label="Plot Type",
                choices=c("Motif Distribution",
                        "Common Motifs",
                        "Most Variable",
                        "Least Variable")),

    # Motif distribution graph
    conditionalPanel(condition="input.plotType == 'Motif Distribution'",
                     selectInput(inputId="distType",
                                 label="Distribution Type",
                                 choices=c("Count","Density")),
                     textInput(inputId="motif",
                               label="Motifs (Seperate each motif by space )",
                               value="ATAT TAG")),
    # Common motifs graph
    conditionalPanel(condition="input.plotType == 'Common Motifs'",
                     numericInput(inputId="numCommonMotifs",
                                  label="Number of Common Motifs to show (Max: 10)",
                                  value=5,
                                  min=1,
                                  max=10,
                                  step=1),
                     checkboxInput("stacked", "Stacked", FALSE)),

    # Most/Least Variable graph
    conditionalPanel(condition="input.plotType == 'Most Variable'
                     || input.plotType == 'Least Variable'",
                     numericInput(inputId="numVariableMotifs",
                                  label="Number of Variable Motifs to show (Max: 10)",
                                  value=5,
                                  min=1,
                                  max=10,
                                  step=1)),

  ),

  # Main panel for displaying outputs
  mainPanel(
    plotOutput('plot')
  )
)

server <- function(input, output) {
  mydf <- reactive({
    data("ShortTandemRepeatsLoci")
    STRExpansionAnalyzer::createVariables(df=ShortTandemRepeatsLoci, input$sd)
  })
  output$plot <- renderPlot({
    if(input$plotType == 'Motif Distribution') {
      if(input$distType == 'Density') {
        p <- STRExpansionAnalyzer::plotMotifsDistribution(mydf(), strsplit(input$motif, " ")[[1]], count=FALSE)
      } else {
        p <- STRExpansionAnalyzer::plotMotifsDistribution(mydf(), strsplit(input$motif, " ")[[1]], count=TRUE)
      }
    } else if(input$plotType == 'Common Motifs') {
      if(input$stacked == TRUE) {
        p <- STRExpansionAnalyzer::plotTopNCommonMotifs(mydf(), input$numCommonMotifs, stacked=TRUE)
      } else {
        p <- STRExpansionAnalyzer::plotTopNCommonMotifs(mydf(), input$numCommonMotifs, stacked=FALSE)
      }
    } else if(input$plotType == 'Most Variable') {
      p <- STRExpansionAnalyzer::plotTopNMostVariableMotifs(mydf(), input$numVariableMotifs)
    } else {
      p <- STRExpansionAnalyzer::plotTopNLeastVariableMotifs(mydf(), input$numVariableMotifs)
    }
    print(p)
  })
}

shinyApp(ui, server)
