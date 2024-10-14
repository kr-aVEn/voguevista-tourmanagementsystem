<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vistavogue.dao.RequestLocationDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.lang.ClassNotFoundException" %>
<%
    String name = request.getParameter("name");
    String lat = request.getParameter("lat");
    String lon = request.getParameter("lon");

    try {
        RequestLocationDAO rl = new RequestLocationDAO();
        rl.addRequestLocation(name, lat, lon);
        response.setContentType("text/plain");
        response.getWriter().write("Location added: " + name);
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        response.setContentType("text/plain");
        response.getWriter().write("Error: " + e.getMessage());
    }
%>
