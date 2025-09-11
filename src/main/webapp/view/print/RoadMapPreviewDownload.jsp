<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.roadmap.model.RoadMapAnnualTargets"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.roadmap.model.RoadMap"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Road Map Preview</title>
<style>

.break{
	page-break-after: always;
} 

.border_black {
	border : 1px solid black;
	padding : 10px 5px;
}

    
.left{
	text-align: left
}

.right{
	text-align: right
}

.center{
	text-align: center
}


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
          size: 790px 950px;
          margin-top: 49px;
          margin-left: 39px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black; 
          
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
           @top-right {
             content: "";
             margin-top: 30px;
             font-size: 13px;
          }
          
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
       
#roadmaptable{
 margin-left : 10px;
 border-collapse : collapse;
 border : 1px solid black;
 width : 98.5%;
}
#roadmaptable th{
 text-align : left;
 font-size: 14px;
}
#roadmaptable td{
 text-align : left;
 vertical-align: top;
}
#roadmaptable td,th{
 border : 1px solid black;
 padding : 5px;
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


</style>
</head>
<body>
<%
RoadMap roadMap = (RoadMap)request.getAttribute("roadMapDetails");
Long roadMapId = roadMap.getRoadMapId();
List<RoadMapAnnualTargets> roadMapAnnualTargetDetails = null;
if(roadMap!=null) {
	roadMapAnnualTargetDetails = roadMap.getRoadMapAnnualTargets().stream().filter(e-> e.getIsActive()==1).collect(Collectors.toList());
}
List<Object[]> roadMapApprovalEmpData = (List<Object[]>)request.getAttribute("roadMapApprovalEmpData");

FormatConverter fc = new FormatConverter();
%>
	<div align="center">
   		<h4 style="font-weight: bold;margin-top: 1.5rem;">Road Map Details</h4>
	</div>
	<table id="roadmaptable">
		<tr>
			<th style="width: 20%;">Title</th>
			<td style="width: 78%;">
				<%if(roadMap.getProjectTitle()!=null) {%>
					<%=roadMap.getProjectTitle() %>
				<%} else{%>-<%} %>
			</td>
		</tr>
		<tr>
			<th>Duration (in months)</th>
			<td>
				<%if(roadMap.getDuration()!=0) {%>
					<%=roadMap.getDuration() %>
				<%} else{%>0<%} %>
			</td>
		</tr>
		<tr>
			<th>Start & End Date</th>
			<td>
				<%if(roadMap.getStartDate()!=null) {%>
					<%=fc.SqlToRegularDate(roadMap.getStartDate()) %>
				<%} %>
				&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;
				<%if(roadMap.getEndDate()!=null) {%>
					<%=fc.SqlToRegularDate(roadMap.getEndDate()) %>
				<%} %>
			</td>
		</tr>
		<tr>
			<th>Aim & Objectives</th>
			<td>
				<%if(roadMap.getAimObjectives()!=null) {%>
					<%=roadMap.getAimObjectives() %>
				<%} else{%>-<%} %>
			</td>
		</tr>
		<tr>
			<th>Scope</th>
			<td>
				<%if(roadMap.getScope()!=null) {%>
					<%=roadMap.getScope() %>
				<%} else{%>-<%} %>
			</td>
		</tr>
		<tr>
			<th>Reference</th>
			<td>
				<%if(roadMap.getReference()!=null) {%>
					<%=roadMap.getReference() %>
				<%} else{%>-<%} %>
			</td>
		</tr>
		<tr>
			<th colspan="2">Annual Targets:</th>
		</tr>
		<tr>
			<th>Year</th>
			<th>Target</th>
		</tr>
		<%if(roadMapAnnualTargetDetails!=null) { 
			int OrigAnnualYear=0,TempAnnualYear=0;
			for(RoadMapAnnualTargets target :roadMapAnnualTargetDetails) {
													 		
				OrigAnnualYear=Integer.parseInt(target.getAnnualYear());
				List<String> targetssList =  roadMapAnnualTargetDetails.stream()
											 .filter(e-> e.getAnnualYear().equalsIgnoreCase(target.getAnnualYear()))
											 .map(e -> e.getAnnualTargets().getAnnualTarget())
											 .collect(Collectors.toList());
		%>
			<%if(OrigAnnualYear!=TempAnnualYear){ %>
				<tr>
					<td>
						<%=OrigAnnualYear %>
					</td>
												
					<td>
						<%int count=1; for(String targets : targetssList) {%>
							<%if(count==1) {%>
								<%=targets!=null?targets: " - " %>
							<%} else{%>
								<%=", "+(targets!=null?targets: " - ") %>
							<%} %>
						<%count++;} %>
					</td>
            									
				</tr>
			<%} %>
		<%TempAnnualYear=OrigAnnualYear;} } %>
	</table>
										
	<!-- Signatures and timestamps -->
	<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 18px;margin-top: 30px;">
     	<div style="font-size: 15px;"> Signature of Initiator</div>
         <%for(Object[] apprInfo : roadMapApprovalEmpData){ %>
			<%if(apprInfo[8].toString().equalsIgnoreCase("RFW")){ %>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
				<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString()).substring(0, 10)  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
 		<%break;}} %>  
 	</div>
							            
	<%for(Object[] apprInfo : roadMapApprovalEmpData) {%>
		<div style="width: 96%;text-align: left;margin-left: 10px;line-height: 18px;margin-top: 20px;">
							            			 		
			<%if(apprInfo[8].toString().equalsIgnoreCase("RAD")){ %>
				<div style="font-size: 15px;"> Signature of Director</div>
				<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
				<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
				<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString()).substring(0, 10)  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
			<%} %>
		</div>	
	<%} %>
</body>
</html>