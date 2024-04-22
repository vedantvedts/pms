<%@page import="com.vts.pfms.roadmap.model.RoadMapAnnualTargets"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.roadmap.model.RoadMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Report</title>
<style type="text/css">
.break {
	page-break-after: always;
}

@page {
	size: 1500px 750px;
	margin-top: 49px;
	margin-left: 55px;
	margin-right: 55px;
	margin-buttom: 49px;

}

#tabledata{
 margin-left : 10px;
 margin-top : 10px;
 border-collapse : collapse;
 border : 1px solid black;
 width : 98.5%;
}
#tabledata th{
 text-align : center;
 font-size: 14px;
}
#tabledata td{
 text-align : left;
}
#tabledata td,th{
 border : 1px solid black;
 padding : 7px;
}

</style>
</head>
<body>
<%
List<RoadMap> roadMapList = (List<RoadMap>)request.getAttribute("roadMapList");
Integer startYear = Integer.parseInt((String)request.getAttribute("startYear")) ;
Integer endYear = Integer.parseInt((String)request.getAttribute("endYear")) ;

%>

	<table id="tabledata">
		<thead>
			<tr>
			<th>SN</th>
			<th>Title</th>
			<th>Aim & Objectives</th>
			<th>Duration <br> (In months) </th>
			<%for(int i=startYear;i<=endYear;i++) {%>
			<th><%=i %></th>
			<%} %>
		</tr>
		</thead>
		<tbody>
			<%	if(roadMapList!=null) {
					int slno=0;
					for(RoadMap roadMap : roadMapList) {
						List<RoadMapAnnualTargets> roadMapAnnualTargetDetails = roadMap.getRoadMapAnnualTargets().stream()
																				.filter(e -> Integer.parseInt(e.getAnnualYear())>=startYear && Integer.parseInt(e.getAnnualYear())<=endYear && e.getIsActive()==1)
																				.collect(Collectors.toList());
			%>
			<%if(roadMapAnnualTargetDetails.size()>0) {%>
			<tr>
				<td style="text-align: center;"><%=++slno %></td>
				<td><%=roadMap.getProjectTitle() %></td>
				<td><%=roadMap.getAimObjectives() %></td>
				<td style="text-align: center;"><%=roadMap.getDuration() %></td>
				
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
						<td>
							<%int count=1; for(String targets : targetssList) {%>
								<%if(count==1) {%>
									<%=targets %>
								<%} else{%>
									<%=", "+targets %>
								<%} %>
							<%count++;} %>
						</td>
	            									
				<%} %>
				<%TempAnnualYear=OrigAnnualYear;} } %>
				<% int size = roadMapAnnualTargetDetails.size()/2;
					if(size!=5) {
						for(int i=1;i<=5-size;i++) {
				%>
					<td style="text-align: center;">NA</td>
				<%} }%>
			</tr>
			<%} } }%>
		</tbody>
		
	</table>
</body>
</html>