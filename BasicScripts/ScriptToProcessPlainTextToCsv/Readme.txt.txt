The Puprose of the script is to give few insights about our work quality. This particular script perform the follwing tasks.

	1. Read the plain text file
	2. Delete the lines according to line numbers
	3. Break the lines into columns according to business logic 
		. The First column start at 0th Character and have length of 38 characters
		. The Second column start at 38th character and have length of 17 characters
		. The Third column start at 55th character and have length of 26 characters
		. The Fourth column start at 81th character and have length of 54 characters
Key Feature:
	1. The new columns can easily defined and resturctured by modyfing columnList ArrayList
	2. The line numbers which need to be deleted can be easily managed by modifying linesArray
	3. A class Column is defined to easyly manage the columns
	4. If any file line does not meet the requirement it will be written to error out file	