# Load the necessary libraries
library(readr)
library(dplyr)

# Define file paths for each species and type for NCBI virus data
human_precursor_ncbi <- "/Users/shayc/Documents/4th Year/Capstone /Human copy/NCBI Precursor-Table 1.csv"
human_processed_ncbi <- "/Users/shayc/Documents/4th Year/Capstone /Human copy/NCBI Processed-Table 1.csv"
bonobo_precursor_ncbi <- "/Users/shayc/Documents/4th Year/Capstone /Bonobo copy/NCBI Precursor-Table 1.csv"
bonobo_processed_ncbi <- "/Users/shayc/Documents/4th Year/Capstone /Bonobo copy/NCBI Processed-Table 1.csv"
mouse_precursor_ncbi <- "/Users/shayc/Documents/4th Year/Capstone /Mouse copy/NCBI Precursor-Table 1.csv"
mouse_processed_ncbi <- "/Users/shayc/Documents/4th Year/Capstone /Mouse copy/NCBI Processed-Table 1.csv"

# Function to load and label data
load_and_label_ncbi <- function(path, species, type) {
  data <- read_csv(path, show_col_types = FALSE) %>%
    mutate(Species = species, Type = type, Database = "ncbi_virus")
  return(data)
}

# Load and label data for each species and type
human_precursor_data_ncbi <- load_and_label_ncbi(human_precursor_ncbi, "Human", "Precursor")
human_processed_data_ncbi <- load_and_label_ncbi(human_processed_ncbi, "Human", "Processed")
bonobo_precursor_data_ncbi <- load_and_label_ncbi(bonobo_precursor_ncbi, "Bonobo", "Precursor")
bonobo_processed_data_ncbi <- load_and_label_ncbi(bonobo_processed_ncbi, "Bonobo", "Processed")
mouse_precursor_data_ncbi <- load_and_label_ncbi(mouse_precursor_ncbi, "Mouse", "Precursor")
mouse_processed_data_ncbi <- load_and_label_ncbi(mouse_processed_ncbi, "Mouse", "Processed")

# Combine all ncbi_virus data into one dataframe
all_ncbi_data <- bind_rows(
  human_precursor_data_ncbi, 
  human_processed_data_ncbi,
  bonobo_precursor_data_ncbi, 
  bonobo_processed_data_ncbi,
  mouse_precursor_data_ncbi, 
  mouse_processed_data_ncbi
)

# View the structure of the combined data
glimpse(all_ncbi_data)

# Write the combined ncbi_virus data to a CSV file
write_csv(all_ncbi_data, "/Users/shayc/Documents/4th Year/Capstone /NCBI combined/combined_ncbi_data.csv")
