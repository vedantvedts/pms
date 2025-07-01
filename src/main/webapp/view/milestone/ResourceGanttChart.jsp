<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">
	label{
		font-weight: bold;
		font-size: 13px;
	}
	body{
		background-color: #f2edfa;
		overflow-x:hidden !important; 
	}
	h6{
		text-decoration: none !important;
	}

	#containers {
	    width: 100%;
	    height: 100%;
	    margin: 0;
	    padding: 0;
	}

	.anychart-credits {
	   display: none;
	}

	.flex-container {
	  display: flex;
	  flex-direction: column;
	  min-height: 100vh;
	}
</style>

</head>
 
<body>
<%
	List<Object[]> employeeList = (List<Object[]>)request.getAttribute("roleWiseEmployeeList");
	List<Object[]> projectList = (List<Object[]>)request.getAttribute("projectList");
	List<Object[]> totalAssignedMainList = (List<Object[]>)request.getAttribute("totalAssignedMainList");
	List<Object[]> totalAssignedSubList = (List<Object[]>)request.getAttribute("totalAssignedSubList");
	String empId = (String)request.getAttribute("empId");
	
	FormatConverter fc = new FormatConverter();
	
	totalAssignedSubList.sort((o1, o2) -> {
	    // Null safety, if needed
	    Long p1 = o1[17] != null ? Long.parseLong(o1[17].toString()) : 0;
	    Long p2 = o2[17] != null ? Long.parseLong(o2[17].toString()) : 0;
	    int result = p1.compareTo(p2);
	    if (result != 0) return result;

	    Long s1 = o1[14] != null ? Long.parseLong(o1[14].toString()) : 0;
	    Long s2 = o2[14] != null ? Long.parseLong(o2[14].toString()) : 0;
	    result = s1.compareTo(s2);
	    if (result != 0) return result;

	    Integer t1 = o1[16] != null ? Integer.parseInt(o1[16].toString()) : 0;
	    Integer t2 = o2[16] != null ? Integer.parseInt(o2[16].toString()) : 0;
	    result = t1.compareTo(t2);
	    if (result != 0) return result;

	    String u1 = o1[15] != null ? o1[15].toString() : "";
	    String u2 = o2[15] != null ? o2[15].toString() : "";
	    return u1.compareTo(u2);
	});

	
