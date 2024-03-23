# Load the necessary libraries
library(readr)
library(dplyr)

# Define file paths for ref_viruses_rep_genomes data for the human species
human_precursor_path_ref <- "/Users/shayc/Documents/4th Year/Capstone /Human copy/Precursor-Table 1.csv"
human_processed_path_ref <- "/Users/shayc/Documents/4th Year/Capstone /Human copy/Processed-Table 1.csv"

# Function to load, clean, and combine data for a single species
load_and_combine_species_data <- function(precursor_path, processed_path, species_name) {
  # Load and clean precursor data
  precursor_data <- read_csv(precursor_path) %>%
    mutate(Type = "Precursor", Species = species_name) %>%
    select(ID, `Protein Name`, Hits, Species, Type) %>%
    na.omit()
  
  # Load and clean processed data
  processed_data <- read_csv(processed_path) %>%
    mutate(Type = "Processed", Species = species_name) %>%
    select(ID, `Protein Name`, Hits, Species, Type) %>%
    na.omit()
  
  # Combine precursor and processed data
  combined_data <- bind_rows(precursor_data, processed_data)
  return(combined_data)
}

# Load and combine data for human species
human_data_ref <- load_and_combine_species_data(human_precursor_path_ref, human_processed_path_ref, "Human")

# Check the structure of the combined data
glimpse(human_data_ref)

# If everything looks correct, you can write the combined data to a CSV file
write_csv(human_data_ref, "/Users/shayc/Documents/4th Year/Capstone /human_data_ref_viruses_rep_genomes.csv")
