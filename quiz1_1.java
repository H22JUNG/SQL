package com.goodee.quiz1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class quiz1_1 {
	String connect = "jdbc:mariadb://localhost:3306/quiz1";
	String user = "root";
	String passwd = "1234";
	Connection conn = null;  //빈 껍데기만 받아놓기 ???
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public quiz1_1() {
		try {
			conn = DriverManager.getConnection(connect, user, passwd);

			String query = "select * from datatable1";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int id = rs.getInt(1);
				String data1 = rs.getString(2);
				String data2 = rs.getString(3);
				String data3 = rs.getString(4);
				
				System.out.println(id + ":" + data1 + "-" + data2 + "-" + data3 );
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) {
		new quiz1_1();

	}

}
