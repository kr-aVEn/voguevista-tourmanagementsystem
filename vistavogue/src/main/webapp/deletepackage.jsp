<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vistavogue.dao.PackageDAO" %>
<%
    int packageId = Integer.parseInt(request.getParameter("packageId"));
    PackageDAO packageDAO = new PackageDAO();
    packageDAO.deletePackage(packageId);

    response.sendRedirect("managepackages.jsp");
%>
