/**
*
* Base Entity
* 
* <p>Usage:</p>
* 
* <pre>
* <code>component extends="models.BaseEntity"</code>
* </pre>
* 
*
*/
component output="false" accessors="true" {

	/**
	*
	* Constructor
	*
	*/
	public models.BaseEntity function init() {

		initProperties(argumentCollection=arguments);
		
		return this;
	}

	/**
	*
	* Initialize bean properties
	*
	*/
	private void function initProperties() {

		var metadata = getMetaData( this );
		var hasDefault = false;
		
		/* Loop through all properties and see if a matching argument was passed */
		for (var stProp in metadata.properties) {
			if (structKeyExists(arguments, stProp.name)) {
				variables[stProp.name] = arguments[stProp.name];
			}
			/* Set defaults */
			else {
				/* if wirebox inject is present then leave alone */
				if (!structKeyExists(stProp, "inject")) {
					/* Use default set for the property */
					if (structKeyExists(stProp, "default")) {
						hasDefault = true;
					}
					else {
						hasDefault = false;
					}

					/* Set default value */
					if (structKeyExists(stProp, "type")) {
						switch(stProp.type){
							case "string":
								variables[stProp.name] = hasDefault ? stProp.default : "";
							break;
							case "boolean":
								variables[stProp.name] = (hasDefault && isBoolean(stProp.default)) ? (stProp.default) : true;
							break;
							case "numeric":
								variables[stProp.name] = (hasDefault && isNumeric(stProp.default)) ? val(stProp.default) : 0;
							break;
							case "struct":
								variables[stProp.name] = {};
							break;
							case "array":
								variables[stProp.name] = [];
							break;
							default:
								variables[stProp.name] = "";
							break;
						}
					}
					/* Default is empty string */
					else {
						variables[stProp.name] = "";
					}
				}
			}
		}

	}

	/**
	*
	* Get a memento
	*
	*/
	public any function getMemento(string filter = "") {

		var metadata = getMetaData( this );
		var stInstance = {};

		/* Loop through properties */
		for(var item in metadata.properties) {
			if (!len(arguments.filter) || listContainsNoCase(arguments.filter, item.name)) {
				/* Make sure property is not null */
				if (!isNull(variables[item.name])) {
					/* If it is an object get memento */
					if (isObject(variables[item.name])) {
						stInstance[item.name] = variables[item.name].getMemento();
					}
					else {
						stInstance[item.name] = variables[item.name];
					}
				}
			}
		}
		
		return stInstance;
	}

	/**
	*
	* Populate properties from json
	*
	* @data.hint data to populate properties with
	*
	*/
	public any function setMemento(required struct data) {

		for (var key in structKeyList(arguments.data)) {
			if (structKeyExists(variables, key)) {
				variables[key] = arguments.data[key];
			}
		}
		
		return this;
	}

	/**
	*
	* Populate properties from json
	*
	* @json.hint JSON string
	*
	*/
	public any function populateFromJSON(required string json) {

		var data = deserializeJSON(arguments.json);

		setMemento( data );
		
		return this;
	}
			
}	