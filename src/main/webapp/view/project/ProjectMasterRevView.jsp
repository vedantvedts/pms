<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, com.vts.pfms.*, java.text.SimpleDateFormat, java.text.DecimalFormat" %>
           <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/projectModule/projectMasterRevView.css" var="ExternalCSS" /> 
<link href="${ExternalCSS}" rel="stylesheet" />
<title>Project View</title>
</head>
<body>
<% 
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy"); 
    List<Object[]> ProjectTypeMainList = (List<Object[]>) request.getAttribute("ProjectTypeMainList");
    List<Object[]> OfficerList = (List<Object[]>) request.getAttribute("OfficerList");
    Object[] ProjectOriginalData = (Object[]) request.getAttribute("ProjectOriginalData");
    String ProjectId = (String) request.getAttribute("ProjectId");
    List<Object[]> CategoryList = (List<Object[]>) request.getAttribute("CategoryList");
    List<Object[]> ProjectTypeList = (List<Object[]>) request.getAttribute("ProjectTypeList");
    List<Object[]> ProjectReviseList = (List<Object[]>) request.getAttribute("ProjectReviseList");

   
%>

<div class="card-header"><h4>Project View</h4></div>
<div class="card shadow-nohover style1" >
    <!-- Original Section -->
    <div class="row mild-bg original style2">
        <div class="col-md-12 d-flex justify-content-center">
            <div><strong>ORIGINAL</strong></div> 
        </div>
    </div>

    <!-- Project Details -->
    <div class="row style3">
        <div class="col-md-4 background d-flex align-items-center">
            <div class="name"><strong>Project Main:</strong></div>   
            <div class="ml-2">
                <%= ProjectOriginalData[26]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[26].toString()): " - "  %>
            </div>
        </div>
        <div class="col-md-8 background d-flex align-items-center">
            <div class="name"><strong>Project Name:</strong></div>   
            <div class="ml-2"><%= ProjectOriginalData[1]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[1].toString()): " - " %></div>
        </div>
    </div>

    <!--  Three Column  -->
  <div class="row style3">
     <div class="col-sm-3 background d-flex align-items-center">
        <div class="name"><strong>Project Number:</strong></div> 
            <div class="ml-2"><%= ProjectOriginalData[27]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[27].toString()): " - " %></div>
     </div>
    <div class="col-sm-3 background d-flex align-items-center">
    	<div class="name"><strong>Project Unit Code:</strong> </div>
     		<div class="ml-2"><%= ProjectOriginalData[3]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[3].toString()): " - " %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      	<div class="name"><strong>Project Code:</strong></div>
      		<div class="ml-2"><%= ProjectOriginalData[2]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[2].toString()): " - " %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>Project Short Name:</strong></div>
      <div class="ml-2"><%= ProjectOriginalData[4]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[4].toString()): " - " %></div>
    </div>
  </div>
  <!--  Three Column  -->
<!--  Four Column  -->
  <div class="row style3">
    
    <div class="col-sm-3 background d-flex align-items-center">
     <div class="name"><strong>End User:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[5]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[5].toString()): " - "%></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>Project Sanc Authority:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[6]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[6].toString()): " - " %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>Board Of Reference:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[7]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[7].toString()): " - " %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>Project Director:</strong></div>
     <div class="ml-2"> 
     
     	<%if(ProjectOriginalData[8]!=null && !ProjectOriginalData[8].toString().equalsIgnoreCase("")) {%>
      		<div class="ml-2"><%= StringEscapeUtils.escapeHtml4(ProjectOriginalData[8].toString())%>&nbsp<%= ProjectOriginalData[10]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[10].toString()): " - " %>,&nbsp<%= ProjectOriginalData[11]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[11].toString()): " - " %></div>
      		<%} else if(ProjectOriginalData[9]!=null && !ProjectOriginalData[9].toString().equalsIgnoreCase("")) { %>
      		<div class="ml-2"><%= StringEscapeUtils.escapeHtml4(ProjectOriginalData[9].toString())%>&nbsp<%= ProjectOriginalData[10]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[10].toString()): " - "%>,&nbsp<%= ProjectOriginalData[11]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[11].toString()): " - " %></div>
      		<%} %>
    
        </div>
    </div>
    
  </div>
  <!--  Four Column  -->
  <!--  three Column  -->
  <div class="row style3">
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>Project Sanction Letter No:</strong></div>
      <div class="ml-2"><%= ProjectOriginalData[12]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[12].toString()): " - " %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
     <div class="name"><strong>Project Sanction Date:</strong></div>
     <div class="ml-2 text-danger"><%= sdf.format(ProjectOriginalData[13]) %></div>
    </div>
    
    
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>PDC:</strong></div>
      <div class="ml-2 text-danger"><%= sdf.format(ProjectOriginalData[14]) %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>Nodal & Participating Lab:</strong></div>
      <div class="ml-2"><%= ProjectOriginalData[15]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[15].toString()): " - " %></div>
    </div>
    
  </div>
  <!--  three  Column  -->
  <!--  three Column  -->
  <div class="row style3">
    <div class="col-sm-4 background d-flex align-items-center">
      <div class="name"><strong>Total Sanction Cost (&#8377;):</strong></div>
      <div class="ml-2"><%= ProjectOriginalData[16]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[16].toString()): " - " %></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
     <div class="name"><strong>Sanction Cost FE (&#8377;):</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[18]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[18].toString()): " - " %></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
      <div class="name"><strong>Sanction Cost RE (&#8377;):</strong></div>
     <div class="ml-2"> <%= ProjectOriginalData[17]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[17].toString()): " - " %></div>
    </div>
    
  </div>
  <!--  three  Column  -->
  <!--  Four Column  -->
  <div class="row style3">
    <div class="col-sm-4 background d-flex align-items-center">
     <div class="name"><strong>Application:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[19]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[19].toString()): " - "%></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
     <div class="name"><strong>Category:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[21]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[21].toString()): " - "%></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
      <div class="name"><strong>Security Classification:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[20]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[20].toString()): " - "%></div>
    </div>
   </div>
   
    
  <!--  Four Column  -->