%>
	<div class="container-fluid">
		<div class="row" style="margin: 0.5rem;">
			<div class="col-12">
        			<ul class="nav nav-pills" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
	  				<li class="nav-item" style="width: 33%;"  >
	    				<div class="nav-link active" style="text-align: center;" id="pills-tab-1" data-toggle="pill" data-target="#tab-1" role="tab" aria-controls="tab-1" aria-selected="true">
		   					<span>Resource List</span> 
	    				</div>
	  				</li>
	  				<li class="nav-item"  style="width: 33%;">
	    				<div class="nav-link" style="text-align: center;" id="pills-tab-2" data-toggle="pill" data-target="#tab-2" role="tab" aria-controls="tab-2" aria-selected="false">
	    	 				<span>Gantt Chart</span> 
	    				</div>
	  				</li>
	  				<li class="nav-item"  style="width: 33%;">
	    				<div class="nav-link" style="text-align: center;" id="pills-tab-3" data-toggle="pill" data-target="#tab-3" role="tab" aria-controls="tab-3" aria-selected="false">
	    	 				<span>Resource Progress</span> 
	    				</div>
	  				</li>
				</ul>
   			</div>
		</div>
		
		<div class="tab-content" id="pills-tabContent">
		
       		<div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="pills-tab-1">
       			<div class="row">
					<div class="col-md-12">
						<div class="card shadow-nohover">
							<div class="card-header ">  
		
								<div class="row" style="margin-top: -5px;">
									<div class="col-md-5">
										<h3>Resource List</h3>  
									</div>
									<div class="col-md-3">
									</div>
									<div class="col-md-4">
									
										<form class="form-inline" method="post" action="ResourceGanttChart.htm" name="myform" id="myform" style="float:right">
			                            	<label>Employee : &nbsp;&nbsp;&nbsp; </label>
			                            	<select class="form-control selectdee" name="empId" onchange="this.form.submit()" >
												<option selected disabled>---Select---</option>
												<%if(employeeList!=null && employeeList.size()>0) {
													for(Object[] obj : employeeList) {%>
														<option value="<%=obj[0]%>" <%if(empId.equalsIgnoreCase(obj[0]+"")) {%>selected<%} %> >
															<%=(obj[1]!=null?obj[1]:(obj[2]!=null?obj[2]:""))+" "+obj[5]+", "+obj[6] %>
														</option>
												<%} }%>
											</select>
			                            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
														
										</form>						
									</div>
								
					   			</div>	   							
		
							</div>
							
							<div class="card-body ">
								<div class="row">
									<div class="col-md-12">
										<div class="table-responsive"> 
                        					<table class="table table-bordered table-hover table-striped table-condensed" id="myTable">
					                            <thead class="center">
					                                <tr>
					                                    <th style="width: 5%;">SN</th>
					                                    <th style="width: 15%;">Project</th>
					                                    <th width="2%">Main</th>
									    				<th width="8%">Sub</th>
					                                    <th style="width: 30%;">Activity</th>
					                                    <th style="width: 10%;">Start</th>
					                                    <th style="width: 10%;">End</th>
					                                    <th style="width: 10%;">Weightage</th>
					                                    <th style="width: 10%;">Progress</th>
					                                </tr>
					                            </thead>
					                            <tbody>
					                            	<%int slno = 0;
					                            	if(totalAssignedMainList!=null && totalAssignedMainList.size()>0) { 
					                            		for(Object[] obj : totalAssignedMainList) { %>
					                            		<tr>
					                            			<td class="center"><%=++slno %></td>
					                            			<td class="center"><%=obj[14]+" ("+obj[15]+")"%></td>
					                            			<td class="center">M<%=obj[2]%></td>
															<td class="center"></td>
					                            			<td><%=obj[3]%></td>
					                            			<td class="center"><%=obj[6]!=null?fc.sdfTordf(obj[6].toString()):"-" %></td>
					                            			<td class="center"><%=obj[7]!=null?fc.sdfTordf(obj[7].toString()):"-" %></td>
					                            			<td class="center"><%=obj[13]%></td>
					                            			<td>
					                            				<%if(!obj[8].toString().equalsIgnoreCase("0")){ %>
																	<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																		<div class="progress-bar progress-bar-striped
																			<%if(obj[12].toString().equalsIgnoreCase("2")){ %>
																				bg-success
																			<%} else if(obj[12].toString().equalsIgnoreCase("3")){ %>
																				bg-info
																			<%} else if(obj[12].toString().equalsIgnoreCase("4")){ %>
																				bg-danger
																			<%} else if(obj[12].toString().equalsIgnoreCase("5")){ %>
																				bg-warning
																			<%}  %>
																			" role="progressbar" style=" width: <%=obj[8] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																			<%=obj[8] %>
																		</div> 
																	</div> 
																<%}else{ %>
																	<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																		<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																			Not Started
																		</div>
																	</div> 
																<%} %>
					                            			</td>
					                            		</tr>
					                            	<%} }%>
					                            	<%if(totalAssignedSubList!=null && totalAssignedSubList.size()>0) { 
					                            		for(Object[] obj : totalAssignedSubList) { 
					                    	   				Object[] projectDetails = projectList.stream().filter(e -> Long.parseLong(e[0].toString())== Long.parseLong(obj[17].toString())).findFirst().orElse(null);
					                            		%>
					                            		<tr>
					                            			<td class="center"><%=++slno %></td>
					                            			<td class="center"><%=projectDetails[1]+" ("+projectDetails[3]+")"%></td>
					                            			<td class="center">M<%=obj[16] %></td>
															<td class="center"><%=obj[15] %> </td>
					                            			<td><%=obj[3]%></td>
					                            			<td class="center"><%=obj[6]!=null?fc.sdfTordf(obj[6].toString()):"-" %></td>
					                            			<td class="center"><%=obj[7]!=null?fc.sdfTordf(obj[7].toString()):"-" %></td>
					                            			<td class="center"><%=obj[13]%></td>
					                            			<td>
					                            				<%if(!obj[8].toString().equalsIgnoreCase("0")){ %>
																	<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																		<div class="progress-bar progress-bar-striped
																			<%if(obj[12].toString().equalsIgnoreCase("2")){ %>
																				bg-success
																			<%} else if(obj[12].toString().equalsIgnoreCase("3")){ %>
																				bg-info
																			<%} else if(obj[12].toString().equalsIgnoreCase("4")){ %>
																				bg-danger
																			<%} else if(obj[12].toString().equalsIgnoreCase("5")){ %>
																				bg-warning
																			<%}  %>
																			" role="progressbar" style=" width: <%=obj[8] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																			<%=obj[8] %>
																		</div> 
																	</div> 
																<%}else{ %>
																	<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																		<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																			Not Started
																		</div>
																	</div> 
																<%} %>
					                            			</td>
					                            		</tr>
					                            	<%} }%>
					               				</tbody>
					               			</table>
					               		</div>		 
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>			
       		</div>	
       		
			<div class="tab-pane fade show " id="tab-2" role="tabpane2" aria-labelledby="pills-tab-2">
				<div class="row">
					<div class="col-md-12">
						<div class="card shadow-nohover">
							<div class="card-header ">  
		
								<div class="row" style="margin-top: -5px;">
									<div class="col-md-5">
										<h3>Gantt Chart</h3>  
									</div>
									<div class="col-md-4">
									
										<form class="form-inline" method="post" action="ResourceGanttChart.htm" name="myform" id="myform" style="float:right">
			                            	<label>Employee : &nbsp;&nbsp;&nbsp; </label>
			                            	<select class="form-control selectdee" name="empId" onchange="this.form.submit()" >
												<option selected disabled>---Select---</option>
												<%if(employeeList!=null && employeeList.size()>0) {
													for(Object[] obj : employeeList) {%>
														<option value="<%=obj[0]%>" <%if(empId.equalsIgnoreCase(obj[0]+"")) {%>selected<%} %> >
															<%=(obj[1]!=null?obj[1]:(obj[2]!=null?obj[2]:""))+" "+obj[5]+", "+obj[6] %>
														</option>
												<%} }%>
											</select>
			                            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
														
										</form>						
									</div>
								
									<div class="col-md-2">
										<div>
											<label>Interval : &nbsp;&nbsp;&nbsp; </label>
											<select class="form-control selectdee " name="interval" id="interval" required="required"  data-live-search="true"  style="width:150px !important; float : right;" >
			                                	<option value="quarter"> Quarterly </option>
			                                	<option value="half" >Half-Yearly</option>
			                                	<option value="year" >Yearly</option>
			                                	<option value="month"> Monthly </option>
											</select>
										</div>
									</div>
								
									<div class="col-md-1" >
										 <button type="submit" class="btn btn-sm prints" id="prints" style="float:left" onclick="ChartPrint(interval)" >Print</button> 
									</div>
									<%-- <div class="col-md-1" >
										<form method="post">
											<button type="submit" class="btn btn-sm back"  formaction="ResourceGanttChart.htm" style="float:right; background-color: #DE834D; font-weight: 600;border:0px;"  >Sub Level</button>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
										<input type="hidden" name="empId"  id="empId" value="<%=empId %>" /> 
										</form>
									</div> --%>
					   			</div>	   							
		
							</div>
							
							<div class="card-body "> 
									
								<div class="row" style="margin-top: -18px;">
										
									<div class="col-md-12" style="float: right;" >
											
										<div class="row" style="margin-top: 5px;font-weight: bold;"   >
											<div class="col-md-8"></div>
											<div class="col-md-4">
												<div style="font-weight: bold; " >
													<span style="margin:0px 0px 10px  10px;">Original :&ensp; <span style=" background-color: #4A90E2;  padding: 0px 15px; border-radius: 3px;"></span></span>
													<span style="margin:0px 0px 10px  15px;">Ongoing :&ensp; <span style=" background-color: #059212;  padding: 0px 15px;border-radius: 3px;"></span></span>
													<span style="margin:0px 0px 10px  15px;">Revised :&ensp; <span style=" background-color: #F5A623; opacity: 0.5; padding: 0px 15px;border-radius: 3px;"></span></span>
												</div>
											</div>
										</div>
											
							   			<div class="flex-container" id="containers" ></div>
		                        			
		                        	</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane fade show " id="tab-3" role="tabpane3" aria-labelledby="pills-tab-3">
       		</div>	
		</div>		
	</div>

