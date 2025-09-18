<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.roadmap.model.RoadMapAnnualTargets"%>
<%@page import="com.vts.pfms.roadmap.model.RoadMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Road Map Report</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/roadMapModule/roadMapReportExcelPreview.css" var="roadMapReportExcelPreview" />
<link href="${roadMapReportExcelPreview}" rel="stylesheet" />


</head>
<body>
<%
int startYear = Integer.parseInt((String)request.getAttribute("startYear"));
int endYear = Integer.parseInt((String)request.getAttribute("endYear"));

String[] projectIds = (String[])request.getAttribute("projectIds");
String[] initiationIds = (String[])request.getAttribute("initiationIds");

List<RoadMap> roadMapList = (List<RoadMap>)request.getAttribute("roadMapList");

List<Object[]> projectList = (List<Object[]>)request.getAttribute("projectList");
List<Object[]> preProjectList = (List<Object[]>)request.getAttribute("preProjectList");
List<Object[]> projectMilestoneActivityList = (List<Object[]>)request.getAttribute("projectMilestoneActivityList");
List<Object[]> preProjectMilestoneActivityList = (List<Object[]>)request.getAttribute("preProjectMilestoneActivityList");

Set<String> projectIdSet = projectIds!=null?new HashSet<>(Arrays.asList(projectIds)):new HashSet<>();
Set<String> initiationIdSet = initiationIds!=null?new HashSet<>(Arrays.asList(initiationIds)):new HashSet<>();

projectList = projectList.stream().filter(e -> projectIdSet.contains(e[0].toString())).collect(Collectors.toList());
preProjectList = preProjectList.stream().filter(e -> initiationIdSet.contains(e[0].toString())).collect(Collectors.toList());

