#
#
#
#

# Library Packages

library(tidyverse)
library(shiny)
library(shinythemes)
library(readxl)


# Load Data

data <- read_excel("raw_data/CFISD_Return_to_School_Data.xlsx",
                   sheet = "Sheet2")


# I cleaned / merged the data in excel since both data sets came in similar
# formats and copy and paste was as easy this time as joining them here.
# Arguably more efficient since I only have to read in one dataset to the app.

###############################################################################
###############################################################################

# Define UI for application 
ui <- fluidPage(theme = shinytheme("sandstone"),

                navbarPage("Cypress-Fairbanks ISD 2020-21 Learning Landscape",
                           
                           # Panel 1
                           tabPanel("Overview",
                                    h1("Cypress-Fairbanks ISD 2020-21 Learning Landscape Analysis"),
                                    p("Analyzing Return to School Questionnaire Data 
                                      from the 2020-21 School Year to Inform Equitable 
                                      Post-Pandemic Recovery", 
                                      style = "font-size:20px;"),
                                    
                                    
                                    br(),
                                    
                                    mainPanel(
                                       p("During the 2020-21 school year, Cypress 
                                         Fairbanks ISD offered families the opportunity 
                                         to choose whether students would attend 
                                         classes in person or virtually. At the 
                                         beginning of each quarterly Marking Period, 
                                         families could change their preferences
                                         through a 'Return to School' Questionnaire. 
                                         On average, more students opted to come 
                                         to campus each quarter as the year progressed, 
                                         with elementary schools generally having 
                                         higher rates of students in-person than 
                                         middle schools, and middle schools having 
                                         higher rates of students in-person than 
                                         high schools, as shown in the chart below."), 
                                        
                                       br(),
                                       img(src = "bar_plot_clean.png", 
                                           height = "90%", 
                                           width = "90%",
                                           style = "display: block; margin-left: 
                                                 auto; margin-right: auto;"),
                                       br(),
                                       br(),
                                       
                                       p("A Question of Equity", 
                                         style = "font-size:20px;"),
                                      
                                       p("Recent research illustrates that for 
                                         most students, in-person schooling leads 
                                         to better academic and developmental outcomes. 
                                         As the current school year comes to an end, 
                                         with over 31,000 students still learning 
                                         remotely, district leaders are faced with 
                                         difficult decisions to make about supplemental 
                                         summer programming and additional supports 
                                         for next school year. In order to equitably 
                                         allocate funding and resources, it is crucial 
                                         to identify which campuses and which students 
                                         may need them the most. In this report, 
                                         I will analyze the data we have to inform
                                         this decision, as well as identify
                                         other key factors that ought to be considered."),

                                       
                                       br(),
                                       ),
                                    
                                    sidebarPanel(
                                        h3("Trends by School Type"),
                                        br(),
                                        h4("Elementary Schools"),
                                        p("Elementary schools increased 38 percentage 
                                          points from an average of 40% of students 
                                          in person in the first Marking Period 
                                          to an average of 78% of students in person 
                                          in the fourth Marking Period. Still, 
                                          11,488 elementary students (22%)  had 
                                          not returned to in-person learning by 
                                          the end of the school year."),
                                        
                                        h4("Middle Schools"),
                                        p("Among middle schools, on-campus instruction 
                                        increased by 33 percentage points, from 
                                        an average of 38% of students in person 
                                        in the first Marking Period to 71% of students 
                                        in person at the end of the school year. 
                                        7,887 middle school students (29%) were still 
                                        learning remotely at the end of the school 
                                        year."),
                                       
                                        h4("High Schools"),
                                        p("The percentage of high school students 
                                          opting for in-person instruction
                                          increased by 23 percentage points, from 
                                          43% to 66% by the end of the school year. 
                                          Still, high schools had the lowest rates 
                                          of students in person, with 12,542 high 
                                          school students (34%) learning remotely in 
                                          Marking Period 4.")
                                        
                                    )
                                    
                                    
                           ),
                           
                           # Panel 2
                           tabPanel("Analysis",
                                    h2("What is the relationship between the portion
                                       of students with economic disadvantages and 
                                       the rates at which students choose in-person 
                                       schooling?"),
                                    br(),
                                    mainPanel(
                                    p("", 
                                      style = "font-size:20px;"),
                                    br(),
                                    
                                    # Interactive Plot
                                    selectInput(inputId = "selected_mp",
                                                label = "Choose a Marking Period",
                                                choices = c("First Marking Period" = "mp1_plot", 
                                                            "Second Marking Period" = "mp2_plot",
                                                            "Third Marking Period" = "mp3_plot", 
                                                            "Fourth Marking Period" = "mp4_plot")),
                                    
                                    
                                    plotOutput("scatter_plot"),
                                    br(),
                                    p("The graph above shows the relationship 
                                      between a school's percentage of students
                                      who experience economic disadvantage and 
                                      the school's percentage of students who opted
                                      for in-person instruction. Note that each 
                                      dot is a school, with color indicating whether 
                                      it is an elementary, middle, or high school, 
                                      and the size corresponding to the size of 
                                      the student body. Choose a Marking Period 
                                      from the dropdown list to see how this 
                                      relationship changed over time."),
                                    br(),
),
                                    
                                    sidebarPanel(
                                        h3("Takeaways"),
                                    
                                    br(),
                                    p("",
                                    strong("At the beginning of the school year, 
                                           there was a strong negative relationship"),
                                      "between the percent of students in a school 
                                      who are economically disadvantaged and the 
                                      percent of students who chose in-person school. 
                                      This trend applied across grade-levels, with 
                                      few outliers."),
                                    br(),
                                    p("Over time, though,",
                                    strong("greater rates of students returned to 
                                           in-person learning, particularly among 
                                           elementary schools."),
                                      "By the end of the year, all elementary schools 
                                      had roughly 70-90% of students back on campus 
                                      daily."),

                                    br(),
                                    p("By the 4th Marking Period,", 
                                    strong("middle and high  schools that have 50% 
                                           or more of their students who are economically 
                                           disadvantaged had returned to on-campus 
                                           schooling at significantly lower rates"),
                                      "than schools with fewer economically disadvantaged 
                                      students. Specifically, they opted in at an 
                                      average rate of 64%, while the schools with 
                                      less than 50% of their students experiencing
                                      economic disadvantage opted in at an average 
                                      rate of 76%."),

                )
                                    
                           ),         

                           
                           # Panel 3
                           
                           tabPanel("Implications for Policy & Practice",
                                    mainPanel(
                                        h3("About the Project"),
                                        h4("Findings"),
                                        p("This project explores the relationship 
                                          between socio-economic status and student 
                                          achievement for each of the roughly 
                                          13,000 school districts in the country. 
                                          I grouped districts by their states 
                                          since the majority of education policy 
                                          decision-making happens at the state 
                                          level. In each state, I found a positive 
                                          correlation between SES and student 
                                          achievement; however, the magnitude of 
                                          correlations vary. I then built a 
                                          predictive model that estimates that
                                          students from a typical school 
                                          district will perform slightly above 
                                          grade-level on future assessments under 
                                          a certain set of assumptions. Because 
                                          I was interested in the variance between 
                                          states, I also analyzed the posterior
                                          distributions for three of the most 
                                          influential states. Ultimately the variance 
                                          between these states could be used to 
                                          inform policy decisions in the future 
                                          as state education agencies strategically 
                                          allocate funding and support for post-pandemic 
                                          recovery."), 
                                        
                                        br(),
                                        
                                        h4("Recommendations For Further Analysis"),
                                        p(strong("Use student-level data to analyze
                                          racial trends.")),
                                        p("A recently released federal survey
                                          shows that across the country, white 
                                          students returned to campus at higher 
                                          rates than students of color, potentially
                                          widening the racial opportunity gap. 
                                          Future analyses should investigate to
                                          what extent that trend exists in Cy-Fair."),
                                        br(),
                                        p(strong("Investigate the experience of 
                                                 students with disabilities.")),
                                        p("Similarly, surveys show that students
                                          recieving IEP services were often not served
                                          as well in a digital setting. Further 
                                          student-level analysis may show how 
                                          many students are in this category, and
                                          how to best support them when they 
                                          return to campus."),
                                        br(),
                                        
                                        h4("Refrences")
                                        
                                        ),
                                    
                                  


                           )))


# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$school_images <- renderImage({
        
        # Load image based on input$school_type from ui
        if (input$school_type == "elementary") {
            {img(src = "elementary.png", 
                 height = "60%", 
                 width = "60%",
                 style = "display: block; margin-left: 
                                            auto; margin-right: auto;")}
        }
        
        else if (input$school_type == "middle") {
            {img(src = "middle.png", 
                 height = "60%", 
                 width = "60%",
                 style = "display: block; margin-left: 
                                            auto; margin-right: auto;")}
        }
        
        else if (input$school_type == "high") {
            {img(src = "high.png", 
                 height = "60%", 
                 width = "60%",
                 style = "display: block; margin-left: 
                                            auto; margin-right: auto;")}
        }
        
    })
    
    
    output$scatter_plot <- renderPlot({
        
            
        # Generate type based on input$selected_mp from ui
        if (input$selected_mp == "mp1_plot") {
            {mp1_plot}
        }
        
        else if (input$selected_mp == "mp2_plot") {
            {mp2_plot}
        }
        
        else if (input$selected_mp == "mp3_plot") {
            {mp3_plot}
        }
        
        else if (input$selected_mp == "mp4_plot") {
            {mp4_plot}
        }
        
        
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
