
import sys
import csv

def parse_tblastn_output(input_filename, output_filename, seq_type):
    with open(input_filename, 'r') as file:
        lines = file.readlines()

    # Initialize a dictionary to store the number of hits for each query
    hits_count = {}

    # Initialize variables to hold query ID and protein name
    query_id = None
    protein_name = None

    # Iterate over the lines in the file
    for line in lines:
        if line.startswith('Query='):
            # Extract the query ID and protein name
            query_info = line.split()
            query_id = query_info[1]
            if seq_type == 'processed':
                protein_name = ' '.join(query_info[2:])
            else:
                protein_name = query_info[-1]
            hits_count[query_id] = {'protein_name': protein_name, 'hit_count': 0}
        elif line.startswith('>'):
            # Increment hit count for the current query
            hits_count[query_id]['hit_count'] += 1

    # Write the data to a CSV file
    with open(output_filename, 'w') as outfile:
        writer = csv.writer(outfile)
        writer.writerow(['ID', 'Protein Name', 'Hits'])
        for query_id, data in hits_count.items():
            writer.writerow([query_id, data['protein_name'], data['hit_count']])

    print(f"Data exported to {output_filename}")

if __name__ == '__main__':
    if len(sys.argv) != 4:
        print("Usage: python new_tblastn_parse.py <input_filename> <output_filename> <seq_type>")
        sys.exit(1)
    
    input_filename = sys.argv[1]
    output_filename = sys.argv[2]
    seq_type = sys.argv[3]
    
    parse_tblastn_output(input_filename, output_filename, seq_type)