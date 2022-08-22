package com.goodee.quiz1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class quiz1_3 {

	public static void main(String[] args) {
		String connect = "jdbc:mariadb://localhost:3306/quiz1";
		String user = "root";
		String passwd = "1234";
		Connection conn = null; 
		PreparedStatement pstmt = null;

		Scanner scan = new Scanner(System.in);
		
		try {
			conn = DriverManager.getConnection(connect, user, passwd);
			
			System.out.println("첫번째 값 >");
			String val1 = scan.next();
			System.out.println("두번째 값 >");
			String val2 = scan.next();
			System.out.println("두번째 값 >");
			String val3 = scan.next();
			
			String query = "insert into datatable1(data1, data2, data3) values(?,?,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, val1);
			pstmt.setString(2, val2);
			pstmt.setString(3, val3);
			
			pstmt.executeUpdate();

			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}

	}

}
