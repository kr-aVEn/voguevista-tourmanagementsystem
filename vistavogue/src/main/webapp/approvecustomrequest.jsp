// approvecustomrequest.jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vistavogue.dao.CustomizationRequestDAO" %>
<%
    int requestId = Integer.parseInt(request.getParameter("requestId"));
CustomizationRequestDAO customPackageRequestDAO = new CustomizationRequestDAO();
    customPackageRequestDAO.updateRequestStatus(requestId, "Approved");

    response.sendRedirect("viewcustompackagerequests.jsp");
%>
