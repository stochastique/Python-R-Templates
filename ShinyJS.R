library(shiny)
library(shinyjs)

ui <- fluidPage(
    useShinyjs(),
    tags$head(
        tags$script(src = "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.min.js"),
        tags$script(src = "https://surveyjs.azureedge.net/1.1.13/survey.jquery.min.js"),
        tags$link(href="https://surveyjs.azureedge.net/1.1.13/survey.css" ,type="text/css" ,rel="stylesheet")
    ),
    tags$body(
        tags$script(src = "www/survey.js", type="text/javascript")
    ),
    HTML('<div id="surveyContainer"></div>'),
    fluidPage(
      textOutput("text1")
    )
)

server <- function(input, output, session) {
    
   runjs('Survey.StylesManager.applyTheme("bootstrap");

var surveyJSON = {"pages":[{"name":"page1","elements":[{"type":"dropdown","name":"question1","choices":["item1","item2","item3"]}]}]}

function sendDataToServer(survey) {
    //send Ajax request to your web server.
    alert("The results are:" + JSON.stringify(survey.data));
}

function sendDataToServer2(survey) {
  Shiny.onInputChange("jsValue",JSON.stringify(survey.data))
}

var survey = new Survey.Model(surveyJSON);
$("#surveyContainer").Survey({
    model: survey,
    onComplete: sendDataToServer2
});


')
    observeEvent(input$jsValue,{
        cat("\nmessage received")
        output$text1 <- renderText(input$jsValue)
    })
    
    
}


shinyApp(ui, server)
