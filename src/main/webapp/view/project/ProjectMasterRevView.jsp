<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, com.vts.pfms.*, java.text.SimpleDateFormat, java.text.DecimalFormat" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Project View</title>
<style>
label {
	font-size: 14px;
}

.input-group-text {
	font-weight: bold;
}

label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

hr {
	margin-top: -2px;
	margin-bottom: 12px;
}

b {
	font-family: 'Lato', sans-serif;
}
.background{
    text-align:center;
    padding-top: .35rem;
    padding-bottom: .35rem;
    background-color: rgba(253, 253, 253, 0.5);
	border-bottom: 1px solid rgba(46, 0, 117, 0.2);
	border-left: 1px solid rgba(46, 0, 117, 0.2);
   
}
 .mild-bg {
    background-color: #651682; 
    color: #fff;
  }
  .original{
  	height: 5px;
  }
  .name {
   	  color: #257b88;
	  border-radius: 4px;
	  padding: 5px 10px;
}

.revname {
   	  color: #887d25;
	  border-radius: 4px;
	  padding: 5px 3px;
}
	.card{
		    border-radius: 4px; 
		    margin: auto;
			width: 95%;
			box-sizing: border-box;
	}

	.sc{
		color: white;	
	}
	.para{
		text-align: justify;
	}
	.text-danger {
	  color: #8c3434 !important;
	  }
	 .colors{
	 		color: #257b88;
	 }
	 .rev-colors{
			color:#887d25;	 
	 }
	  
</style>
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
<div class="card shadow-nohover" style="background-color: #DDD;">
    <!-- Original Section -->
    <div class="row mild-bg original" style="height: 25px;width: 100%;margin: auto;">
        <div class="col-md-12 d-flex justify-content-center">
            <div><strong>ORIGINAL</strong></div> 
        </div>
    </div>

    <!-- Project Details -->
    <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
        <div class="col-md-4 background d-flex align-items-center">
            <div class="name"><strong>Project Main:</strong></div>   
            <div class="ml-2">
                <%= ProjectOriginalData[26] %>
            </div>
        </div>
        <div class="col-md-8 background d-flex align-items-center">
            <div class="name"><strong>Project Name:</strong></div>   
            <div class="ml-2"><%= ProjectOriginalData[1] %></div>
        </div>
    </div>

    <!--  Three Column  -->
  <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
     <div class="col-sm-3 background d-flex align-items-center">
        <div class="name"><strong>Project Number:</strong></div> 
            <div class="ml-2"><%= ProjectOriginalData[27] %></div>
     </div>
    <div class="col-sm-3 background d-flex align-items-center">
    	<div class="name"><strong>Project Unit Code:</strong> </div>
     		<div class="ml-2"><%= ProjectOriginalData[3] %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      	<div class="name"><strong>Project Code:</strong></div>
      		<div class="ml-2"><%= ProjectOriginalData[2] %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>Project Short Name:</strong></div>
      <div class="ml-2"><%= ProjectOriginalData[4] %></div>
    </div>
  </div>
  <!--  Three Column  -->
