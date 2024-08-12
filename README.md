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
Explanation: This line defines the file path to the CSV file that contains the dataset. The path is stored in the $csvFilePath variable.
```powershell
$csvFilePath = "D:\PowerShell\Analyze\people_dataset.csv"
```

#### 2. Import the CSV file
Explanation: This command imports the content of the CSV file into a variable named $data. The Import-Csv cmdlet reads the CSV file and converts each row into a PowerShell object.
```powershell
$data = Import-Csv -Path $csvFilePath
```

#### 3. Calculate mean and standard deviation for age
Explanation: $ages: Extracts the age data from each record and converts it to an integer. $meanAge: Calculates the average (mean) age. $variance: Computes the variance, which measures how far the ages deviate from the mean. $stdDevAge: Calculates the standard deviation, providing insight into the spread of ages.
```powershell
$ages = $data | ForEach-Object { [int]$_."Age" }
$meanAge = ($ages | Measure-Object -Average).Average
$variance = ($ages | ForEach-Object { ($_ - $meanAge) * ($_ - $meanAge) } | Measure-Object -Sum).Sum / ($ages.Count - 1)
$stdDevAge = [math]::Sqrt($variance)
```

#### 4. Calculate Range for Age
Explanation: $sortedAges: Sorts the ages in ascending order. $rangeAge: Calculates the range of ages by subtracting the minimum age from the maximum age.
```powershell
$sortedAges = $ages | Sort-Object
$rangeAge = $sortedAges[-1] - $sortedAges[0]
```
#### 5. Calculate the Distribution of Counts for Race
Explanation: $raceCounts: Groups the data by race and counts the number of occurrences for each race. The results are then sorted in descending order by count.
```powershell
# Calculate the distribution of counts for race
$raceCounts = $data | Group-Object -Property Race | Select-Object Name, Count | Sort-Object Count -Descending
```
#### 6. Find the Oldest and Youngest Individuals by Name
Explanation: $oldest: Finds the oldest individual by sorting the data by age in descending order and selecting the first record. $youngest: Finds the youngest individual by sorting the data by age in ascending order and selecting the first record.
```powershell
$oldest = $data | Sort-Object -Property Age -Descending | Select-Object -First 1 -Property Name, Age
$youngest = $data | Sort-Object -Property Age | Select-Object -First 1 -Property Name, Age
```

#### 7. Output the Results
Explanation: The script outputs the calculated mean age, standard deviation, age range, race distribution, and the names and ages of the oldest and youngest individuals.
```powershell
Write-Output ""
Write-Output "Mean Age: $meanAge"
Write-Output "Standard Deviation of Age: $stdDevAge"
Write-Output "Range of Ages: $rangeAge"
Write-Output "`nRace Distribution:"
$raceCounts | ForEach-Object { Write-Output "$($_.Name): $($_.Count)" }
Write-Output "`nOldest Person: $($oldest.Name), Age: $($oldest.Age)"
Write-Output "Youngest Person: $($youngest.Name), Age: $($youngest.Age)"

```

#### 8. Prompt the User to Press Enter to Close
Explanation: The script pauses and waits for the user to press Enter before closing. This is useful if the script is run from a command prompt or PowerShell window.
```powershell
Write-Output "`nPress Enter to close..."
[void][System.Console]::ReadLine()
```

#### Optional - If you want to list all of the youngest and oldest (not just the first case just I have above)
```powershell
# Find the maximum age (Oldest)
$maxAge = ($data | Sort-Object -Property Age -Descending | Select-Object -First 1).Age

# Filter and display all individuals with the maximum age
$oldest = $data | Where-Object { $_.Age -eq $maxAge } | Select-Object Name, Age

# Output the results for the oldest individuals
Write-Output "Oldest Individuals:"
$oldest | ForEach-Object { Write-Output "$($_.Name), Age: $($_.Age)" }

Write-Output ""

# Find the minimum age (Youngest)
$minAge = ($data | Sort-Object -Property Age | Select-Object -First 1).Age

# Filter and display all individuals with the minimum age
$youngest = $data | Where-Object { $_.Age -eq $minAge } | Select-Object Name, Age

# Output the results for the youngest individuals
Write-Output "Youngest Individuals:"
$youngest | ForEach-Object { Write-Output "$($_.Name), Age: $($_.Age)" }
```

### Usage
(1) Save the script in a .ps1 file format. <br>
(2) Ensure the CSV file path is correct. <br>
(3) Run the script in PowerShell (if you made this with a basic text editor in Windows, right click on the .ps1 file and select "run with PowerShell". <br>
(4) Review the output displayed in the console.
