## Load the required libraries, and install them if necessary
require(shiny) || install.packages(shiny)
require(shinythemes) || install.packages(shinythemes)
require(rhandsontable) || install.packages(rhandsontable)

shinyUI(fluidPage(theme = "simplex.css",

    ## Header bar with links to other apps
    HTML('<br>
            <link rel="stylesheet" type="text/css" href="index.css">
            <style>
            html { overflow-y: scroll; }
            </style>
            <div class="bar">
            <b class="title">Measurement and Modelling Lab &nbsp; - &nbsp; Tools</b><br class="rwd-break">
            <b class="link">
                <a href="https://shiny.rcg.sfu.ca/u/tmustaph/MML-R2/"><font color="white">MML-R2</font></a>
                &emsp;&nbsp;<a href="https://shiny.rcg.sfu.ca/u/tmustaph/MML-Multicorr/"><font color="white">MML-Multicorr</font></a>
                &emsp;&nbsp;<a href="https://shiny.rcg.sfu.ca/u/tmustaph/MML-WBCORR/"><font color="white">MML-WBCORR</font></a>
                &emsp;&nbsp;<a href="https://shiny.rcg.sfu.ca/u/tmustaph/csv-generator/"><font color="#00ca8a">CSV Generator</font></a>
                &emsp;&nbsp;<a href="https://shiny.rcg.sfu.ca/u/tmustaph/distribution-tests/"><font color="white">Distribution Tests</font></a>
                
            </b>
            </div>
            <br>'
        ),

    ## CSS style stuff
    tags$head(
           tags$style(HTML("@import url('//fonts.googleapis.com/css?family=Patua+One');
                          body { min-width: 450px; }
                          sub { vertical-align: 25%; font-size: 70%; }"))),

    ## No title since it's in the header bar
    headerPanel('', windowTitle = 'CSV Generator'),

    sidebarLayout(
        sidebarPanel(
            selectInput("file",
                        label = "File to create:",
                        choices = list("Correlation matrix" = "correlation", "Hypothesis matrix" = "hypothesis"),
                        selected = "correlation"),
            sliderInput("variables",
                        "Number of variables:",
                        min = 2,
                        max = 16,
                        value = 2)),

        mainPanel(
            tabsetPanel(

                id = "inTabset",
                                        #tabPanel(value = "about", "About", includeHTML("./documentation/about.html")),
                tabPanel(value = "output", "Output",

                         ## Javascript table for creating a correlation matrix
                         conditionalPanel(condition = "input.file == 'correlation'",
                                          rHandsontableOutput("corrtable1")),

                         ## Javascript table for specifying hypotheses
                         conditionalPanel(condition = "input.file == 'hypothesis'",
                                          rHandsontableOutput("corrtable2")),

                         ## Space between the two tables for creating a hypothesis matrix
                         conditionalPanel(condition = "input.file == 'hypothesis'",
                                          HTML("<br>")),

                         ## Javascript table for generating and downloading the hypothesis matrix
                         conditionalPanel(condition = "input.file == 'hypothesis'",
                                          rHandsontableOutput("hypothesistable"))

                         ),
                tabPanel(value = "about", "About", includeHTML("./documentation/about.html"))
            )


)

  ),

  HTML('<br><br><br><br><br><br><br><br><br><br>'), ## Breathing room

  ## Footer bar
  HTML('<link rel="stylesheet" type="text/css" href="index.css">
        <div class="bar2">
          <b class="bottom">
            <font color="#717171">Provided by the</font>
            <a href="http://members.psyc.sfu.ca/labs/mml"><font color=white>Measurement and Modelling Lab</font></a>
            <font color="#717171"> at</font>
            <a href="https://www.sfu.ca/"><font color=white> SFU</font></a>
          </b>
        </div><br>')
  )
)
