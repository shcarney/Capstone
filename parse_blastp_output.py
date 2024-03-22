import sys
import csv

# Check if the correct number of command line arguments are provided
if len(sys.argv) != 3:
    print("Usage: python parse_blastp_output.py <input_filename> <output_filename>")
    sys.exit(1)

# Get the input and output filenames from the command line arguments
input_filename = sys.argv[1]
output_filename = sys.argv[2]

# Initialize dictionaries to store hits for each query and its protein name
hits_dict = {}
protein_names = {}

# Open the input file
with open(input_filename, 'r') as file:
    for line in file:
        # Skip comment lines and empty lines
        if line.startswith('#') or not line.strip():
            continue

        # Split the line by tabs
        columns = line.strip().split('\t')

        # Ensure the line contains the expected number of columns
        if len(columns) >= 1:
            # Extract query ID and protein name
            query_info = columns[0].split('|')
            if len(query_info) >= 3:
                query_id = query_info[1]
                protein_name = query_info[2]

                # Check if the query ID already exists
                if query_id in hits_dict:
                    # Increment hit count for the query
                    hits_dict[query_id] += 1
                else:
                    # Initialize hit count for the query
                    hits_dict[query_id] = 1
                    # Store the protein name for the query
                    protein_names[query_id] = protein_name

# Write the hits data to a CSV file
with open(output_filename, 'w', newline='') as outfile:
    # Create a CSV writer object
    writer = csv.writer(outfile)
    # Write the header row
    writer.writerow(["Query", "Protein Name", "Number of Hits"])
    # Write the data rows
    for query_id, num_hits in hits_dict.items():
        # Write the query ID, protein name, and number of hits
        writer.writerow([query_id, protein_names.get(query_id, ""), num_hits])

print(f"Hits table exported to {output_filename}")