<script>
	$(document).ready(function() {
	    $('#myTable').DataTable({
	        "lengthMenu": [5, 10, 25, 50, 75, 100],
	        "pagingType": "simple",
	        "pageLength": 5
	    });
	});
	/* anychart.onDocumentReady(function () {  */  
   	  
	function chartprint(type,interval){
		var data = [
	   		  <%int count=1; for(Object[] obj : totalAssignedMainList){ %>
	
				{
					id: "<%=obj[2]%>",
					name: "<%=obj[3]%>",
					project: "<%=obj[14]+" ("+obj[15]+")"%>",
					<%if(!obj[9].toString().equalsIgnoreCase("0") && !obj[9].toString().equalsIgnoreCase("1")){ %>
						baselineStart: "<%=obj[6]%>",
						baselineEnd: "<%=obj[7]%>", 
						baseline: {fill: "#F5A623 0.5", stroke: "0.0 #F5A623"},
						actualStart: "<%=obj[4]%>",
						actualEnd: "<%=obj[5]%>",
						actual: {fill: "#4A90E2", stroke: "0.8 #4A90E2"},
						baselineProgressValue: "<%= Math.round((int)obj[8])%>%",
						progress: {fill: "#7ED321 0.0", stroke: "0.0 #150e56"},
						progressValue: "<%= Math.round((int)obj[8])%>% ", 
					<%} else{%>
						<%-- baselineStart: "<%=obj[6]%>",
						baselineEnd: "<%=obj[7]%>",  --%>
						baselineStart: "<%=obj[4]%>",
						baselineEnd: "<%=obj[5]%>", 
						baseline: {fill: "#4A90E2", stroke: "0.8 #4A90E2"},
						baselineProgressValue: "<%= Math.round((int)obj[8])%>%",
						progress: {fill: "#7ED321 0.0", stroke: "0.0 #150e56"},
						progressValue: "<%= Math.round((int)obj[8])%>% ", 
					<%}%>
					  rowHeight: "55",
				},
			<%}%>
	   		  <%for(Object[] obj : totalAssignedSubList){ 
   				Object[] projectDetails = projectList.stream().filter(e -> Long.parseLong(e[0].toString())== Long.parseLong(obj[17].toString())).findFirst().orElse(null);
	   		  %>
	
				{
					id: "<%=obj[2]%>",
					name: "<%=obj[3]%>",
					project: "<%=projectDetails[1]+" ("+projectDetails[3]+")"%>",
					<%if(!obj[9].toString().equalsIgnoreCase("0") && !obj[9].toString().equalsIgnoreCase("1")){ %>
						baselineStart: "<%=obj[6]%>",
						baselineEnd: "<%=obj[7]%>", 
						baseline: {fill: "#F5A623 0.5", stroke: "0.0 #F5A623"},
						actualStart: "<%=obj[4]%>",
						actualEnd: "<%=obj[5]%>",
						actual: {fill: "#4A90E2", stroke: "0.8 #4A90E2"},
						baselineProgressValue: "<%= Math.round((int)obj[8])%>%",
						progress: {fill: "#7ED321 0.0", stroke: "0.0 #150e56"},
						progressValue: "<%= Math.round((int)obj[8])%>% ", 
					<%} else{%>
						<%-- baselineStart: "<%=obj[6]%>",
						baselineEnd: "<%=obj[7]%>",  --%>
						baselineStart: "<%=obj[4]%>",
						baselineEnd: "<%=obj[5]%>", 
						baseline: {fill: "#4A90E2", stroke: "0.8 #4A90E2"},
						baselineProgressValue: "<%= Math.round((int)obj[8])%>%",
						progress: {fill: "#7ED321 0.0", stroke: "0.0 #150e56"},
						progressValue: "<%= Math.round((int)obj[8])%>% ", 
					<%}%>
					  rowHeight: "55",
				},
			<%}%>
			];
		
			// create a data tree
			var treeData = anychart.data.tree(data, "as-tree");
			// create a chart
			var chart = anychart.ganttProject();
			// set the data
			chart.data(treeData);   
	    	// set the container id
	    	chart.container("containers");  
    	
    	
    	
	    	// initiate drawing the chart
	    	chart.draw();    
	    	// fit elements to the width of the timeline
	    	chart.fitAll();
		    /* ToolTip */
		    chart.getTimeline().tooltip().useHtml(true);  
		    
		    var timeline = chart.getTimeline();

			// configure labels of elements
			timeline.elements().labels().fontWeight(600);
			timeline.elements().labels().fontSize("14px");
			timeline.elements().labels().fontColor("#333333");

		    chart.getTimeline().tooltip().format(
		   		 function() {
		   		        var actualStart = this.getData("actualStart") ? this.getData("actualStart") : this.getData("baselineStart");
		   		        var actualEnd = this.getData("actualEnd") ? this.getData("actualEnd") : this.getData("baselineEnd");
		   		        var reDate=this.getData("actualStart") ;
		   		   
		   		        var html="";
		   		        if(reDate===undefined){
		   		        	html="";
		   		        	html= "<span style='font-weight:600;font-size:10pt'> Actual : " +
		   		               anychart.format.dateTime(actualStart, 'dd MMM yyyy') + " - " +
		   		               anychart.format.dateTime(actualEnd, 'dd MMM yyyy') + "</span><br>" +
		   		               "Progress: " + this.getData("baselineProgressValue") + "<br>"
		   		        }else{
		   		        	html="";
		   		        html="<span style='font-weight:600;font-size:10pt'> Actual : " +
		   		               anychart.format.dateTime(actualStart, 'dd MMM yyyy') + " - " +
		   		               anychart.format.dateTime(actualEnd, 'dd MMM yyyy') + "</span><br>" +
		   		               "<span style='font-weight:600;font-size:10pt'> Revised : " +
		   		               anychart.format.dateTime(this.getData("baselineStart"), 'dd MMM yyyy') + " - " +
		   		               anychart.format.dateTime(this.getData("baselineEnd"), 'dd MMM yyyy') + "</span><br>" +
		   		               "Progress: " + this.getData("baselineProgressValue") + "<br>"
		   		        }
		   		        
		   		        return html;
		   		    }
		      
		    ); 
    

			/* Title */
			var title = chart.title();
			title.enabled(true);
			title.text("Resource Gantt Chart");
			title.fontColor("#1976D2");  // Darker blue for better contrast
			title.fontSize(18);
			title.fontWeight(600);
			title.padding(5);


		
			/* Hover */
			chart.rowHoverFill("#FFCC80 0.3");  // Softer orange for hover
			chart.rowSelectedFill("#FFCC80 0.3");
			chart.rowStroke("0.5 #4A90E2");  // Matches Sky Blue
			chart.columnStroke("0.5 #4A90E2");  
	
			chart.defaultRowHeight(35);
			chart.headerHeight(90);
	
			/* Hiding the middle column */
			chart.splitterPosition("15.6%");
	
			var dataGrid = chart.dataGrid();
			dataGrid.rowEvenFill("#E0E0E0 0.3");  // Light gray for contrast
			dataGrid.rowOddFill("#E0E0E0 0.1");
			dataGrid.rowHoverFill("#FFD54F 0.3");  // Light yellow hover
			dataGrid.rowSelectedFill("#FFD54F 0.3");
			dataGrid.columnStroke("2 #4A90E2");  
			dataGrid.headerFill("#4A90E2 0.2");
	
			/* Title */
			var column_1 = chart.dataGrid().column(1);
			column_1.labels().fontWeight(600);
			column_1.labels().useHtml(true);
			column_1.labels().fontColor("#0D47A1");  // Dark blue for labels
	
			var column_2 = chart.dataGrid().column(1);
			column_2.title().text("Activity");
			column_2.title().fontColor("#2C3E50");  // Deep blue title
			column_2.title().fontWeight(600);
	
			var column_3 = chart.dataGrid().column(2);
			column_3.title().text("Project");
			column_3.title().fontColor("#2C3E50");
			column_3.title().fontWeight(600);
			column_3.labels().useHtml(true);
			column_3.labels().fontColor("#0D47A1");
			column_3.labels().format("{%project}");
			column_3.width(150);
			
			chart.dataGrid().column(0).width(25);
	
			chart.dataGrid().tooltip().useHtml(true);

      
   	
   	
		   	 /* Set width of column */
		   	/* chart.dataGrid().column(0).setColumnFormat(
		   		   
		   		    {
		   		      formatter: function(value) {
		   		        return value.toUpperCase();
		   		      },
		   		      textStyle: {fontColor: "#055C9D",fontWeight:"600"},
		   		      width: 10
		   		    }
		   		);   */
		   	
		/* chart.fitAll();
		   	chart.zoomTo("month", 3, "first-date"); */
		   	
		   	/* chart.getTimeline().scale().minimum("2019-01-01");
		   	chart.getTimeline().scale().maximum("2021-07-15"); */
		   	
		   	//chart.getTimeline().scale().zoomLevels([["month", "quarter","year"]]);
   	
		if(interval==="year"){
	   		/* Yearly */
	    	chart.getTimeline().scale().zoomLevels([["year"]]);
	    	var header = chart.getTimeline().header();
	    	header.level(2).format("{%value}-{%endValue}");
	    	header.level(1).format("{%value}-{%endValue}"); 
	   	}
	   	
	   	if(interval==="half"){
	   		/* Half-yearly */
	    	chart.getTimeline().scale().zoomLevels([["semester", "year"]]);
	    	var header = chart.getTimeline().header();
	    	/* header.level(2).format("{%value}-{%endValue}"); */
	    	header.level(2).format("{%value}-{%endValue}");
	    	header.level(0).format(function() {
	    			var duration = '';
	    			if(this.value=='Q1')
	    				duration='H1';
	    			if(this.value=='Q3')
	    				duration='H2'
	    		  return duration;
	    		});
	   	}
	   	
	   	if(interval==="quarter"){
	   		/* Quarterly */
	    	chart.getTimeline().scale().zoomLevels([["quarter", "semester","year"]]);
	    	var header = chart.getTimeline().header();
	    	header.level(1).format(function() {
	   			var duration = '';
	   			if(this.value=='Q1')
	   				duration='H1';
	   			if(this.value=='Q3')
	   				duration='H2'
	   		  return duration;
	   		});
	   		
	   		
	   	}
	   	
	   	if(interval==="month"){
	   		/* Monthly */
	    	chart.getTimeline().scale().zoomLevels([["month", "quarter","year"]]);
	   	}
	   	
	   	else if(interval===""){
	
	   		/* Quarterly */
	    	chart.getTimeline().scale().zoomLevels([["quarter", "semester","year"]]);
	    	var header = chart.getTimeline().header();
	    	header.level(1).format(function() {
	   			
	   			var duration = '';
	   		
	   			if(this.value=='Q1')
	   				duration='H1';
	   			if(this.value=='Q3')
	   				duration='H2'
	
	   		  return duration;
	   		});
	   		
	   	}
   	
   	
   	
	   	/* chart.getTimeline().scale().fiscalYearStartMonth(4); */
	   	
	   	/* Header */
	   	var header = chart.getTimeline().header();
	   	header.level(0).fill("#4A90E2 0.2");  // Softer Sky Blue for clarity
	   	header.level(0).stroke("#4A90E2");   // Matches Sky Blue
	   	header.level(0).fontColor("#0D47A1");  // Darker blue for better readability
	   	header.level(0).fontWeight(600);
	   	
	   	/* Marker */
	   	var marker_1 = chart.getTimeline().lineMarker(0);
	   	marker_1.value("current");
	   	marker_1.stroke("2 #FF6F00");  // Bright Orange for better visibility
	   	
	   	/* Progress */
	   	var timeline = chart.getTimeline();
	   	
	   	timeline.tasks().labels().useHtml(true);
	   	timeline.tasks().labels().format(function() {
	   		if (this.progress == 1) {
	   		    return "<span style='color:#388E3C;font-weight:bold;font-family:Lato;'>Completed</span>";  // Green for completion
	   		  } else {
	   		    return "<span style='color:#D32F2F;font-weight:bold;font-family:Lato;'></span>";  // Red for pending
	   		  }
	   	});
   	
   	
   	
  		// calculate height
	   	var traverser = treeData.getTraverser();
	      var itemSum = 0;
	      var rowHeight = chart.defaultRowHeight();
	      while (traverser.advance()){
	         if (traverser.get('rowHeight')) {
	        itemSum += traverser.get('rowHeight');
	      } else {
	      	itemSum += rowHeight;
	      }
	      if (chart.rowStroke().thickness != null) {
	      	itemSum += chart.rowStroke().thickness;
	      } else {
	        itemSum += 1;
	      }
	      }
	      itemSum += chart.headerHeight();
	      
	      //customize printing
	      var menu = chart.contextMenu();
	      
	      // To download and stuff 
	      
	     /*  menu.itemsFormatter(function(items) {
	        items['print-chart'].action = 
	      	  
	      	  function() {
	          document.getElementById('containers').style.height = String(itemSum) + 'px';
	          setTimeout(function() {
	            chart.print();
	            setTimeout(function() {
	              document.getElementById('containers').style.height = '100%';
	            },5000);
	          },1000);
	        }
	        return items;
	      });   */
	      
	      
	     // to print
	
	  	if(type==="print"){
	
	  		anychart.onDocumentReady(function () { 
	  		
	           document.getElementById('containers').style.height = String(itemSum) + 'px';
	           setTimeout(function() {
	           
	           //  anychart.exports.server("E://pmsuploadedfiles");	
	             //chart.saveAsPng(360, 500, 0.3, 'PngChart'); 
	             
	       /*       chart.saveAsJpg({"width": 360,
	           "height": 500,
	           "quality": 0.3,
	           "forceTransparentWhite": false,
	           "filename": "My Chart JPG"}); */
	             
	             
	           // chart.saveAsPdf('a4', true, 100, 100, 'PdfChart');
	             chart.print();
	             setTimeout(function() {
	               //document.getElementById('containers').style.height = '100%';
	             },3000);
	           },1000);
	         }); 
	    
	  	}
    }     
    
 /*    });  */
    
    $( document ).ready(function(){
  	  
  	  chartprint('type','');
    })
    
    
    function ChartPrint(){
  		
  	  var interval = $("#interval").val();
  	  $('#containers').empty();
  	  chartprint('print',interval);
   }
 
  </script>
										
<script>

$('#interval').on('change',function(){
	
	$('#containers').empty();
	var interval = $("#interval").val()
	chartprint('type',interval);
	
})

$('#empId').on('change',function(){
	
	$('#myform').submit();
})

</script>


</body>

</html>