<!--  Four Column  -->
  <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
    
    <div class="col-sm-3 background d-flex align-items-center">
     <div class="name"><strong>End User:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[5]%></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>Project Sanc Authority:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[6] %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>Board Of Reference:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[7] %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>Project Director:</strong></div>
     <div class="ml-2"> 
     
     	<%if(ProjectOriginalData[8]!=null && !ProjectOriginalData[8].toString().equalsIgnoreCase("")) {%>
      		<div class="ml-2"><%= ProjectOriginalData[8]%>&nbsp<%= ProjectOriginalData[10] %>,&nbsp<%= ProjectOriginalData[11] %></div>
      		<%} else if(ProjectOriginalData[9]!=null && !ProjectOriginalData[9].toString().equalsIgnoreCase("")) { %>
      		<div class="ml-2"><%= ProjectOriginalData[9]%>&nbsp<%= ProjectOriginalData[10] %>,&nbsp<%= ProjectOriginalData[11] %></div>
      		<%} %>
    
        </div>
    </div>
    
  </div>
  <!--  Four Column  -->
  <!--  three Column  -->
  <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="name"><strong>Project Sanction Letter No:</strong></div>
      <div class="ml-2"><%= ProjectOriginalData[12] %></div>
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
      <div class="ml-2"><%= ProjectOriginalData[15] %></div>
    </div>
    
  </div>
  <!--  three  Column  -->
  <!--  three Column  -->
  <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-4 background d-flex align-items-center">
      <div class="name"><strong>Total Sanction Cost (&#8377;):</strong></div>
      <div class="ml-2"><%= ProjectOriginalData[16] %></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
     <div class="name"><strong>Sanction Cost FE (&#8377;):</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[18] %></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
      <div class="name"><strong>Sanction Cost RE (&#8377;):</strong></div>
     <div class="ml-2"> <%= ProjectOriginalData[17] %></div>
    </div>
    
  </div>
  <!--  three  Column  -->
  <!--  Four Column  -->
  <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-4 background d-flex align-items-center">
     <div class="name"><strong>Application:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[19]%></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
     <div class="name"><strong>Category:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[21]%></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
      <div class="name"><strong>Security Classification:</strong></div>
     <div class="ml-2"><%= ProjectOriginalData[20]%></div>
    </div>
   </div>
   
    
  <!--  Four Column  -->
<!--  Six Column  -->
  <div class="row " style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 d-flex align-items-center ">
    	<div class="sc colors"> <strong>Scope:</strong></div>
    </div>
  </div>
   <div class="row" style="margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para" ><%= ProjectOriginalData[22] %></div>
    </div>
  </div>
  <div class="row " style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc colors"> <strong>Objective:</strong></div>
    </div>
  </div>
   <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;" >
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para"><%= ProjectOriginalData[23] %></div>
    </div>
  </div>
   <div class="row " style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc colors"> <strong>Deliverable:</strong></div>
    </div>
  </div>
   <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para"><%= ProjectOriginalData[24] %></div>
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
    <div class="card" style="background-color: #DDD;">
        <div class="row mild-bg original" style="background-color: <%= revisionColor %>;height: 25px;width: 100%;margin: auto;">
            <div class="col-md-12 d-flex justify-content-center">
                <div><strong>REVISION - <%= index++ %></strong></div> 
            </div>
        </div>

        <!-- Revision Details -->
        <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
            <div class="col-md-4 background d-flex align-items-center">
                <div class="revname"><strong>Project Number:</strong></div>   
                <div class="ml-2"><%= obj[0] %></div>
            </div>
            <div class="col-md-8 background d-flex align-items-center">
                <div class="revname"><strong>Project Name:</strong></div>   
                <div class="ml-2"><%= ProjectOriginalData[1] %></div>
            </div>
        </div>

        <!--  Two Column  -->
<!--  Three Column  -->
  <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
     
    <div class="col-sm-3 background d-flex align-items-center">
    	<div class="revname"><strong>Project Unit Code:</strong> </div>
     		<div class="ml-2"><%=obj[1]%></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      	<div class="revname"><strong>Project Code:</strong></div>
      		<div class="ml-2"><%= obj[2] %></div>
    </div>
     <div class="col-sm-3 background d-flex align-items-center">
      	<div class="revname"><strong>Board Of Reference:</strong></div>
      		<div class="ml-2"><%= obj[3] %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      	<div class="revname"><strong>Project Director:</strong></div>
      	<%if(obj[5]!=null && !obj[5].toString().equalsIgnoreCase("")) {%>
      		<div class="ml-2"><%= obj[5]%>&nbsp<%= obj[4] %>,&nbsp<%= obj[7] %></div>
      		<%} else if(obj[6]!=null && !obj[6].toString().equalsIgnoreCase("")) { %>
      		<div class="ml-2"><%= obj[6]%>&nbsp<%= obj[4] %>,&nbsp<%= obj[7] %></div>
      		<%} %>
    </div>
   
  </div>
  <!--  Three Column  -->
<!--  Four Column  -->
  
  <!--  Four Column  -->
  <!--  three Column  -->
  <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="revname"><strong>Project Sanc Authority:</strong></div>
      <div class="ml-2"><%= obj[9] %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
     <div class="revname"><strong>Project Sanction Letter No:</strong></div>
     <div class="ml-2 "><%=obj[10]%></div>
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
  <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-4 background d-flex align-items-center">
      <div class="revname"><strong>Total Sanction Cost (&#8377;):</strong></div>
      <div class="ml-2"><%=obj[13]%></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
     <div class="revname"><strong>Sanction Cost FE (&#8377;):</strong></div>
     <div class="ml-2"><%= obj[14] %></div>
    </div>
    <div class="col-sm-4 background d-flex align-items-center">
      <div class="revname"><strong>Sanction Cost RE (&#8377;):</strong></div>
     <div class="ml-2"> <%= obj[15] %></div>
    </div>
    
  </div>
  <!--  three  Column  -->
  <!--  Four Column  -->

 <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
	 <div class="col-sm-3 background d-flex align-items-center">
	     <div class="revname"><strong>  Nodal & Participating Lab:</strong></div>
	     <div class="ml-2"><%=obj[16]%></div>
	    </div>
    <div class="col-sm-3 background d-flex align-items-center">
     <div class="revname"><strong>Application:</strong></div>
     <div class="ml-2"><%=obj[17]%></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
     <div class="revname"><strong>Category:</strong></div>
     <div class="ml-2"><%= obj[24] %></div>
    </div>
    <div class="col-sm-3 background d-flex align-items-center">
      <div class="revname"><strong>Security Classification:</strong></div>
     <div class="ml-2"><%= obj[23] %></div>
    </div>
   </div>
   
    
  <!--  Four Column  -->
<!--  Six Column  -->
  <div class="row " style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc rev-colors"> <strong>Scope:</strong></div>
    </div>
  </div>
   <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para" ><%= obj[19] %></div>
    </div>
  </div>
  <div class="row " style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc rev-colors"> <strong>Objective:</strong></div>
    </div>
  </div>
   <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;" >
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para"><%= obj[20] %></div>
    </div>
  </div>
   <div class="row " style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc rev-colors"> <strong>Deliverable:</strong></div>
    </div>
  </div>
   <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para"><%= obj[21] %></div>
    </div>
  </div>
   <div class="row " style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 d-flex align-items-center">
    	<div class="sc rev-colors"> <strong>Remarks:</strong></div>
    </div>
  </div>
   <div class="row" style="width: 100%;margin-left: auto;margin-right: auto;">
    <div class="col-sm-12 background d-flex align-items-center">
    	<div class="ml-2 para"><%= obj[22] %></div>
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