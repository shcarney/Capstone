library(readr)
library(dplyr)

# Function to clean a single CSV file
clean_csv_file <- function(file_path) {
  data <- read_csv(file_path)
  
  # Convert 'Hits' to numeric, just to confirm
  data$Hits <- as.numeric(as.character(data$Hits))
  
  # Remove completely empty columns
  data <- data[, colSums(is.na(data)) < nrow(data)]
  
  return(data)
}

# Define the file paths for each species
human_files <- list.files("/Users/shayc/Documents/4th Year/Capstone /Human copy", full.names = TRUE, pattern = "\\.csv$")
bonobo_files <- list.files("/Users/shayc/Documents/4th Year/Capstone /Bonobo copy", full.names = TRUE, pattern = "\\.csv$")
mouse_files <- list.files("/Users/shayc/Documents/4th Year/Capstone /Mouse copy", full.names = TRUE, pattern = "\\.csv$")

# Clean all CSV files for each species
human_data <- lapply(human_files, clean_csv_file)
bonobo_data <- lapply(bonobo_files, clean_csv_file)
mouse_data <- lapply(mouse_files, clean_csv_file)

# If needed, combine data from all files within each species into a single dataframe
human_combined <- bind_rows(human_data)
bonobo_combined <- bind_rows(bonobo_data)
mouse_combined <- bind_rows(mouse_data)

# Check the combined data
head(human_combined)
head(bonobo_combined)
head(mouse_combined)

