package com.goodee.quiz1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class quiz1_2 {
	
	public static void main(String[] args) {
		String connect = "jdbc:mariadb://localhost:3306/quiz1";
		String user = "root";
		String passwd = "1234";
		Connection conn = null;  //빈 껍데기만 받아놓기 ???
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Scanner scan = new Scanner(System.in);
		
		try {
			conn = DriverManager.getConnection(connect, user, passwd);
			
			System.out.println("입력 >");
			int i = scan.nextInt();
			
			String query = "select * from datatable1 where id = ? ";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, i);
		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String data1 = rs.getString(2);
				String data2 = rs.getString(3);
				String data3 = rs.getString(4);
				
				System.out.println(i + ":" + data1 + "-" + data2 + "-" + data3);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
				try {
					rs.close();
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

		}

	}

}
