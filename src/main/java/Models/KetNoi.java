package Models;

import java.sql.Connection;
import java.sql.DriverManager;

public class KetNoi {
	public Connection cn;
	public void ketnoi() throws Exception{
	   Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	   cn= DriverManager.getConnection("jdbc:sqlserver://LAPTOP-KAECOSVK:1433;databaseName=QLSach;user=sa; password=123;useUnicode=true;characterEncoding=UTF-8");
	   System.out.println("Da ket noi");
	}
}
