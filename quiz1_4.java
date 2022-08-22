package com.goodee.quiz1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class quiz1_4 {

	public static void main(String[] args) {
		String connect = "jdbc:mariadb://localhost:3306/quiz1";
		String user = "root";
		String passwd = "1234";
		Connection conn = null; 
		PreparedStatement pstmt = null;
		
		Scanner scan = new Scanner(System.in);

		try {
			conn = DriverManager.getConnection(connect, user, passwd);
			System.out.println("대상 id >");
			int id = scan.nextInt();
			System.out.println("바꾸고 싶은 column > ");
			String col = scan.next();
			System.out.println("바꿀 값 > ");
			String val = scan.next();
			
			String query = "update datatable1 set " + col + "=? where id=?";
			
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, val);
			pstmt.setInt(2, id);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					
					e.printStackTrace();
				}
		}
	}

}