<!--  Six Column  -->
  <div class="row style3">
    <div class="col-sm-12 d-flex align-items-center ">
    	<div class="sc colors"> <strong>Scope:</strong></div>
    </div>
  </div>
   <div class="row style4">
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para" ><%= ProjectOriginalData[22]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[22].toString()): " - " %></div>
    </div>
  </div>
  <div class="row style3">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc colors"> <strong>Objective:</strong></div>
    </div>
  </div>
   <div class="row style3" >
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para"><%= ProjectOriginalData[23]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[23].toString()): " - " %></div>
    </div>
  </div>
   <div class="row style3">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc colors"> <strong>Deliverable:</strong></div>
    </div>
  </div>
   <div class="row style3">
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para"><%= ProjectOriginalData[24]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[24].toString()): " - " %></div>
    </div>
  </div>
</div>	
<br>

    <!-- Revision Section -->
    <%
        String[] revisionColors = {"#c47b3c", "#48659b","#3e973e","#8c973e","#97573e","#223182","#8c416f","#223e82","#3e9765","#8c4148","#3e7e97","#77973e","#3e978a","#93568c","#b72b2b"};
        int colorIndex = 0; 
        int index = 1;
        for (Object[] obj : ProjectReviseList) {
            String revisionColor = revisionColors[colorIndex++];
    %>
    <div class="card style5">
        <div class="row mild-bg original rev-color-<%= colorIndex %>">
            <div class="col-md-12 d-flex justify-content-center">
                <div><strong>REVISION - <%= index++ %></strong></div> 
            </div>
        </div>

        <!-- Revision Details -->
        <div class="row style3">
            <div class="col-md-4 background d-flex align-items-center">
                <div class="revname"><strong>Project Number:</strong></div>   
                <div class="ml-2"><%= obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - " %></div>
            </div>
            <div class="col-md-8 background d-flex align-items-center">
                <div class="revname"><strong>Project Name:</strong></div>   
                <div class="ml-2"><%= ProjectOriginalData[1]!=null?StringEscapeUtils.escapeHtml4(ProjectOriginalData[1].toString()): " - " %></div>
            </div>
        </div>

        <!--  Two Column  -->
<!--  Three Column  -->
  <div class="row style3">
     
    <div class="col-sm-3 background d-flex align-items-center">
    	<div class="revname"><strong>Project Unit Code:</strong> </div>
     		<div class="ml-2"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      	<div class="revname"><strong>Project Code:</strong></div>
      		<div class="ml-2"><%= obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></div>
    </div>
     <div class="col-sm-3 background d-flex align-items-center">
      	<div class="revname"><strong>Board Of Reference:</strong></div>
      		<div class="ml-2"><%= obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      	<div class="revname"><strong>Project Director:</strong></div>
      	<%if(obj[5]!=null && !obj[5].toString().equalsIgnoreCase("")) {%>
      		<div class="ml-2"><%= StringEscapeUtils.escapeHtml4(obj[5].toString())%>&nbsp<%= obj[4] !=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>,&nbsp<%= obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " %></div>
      		<%} else if(obj[6]!=null && !obj[6].toString().equalsIgnoreCase("")) { %>
      		<div class="ml-2"><%=StringEscapeUtils.escapeHtml4(obj[6].toString())%>&nbsp<%= obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %>,&nbsp<%= obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " %></div>
      		<%} %>
    </div>
   
  </div>
  <!--  Three Column  -->
<!--  Four Column  -->
  
  <!--  Four Column  -->
  <!--  three Column  -->
  <div class="row style3">
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="revname"><strong>Project Sanc Authority:</strong></div>
      <div class="ml-2"><%= obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - " %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
     <div class="revname"><strong>Project Sanction Letter No:</strong></div>
     <div class="ml-2 "><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - "%></div>
    </div>
    
    
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="revname"><strong>Project Sanction Date:</strong></div>
      <div class="ml-2 text-danger"><%= sdf.format(obj[11]) %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="revname"><strong>PDC:</strong></div>
      <div class="ml-2 text-danger"><%= sdf.format(obj[12]) %></div>
    </div>
    
  </div>
  <!--  three  Column  -->
  <!--  three Column  -->
  <div class="row style3">
    <div class="col-sm-4 background d-flex align-items-center">
      <div class="revname"><strong>Total Sanction Cost (&#8377;):</strong></div>
      <div class="ml-2"><%=obj[13]!=null?StringEscapeUtils.escapeHtml4(obj[13].toString()): " - "%></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
     <div class="revname"><strong>Sanction Cost FE (&#8377;):</strong></div>
     <div class="ml-2"><%= obj[14]!=null?StringEscapeUtils.escapeHtml4(obj[14].toString()): " - " %></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
      <div class="revname"><strong>Sanction Cost RE (&#8377;):</strong></div>
     <div class="ml-2"> <%= obj[15]!=null?StringEscapeUtils.escapeHtml4(obj[15].toString()): " - " %></div>
    </div>
    
  </div>
  <!--  three  Column  -->
  <!--  Four Column  -->

 <div class="row style3">
	 <div class="col-sm-3 background d-flex align-items-center">
	     <div class="revname"><strong>  Nodal & Participating Lab:</strong></div>
	     <div class="ml-2"><%=obj[16]!=null?StringEscapeUtils.escapeHtml4(obj[16].toString()): " - "%></div>
	    </div>
    <div class="col-sm-3 background d-flex align-items-center">
     <div class="revname"><strong>Application:</strong></div>
     <div class="ml-2"><%=obj[17]!=null?StringEscapeUtils.escapeHtml4(obj[17].toString()): " - "%></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
     <div class="revname"><strong>Category:</strong></div>
     <div class="ml-2"><%= obj[24]!=null?StringEscapeUtils.escapeHtml4(obj[24].toString()): " - " %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="revname"><strong>Security Classification:</strong></div>
     <div class="ml-2"><%= obj[23]!=null?StringEscapeUtils.escapeHtml4(obj[23].toString()): " - " %></div>
    </div>
   </div>
   
    
  <!--  Four Column  -->
<!--  Six Column  -->
  <div class="row style3">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc rev-colors"> <strong>Scope:</strong></div>
    </div>
  </div>
   <div class="row style3">
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para" ><%= obj[19]!=null?StringEscapeUtils.escapeHtml4(obj[19].toString()): " - " %></div>
    </div>
  </div>
  <div class="row style3">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc rev-colors"> <strong>Objective:</strong></div>
    </div>
  </div>
   <div class="row style3" >
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para"><%= obj[20]!=null?StringEscapeUtils.escapeHtml4(obj[20].toString()): " - " %></div>
    </div>
  </div>
   <div class="row style3">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc rev-colors"> <strong>Deliverable:</strong></div>
    </div>
  </div>
   <div class="row style3">
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para"><%= obj[21]!=null?StringEscapeUtils.escapeHtml4(obj[21].toString()): " - " %></div>
    </div>
  </div>
   <div class="row style3">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc rev-colors"> <strong>Remarks:</strong></div>
    </div>
  </div>
   <div class="row style3">
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para"><%= obj[22]!=null?StringEscapeUtils.escapeHtml4(obj[22].toString()): " - " %></div>
    </div>
  </div>
</div>	
<br>
	<% } %>
	





<!-- Back Button -->
<div align="center">
    <a class="btn btn-info btn-sm shadow-nohover back" href="ProjectList.htm">BACK</a>
</div>
</body>
</html>