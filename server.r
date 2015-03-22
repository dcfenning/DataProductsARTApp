##server.r
library(shiny)
##Function to take user input to select column to read, by age and statistic
##if stat user selected was data not requiring calculation then select col by age and statistic
##else if statistic user selected has had calculations on it then select col by age, statistic and the calculation

 selected_col <- function(fstats_in,age_in){
   if(fstats_in %in% nocalcstats){
     user_selection <- paste(fstats_in,age_in, sep="")
   }else{
     user_selection <- paste(fstats_in,age_in,"calc", sep="")       
   }
   colnum <- which(names(fdata)==user_selection)
 }



shinyServer(function(input, output){
                ####Loaded once per user#####

                incols <- reactive({selected_col(input$fstats_in,input$age_in)})
                state_data <- reactive({subset(fdata, fdata$State == input$state_in)})
                substate_data <- reactive({ u_col <- selected_col(input$fstats_in,input$age_in)
                                            sum_data <- subset(fdata, fdata$State == input$state_in)
                                            col_sum <- c("State", "Clinic_Name", "City", "MedicalDirector","No_of_IVF_cycles_in_2012")
                                            
                                            sum_data[,col_sum]
                                           })
                 ####All ouputs#####

                  output$subdata_out <- renderDataTable({substate_data()}, options = list(lengthMenu = c(5, 30, 50), pageLength = 8))
                 
                  output$state_out <- renderText({paste("The average for the statistic and age group you selected in ",input$state_in," is:")})
                 
                  output$smean_out <- renderText({
                    subset_data <- state_data()            
                    mean(subset_data[,incols()])
                    })

                  output$gplot_out <- renderGvis({
                               aggfdata <- setNames(aggregate(x=fdata[,incols()], by = list(fdata$State), FUN = mean, na.action = na.omit), c("State_Name","Average for State"))
                                G <- gvisGeoChart(aggfdata, locationvar = "State_Name", colorvar = "Average for State", hovervar ="State_Name", 
                                      options=list(region="US", displayMode="regions", resolution="provinces", title="Average per State",titlePosition='out',width=600, height=400, datalessRegionColor='grey', legend.numberFormat='.##'))
                                return(G)
                     })


        }
)