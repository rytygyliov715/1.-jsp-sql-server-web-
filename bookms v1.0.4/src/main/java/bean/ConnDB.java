package bean;

import java.sql.*;

public class ConnDB {
	private static final String dbDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static final String dbUrl = "jdbc:sqlserver://127.0.0.1:1433;DatabaseName=jdbc";
	private static final String dbUser = "sa";
	private static final String dbPwd = "12345";
	public Connection conn = null;
	public Statement stmt = null;
	public ResultSet rs = null;

	// 打开数据库连接
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName(dbDriver); // 加载数据库驱动
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPwd); // 建立数据库连接对象
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (conn == null) {
			System.err.println("警告:数据库连接失败!");
		}
		return conn;
	}

	// 读取结果集
	public ResultSet doQuery(String sql) // 执行select
	{
		try {
			conn = ConnDB.getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, // 此参数支持读取结果集时“双向滚动”
					ResultSet.CONCUR_READ_ONLY); // 此参数为“只读”
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	// 更新数据
	public int doUpdate(String sql) // 执行insert、update、delete
	{
		int result = 0;
		try {
			conn = ConnDB.getConnection();
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			result = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			result = 0;
		}
		return result;
	}

	// 关闭数据库连接
	public void closeConnection() {
		try {
			if (rs != null)
				rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (stmt != null)
				stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}