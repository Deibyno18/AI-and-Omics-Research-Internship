#Creating and orginizing folders within the working director/project pathway
dir.create("Raw_data")
dir.create("Clean_data")
dir.create("Script")
dir.create("Results")
dir.create("Plorts")

#---------------------------------------------------------------------------

# load the dataset into your R environment, we should open "patient_info"
RawData <- read.csv(file.choose())

# Inspect the structure of the dataset using appropriate R functions
View(RawData)
str(RawData)

# Identify variables with incorrect or inconsistent data types.
##"patient_id", "age" and "bmi" has the right data type
##"gender", "diagnosis" and "smoker" need to be changed to a factor data type

# Convert variables to appropriate data types where needed
RawData$gender <- as.factor(RawData$gender)
RawData$diagnosis <- as.factor(RawData$diagnosis)
RawData$smoker <- as.factor(RawData$smoker)

RawData$gender <- factor(RawData$gender, levels = c("Male", "Female"))
RawData$diagnosis <- factor(RawData$diagnosis, levels = c("Cancer", "Normal"))
RawData$smoker <- factor(RawData$smoker, levels = c("Yes", "No")

                         \
# Create a new variable for smoking status as a binary factor:
# 1 for "Yes", 0 for "No"

RawData$smoker_num <- ifelse(RawData$smoker == "Yes", 1, 0)
RawData$smoker_num <- as.factor(RawData$smoker)

#-----------------------------------------------------------------------------------------

# Save the cleaned dataset in your clean_data folder with the name patient_info_clean.csv
write.csv(RawData, file = "results/patient_info_clean.csv")

# Save your R script in your script folder with name "class_Ib"
