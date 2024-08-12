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
#Explanation: This line defines the file path to the CSV file that contains the dataset. The path is stored in the $csvFilePath variable.
$csvFilePath = "D:\PowerShell\Analyze\people_dataset.csv"
```

#### 2. Import the CSV file
```powershell
#Explanation: This command imports the content of the CSV file into a variable named $data. The Import-Csv cmdlet reads the CSV file and converts each row into a PowerShell object.
$data = Import-Csv -Path $csvFilePath
```

#### 3. Calculate mean and standard deviation for age
#Explanation: $ages: Extracts the age data from each record and converts it to an integer. $meanAge: Calculates the average (mean) age. $variance: Computes the variance, which measures how far the ages deviate from the mean. $stdDevAge: Calculates the standard deviation, providing insight into the spread of ages.
```powershell
$ages = $data | ForEach-Object { [int]$_."Age" }
$meanAge = ($ages | Measure-Object -Average).Average
$variance = ($ages | ForEach-Object { ($_ - $meanAge) * ($_ - $meanAge) } | Measure-Object -Sum).Sum / ($ages.Count - 1)
$stdDevAge = [math]::Sqrt($variance)
```

#### Calculate Range for Age
```powershell
Explanation: $sortedAges: Sorts the ages in ascending order. $rangeAge: Calculates the range of ages by subtracting the minimum age from the maximum age.
$sortedAges = $ages | Sort-Object
$rangeAge = $sortedAges[-1] - $sortedAges[0]
```
