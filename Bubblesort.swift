import Foundation // Import Foundation for file handling

// MARK: - Bubble Sort Program in Swift
// This program reads integers from input.txt,
// checks for valid numbers (comma-separated),
// prints "Sorting", sorts them using Bubble Sort,
// and writes the sorted numbers to output.txt.

// Bubble Sort function that returns a new sorted array
func sorting(arr: [Int]) -> [Int] {
    var arrCopy = arr // Make a copy to sort
    let n = arrCopy.count // Get array length
    
    for i in 0..<n-1 { // Loop through each element
        for j in 0..<n-i-1 { // Compare adjacent elements
            if arrCopy[j] > arrCopy[j+1] { // Swap if left > right
                let temp = arrCopy[j] // Store left element temporarily
                arrCopy[j] = arrCopy[j+1] // Move right to left
                arrCopy[j+1] = temp // Move left to right
            }
        }
    }
    
    return arrCopy // Return sorted array
}

// Function to read input, sort, and write output
func sortingKeeper() {
    let inputFile = "input.txt" // Input file path
    let outputFile = "output.txt" // Output file path
    
    // Check if input file exists
    guard FileManager.default.fileExists(atPath: inputFile) else {
        print("No file") // File not found
        return
    }
    
    var numbers = [Int]() // Array to store valid integers
    
    do {
        let content = try String(contentsOfFile: inputFile) // Read file content
        let lines = content.components(separatedBy: .newlines) // Split by new lines
        
        for line in lines { // Loop through each line
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty { continue } // Skip empty lines
            
            // Split by commas for comma-separated numbers
            let items = trimmed.components(separatedBy: ",")
            for item in items { // Loop through each item
                let value = item.trimmingCharacters(in: .whitespaces) // Trim spaces
                if let num = Int(value) { // Convert to integer
                    numbers.append(num) // Add valid number
                } else { // Invalid number found
                    print("This is an error")
                    return
                }
            }
        }
    } catch { // Handle read error
        print("No file")
        return
    }
    
    if numbers.isEmpty { // No numbers found
        print("No file")
        return
    }
    
    print("Sorting") // Display sorting message
    let sortedNumbers = sorting(arr: numbers) // Get sorted array
    
    // Prepare output text
    var outputText = ""
    for num in sortedNumbers { // Loop through sorted numbers
        outputText += "\(num)\n" // Write each number on a new line
    }
    
    do {
        try outputText.write(toFile: outputFile, atomically: true, encoding: .utf8) // Write output
    } catch { // Handle write error
        print("Could not write to output.txt")
    }
}

// Call the function (main entry point)
sortingKeeper()
