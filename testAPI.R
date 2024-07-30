#* @apiTitle Diabetes Prediction API

#* Predict Diabetes Status
#* @param HighBP whether an individual has high blood pressure
#* @param HighChol whether an individual has high cholesterol
#* @param BMI body mass index
#* @param Stroke whether an individual has ever had a stroke
#* @param HeartDiseaseorAttack whether an individual has ever had heart disease or a heart attack
#* @param PhysActivity whether an individual has engaged in physical activity in the past month
#* @param Fruits whether an individual consumes fruits daily
#* @param Veggies whether an individual consumes vegetables daily
#* @param HvyAlcoholConsump whether an individual engages in heavy alcohol consumption
#* @param GenHlth general health condition
#* @param MentHlth mental health condition
#* @param PhysHlth phsical health condition
#* @param DiffWalk whether an individual has difficulty walking or climbing stairs
#* @param Age 1:13
#* @param Education 1:6
#* @param Income 1:8
#* @get /pred
function(
    HighBP = names(sort(table(data$HighBP), decreasing = TRUE))[1],
    HighChol = names(sort(table(data$HighChol), decreasing = TRUE))[1],
    BMI = mean(data$BMI),
    Stroke = names(sort(table(data$Stroke), decreasing = TRUE))[1],
    HeartDiseaseorAttack = names(sort(table(data$HeartDiseaseorAttack), decreasing = TRUE))[1],
    PhysActivity = names(sort(table(data$SPhysActivity), decreasing = TRUE))[1],
    Fruits = names(sort(table(data$Fruits), decreasing = TRUE))[1],
    Veggies = names(sort(table(data$Veggies), decreasing = TRUE))[1],
    HvyAlcoholConsump = names(sort(table(data$HvyAlcoholConsump), decreasing = TRUE))[1],
    GenHlth = mean(data$GenHlth),
    MentHlth = mean(data$MentHlth),
    PhysHlth = mean(data$PhysHlth),
    DiffWalk = names(sort(table(data$DiffWalk), decreasing = TRUE))[1],
    Age = mean(data$Age),
    Education = mean(data$Education),
    Income = mean(data$Income)
) {
  new_data <- data.frame(
    HighBP = as.factor(HighBP),
    HighChol = as.factor(HighChol),
    BMI = as.numeric(BMI),
    Stroke = as.factor(Stroke),
    HeartDiseaseorAttack = as.factor(HeartDiseaseorAttack),
    PhysActivity = as.factor(PhysActivity),
    Fruits = as.factor(Fruits),
    Veggies = as.factor(Veggies),
    HvyAlcoholConsump = as.factor(HvyAlcoholConsump),
    GenHlth = as.factor(GenHlth),
    MentHlth = as.factor(MentHlth),
    PhysHlth = as.factor(PhysHlth),
    DiffWalk = as.factor(DiffWalk),
    Age = as.numeric(Age),
    Education = as.numeric(Education),
    Income = as.numeric(Income)
  )
  
  prediction <- predict(random_forest_model, newdata = new_data, type = "prob")
  list(prediction = prediction[, "yes"])
}

#* Get Information
#* @get /info
function() {
  list(
    name = "Wenna Han",
    url = "https://wennahan.github.io/ST558_Final_Project/"
  )
}


# Example function calls
# curl -X POST "http://localhost:8000/pred"
# curl -X POST "http://localhost:8000/pred" -d "Age=1&Income=1"
# curl -X GET "http://localhost:8000/info"