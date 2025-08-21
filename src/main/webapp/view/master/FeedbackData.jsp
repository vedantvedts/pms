<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Feedback</title>
</head>
<body>
<% Object[] FeedbackData = (Object[])request.getAttribute("FeedbackData");
 SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
%>
<b>User Name:</b><%=FeedbackData[1]!=null?StringEscapeUtils.escapeHtml4(FeedbackData[1].toString()):"-" %>&nbsp;&nbsp;&nbsp;<b>Time :</b><%=sdf1.format(FeedbackData[2]) %><br>
<hr>
<%=FeedbackData[0] %>
</body>
</html>