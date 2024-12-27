import os

# Define the list of states
year_list = [2007, 2008, 2009]

# Loop through each state and render the Quarto document
for i in year_list:
    output_file = f'penguin_report_{i}.html'  # Customize the output file name
    command = (
        f'quarto render index.qmd '
        f'-P year:{i} '
        f'--output {output_file}'
    )
    os.system(command)
