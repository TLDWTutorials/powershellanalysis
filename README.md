# Define the path to the CSV file
# The $csvFilePath variable stores the path to the CSV file that contains the dataset to be analyzed.
$csvFilePath = "D:\PowerShell\Analyze\people_dataset.csv"

# Import the CSV file
# The Import-Csv cmdlet reads the content of the CSV file specified by $csvFilePath and converts it into an array of custom objects, which is stored in the $data variable.
$data = Import-Csv -Path $csvFilePath

# Calculate mean and standard deviation for age
# The $ages variable is populated by iterating through each object in $data and extracting the value of the "Age" field, converting it to an integer.
$ages = $data | ForEach-Object { [int]$_."Age" }

# The mean (average) age is calculated by using the Measure-Object cmdlet with the -Average parameter. The result is stored in $meanAge.
$meanAge = ($ages | Measure-Object -Average).Average

# Variance is calculated by iterating through each age, subtracting the mean age, squaring the result, and then summing these squared differences.
# The sum is divided by (n-1) where n is the count of ages to get the variance. This value is stored in $variance.
$variance = ($ages | ForEach-Object { ($_ - $meanAge) * ($_ - $meanAge) } | Measure-Object -Sum).Sum / ($ages.Count - 1)

# The standard deviation of age is calculated by taking the square root of the variance using the [math]::Sqrt method, and the result is stored in $stdDevAge.
$stdDevAge = [math]::Sqrt($variance)

# Calculate range for age
# The $sortedAges variable stores the list of ages sorted in ascending order.
$sortedAges = $ages | Sort-Object

# The age range is calculated by subtracting the minimum age (first element of the sorted list) from the maximum age (last element of the sorted list).
$rangeAge = $sortedAges[-1] - $sortedAges[0]

# Calculate the distribution of counts for race
# The $raceCounts variable is populated by grouping the data based on the "Race" field and counting the number of occurrences for each race.
# The results are sorted in descending order based on the count.
$raceCounts = $data | Group-Object -Property Race | Select-Object Name, Count | Sort-Object Count -Descending

# Find the oldest and youngest individuals by name
# The $oldest variable stores the details of the oldest person in the dataset by sorting the data based on the "Age" field in descending order and selecting the first entry.
$oldest = $data | Sort-Object -Property Age -Descending | Select-Object -First 1 -Property Name, Age

# The $youngest variable stores the details of the youngest person in the dataset by sorting the data based on the "Age" field in ascending order and selecting the first entry.
$youngest = $data | Sort-Object -Property Age | Select-Object -First 1 -Property Name, Age

# Output the results
# The following lines output the calculated mean age, standard deviation, and age range to the console.
Write-Output ""
Write-Output "Mean Age: $meanAge"
Write-Output "Standard Deviation of Age: $stdDevAge"
Write-Output "Range of Ages: $rangeAge"

# Output the distribution of race counts
# The race distribution is displayed by iterating through the $raceCounts array and printing each race along with its count.
Write-Output "`nRace Distribution:"
$raceCounts | ForEach-Object { Write-Output "$($_.Name): $($_.Count)" }

# Output the oldest and youngest individuals' names and ages
# The details of the oldest person are printed to the console.
Write-Output "`nOldest Person: $($oldest.Name), Age: $($oldest.Age)"

# The details of the youngest person are printed to the console.
Write-Output "Youngest Person: $($youngest.Name), Age: $($youngest.Age)"

# Prompt the user to press Enter to close
# The script waits for the user to press Enter before closing by calling the ReadLine method.
Write-Output "`nPress Enter to close..."
[void][System.Console]::ReadLine()
