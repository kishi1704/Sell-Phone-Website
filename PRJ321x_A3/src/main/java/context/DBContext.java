package context;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
	/*Change/update information of your database connection,
	 * DO NOT change name of instance variables in this class*/
	private final String serverName = "localhost";
	private final String dbName = "ShoppingDB";
	private final String portNumber = "1433";
	private final String instance = ""; // leave this one empty if your sql is a single instance;
	private final String userID = "sa";
	private final String password = "letmein";
	
	/* Get connection to database*/
	public Connection getConnection() throws Exception {
		String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName;
		if(instance == null || instance.trim().isEmpty()) {
			url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName;
		}
		
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		return DriverManager.getConnection(url, userID, password);
	}
}
