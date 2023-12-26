/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.uniquedeveloper.registration;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.*;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.uniquedeveloper.registration.DbCon;
import com.uniquedeveloper.registration.*;

@WebServlet(name = "OrderNowServlet", urlPatterns = {"/order-now"})
public class OrderNowServlet extends HttpServlet {

   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");

    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    Date date = new Date();

    Order order = new Order();
    int uid = Integer.parseInt(request.getParameter("uid"));
    int pid = Integer.parseInt(request.getParameter("productId"));
    double price = Double.parseDouble(request.getParameter("price"));
    String name = request.getParameter("productName");
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    
    order.setProductName(name);
    order.setProductId(pid);
    order.setQunatity(quantity);
    order.setUid(uid);
    order.setTPrice(price);
    order.setDate(formatter.format(date)); // Set the current date in the required format
  System.out.println(price);
    OrderDao orderDao = new OrderDao(DbCon.getConnection());
    boolean status=orderDao.insertOrder(order);
    
    if(status){
         response.sendRedirect("product.jsp");
    }
    else{
        response.sendRedirect("error.jsp");
    }


   
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
