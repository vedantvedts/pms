<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Para Details</title>
<%
String lablogo = (String)request.getAttribute("lablogo");
Object[] projectDetails = (Object[])request.getAttribute("projectDetails");
Object[] sqrFile = (Object[])request.getAttribute("SQRFile");
Object[] LabList = (Object[])request.getAttribute("LabList");
List<Object[]> ParaDetails = (List<Object[]>)request.getAttribute("ParaDetails");
%>
<style>

 #pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
		@page{             
          size: 790px 1050px;
          margin-top: 49px;
          margin-left: 49px;
          margin-right: 49px;
          margin-buttom: 49px; 	
          border: 2px solid black;    
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
          
          @top-right {
         	 content : "Project : <%=projectDetails!=null && projectDetails[2]!=null?projectDetails[2]:"-" %>";
             margin-top: 30px;
             margin-right: 10px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
   		   
          }            
           @top-left {
          	margin-top: 30px;
            margin-left: 10px;
          <%--   content: "<%=Labcode%>"; --%>
          }  
          @top-center { 
          font-size: 13px;
          margin-top: 30px;
          
          }  
          @bottom-center { 
          font-size: 13px;
           margin-bottom: 30px;
         
          }
          @bottom-left { 
           font-size: 13px;
	        margin-bottom: 30px;
	      content: "<%=projectDetails!=null && projectDetails[12]!=null?projectDetails[12]:"-"%>"; 
          }   
 }
 .border-black{
	 border:1px solid black !important;
	 border-collapse: collapse !important;
 }
 .border-black td th{
	 padding:0px !important;
	 margin: 0px !important;
 }
 p{
	 text-align: justify !important;
	 padding:12px;
 }
 span{
	 background: white !important;
	 color:black;
 }

#sqrfiledata{
	/* margin-left: 8px; */
	width: 100%;
	padding: 5px; 
} 
#sqrfiledata td, #sqrfiledata th{
	text-align: left;
	white-space: normal;
	vertical-align: top;
} 

</style>
</head>
<body>
	<div style="page-break-before:always"></div> 
	<div style="text-align: center;width: 650px !important;">
		<h3 style="text-transform:uppercase;">DRAFT GENERAL STAFF QUALITATIVE REQUIREMENT FOR 
			<%=projectDetails!=null && projectDetails[3]!=null?projectDetails[3]:"-" %> (<%=projectDetails!=null && projectDetails[2]!=null?projectDetails[2]:"-" %>)
		</h3>
		<!-- <hr style="width:80%;"> -->
		
		<div style="">
		
		<%int slno=0; %>
		<table id="sqrfiledata">
			<tr>
				<th align="center" style="width: 2%;"><%=++slno %>.</th>
				<th style="width: 49%;">&nbsp;&nbsp;Ref to General Staff Policy Statement No.</th>
				<td style="width: 1%;">:</td>
				<td style="width: 48%;"><%=sqrFile!=null && sqrFile[1]!=null?sqrFile[1]:"-" %></td>
			</tr>
			<tr>
				<th align="center"><%=++slno %>.</th>
				<th>&nbsp;&nbsp;SQR No.</th>
				<td>:</td>
				<td><%=sqrFile!=null && sqrFile[6]!=null?sqrFile[6]:"-" %></td>
			<tr>
				<th align="center"><%=++slno %>.</th>
				<th>&nbsp;&nbsp;Other Previous SQR No.</th>
				<td>:</td>
				<td><%=sqrFile!=null && sqrFile[8]!=null?sqrFile[8]:"-" %></td>
			</tr>
			<tr>
				<th align="center"><%=++slno %>.</th>
				<th>&nbsp;&nbsp;Ref of Meeting</th>
				<td style="vertical-align: top;">:</td>
				<td style="vertical-align: top;"><%=sqrFile!=null && sqrFile[9]!=null?sqrFile[9]:"-" %></td>
			</tr>
			<tr>
				<th align="center"><%=++slno %>.</th>
				<th>&nbsp;&nbsp;Line Directorate File No.</th>
				<td>:</td>
				<td><a href="SQRDownload.htm?reqInitiationId=<%=sqrFile[2]%>" target="blank">Download</a></td>
			</tr>
			<tr>
				<th align="center"><%=++slno %>.</th>
				<th>&nbsp;&nbsp;Nomenclature</th>
				<td>:</td>
				<td>
					<%=projectDetails!=null && projectDetails[3]!=null?projectDetails[3]:"-" %> (<%=projectDetails!=null && projectDetails[2]!=null?projectDetails[2]:"-" %>)
				</td>
			</tr>
			<tr>
				<th align="center"><%=++slno %>.</th>
				<th>&nbsp;&nbsp;Security Classification</th>
				<td>:</td>
				<td><%=projectDetails!=null && projectDetails[12]!=null?projectDetails[12]:"-"%></td>
			</tr>
			<tr>
				<th align="center"><%=++slno %>.</th>
				<th>&nbsp;&nbsp;Priority for Development</th>
				<td>:</td>
				<td><%=sqrFile!=null && sqrFile[10]!=null?(sqrFile[10].toString().equalsIgnoreCase("E")?"Early":(sqrFile[10].toString().equalsIgnoreCase("I")?"Immediate":"Late")):"-" %></td>
			</tr>
		</table>
		
		<h4 style="text-decoration: underline;">INTRODUCTION AND OPERATIONAL EMPLOYEMENT OF EQUIPMENT</h4>
		<%if(!ParaDetails.isEmpty()) {
			int count=0;
			for(Object[]obj:ParaDetails){
		%>
				<div align="left" style="padding:10px">
					<span style="font-weight: 600; ">
						<%=++slno %>. &nbsp;&nbsp;Para<%="-"+(++count) %>- <%=obj[3].toString() %> 
					</span>
				</div>
				<%if(obj[4]!=null){ %>
					<%=obj[4]%>
				<%}else {%>
					No Details added
				<%} %>
		<%} }%>
		
		</div>
	</div>
</body>
</html>