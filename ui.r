##ui.r for data products project
library(shiny)
shinyUI(fluidPage(
        titlePanel("US Assisted Reproductive Technologies Data 2012 Analysis Tool"),
        sidebarLayout(
 
        sidebarPanel(
              h3('Select data you would like to view'),
              selectInput("state_in", "Select a State", choices = states, selected="ALASKA"),
              br(),
              selectInput("fstats_in", "Select an IVF statistic", choices = fstats_list, selected="FshNDCycle"), 
              selectInput("age_in", "...and please select an age group.", 
                            choices = c("<35"=1,"35-37"=2,"38-40"=3,"41-42"=4,"43-44"=5,">44"=6), 
                            selected=1),
                
              h4('Please note data is only available for FRESH NON DONOR EGGS ONLY')
        ),
        
        mainPanel(
          tabsetPanel(
            tabPanel("Data Table",
                     h2('Introduction'),
                    p("Welcome to the Assisted Reproductive Technology data tool.
                      This interactive tool summarises the most recent data collected by the Centers for Disesase Control and Prevention on Assisted Reproductive Technology in the USA.
                      Please see the User Guide tab for more information about the data and how to use this tool."),
                    br(),
                    p("To get started simply choose from the dropdown lists on the left handside of the page the data you would like to see.  Don't
                      forget to check out the interactive map tab that shows you an overview of the statistics by state"),
                    h2('Averages by State'),
                    textOutput("state_out"),          
                    verbatimTextOutput("smean_out"),
                    br(),
                    h2('All Fertility Clinics in State and Number of IVF cycles performed in 2012'),
                    dataTableOutput("subdata_out")
            ),
            tabPanel("Interactive Map", 
                     h2('Interactive Map'),
                     br(),
                     p("Use the drop down lists on the left hand side of the page to select a statistic and age group.  Hover over each state for the exact average based
                       on your selection."),
                     htmlOutput("gplot_out"),
                     br(),
                     p("Note, there is no data available for Wyoming and New England")
            ),
            tabPanel("User Guide", 
                     h2('User Guide'),
                     h3('Background'),
                     p("The Centers for Disease Control and Prevention collects annual data from clinics in the US performing Assisted Reproductive Technology (ART).
                       The Fertility Clinic Success Rate and Certification Act of 1992 mandates that clinics performing ART annually provide data for all procedures performed.
                       Data from US clinics that provide ART services to treat infertility are a rich source of information about the factors that contribute to success -the delivery
                       of a live born infant."),
                     p("Annual ART success rates data are available as interactive national summary tables and fertility clinic tables to download in PDF in addition to spreadsheets.
                       However, these reports do not provide state wide assessments or allow comparisons.  This tool provides a user with the ability to select a clinic and any state
                       to compare against."),
                     h3('Latest Data'),
                     p("The most recent data available is from 2012 as it takes + 10 months from the end of 2012 to determine live birth success of procedures in 2012.
                       CDCs 2012 ART Ferility Clinic Success Rates data includes 176,247 ART cycles performed at 456 reporting clinics in the US during 2012.  These cycles
                       resulted in 51,267 live births (deliveries of one or more living infants) and 65,160 lie born infants.  Today, over 1% of all infants born in the US every year are
                       conceived using ART.",
                       span("The 2012 data is available at this site: http://www.cdc.gov/art/reports/index.html", style = "color:blue")),
                     h3('Notes about using this data'),
                     p("The CDC notes that many people considering ART will want to use this data to find the best clinic.
                       However, ",
                       span("comparisons between clinics should be made with caution", style = "color:red"),
                       ".  Many factors contribute to the success of an ART procedure.  Some factors are related to the
                       training and experience of the ART clinic and laboratory professionals and the quality of services they provide.  Other factors are related to the patients themselves, such as
                       their age ad the cause of their infertility.  Some clinics may be more willing than others to accept patients with low chances of success or may specialise in various ART treatments
                       that attract particular types of patients."),
                     h3('Interactive panels'),
                     p("This tool provides user input using the drop down boxes in the left hand panel.  This panel remains on the left for the user to interact with.  
                       Each time a selection is made by the user from the drop down list, the data table and interactive maps are refreshed."),
                     p("There are two data visualisation tabs: Data Table and Interactive Map.  The Data Table provides the user with an interative table to search for a state,
                       or view as many states as desired on one screen.  The Interactive Map shows the statistics selected by the user with a colour distribution shown on the sliding scale at
                       the bottom of the map.  When the user hovers over a state, the user is providing with the average for that state and the state name.  If the user changes the parameters in the left
                       hand panel, the data will refresh to reflect that statistic or age group."),
                     h3('The statistics - descriptions'),
                     h4('Number of cycles'),
                     p("This represents the number of ART cycles by age of woman"),
                     h4('% of cancellations'),
                     p("Number of cycles canceled divided by the total number of cycles, expressed as a percentage of cycles. This refers to the cycles that were stopped before an egg retrieval was attempted. 
                       A cycle may be canceled if a woman's ovaries do not respond to fertility medications and thus do not produce a sufficient number of follicles. 
                       Cycles also may be canceled because of illness or other medical or personal reasons"),
                     h4('Average Number of embryos transferred'),
                     p("Average number of embryos per transfer procedure in which one or more embryos were transferred. The average number of embryos transferred varies from clinic to clinic."),
                     h4('% of embryos transferred resulting in implantation'),
                     p("The larger of either the maximum number of fetal hearts or maximum number of infants born [live births + stillbirths] divided by the number of embryos transferred, 
                       expressed as a percentage of embryos transferred.  This represents the cycles resulting in an intrauterine clinical pregnancy out of the total number of embryos transferred, 
                       in which one or more embryos were transferred. Not all fetal hearts can be detected by ultrasound. For this reason, a positive intrauterine clinical pregnancy 
                       is defined as the larger of either the maximum number of fetal hearts detected by ultrasound or maximum number of infants born, including live births and stillbirths."),
                     h4('% of elective single embryo transfer'),
                     p("The number of cycles in which 1 embryo was transferred and >0 embryos were cryopreserved, divided by the number of transfer procedures in which either 1 embryo was transferred 
                       and >0 embryos were cryopreserved or >1 embryos were transferred, expressed as a percentage of these transfer procedures.  This represents the cycles in which one embryo is selected to 
                       be transferred from a larger number of available embryos, usually for the purpose of reducing the chance of having a multiple birth. For these cycles, 
                       one or more of the extra embryos are cryopreserved during the current cycle for future use"),
                     h4('% of cycles resulting in singleton live births'),
                     p("Number of singleton live births divided by number of cycles, expressed as a percentage of cycles. This represents the cycles that resulted in the birth of a 
                       single live infant out of all cycles started."),
                     h4('%of cycles resulting in triplets or more live births'),
                     p("Number of triplet or more live births divided by number of cycles, expressed as a percentage of cycles.  This represents the cycles that resulted in a triplet or more live birth out of all cycles started. 
                       A multiple-infant birth with one or more infants born live is counted as one live birth"),
                     h4('% of cycles resulting in live births'),
                     p("Number of live births divided by number of cycles, expressed as a percentage of cycles.  This represents the cycles that resulted in a live birth out of all cycles started. A cycle resulting in live birth 
                       may include one or more infants born alive; that is, a multiple-infant birth (e.g., twins, triplets) with at least one live-born infant is counted as one live birth."),
                     h4('% of cycles resulting in pregnancy'),
                     p("Number of pregnancies divided by number of cycles, expressed as a percentage of cycles.  This represents the cycles that resulted in a pregnancy out of all cycles started. 
                       Because some pregnancies end in a miscarriage, induced abortion, or stillbirth, the percentage of cycles resulting in pregnancies is usually higher than the percentage of cycles resulting in live births.")
                     
                     
                     

                     )
        )
))))

