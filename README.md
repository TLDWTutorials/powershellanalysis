## PowerShell Script for Analyzing a Dataset

### Overview
This script performs basic statistical analysis on a dataset stored in a CSV file. The analysis includes calculating the mean, standard deviation, and range of ages, as well as determining the distribution of race counts, and identifying the oldest and youngest individuals by name.

### Prerequisites
- PowerShell
- A CSV file containing the dataset with at least the following columns:
  - `Age`: An integer representing the age of an individual.
  - `Race`: A string representing the race of an individual.

### Code Breakdown

#### 1. Define the Path to the CSV File
```powershell
# Define the path to the CSV file
$csvFilePath = "D:\PowerShell\Analyze\people_dataset.csv"
```

test
