
import os
import pandas as pd

# Function to parse the BLAST output file
def parse_blast_output(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    query_info = {}
    for line in lines:
        if line.startswith('# Query:'):
            parts = line.strip().split()
            query_id = parts[2]
            # Assuming the protein name is always the last part after the last space
            protein_name = ' '.join(parts[3:]).split('OS=')[0].strip()
            query_info[query_id] = {'ID': query_id, 'Protein Name': protein_name, 'Hits': 0}
        elif not line.startswith('#') and line.strip():
            query_info[query_id]['Hits'] += 1

    return pd.DataFrame(list(query_info.values()))

# Find all BLAST output files in the current directory
def find_blast_files():
    return [f for f in os.listdir() if f.endswith('_ncbi.txt')]

# Main execution logic
def main():
    blast_files = find_blast_files()
    for blast_file in blast_files:
        df = parse_blast_output(blast_file)
        csv_file = blast_file.replace('.txt', '.csv')
        df.to_csv(csv_file, index=False)
        print(f'Parsed "{blast_file}" and saved to "{csv_file}"')

if __name__ == '__main__':
    main()
