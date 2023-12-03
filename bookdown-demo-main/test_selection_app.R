library(dplyr)
library(shiny)

input_data <- read.csv("C:/Users/ofatunde/Dropbox/World Bank JDC Fellowship/Project work/Microdata library/Documentation wiki/microdata-citation-explorer-public/microdata-citation-explorer/data/outputs/concatenated_results_12_May.csv")

dataset_numbers <- unique(input_data$dataset_id)
query_numbers <- unique(input_data$query_type)

########### UI function ==================================================================
shinyApp(
  ui = fluidPage(
    sidebarLayout(
      sidebarPanel(
        #actionButton("newplot", "New plot"),
        selectInput(
          inputId = "selected_dataset",
          label = "Select dataset number",
          choices = dataset_numbers,
          selected = 189,
          multiple = FALSE,
          selectize = TRUE,
          width = NULL,
          size = NULL
        ),

        selectInput(
          inputId = "selected_query",
          label = "Select query type",
          choices = query_numbers,
          selected = "AFRO",
          multiple = FALSE,
          selectize = TRUE,
          width = NULL,
          size = NULL
        )
      ),
      mainPanel(
        fluidRow(
          column(6,
                tableOutput("table1")
          )
        )

      )
    )
  ),
  server = function(input, output) {
    output$table1 <- renderTable({
      # input$newplot
      # Add a little noise to the cars data
      input_data %>%
        filter(dataset_id == input$selected_dataset,
               query_type == input$selected_query)
    })

  }
)