%>

	<div class="mt-4">
		<form action="RoadMapReportExcelDownload.htm" method="post" class="mt-4">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<input type="hidden" name="startYear" value="<%=startYear%>">
			<input type="hidden" name="endYear" value="<%=endYear%>">
			<%
			if(projectIds!=null && projectIds.length>0){
			for(String projectId:projectIds) {%>
				<input type="hidden" name="projectIds" value="<%=projectId%>">
			<%} }%>
			<%
			if(initiationIds!=null && initiationIds.length>0){
			for(String initiationId:initiationIds) {%>
				<input type="hidden" name="initiationIds" value="<%=initiationId%>">
			<%} }%>
			
			<div class="center">
				<button type="submit" class="btn btn-sm cs-generate" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Road Map Report Excel Download">
					GENERATE EXCEL
				</button> 
			</div>
			
		</form>
		
			<h4>ROAD MAP REPORT</h4>
		<div class="table-wrapper">
			<table>
				<thead class="center">
					<tr>
						<th class="center" colspan="<%=6+(endYear-startYear)%>">
							<h4>ROAD MAP REPORT</h4>
						</th>
					</tr>
					<tr>
						<th width="3%">SN</th>
						<th width="20%">Title</th>
						<th width="25%">Aim & Objects</th>
						<th width="10%">Duration (in months)</th>
						<th width="10%">Project Type</th>
						<%for(int i=startYear;i<=endYear;i++) { %>
							<th><%=i %></th>
						<%} %>
					</tr>
				</thead>
				<tbody>
					<!-- Existing Projects -->
					<%
					int slno=0;
					if(projectList!=null && projectList.size()>0) {
						
						for(Object[] obj : projectList) {
							List<Object[]> annualTargetsDetails = projectMilestoneActivityList!=null && projectMilestoneActivityList.size()>0? projectMilestoneActivityList.stream()
																  .filter(e -> (Long.parseLong(e[0].toString())==Long.parseLong(obj[0].toString())) && (Integer.parseInt(e[2].toString().substring(0,4))>=startYear) &&  (Integer.parseInt(e[3].toString().substring(0,4))<=endYear) )
																  .collect(Collectors.toList()) : new ArrayList<Object[]>();
							if(annualTargetsDetails.size()>0) {
					%>
								<tr>
									<td width="3%" class="center"><%=++slno %></td>
									<td width="20%"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):"-" %></td>
									<td width="25%"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):"-" %></td>
									<td width="10%" class="center"><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()):"-" %></td>
									<td width="10%" class="center">Existing</td>
									<%
										for(int i=startYear;i<=endYear;i++) {
										Integer year = i;
										List<String> targetsList =  annualTargetsDetails.stream()
																	.filter(e-> year>=(Integer.parseInt(e[2].toString().substring(0,4))) && (year<=Integer.parseInt(e[3].toString().substring(0,4))) )
																	.map(e -> e[1].toString())
																	.collect(Collectors.toList());
	
										String annualTarget = targetsList.isEmpty() ? "NA" : String.join(", ", targetsList);
	
	
									%>
										<td <%if(targetsList.isEmpty()) {%> class="center"<%} %> ><%=annualTarget!=null?StringEscapeUtils.escapeHtml4(annualTarget): " - "  %></td>
									<%} %>
								</tr>
							<%} %>
						<%} %>	
					<%} %>
					
					<!-- Initiation Projects -->
					<%
					if(preProjectList!=null && preProjectList.size()>0) {
						
						for(Object[] obj : preProjectList) {
							List<Object[]> annualTargetsDetails = preProjectMilestoneActivityList!=null && preProjectMilestoneActivityList.size()>0? preProjectMilestoneActivityList.stream()
																  .filter(e -> (Long.parseLong(e[0].toString())==Long.parseLong(obj[0].toString())) && (Integer.parseInt(e[2].toString().substring(0,4))>=startYear) &&  (Integer.parseInt(e[3].toString().substring(0,4))<=endYear) )
																  .collect(Collectors.toList()) : new ArrayList<Object[]>();
							if(annualTargetsDetails.size()>0) {
					%>
								<tr>
									<td width="3%" class="center"><%=++slno %></td>
									<td width="20%"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):"-" %></td>
									<td width="25%"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):"-" %></td>
									<td width="10%" class="center"><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()):"-" %></td>
									<td width="10%" class="center">Initiation</td>
									<%
										for(int i=startYear;i<=endYear;i++) {
										Integer year = i;
										List<String> targetsList =  annualTargetsDetails.stream()
																	.filter(e-> year>=(Integer.parseInt(e[2].toString().substring(0,4))) && (year<=Integer.parseInt(e[3].toString().substring(0,4))) )
																	.map(e -> e[1].toString())
																	.collect(Collectors.toList());
	
										String annualTarget = targetsList.isEmpty() ? "NA" : String.join(", ", targetsList);
	
	
									%>
										<td <%if(targetsList.isEmpty()) {%> class="center"<%} %> ><%=annualTarget!=null?StringEscapeUtils.escapeHtml4(annualTarget): " - "  %></td>
									<%} %>
								</tr>
							<%} %>
						<%} %>	
					<%} %>
					
					<!-- Road Map (New) Projects -->
					<%
					if(roadMapList!=null) {
	
						for(RoadMap roadMap : roadMapList) {
							
							List<RoadMapAnnualTargets> roadMapAnnualTargetDetails = roadMap.getRoadMapAnnualTargets().stream()
																					.filter(e -> Integer.parseInt(e.getAnnualYear())>=startYear && Integer.parseInt(e.getAnnualYear())<=endYear && e.getIsActive()==1)
																					.collect(Collectors.toList());
							if(roadMapAnnualTargetDetails.size()>0) {
					%>
								<tr>
									<td width="3%" class="center"><%=++slno %></td>
									<td width="20%"><%=roadMap.getProjectTitle()!=null?roadMap.getProjectTitle():"-" %></td>
									<td width="25%"><%=roadMap.getAimObjectives()!=null?roadMap.getAimObjectives():"-" %></td>
									<td width="10%" class="center"><%=roadMap.getDuration() %></td>
									<td width="10%" class="center">New</td>
									<%
									for(int i=startYear;i<=endYear;i++) {
										Integer year = i;
										
										List<String> targetsList =  roadMapAnnualTargetDetails.stream()
												 					.filter(e-> year==Integer.parseInt(e.getAnnualYear()))
												 					.map(e -> e.getAnnualTargets().getAnnualTarget())
												 					.collect(Collectors.toList());
										
										String annualTarget = targetsList.isEmpty() ? "NA" : String.join(", ", targetsList);
	
									%>
										<td <%if(targetsList.isEmpty()) {%> class="center"<%} %> ><%=annualTarget!=null?StringEscapeUtils.escapeHtml4(annualTarget): " - " %></td>
									<%} %>
								</tr>
							<%} %>
						<%} %>
					<%} %>
				</tbody>
			</table>
		</div>	
	</div>
</body>
</html>