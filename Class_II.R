#Creating and orginizing folders within the working director/project pathway
dir.create("Raw_Data")
dir.create("Clean_data")
dir.create("Script")
dir.create("Results")
dir.create("Plorts")

#-------------------------------------

# -------------------------------
# Assignment 2: DGE Classification
# -------------------------------

# Define the classification function
classify_gene <- function(logFC, padj) {
  if (logFC > 1 & padj < 0.05) {
    return("Upregulated")
  } else if (logFC < -1 & padj < 0.05) {
    return("Downregulated")
  } else {
    return("Not_Significant")
  }
}

# Set input and output directories
input_dir <- "Raw_Data"
output_dir <- "Results"

# Create output folder if it doesn't exist
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# List of input files
files_to_process <- c("DEGs_Data_1.csv", "DEGs_Data_2.csv")

# Prepare a list to store processed results
result_list <- list()

# Loop through each file
for (file_name in files_to_process) {
  cat("\nProcessing:", file_name, "\n")
  
  # Construct full path and read data
  input_path <- file.path(input_dir, file_name)
  data <- read.csv(input_path, header = TRUE)
  
  # Replace missing padj values with 1
  data$padj[is.na(data$padj)] <- 1
  
  # Apply classification function to each row
  data$status <- mapply(classify_gene, data$logFC, data$padj)
  
  # Save processed data to Results folder
  output_path <- file.path(output_dir, paste0("Processed_", file_name))
  write.csv(data, output_path, row.names = FALSE)
  
  # Store in result list
  result_list[[file_name]] <- data
  
  # Print summary statistics
  cat("Summary for", file_name, ":\n")
  print(table(data$status))
  
  # Additional counts
  significant_genes <- sum(data$padj < 0.05)
  upregulated_genes <- sum(data$logFC > 1 & data$padj < 0.05)
  downregulated_genes <- sum(data$logFC < -1 & data$padj < 0.05)
  
  cat("Significant genes:", significant_genes, "\n")
  cat("Upregulated genes:", upregulated_genes, "\n")
  cat("Downregulated genes:", downregulated_genes, "\n")
}

# Access results if needed
results_1 <- result_list[[files_to_process[1]]]
results_2 <- result_list[[files_to_process[2]]]

save.image(file = "Deiby_Alexander_Cabuyales_Diaz_Class_2_Assignment.RData")
