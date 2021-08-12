module.exports = {
	HOST: "localhost",
	USER: "root", // change to match your configuration
	PASSWORD: "", // change to match your configuration
	//PORT: 3000, // change to match your configuration
	DB: "groupomania",
	dialect: "mysql",
	pool: {
		max: 5,
		min: 0,
		acquire: 30000,
		idle: 10000
	}
};
	