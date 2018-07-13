/**
* My Event Handler Hint
*/
component extends="coldbox.system.EventHandler"{

	property name="logService" inject="logs.LogService";
	
	/**
	* Index
	*/
	any function index( event, rc, prc ){
		prc.logs = logService.getTail();

		event.setView("logs/index");
	}
	
}