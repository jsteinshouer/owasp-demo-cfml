
CREATE TABLE [user] (
	p_user int IDENTITY(1,1),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	username VARCHAR(50),
	password VARCHAR(150),
 	PRIMARY KEY (p_user)
);

CREATE TABLE recipe (
	p_recipe INT IDENTITY(1,1),
	title VARCHAR(50),
	description VARCHAR(100),
	ingredients VARCHAR(max),
	directions VARCHAR(max),
	f_user INT,
	PRIMARY KEY (p_recipe)
);