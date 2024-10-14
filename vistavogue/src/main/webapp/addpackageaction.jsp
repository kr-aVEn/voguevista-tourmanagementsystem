<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vistavogue.dao.PackageDAO" %>
<%@ page import="vistavogue.beans.Package" %>
<%
    String name = request.getParameter("name");
    int duration = Integer.parseInt(request.getParameter("duration"));
    double cost = Double.parseDouble(request.getParameter("cost"));

    Package newPackage = new Package();
    newPackage.setName(name);
    newPackage.setDuration(duration);
    newPackage.setCost(cost);
    
    PackageDAO packageDAO = new PackageDAO();
    packageDAO.addPackage(newPackage);

    response.sendRedirect("managepackages.jsp");
%>
