<%@page import="com.vts.pfms.utils.PMSLogoUtil"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RFA Report PDF</title>
<style type="text/css">

#pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
 @page {             
          size: A3 landscape;
          margin-top: 39px;
          margin-left: 39px;
          margin-right: 39px;
          margin-buttom: 39px; 	
          border: 1px solid black;    
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
              font-size: 13px;
          }
      }

.border-black{
padding:4px;
border: 1px solid black;
border-collapse: collapse;
}
.break
	{
		page-break-after: always;
	} 

th,td {
  border: 1px solid;
}
th{
font-size: 18px;
}
 p{
 padding:5px;
 text-align: justify;
  }
</style>
</head>
<body>

<%
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat();
SimpleDateFormat sdf2=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf3=new SimpleDateFormat("yyyy-MM-dd");
String fdate=(String)request.getAttribute("fdate");
String tdate=(String)request.getAttribute("tdate");  
String rfatypeid=(String)request.getAttribute("rfatypeid");  
String projectid = (String)request.getAttribute("projectid");
String projectType = (String)request.getAttribute("projectType");
String lablogo=(String)request.getAttribute("lablogo");
List<Object[]> ProjectList = (List<Object[]>)request.getAttribute("ProjectList");
List<Object[]> preProjectList = (List<Object[]>) request.getAttribute("preProjectList");
List<Object[]> RfaActionReportList = (List<Object[]>)request.getAttribute("RfaActionReportList");
List<Object[]> AssigneeList=(List<Object[]>) request.getAttribute("AssigneeEmplList");
String projectCode=projectType.equalsIgnoreCase("P") ? 
        ProjectList.stream().filter(project -> project[0] != null && project[0].toString().equals(projectid)) 
	   .map(project -> project[4] != null ? project[4].toString() : null)
	   .findFirst()
	   .orElse(null)
	           :
		preProjectList.stream().filter(project -> project[0] != null && project[0].toString().equals(projectid)) 
	   .map(project -> project[3] != null ? project[3].toString() : null)
	   .findFirst()
	   .orElse(null);
%>

    <div id="container pageborder" align="center"  class="firstpage" id="firstpage"  >
      <div class="border-black" style="margin-top: 5px; margin-left: 3px;width: 1490px;">
          <div class="row">
          <div class="col-md-12">
             <div class="col-md-2" style="display: inline-block;float: left !important;">
                <img style="height: 2.5cm" src="data:image/png;base64,<%=lablogo%>">
             </div>
             <div class="col-md-8" style="display: inline-block;float: none;">
		     <div style="font-size: 30px;padding: 20px;font-weight: 600;text-decoration: underline;">RFA Reports From &nbsp; <%=sdf.format(sdf1.parse(fdate))%>  &nbsp; To &nbsp; <%=sdf.format(sdf1.parse(tdate))%></div>
	         <div class="col-md-12">
				<div class="col-md-6" style="display: inline-block; margin-right: 90px;font-size: 22px;font-weight: 600;">Project : <%=projectCode %></div>
                <div  class="col-md-6" style="display: inline-block; margin-left: 90px;font-size: 22px;font-weight: 600;">RFA Type : <%if(rfatypeid!=null && rfatypeid.equalsIgnoreCase("-")){%><%="All"%><%}else{%><%=rfatypeid %><%} %></div>
             </div>
             </div>
              <div class="col-md-2" style="display: inline-block;float: right !important;">
                <img style="height: 2.5cm" src="data:image/png;base64,<%=lablogo%>">
             </div>
             </div>
           </div>
        </div>
        <table class="border-black" style="margin-top: 5px; margin-left: 3px; width: 1500px">
        <tr style="background-color: #C4DDFF;">
           <th style="width: 5%">SN</th>
           <th style="width: 14%">RFA Number</th>
           <th style="width: 7%">RFA Date</th>
           <th style="width: 15%">Raised By</th>
           <th style="width: 12%">Problem Statement</th>
           <th style="width: 20%">Assigned To</th>
           <th style="width: 20%">Clarification</th>
           <th style="width: 7%">Completion Date</th>
        </tr>
        <%
        int count=0;
        if(RfaActionReportList!=null && RfaActionReportList.size()>0){
        for(Object[] obj : RfaActionReportList){
        %>
        <tr>
          <td><%=++count %></td>
          <td><%if(obj[1]!=null){%><%=obj[1].toString()%><%}else{ %>-<%} %></td>
          <td><%if(obj[2]!=null){%><%=sdf.format(sdf1.parse(obj[2].toString()))%><%}else{ %>-<%} %></td>
          <td><%if(obj[14]!=null){%><%=obj[14].toString()%><%}else{ %><%=obj[15].toString()%><%} %></td>
          <td style=" text-align: justify;padding:5px;"><%if(obj[5]!=null){%><%=obj[5].toString()%><%}else{ %>-<%} %></td>
          <%-- <td style=" text-align: justify;padding:5px;"><%if(obj[10]!=null){%><%=obj[10].toString()%><%}else{ %>-<%} %></td> --%>
          <td>
			<%if(AssigneeList!=null ){ 
				for(Object[] obj1 : AssigneeList){
					if(obj1[0].toString().equalsIgnoreCase(obj[0].toString())){
					%>
			      <div style="margin-bottom:0px !important;"> <%=obj1[1].toString()+", "+obj1[2].toString() %> (<%=obj1[4].toString() %>) </div>          
			<% }}}%>
		  </td>
          <td><%if(obj[11]!=null){%><%=obj[11].toString()%><%}else{ %>-<%} %></td>
          <td><%if(obj[9]!=null){%><%=sdf.format(sdf1.parse(obj[9].toString()))%><%}else{ %>-<%} %></td>
        </tr>
        <%}} %>
        </table>
    </div>
</body>
</html>