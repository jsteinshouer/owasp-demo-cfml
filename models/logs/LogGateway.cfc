/**
*
* <h3>Gateway for logbox logs stored in the database</h3>
* 
* <h4>Usage:</h4>
* <pre><code>
* 	qLogs = logService.getTail();
* </code>
* </pre>
* 
* @file  models/logs/LogGateway.cfc
* @author  Jason Steinshouer
* @date  1/14/2015
*
*/
component output="false" {

	/**
	* My datasource
	*
	*/
	property name="dsn" inject="coldbox:datasource:RecipeBox" type="struct";


	/**
	* Gets a query of last 100 log entries by date
	* 
	* <pre>
	* qLogs = logService.getTail();
	* </pre>
	*
	*/
	public query function getTail() {

		var q = queryExecute(
			"
				SELECT TOP 100 *
				FROM application_log
				ORDER BY logdate DESC
			",
			{},
			{
				datasource = dsn.name
			}
		);
		
		return q;
	}
	
	
	
	
	
}