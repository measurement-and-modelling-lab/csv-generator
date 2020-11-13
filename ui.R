## Load the required libraries, and install them if necessary
require(shiny) || install.packages(shiny)
require(shinythemes) || install.packages(shinythemes)
require(rhandsontable) || install.packages(rhandsontable)

shinyUI(fluidPage(theme = "simplex.css",

    ## Header bar with links to other apps
    HTML('<br>
  
    <link rel="stylesheet" type="text/css" href="index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
function myFunction() {
  var x = document.getElementById("myTopnav");
  if (x.className === "topnav") {
    x.className += " responsive";
    document.getElementById("row-break").style.display = "inline";
    document.getElementById("row-break2").style.display = "inline";
  } else {
    x.className = "topnav";
    document.getElementById("row-break").style.display = "none";
    document.getElementById("row-break2").style.display = "none";
  }
}
</script>
  <style>
    html {
       overflow-y: scroll;
       }
  </style>
    <title>Analytics^2 - About</title>
    <div class="bar">
    <div class="topnav" id="myTopnav"">
      <a href="javascript:void(0);" class="icon" onclick="myFunction()">
        <i class="fa fa-bars"></i>
      </a>
      <b class="title">Measurement and Modelling Lab &nbsp; - &nbsp; Tools</b><br class="rwd-break" id="row-break"><br class="rwd-break" id="row-break2">
      <a href="https://shiny.rcg.sfu.ca/u/zrauf/MML-R2/"><font color="white">MML-R2</font></a>
      <a href="https://shiny.rcg.sfu.ca/u/zrauf/MML-Multicorr/"><font color="white">MML-Multicorr</font></a>
      <a href="https://shiny.rcg.sfu.ca/u/zrauf/MML-WBCORR/"><font color="white">MML-WBCORR</font></a>
      <a href="https://shiny.rcg.sfu.ca/u/zrauf/csv-generator/"><font color="#00ca8a">CSV Generator</font></a>
      <a href="https://shiny.rcg.sfu.ca/u/zrauf/distribution-tests/"><font color="white">Distribution Tests</font></a>

    </div>
    </div>
         
         
         
  '),
    
    HTML("<br>"),

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
