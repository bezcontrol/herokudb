package com.heroku.example;

import java.io.File;
import java.io.FileNotFoundException;
import java.net.URI;
import java.net.URISyntaxException;
import java.sql.*;
import java.util.Scanner;

public class Main {
    
    public static void main(String[] args)  {
        try {
            String str="";
            Scanner in1 = new Scanner(new File("pgsql.sql"));
            while(in1.hasNext())
                str += in1.nextLine() + "\r\n";
            in1.close();
            Connection connection =  getConnection();
            PreparedStatement pr= connection.prepareStatement(str);
            pr.executeQuery();
            pr.close();
            connection.close();
            allUsers();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

    }

    private static void allUsers() {
        Connection connection;
        try {
            connection = getConnection();
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM internet_provider.users");
            while (rs.next()) {
                System.out.println(rs.getString("login"));
            }
        } catch (URISyntaxException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    private static Connection getConnection() throws URISyntaxException, SQLException {
        URI dbUri = new URI(System.getenv("DATABASE_URL"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + dbUri.getPath();

        return DriverManager.getConnection(dbUrl, username, password);
    }

}