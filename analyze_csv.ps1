# Define the path to the CSV file
$csvFilePath = "D:\PowerShell\Analyze\people_dataset.csv"

# Import the CSV file
$data = Import-Csv -Path $csvFilePath

# Calculate mean and standard deviation for age
$ages = $data | ForEach-Object { [int]$_."Age" }
$meanAge = ($ages | Measure-Object -Average).Average
$variance = ($ages | ForEach-Object { ($_ - $meanAge) * ($_ - $meanAge) } | Measure-Object -Sum).Sum / ($ages.Count - 1)
$stdDevAge = [math]::Sqrt($variance)

# Calculate range for age
$sortedAges = $ages | Sort-Object
$rangeAge = $sortedAges[-1] - $sortedAges[0]

# Calculate the distribution of counts for race
$raceCounts = $data | Group-Object -Property Race | Select-Object Name, Count | Sort-Object Count -Descending

# Find the oldest and youngest individuals by name
$oldest = $data | Sort-Object -Property Age -Descending | Select-Object -First 1 -Property Name, Age
$youngest = $data | Sort-Object -Property Age | Select-Object -First 1 -Property Name, Age

# Output the results
Write-Output ""
Write-Output "Mean Age: $meanAge"
Write-Output "Standard Deviation of Age: $stdDevAge"
Write-Output "Range of Ages: $rangeAge"
Write-Output "`nRace Distribution:"
$raceCounts | ForEach-Object { Write-Output "$($_.Name): $($_.Count)" }
Write-Output "`nOldest Person: $($oldest.Name), Age: $($oldest.Age)"
Write-Output "Youngest Person: $($youngest.Name), Age: $($youngest.Age)"

# Prompt the user to press Enter to close
Write-Output "`nPress Enter to close..."
[void][System.Console]::ReadLine()
