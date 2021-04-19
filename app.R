library(shiny)
library(emojifont)
library(emo)
library(shinyjs)
library(shinyMobile)

image_address <- "https://www.honestcookingblog.com/recipes/images/"
recipe_address <- "https://www.honestcookingblog.com/recipes/"

recipes <- list(c("Sambar","sambar.jpg","sambar.html","e2 r4 main vege curry india healthy instantpot"),
                c("Chai creme brulee","cremebrulee.jpg","chaicremebrulee.html","e2 r4 dessert pudding instantpot"),
                c("Naan Two Ways","naan.jpg","naan.html","e1 r3 side bread india instantpot"),
                c("Beef Stock","beefstock.jpg","beefstock.html","e1 r3 beef instantpot staple"),
                c("Massaman","massaman.jpg","massaman.html","e3 r4 main thailand curry beef"),
                c("Aloo Mushroom Masala","matarmushroom.jpg","aloomushroom.html","e2 r3 main india curry vege healthy instantpot"),
                c("Italian Beef Rolls","italianbeef.jpg","italianbeef.html","e1 r3 light burger italy instantpot"),
                c("Zuppa Toscana","zuppatoscana.jpg","zuppatoscana.html","e2 r4 main soup winter italy"),
                c("Rice Kheer","kheer.jpg","ricekheer.html","e1 r3 dessert summer instantpot pudding")
                )


values <- c('noodles','pasta','soup','curry','pancake','salad','fish','chicken','pork','beef','lamb','game','mushroom','bread','burger','bento','cake','cookie','pudding','icecream','drink')
names(values) <- c(127836,127837,127858,127835,129374,129367,128031,128020,128055,128046,128017,129420,127812,127838,127828,127857,127856,127850,127854,127846,127865)


path <- "C:\\Users\\bonmc643\\CookingBlog\\app.R"
# Define UI for application that draws a histogram
ui <- fluidPage(
useShinyjs(),
    # Application title
        h4("Search for recipes here"),
        fluidRow(
            column(2,class = "col-xs-5",
                   selectInput("meal","Meal:",c("Breakfast","Light Meal","Main","Tea","Dessert","Side","Staple"),selected = "Main")),
            
            column(2,class = "col-xs-3", sliderInput("effort",
                             "Effort:",
                             min = 1,
                             max = 4,
                             pre=emoji('persevere'),value=c(1,4))),
                 column(2,class = "col-xs-3",
                 sliderInput("reward",
                             "Reward:",
                             min = 1,
                             max = 4,
                             pre=emoji('yum'),value=c(1,4)))),
        fluidRow(
            column(1,class = "col-xs-2",
                   checkboxGroupInput("type","Type:",choices=c(
                      emoji("ramen"),
                      emoji("spaghetti"),
                      emoji("stew"),
                      emoji("curry"),
                      emoji("pancakes"),
                      emoji("green_salad"),
                      emoji("fish"),
                      emoji("chicken"),
                      emoji("pig"),
                      emoji("cow"),
                      emoji("sheep"),
                      emoji("deer"),
                      emoji("mushroom"),
                      emoji("bread"),
                      emoji("hamburger"),
                      emoji("bento"),
                      emoji("cake"),
                      emoji("cookie"),
                      emoji("custard"),
                      emoji("icecream"),
                      emoji("tropical_drink")
                   ))
            ),
            column(1,class = "col-xs-3",
                   checkboxGroupInput("healthy","Plus:",c("healthy","vege","instant pot")),
                   checkboxGroupInput("season","Season:",c(emoji("sunny"),emoji("fallen_leaf"),emoji("snowflake"),emoji("seedling"))),
                   checkboxGroupInput("occassion","Occassion:",c(emoji("christmas_tree"),emoji("rabbit"),emoji("confetti_ball"),emoji("girl"))),
                   checkboxGroupInput("cuisine","Cuisine:",c("Australian","Swedish","British","Japanese","Korean","Dutch","Italian","Indian","Thai")))
                   
            ,            
            column(10,class = "col-xs-7",flowLayout(
                htmlOutput("r1"),
                htmlOutput("r2"),
                htmlOutput("r3"),
                htmlOutput("r4"),
                htmlOutput("r5"),
                htmlOutput("r6"),
                htmlOutput("r7")
                
                
                
            )),
            
        )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    # first restrict it to the selected meal, effort and reward

    update_display <- function(){
        show <- c()
        hide <- c()
        selected_meal <- str_to_lower(input$meal)
        if(selected_meal=='light meal'){selected_meal <- 'light'}
        selected_effort <- input$effort
        selected_reward <- input$reward
        effort_range <- selected_effort[1]:selected_effort[2]
        reward_range <- selected_reward[1]:selected_reward[2]
        
        
        # first do meal, effort, reward
        for (i in 1:length(recipes)){
            description <- recipes[[i]][4]
            effort <- str_split(description," ")[[1]][1]
            effort <- as.numeric(str_remove(effort,"e"))
            reward <- str_split(description," ")[[1]][2]
            reward <- as.numeric(str_remove(reward,"r"))
            if(grepl(selected_meal,description)&(reward %in% reward_range)&(effort %in% effort_range)){
                if(!(i %in% show)){
                    
                    # check for additional filters
                    if(is.character(input$type)){
                        print("in filters")
                        more_filters <- c()
                        selected_types <- input$type
                        for(type in selected_types){
                            key <- utf8ToInt(type)
                            name <- values[as.character(key)][[1]]
                            if(!(name %in% more_filters)){more_filters <- c(more_filters,name)}
                        }
                        for(filter in more_filters){
                            if((grepl(filter,description))){
                                # show it
                                show <- c(show,i)
                            }else{hide <- c(hide,i)}
                        }
                    }else{show <- c(show,i)}
                    
                }
            }
             else{
                 hide <- hide(hide,i)
             }
        }
        }
        
        if(length(show)!=0){
            
            lapply(1:length(show),function(i){
                outputId <- paste0("r", i)
                recipe_num <- show[i]
                src <- paste(image_address,recipes[[recipe_num]][2],sep = '')
                caption <- recipes[[recipe_num]][1]
                source <- paste(recipe_address,recipes[[recipe_num]][3],sep='')
                output[[outputId]] <- renderText({c('<figure><a href="',source,'"><img src="',src,'" width=150 height=150 style="padding-top: 10px;"></a><figcaption>',caption,'</figcaption></figure>')})
                show(outputId)
                
                for(i in (length(show)+1):7){
                    outputId <- paste0("r", i)
                    hide(outputId)
                }
                
            })   }else{
                for(i in 1:length(recipes)){outputId <- paste0("r",i)
                hide(outputId)}
            } 
    
    
    observeEvent(input$meal,update_display())
    observeEvent(input$effort,update_display())
    observeEvent(input$reward,update_display())
    observeEvent(input$type,update_display())
    
    }
    
   
    
    
    

    
    
    # # render all the images
    # lapply(1:3, function(i) {
    #     outputId <- paste0("r", i)
    #     src <- paste(image_address,recipes[[i]][2],sep = '')
    #     caption <- recipes[[i]][1]
    #     source <- paste(recipe_address,recipes[[i]][3],sep='')
    #     output[[outputId]] <- renderText({c('<figure><a href="',source,'"><img src="',src,'" width=150 height=150 style="padding-top: 10px;"></a><figcaption>',caption,'</figcaption></figure>')})
    # })



# Run the application 
shinyApp(ui = ui, server = server)
