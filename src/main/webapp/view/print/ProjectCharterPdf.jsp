<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Project Charter</title>
<style type="text/css">
#pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
.bold{
	font-weight: 800 !important;
}

 @page  {             
          size:    790px 1200px;
          margin-top: 49px;
          margin-left: 39px;
          margin-right: 39px;
          margin-buttom: 49px;  	
          border-top: 1px solid black;
          
          @bottom-left {          		
             content: "";
             margin-bottom: 30px;
             margin-right: 10px;
             font-size: 13px;
          }
           
           
                    
           @bottom-right  {
            content: "Page " counter(page) " of " counter(pages);
            margin-bottom: 30px;
          }
        /*    @top-right {
             content: "Annexure-I";
             margin-top: 30px;
             font-size: 13px;
          } */
          
          @top-center {
             content: "";
             margin-top: 30px;
             font-size: 13px;
          }
          
          
          @top-left {
          	margin-top: 30px;
            content: "";
            font-size: 13px;
          }               
          
 }
 
 #tabledata td:nth-child(1),
#tabledata th:nth-child(1) {
    width: 10%;
}

#tabledata td:nth-child(2),
#tabledata th:nth-child(2) {
    width: 10%;
}

/* Adjust font size */
#tabledata th,
#tabledata td {
    font-size: 14px;
}
 
#tabledata{
 margin-left : 10px;
 border-collapse : collapse;
 border : 1px solid black;
 width : 98.5%;
 
}
/* #tabledata th{
 text-align : center;
 font-size: 10px;
} */
   #tabledata th,
    #tabledata td {
        text-align: center;
        border: 1px solid black;
        padding: 5px;
        font-size: 12px;
        width: 200px;
       
    }


 p
{
	text-align: justify !important;
  	text-justify: inter-word;
}
 p,td,th
{
  word-wrap: break-word;
  word-break: normal ;
} 
 .center {
            text-align: center;
            font-size: 14px; /* Adjust the font size as needed */
           /*  color: #3366cc; */
        }
        
.projectattributetable th{
	text-align: left !important;
}
th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
	overflow-wrap: break-word;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 	overflow-wrap: break-word;
 }
</style>
</head>
<body>
<%
DecimalFormat df=new DecimalFormat("####################.##");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); 
Object[] ProjectEditData=(Object[])request.getAttribute("ProjectEditData");
Object[] ProjectEditData1=(Object[])request.getAttribute("ProjectEditData1");
List<Object[]> ProjectAssignList=(List<Object[]>)request.getAttribute("ProjectAssignList");
List<Object[]> ProjectDetail=(List<Object[]>)request.getAttribute("ProjectDetails"); 
List<Object[]> riskdatalist=(List<Object[]>)request.getAttribute("riskdatalist");
List<String> projectidlist = (List<String>)request.getAttribute("projectidlist");
int ProjectAssignListsize=ProjectAssignList.size();
String Project=(String)request.getAttribute("ProjectId");
List<Object[]> MilestoneActivityList=(List<Object[]>)request.getAttribute("MilestoneActivityList");
%>
<h5 style="color: purple;font-size: 20px">PROJECT CHARTER</h5>
<div style="border: 1px solid black;width: 100%">
<div style="font-size: 20px;background-color: purple;color: white;padding: 5px">
1. General Project Information 
</div>
			<div class="content">
												
												<table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;border: 1px solib black;" >
											
										<tr>
											
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Project Name</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=ProjectEditData[1] %></td>
											
										</tr>
										
										<tr>
											 
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Category</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=ProjectEditData[14] %></td>
										</tr>
										<tr>
											
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Date of Sanction</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=sdf.format(sdf1.parse(ProjectEditData[3].toString()))%></td>
										</tr>
										<tr>
											 
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>User</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=ProjectEditData[16] %></td>
										</tr>
</table>
</div>

