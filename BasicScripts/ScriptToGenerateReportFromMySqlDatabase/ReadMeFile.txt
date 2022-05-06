Query to create Table

CREATE TABLE `student` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `roll_number` varchar(10) NOT NULL,
  `grade` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) 


INSERT INTO `student` VALUES 
	(1,'Student1','1234567890','01'),
	(2,'Student2','1234567891','02'),
	(3,'Student3','1234567892','03'),
	(4,'Student4','1234567893','04'),
	(5,'Student5','1234567894','05');

#This script will read the data from sql database and export it to csv format
#By changing the Query we can play around