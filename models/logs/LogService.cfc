/**
*
* Service object for getting application logs
* 
* @file  /models/logs/logService.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {

	property name="logGateway" inject="logs.LogGateway";

	public function init(){
		return this;
	}


	/**
	* Gets a query of last 100 log entries by date
	* 
	* <pre>
	* qLogs = logService.getTail();
	* </pre>
	*
	*/
	public any function getTail() {
		
		return logGateway.getTail();
	}
	
	
}