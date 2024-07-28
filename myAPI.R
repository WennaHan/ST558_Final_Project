#myAPI.R 
library(GGally)
library(leaflet)

#Send a message
#* @get /readme
function(){
  "This is our basic API"
}

#http://localhost:PORT/readme


#Echo the parameter that was sent in
#* @param msg The message to echo back.
#* @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#http://localhost:PORT/echo?msg=Hey

#Find natural log of a number
#* @param num Number to find ln of
#* @get /ln
function(num){
  log(as.numeric(num))
}

#http://localhost:PORT/ln?num=40

#Find multiple of two numbers
#* @param num1 1st number
#* @param num2 2nd number
#* @get /mult
function(num1, num2){
  as.numeric(num1)*as.numeric(num2)
}

#http://localhost:PORT/mult?num1=10&num2=10

#* Plot histogram of iris data
#* @png
#* @param type base or GGally
#* @get /plotiris
function(type="base"){
  if(type == "GGally"){
    a<- ggpairs(iris)
    print(a)
  } else {
    pairs(iris)
  }
}

#http://localhost:PORT/plotiris?type=GGally


#* Plotting widget
#* @serializer htmlwidget
#* @param lat latitude
#* @param lng longitude
#* @get /map
function(lng = 174.768, lat = -36.852){
  m <- leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(as.numeric(lng), as.numeric(lat))
  m  # Print the map
}

#query with http://localhost:PORT/map?lng=174&lat=-36