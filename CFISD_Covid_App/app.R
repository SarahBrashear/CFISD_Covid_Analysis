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

                navbarPage("Cypress-Fairbanks ISD On-Campus Learning Trends",
                           
                           # Panel 1
                           tabPanel("Background",
                                    h1("What Happens When Families Can Choose?"),
                                    p("An Analysis of the Opportunity to Choose 
                                       Between Fully Virtual or Fully On-Campus
                                       Learning during the Covid-19 Pandemic", 
                                      style = "font-size:20px;"),
                                    
                                    
                                    br(),
                                    
                                    # Main Panel
                                    # This is where the interactive portion of 
                                    # my app is.
                                    
                                    mainPanel(
                                       p("
During the 2020-21 school year, Cypress Fairbanks ISD offered students and families the opportunity to choose whether students would attend classes in person each day, or if they would learn remotely during synchronous virtual instruction. At the beginning of each quarter, families could change their preferences. On average, more students opted in each quarter as the year progressed, with elementary schools generally having higher rates of students in-person than middle schools, and middle schools having higher rates of students in-person than high schools, as shown below."), 
                                        
                                       br(),
                                       img(src = "bar_plot.png", 
                                           height = "80%", 
                                           width = "80%",
                                           style = "display: block; margin-left: 
                                                 auto; margin-right: auto;"),
                                       br(),
                                       br(),
                                        
                                        # Interactive Plot
                                        selectInput(inputId = "selected_mp",
                                                    label = "Choose a Marking Period",
                                                    choices = c("First Marking Period", 
                                                                "Second Marking Period",
                                                                "Third Marking Period", 
                                                                "Fourth Marking Period")),
                                    

                                        plotOutput("scatter_plot"),
                                        br(),
                                        
                                        p("Select a state from the dropdown list
                                          above in order to see the relationship 
                                          between student achievement and 
                                          socioeconomic status for each school 
                                          district in that state. Each bubble 
                                          represents one public school district, 
                                          and the size of the district represents
                                          the number of students enrolled in the 
                                          district. Along the X axis, you can 
                                          see a school district's average 
                                          socioeconomic status, with zero 
                                          representing the national average SES. 
                                          Along the Y axis, you see student 
                                          achievement, measured by the average 
                                          test scores of 5th graders in that 
                                          district.")),
                                    
                                    
                                    h2("Trends by Grade"),
                                    p(),
                                    
                                    sidebarPanel(
                                        h4("Elementary Schools"),
                                        p(
"Elementary schools
went from an average of 40% of students in person in the first Marking Period, to an
average of 78% of students in person in the fourth Marking Period, for an increase of
38 percentage points. Still, by the end of the school year elementary schools had 22%
of their students learning remotely, on average. 11,488 elementary students in 
CFISD had not returned to in-person learning by the end of the school year.
"),
                                        h4("Middle Schools"),
                                        p("
Among middle schools, on-campus instruction increased by 33 percentage points,
from an average of 38% of students in person in the first Marking Period
to 71% of students in person at the end of the school year. 7,887 middle school
students were still learning remotely at the end of the school year. 
                                          "),
                                       
                                        h4("High Schools"),
                                        p("
High Schools in CFISD saw the percentage of students opting for in person instruction
increase by 23 percentage points, from 43% to 66% by the end of the school year. Still,
12,542 high school students were learning remotely in Marking Period 4. 
                                            
                                        ")
                                        
                                    )
                                    
                                    
                           ),
                           
                           # Panel 2
                           tabPanel("School-level Trends",
                                    h2("How would we expect students in the 
                                       \"typical\" school district to perform on 
                                       future assessments?"),
                                    p("Modeling Predicted Student Achievement", 
                                      style = "font-size:20px;"),
                                    p("Public school districts vary dramatically 
                                      in size, location, student body demographics, 
                                      and available funding. All of these factors 
                                      shape the learning outcomes of the students 
                                      who attend them. While no two school districts 
                                      are exactly the same, the SEDA data allows 
                                      us to compare student outcomes across time 
                                      and place in order to better understand and 
                                      explain the variance in student achievement.
                                      Now more than ever,as districts across the 
                                      country prepare for a post-pandemic educational 
                                      landscape, it is imperative that education 
                                      leaders and policy-makers understand how 
                                      educational outcomes vary across the country."), 
                                    br(),
                                    p("I designed a predictive model to explore 
                                      the ", 
                                      strong("predicted student achievement"),
                                      "for the average school district, based 
                                      on socio-economic status. With a lens towards 
                                      equity, I wanted to explore whether \"demography 
                                      is destiny\" for students in U.S. public schools, 
                                      or if students who are born into low-SES communities 
                                      are provided educational opportunities that 
                                      allow them to achieve as highly as their more 
                                      affluent peers. I decided to control for
                                      the percentage of students who are English 
                                      Language Learners and the percentage of students 
                                      who receive special education services based 
                                      on extensive literature that shows that 
                                      traditional assessments do not accurately
                                      measure achievement outcomes for these groups 
                                      of students. I also tested a few other 
                                      models-one controlling for racial differences 
                                      between school districts, and one controlling 
                                      for various component parts of the SES index,
                                      such as the percentage of students receiving 
                                      free or reduced-price lunch (a proxy for 
                                      parental income). Using the Loo Compare analysis, 
                                      I found that the racial demographic variables 
                                      were not statistically significant. Further, 
                                      the model that accounted for state, district's 
                                      percentage of English Language Learners, and 
                                      students receiving special education services 
                                      was the strongest. It is illustrated below."),
                                    
                                    
                                    br(),
                                    p(strong("Regression Model Equation:")),
                                    
                                    # the withMathJax function is the easiest way
                                    # to write equations in a shiny app. I learned
                                    # about this from peers on Demo Day.
                                    
                                    withMathJax('$$ meanavg_i = \\beta_0 + 
                                        \\beta_1sesavgall_i + 
                                        \\beta_2sesavgall_i*state_i + 
                                        \\beta_3perell_i +
                                        \\beta_4perspeced_i +
                                        \\varepsilon_i $$'),
                                    
                                    br(),
                                    br(),
                                    
                                    p("Interpretation of Findings:", 
                                      style = "font-size:20px;"),
                                    br(),
                                    
                                    # Loading the full data into the
                                    # app and running the regression, and then
                                    # building the plot in the app would have 
                                    # slowed it down significantly. Also, lots
                                    # of classmates tried to use plotly and had
                                    # issues with it. I opted to load in all my 
                                    # posterior plots as static images, following
                                    # the code from Beau's app as an example. 
                                    
                                    img(src = "posterior.png", 
                                        height = "80%", 
                                        width = "80%",
                                        style = "display: block; margin-left: 
                                                 auto; margin-right: auto;"),
                                    
                                    # Also learned from a peer's code comments
                                    # that images have to be housed in a folder
                                    # called "www" in order to be read in. 
                                    # Upon further Googling, I learned that 
                                    # the www directory also has to be at the
                                    # same level as the UI and Server. So, in
                                    # the app's main folder. 
                                    
                                    br(),
                                    
                                    p("Based on this model,", 
                                      strong("we would expect 5th 
                                      grade students in an average school district 
                                      in the United States to perform slightly 
                                      above grade level"),
                                      "if they have national average
                                      socio-economic status, and just 10% of students 
                                      receive Special Education services, and 10% 
                                      are English Language Learners, regardless 
                                      of the state they are in. The plot above 
                                      shows the range of potential outcomes for 
                                      student achievement. Since each unit represents
                                      one grade level (5 indicating mastery of 
                                      knowledge and skills on par with a 5th grader, 
                                      6 indicating 6th grade, and so on), this 
                                      model estimates that 5th graders are very 
                                      likely to perform between 5.37 and 5.47. While 
                                      it is reassuring to see that America's middle
                                      class 5th graders are performing slightly 
                                      above 5th grade-level, on average, this finding 
                                      alone was not particularly insightful. The 
                                      more I dug into the data, though, the more 
                                      I realized that there are wide discrepencies 
                                      between the predicted achievement outcomes 
                                      between different states. Click on the 'Differences 
                                      Between States' tab to learn more.") 
                                    
                                    # My biggest error when editing this app is
                                    # having commas and parentheses slightly off
                                    
                           ),         

                           
                           # Panel 4
                           
                           tabPanel("About",
                                    mainPanel(
                                        h3("About the Project"),
                                        h4("Summary"),
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
                                        
                                        h4("Limitations of This Analysis"),
                                        p("The main limitation of these models is 
                                          that they hope to answer questions 
                                          about future academic performance, and 
                                          yet the Covid-19 pandemic has dramatically
                                          changed the learning experiences students 
                                          had over the last year. In other words, 
                                          I am concerned about the external 
                                          validity of this data, since the learning
                                          conditions during the pandemic looked 
                                          so different from state to state, and 
                                          district to district over the last year.
                                          Another limitation of this analysis is 
                                          that my models use 5th grade test scores 
                                          to represent student achievement for 
                                          the school districts. While the scores
                                          are averaged across several years, a 
                                          stronger model may make use of more 
                                          grade levels, or examine differences 
                                          between grade levels or within grade 
                                          levels, over time."),
                                        
                                        br(),
                                        
                                        h4("Data"),
                                        p("I was inspired by my Harvard Graduate 
                                          School of Education professor, Andrew 
                                          Ho, to use the SEDA data for my analysis.
                                          I learned about this data set in his 
                                          course, Intermediate and Advanced 
                                          Statistical Methods for Applied Education
                                          Research, and was excited by the 
                                          opportunity to use it in my own original 
                                          analysis for Gov 1005. The datasets and 
                                          the reproduceable code for this analysis 
                                          can be found in my", 
                                          a(href="https://github.com/SarahBrashear",
                                            "GitHub repository."), 
                                          "For more information about the data 
                                          itself, click the Data tab at the top 
                                          of the page.")),
                                    
                                    # Here's the link to my Github repo, which 
                                    # is one of the required components of the 
                                    # project.
                                    
                                    br(),
                                    br(),
                                    br(),
                                    
                                    sidebarPanel(
                                        img(src = "IMG_6688.JPG", 
                                            height = "60%", 
                                            width = "60%",
                                            style = "display: block; margin-left: 
                                            auto; margin-right: auto;"),
                                        h3("About Me"),
                                        h4("Sarah Brashear, Ed.M. Candidate"),
                                        h4("Harvard Graduate School of Education"),
                                        p("I am a master's student studying Education
                                          Policy. As a former high school English 
                                          teacher, I think of data analysis as 
                                          another language through which to tell 
                                          compelling stories. After I leave Harvard 
                                          this spring, I hope to  use my analytical 
                                          skills and knowledge of the US education 
                                          landscape to improve the lives of 
                                          students on a much larger scale than I 
                                          could when my sphere of influence 
                                          stopped at my classroom doors."))
                           )))


# Define server logic required to draw a histogram
server <- function(input, output) {
    
    # This output is my interactive plot that's on the first tab of my app.
    # You select the state from the drop down list, and then it spits out
    # the ggplot with the data filtered for just that state.
    # I kind of got lucky with this. I guessed that the filtering part would
    # work, and then it did! On the first try!!
    
    output$scatter_plot <- renderPlot({
        
            
        data %>%
            rename(Type = type) %>%
            ggplot(aes(x = perc_econ_dis,
                       y = mp1_perc_oncampus,
                       size = enrollment,
                       color = Type)) +
            geom_point(alpha = .7) +
            geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = "grey15", se = FALSE) +
            labs(title = "Wealthier Schools Had More of their Students Opting to Learn In-Person",
                 subtitle = "There was a strong negative correlation in Marking Period 1",
                 x = "Percentage of Students Who are Economically Disadvantaged",
                 y = "Percentage of Students Choosing In-Person School",
                 caption = "Source: Cypress-Fairbanks ISD") +
            scale_size(guide = 'none') +
            theme_classic() 
        
        
        
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
