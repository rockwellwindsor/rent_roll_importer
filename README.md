# Summary
	* As a user you can upload a CSV file
		* This data will be saved in the DB
	* You can return a report of currently Unit information, occupied and vacant Units

# Assumptions Made
* I based my rent roll on the supplied example (here)[https://github.com/WelcomeHome-Software/developer-interview/blob/main/assets/units-and-residents.csv]
* Added very little valdiation for the sake of time.  What I included I assumed to be the essentially required validations
	* Unit needs a number and floor plan
	* Tenant needs a name

# Commands
* You can pull from the added `rent_roll.csv` file in the public repo to populate your DB in order to generate the report
	* `$ rails runner "RentRollImporter.import('public/rent_roll.csv')"`
* You can print out the report to the command line by passing in a date
	* `rails runner "LeaseScanner.generate_report('2024-08-15')"`

# Next Steps
* There are a huge amount of validations that could make this more robust obviously. a few that come to mind:
	* Make sure `move_in` and `move_out` dates are valid dates and do not overlap.
		* also make sure the move out date is not before the move in date
		* One tenants move in date is not before the previous tenants move out date, etc.
	* Parsing the uploaded CSV file could be much more robust as well.  It would certianly need some error handling and reporting
* I assume more agile reporting would also be a part of this kind of development.