<div style="font-size: 20px;background-color: purple;color: white;padding: 5px">
2. Project Team 
</div>
<div class="content">
								
								
									
					      <table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;margin-right:10px;   border-collapse:collapse;" >
					                  <tr>
											 <td style="width: 85px !important; padding: 5px; padding-left: 10px"></td>
											 <td style="width: 120px;padding: 5px; padding-left: 10px"><b> Name, Designation</b></td>
											  <!-- <td style="width:90px;padding: 5px; padding-left: 10px"><b> Department</b></td> -->
											   <td style="width: 100px;padding: 5px; padding-left: 10px"><b> Telephone</b></td>
											    <td style="width: 90px;padding: 5px; padding-left: 10px"><b> Email</b></td>
											
										</tr>
										
										
										<tr>
										<td   style="width: 125px !important; padding: 5px; padding-left: 10px">	Project Director</td>
										 <td style="width: 130px;padding: 5px; padding-left: 10px"><b><%=ProjectEditData1[28] %>, <%=ProjectEditData1[29] %></b></td>
											  <%-- <td style="width: 90px;padding: 5px; padding-left: 10px"><b> <%=ProjectEditData1[29] %></b></td> --%>
											   <td style="width: 100px;padding: 5px; padding-left: 10px"><b> <%=ProjectEditData1[30] %></b></td>
											    <td style="width: 90px;padding: 5px; padding-left: 10px"><b><%=ProjectEditData1[31] %> </b></td>
										</tr>
										
										<tr>
									 <td  rowspan="<%=ProjectAssignListsize+1 %>" style="width: 85px !important; padding: 5px; padding-left: 10px">Team Members</td>
										</tr>
										<% for(Object[]o:ProjectAssignList){%>
										<tr>
										
											 
											 
											 <td style="width: 180px;padding: 5px; padding-left: 10px"><b><%=o[3] %>, <%=o[4] %> </b></td>
											 <%--  <td style="width: 30px;padding: 5px; padding-left: 10px"><b><%=o[4] %></b></td> --%>
											   <td style="width: 100px;padding: 5px; padding-left: 10px"><b><%=o[6] %> </b></td>
											    <td style="width: 90px;padding: 5px; padding-left: 10px"><b><%=o[7] %> </b></td>
											
										
										</tr>
										<%} %>
									
									</table>
		
							</div>
							
							
<div style="font-size: 20px;background-color: purple;color: white;padding: 5px">
3. StakeHolders 
</div>
<div class="content">
						  <h4>No data avaiable</h4>
						  </div>
						  
<div style="font-size: 20px;background-color: purple;color: white;padding: 5px">
4. Project Scope Statement
</div>	
  <div class="content" >
						  
						    <table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
					               <tr>
											 <td style="width: 5px !important; padding: 5px; padding-left: 10px">(a)</td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Project Scope</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=ProjectEditData[17] %></td>
											
										</tr>
										
										<tr>
											 <td  style=" padding: 5px; padding-left: 10px">(b)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Objectives</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=ProjectEditData[4] %></td>
										</tr>
										
											<tr>
											 <td  style=" padding: 5px; padding-left: 10px">(c)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Deliverables</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=ProjectEditData[5] %></td>
										</tr>
						
		                      </table>
		                      
		                    <h5 style="margin-left: 18px"> Project Major MileStones</h5>
		                       <table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
										<tr>
											 <td style="width: 60px !important; padding: 5px; padding-left: 10px">Mil-No</td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Milestone Activity</b></td>
									
										</tr>
										<%if(MilestoneActivityList.size()>0){ %>
										<%for(Object[]o:MilestoneActivityList){ %>
										<tr>
											 <td style="width: 60px !important; padding: 5px; padding-left: 10px">Mil-<%=o[5]%></td>
											 <td style="width: 400px !important;padding: 5px; padding-left: 10px"><b><%=o[4] %></b></td>
									
										</tr>
										<%}}else{ %>
										<td colspan="2"style="text-align: center;">No data found</td>
										<%} %>
										
										</table>
		                      
		                      <h5 style="margin-left: 18px">Major Known Risk</h5>
		         
                   
                     
						
					
						    <table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
										<tr>
											 <td style="width: 400px !important; padding: 5px; padding-left: 10px">Risk</td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Risk Rating</b></td>
									
										</tr>
										<%if(riskdatalist.size()>0){ %>
									<%for(Object[]o:riskdatalist){ %>
										<tr>
											 <td style="width: 400px !important; padding: 5px; padding-left: 10px"><%=o[1] %></td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Risk</b></td>
										</tr>
									<%}}else{ %>
									<td colspan="2" style="text-align: center;">No data available</td>
									<%} %>
									</div>
									</table>
						   <h5 style="margin-left: 18px">Issues</h5>
						  <table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
										<tr>
											
											 <td style=" width: 400px !important;padding: 5px; padding-left: 10px;font-size: 15px;text-align:center;"><b>Issues</b></td>
									
										</tr>
										
										<tr>
											 
											 <td style="width: 400px !important;padding: 5px; padding-left: 10px;text-align:center;"><b>No data Available</b></td>
									
										</tr>
										</table>
						   	</div>				  
<div style="font-size: 20px;background-color: purple;color: white;padding: 5px">
5. Communication Strategy (specify how the project manager will communicate to the Executive Sponsor, Project Team members and Stakeholders, e.g., frequency of status reports, frequency of Project Team meetings, etc.
</div>
<div class="content" style="margin: 5px" >
						  No data is available
						</div>
	<div style="font-size: 20px;background-color: purple;color: white;padding: 5px">
6. Sign-off
</div>	
<div class="content" style="margin: 5px" >
						  No data is available
						</div>
					<div style="font-size: 20px;background-color: purple;color: white;padding: 5px">
6. Notes
</div>	
	<div class="content" style="margin: 5px" >
						  No data is available
						</div>			
