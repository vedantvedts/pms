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
Object[] DocTempAtrr=(Object[])request.getAttribute("DocTempAttributes");
String FontFamily="Times New Roman";
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
          margin-left: 70px;
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
          @left-top {
          	content: element(pageHeader);
            font-size: 13px;
            
          } 
          @bottom-left { 
           font-size: 13px;
	       margin-bottom: 30px;
	       content: "<%=projectDetails!=null && projectDetails[12]!=null?projectDetails[12]:"-"%>"; 
          }   
 }
 #headerdiv {
  position: running(pageHeader); /* This will be used for paged media */
  justify-content: space-between; /* Distribute space between items */
  align-items: center; /* Align items vertically in the center */
  padding: 10px; /* Add some padding */
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

<div id="headerdiv">
	<div style="position: absolute; top: 470px; left:-400px;  transform: rotate(-90deg); font-size: 7px; color: #000; width:900px;opacity:0.5; ">
				  <!--   <b style="font-size: 12px;text-decoration: underline;">RESTRICTION ON USE, DUPLICATION OR DISCLOSURE OF PROPRIETARY INFORMATION</b><br>
				    <span style="text-decoration: none; font-size: 11px;">This document contains information, which is the sole property of LRDE, DRDO. The document is submitted to the recipient for his use only. The recipient undertakes not to duplicate the document or to disclosure in part of or the whole of any of the information contained herein to any third party without receiving beforehand, written permission from the submitter. If you are not the intended recipient please notify the sender at director <a href="@lrde.gov.in" target="_blank">@lrde.gov.in</a> immediately and destroy all copies of this document.</span> -->
				<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString() %> <%} %>
				
				</div>
   </div>
 <div class="heading-container" style="text-align: center; position: relative;">
</div>

<br><br><br><br><br><br><br><br><br><br><br><br>
			<div align="center"></div>
			<div style="text-align: center; margin-top: 75px;">
				<h4 style="font-size: 18pt;;font-family:""; !important;" class="heading-color ">QR PARA  </h4>
					<div align="center" >
						<img class="logo" style="width: 80px; height: 80px; margin-bottom: 5px"
							<%if (lablogo != null) {%> src="data:image/png;base64,<%=lablogo%>" alt="Configuration"
							<%} else {%> alt="File Not Found" <%}%>>
				</div>
				<br> <br>
				<div align="center">
					<h4 style="font-size: 20px;font-family: "";">
				<%
				if(LabList!=null && LabList[1] != null) {
				%>
				<%=LabList[1].toString()+"("+LabList[0].toString()+")"%>
				<%
				}else {
				%>-<%
				}
				%>
					</h4>
					<h4 style="font-family: "";">
						Government of India, Ministry of Defence<br>Defence Research
						& Development Organization
					</h4>
				</div>
				<h4 style="font-family: "";">
					<%if(LabList!=null && LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %>
					<%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %>
					<%}else{ %>
					-
					<%} %>
				</h4>
<%-- <div style="text-align: right;margin-right:20px;">
    <span style="font-weight: bold;font-family: "";"><%= month.toString().substring(0,3) %> <%= year %></span>
   </div> --%>
   <br><br><br>

			</div>
			<br>
	<div style="page-break-before:always"></div> 
	<div style="text-align: center;width: 645px !important;padding:10px;">
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
			<div style="page-break-before:always"></div> 
		<h4 style="text-decoration: underline;">INTRODUCTION AND OPERATIONAL EMPLOYEMENT OF EQUIPMENT</h4>
		<%if(!ParaDetails.isEmpty()) {
			int count=0;
			for(Object[]obj:ParaDetails){
		%>
				<div align="left" style="padding:4px;">
					<span style="font-weight: 600; ">
						 <%=obj[3].toString() %> 
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