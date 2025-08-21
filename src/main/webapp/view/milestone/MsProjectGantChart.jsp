
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<spring:url value="/resources/js/exporting.js" var="export" />
<spring:url value="/resources/js/highcharts-gantt.js" var="highchartsgantt" />
<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
	<script src="${highchartsgantt}"></script>
<%--  	<script src="${export}"></script> --%>
 	<link href="${sweetalertCss}" rel="stylesheet" />
	<script src="${sweetalertJs}"></script>
<title>Gantt Chart</title>
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
List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
List<Object[]> mstaskList=(List<Object[]>)request.getAttribute("mstaskList");
Object[] projectDetails = (Object[])request.getAttribute("ProjectDetails");
String ProjectId=(String)request.getAttribute("ProjectId");
%>
	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
		
			<div class="card-header" style="background-color: transparent;height: 3rem;">
 				<div class="row">
 					<div class="col-md-7">
 						<h3 class="text-dark" style="font-weight: bold;">Gantt Chart - <%=projectDetails!=null?(projectDetails[3]!=null?StringEscapeUtils.escapeHtml4(projectDetails[3].toString()):" - "+" ("+projectDetails[1]!=null?StringEscapeUtils.escapeHtml4(projectDetails[1].toString()):" - "+")"):"" %> </h3>
 					</div>
 					<div class="col-md-3"></div>
 					<div class="col-md-2 right">
	 					<a class="btn btn-sm back" href="MSProjectMilestone.htm?ProjectId=<%=ProjectId%>">Back</a>
 					</div>
 					
 				</div>
       		</div>
       		
       		<%-- <div class="card-body">
       			<div id="container"></div>
       			<form method="post" action ="MSProjectMilestone.htm">
					<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
					<input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
					<input type="hidden" name="ProjectId" value="<%=ProjectId%>">
				</form>
       		</div> --%>
       		<div class="card-body">
       			<div class="row" style="margin-top: -18px;">
					<div class="col-md-12" style="float: right;" >
						<div class="row" style="margin-top: 5px;font-weight: bold;"   >
							<div class="col-md-8"></div>
							<div class="col-md-4">
								<div style="font-weight: bold; " >
									<span style="margin:0px 0px 10px  10px;">Original :&ensp; <span style=" background-color: #29465B;  padding: 0px 15px; border-radius: 3px;"></span></span>
									<span style="margin:0px 0px 10px  15px;">Ongoing :&ensp; <span style=" background-color: #059212;  padding: 0px 15px;border-radius: 3px;"></span></span>
									<span style="margin:0px 0px 10px  15px;">Revised :&ensp; <span style=" background-color: #f25287; opacity: 0.5; padding: 0px 15px;border-radius: 3px;"></span></span>
								</div>
							</div>
						</div>

					   	<div class="flex-container" id="containers" ></div>
                        			
                	</div>
				</div>
       		</div>
       	</div>
	</div>
	
	<script>
		/* anychart.onDocumentReady(function () {  */  
								    	  
		function chartprint(type,interval){
			var data = [
				<%
				if(mstaskList!=null && mstaskList.size()>0) {
					int count=0; 
					for(Object[] level1 : mstaskList){ 
						if(level1[8].toString().equalsIgnoreCase("1")){
				%>
								    		  
						{
							id: "<%=++count%>",
							name: "<%=level1[10]!=null?StringEscapeUtils.escapeHtml4(level1[10].toString()):" - "%>",
							<%if(level1[24]!=null &&  Integer.parseInt(level1[24].toString())!=0){ %>
								baselineStart: "<%=level1[11]%>",
								baselineEnd: "<%=level1[12]%>", 
								baseline: {fill: "#f25287 0.5", stroke: "0.0 #f25287"},
								actualStart: "<%=level1[22]%>",
								actualEnd: "<%=level1[23]%>",
				    		    actual: {fill: "#29465B", stroke: "0.8 #29465B"},
				    		    baselineProgressValue: "<%=Math.round(Integer.parseInt(level1[15].toString()))%>%",
				    		  
							<%} else{ %>
								baselineStart: "<%=level1[22]%>",
				    		    baselineEnd: "<%=level1[23]%>", 
				    		    baseline: {fill: "#29465B", stroke: "0.8 #29465B"},
				    		    baselineProgressValue: "<%=Math.round(Integer.parseInt(level1[15].toString()))%>%",
				    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
				    		    progressValue: "<%=Math.round(Integer.parseInt(level1[15].toString()))%>% ",
							<% }%>
							rowHeight: "55",
							
							/* ------------------------------------ Level-2 --------------------------------------------- */
							// Handle hierarchy by creating child nodes 
		                    children: [
		                    	<%
									int countA=0;
									for(Object[] level2 : mstaskList){
										if(level2[8].toString().equalsIgnoreCase("2") && level2[7].toString().equalsIgnoreCase(level1[6].toString())){
								%>
								
									{
										id: "<%=count+"."+(++countA)%>",
										name: "<%=level2[10]!=null?StringEscapeUtils.escapeHtml4(level2[10].toString()):" - "%>",
										<%if(level2[24]!=null &&  Integer.parseInt(level2[24].toString())!=0){ %>
											baselineStart: "<%=level2[11]%>",
											baselineEnd: "<%=level2[12]%>", 
											baseline: {fill: "#f25287 0.5", stroke: "0.0 #f25287"},
											actualStart: "<%=level2[22]%>",
											actualEnd: "<%=level2[23]%>",
							    		    actual: {fill: "#29465B", stroke: "0.8 #29465B"},
							    		    baselineProgressValue: "<%=Math.round(Integer.parseInt(level2[15].toString()))%>%",
							    		    progress: {fill: "#FF7F3E 0.0", stroke: "0.0 #FF7F3E"},
							    		    progressValue: "<%=Math.round(Integer.parseInt(level2[15].toString()))%>% ", 
										<%} else{%>
											baselineStart: "<%=level2[22]%>",
							    		    baselineEnd: "<%=level2[23]%>", 
							    		    baseline: {fill: "#29465B", stroke: "0.8 #29465B"},
							    		    baselineProgressValue: "<%=Math.round(Integer.parseInt(level2[15].toString()))%>%",
							    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
							    		    progressValue: "<%=Math.round(Integer.parseInt(level2[15].toString()))%>% ",
										<%}%> 
										rowHeight: "55",
										
										/* ------------------------------------ Level-3 --------------------------------------------- */
										// Handle hierarchy by creating child nodes 
					                    children: [
					                    	<%
												int countB=0;
												for(Object[] level3 : mstaskList){
													if(level3[8].toString().equalsIgnoreCase("3")  && level3[7].toString().equalsIgnoreCase(level2[6].toString())){
											%>
												{
													id: "<%=count+"."+countA+"."+(++countB)%>",
													name: "<%=level3[10]!=null?StringEscapeUtils.escapeHtml4(level3[10].toString()):" - "%>",
													<%if(level3[24]!=null &&  Integer.parseInt(level3[24].toString())!=0){ %>
														baselineStart: "<%=level3[11]%>",
														baselineEnd: "<%=level3[12]%>", 
														baseline: {fill: "#f25287 0.5", stroke: "0.0 #f25287"},
														actualStart: "<%=level3[22]%>",
														actualEnd: "<%=level3[23]%>",
										    		    actual: {fill: "#29465B", stroke: "0.8 #29465B"},
										    		    baselineProgressValue: "<%=Math.round(Integer.parseInt(level3[15].toString()))%>%",
										    		    progress: {fill: "#FF7F3E 0.0", stroke: "0.0 #FF7F3E"},
										    		    progressValue: "<%=Math.round(Integer.parseInt(level3[15].toString()))%>% ", 
													<%} else{%>
														baselineStart: "<%=level3[22]%>",
										    		    baselineEnd: "<%=level3[23]%>", 
										    		    baseline: {fill: "#29465B", stroke: "0.8 #29465B"},
										    		    baselineProgressValue: "<%=Math.round(Integer.parseInt(level3[15].toString()))%>%",
										    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
										    		    progressValue: "<%=Math.round(Integer.parseInt(level3[15].toString()))%>% ",
													<%}%>  
													rowHeight: "55",
													
													/* ------------------------------------ Level-4 --------------------------------------------- */
													// Handle hierarchy by creating child nodes 
								                    children: [
								                    	<%
															int countC=0;
															for(Object[] level4 : mstaskList){
																if(level4[8].toString().equalsIgnoreCase("4")  && level4[7].toString().equalsIgnoreCase(level3[6].toString())){
														%>
															{
																id: "<%=count+"."+countA+"."+countB+"."+(++countC)%>",
																name: "<%=level4[10]!=null?StringEscapeUtils.escapeHtml4(level4[10].toString()):" - "%>",
																<%if(level4[24]!=null &&  Integer.parseInt(level4[24].toString())!=0){ %>
																	baselineStart: "<%=level4[11]%>",
																	baselineEnd: "<%=level4[12]%>", 
																	baseline: {fill: "#f25287 0.5", stroke: "0.0 #f25287"},
																	actualStart: "<%=level4[22]%>",
																	actualEnd: "<%=level4[23]%>",
													    		    actual: {fill: "#29465B", stroke: "0.8 #29465B"},
													    		    baselineProgressValue: "<%=Math.round(Integer.parseInt(level4[15].toString()))%>%",
													    		    progress: {fill: "#FF7F3E 0.0", stroke: "0.0 #FF7F3E"},
													    		    progressValue: "<%=Math.round(Integer.parseInt(level4[15].toString()))%>% ", 
																<%} else{%>
																	baselineStart: "<%=level4[22]%>",
													    		    baselineEnd: "<%=level4[23]%>", 
													    		    baseline: {fill: "#29465B", stroke: "0.8 #29465B"},
													    		    baselineProgressValue: "<%=Math.round(Integer.parseInt(level4[15].toString()))%>%",
													    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
													    		    progressValue: "<%=Math.round(Integer.parseInt(level4[15].toString()))%>% ",
																<%}%>  
																rowHeight: "55",
																
																/* ------------------------------------ Level-5 --------------------------------------------- */
																// Handle hierarchy by creating child nodes 
											                    children: [
											                    	<%
																		int countD=0;
																		for(Object[] level5 : mstaskList){  
																			if(level5[8].toString().equalsIgnoreCase("5")  && level5[7].toString().equalsIgnoreCase(level4[6].toString())){
																	%>
																		{
																			id: "<%=count+"."+countA+"."+countB+"."+countC+"."+(++countD)%>",
																			name: "<%=level5[10]!=null?StringEscapeUtils.escapeHtml4(level5[10].toString()):" - "%>",
																			<%if(level5[24]!=null &&  Integer.parseInt(level5[24].toString())!=0){ %>
																				baselineStart: "<%=level5[11]%>",
																				baselineEnd: "<%=level5[12]%>", 
																				baseline: {fill: "#f25287 0.5", stroke: "0.0 #f25287"},
																				actualStart: "<%=level5[22]%>",
																				actualEnd: "<%=level5[23]%>",
																    		    actual: {fill: "#29465B", stroke: "0.8 #29465B"},
																    		    baselineProgressValue: "<%=Math.round(Integer.parseInt(level5[15].toString()))%>%",
																    		    progress: {fill: "#FF7F3E 0.0", stroke: "0.0 #FF7F3E"},
																    		    progressValue: "<%=Math.round(Integer.parseInt(level5[15].toString()))%>% ", 
																			<%} else{ %>
																				baselineStart: "<%=level5[22]%>",
																    		    baselineEnd: "<%=level5[23]%>", 
																    		    baseline: {fill: "#29465B", stroke: "0.8 #29465B"},
																    		    baselineProgressValue: "<%=Math.round(Integer.parseInt(level5[15].toString()))%>%",
																    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																    		    progressValue: "<%=Math.round(Integer.parseInt(level5[15].toString()))%>% ",
																			<% }%>   
																			rowHeight: "55",
																		
																		},
																	<% } }%>
																],
																/* ------------------------------------ Level-5 End--------------------------------------------- */
															},
														<% } }%>
													],
													/* ------------------------------------ Level-4 End --------------------------------------------- */
												},
											<% } }%>
										],
										/* ------------------------------------ Level-3 End --------------------------------------------- */
									},
								<% } }%>
							],
							/* ------------------------------------ Level-2 End --------------------------------------------- */
						},
					<%} } }%>
			];
			/* ------------------------------------ Level-1 End --------------------------------------------- */	
				
			// create a data tree
	   		var treeData = anychart.data.tree(data, "as-tree");
	
	   		// create a chart
	   		var chart = anychart.ganttProject();
	
	   		// set the data
	   		chart.data(treeData);   
	 
	   	    // set the indent for nested labels in the second column
	   	    chart.dataGrid().column(1).depthPaddingMultiplier(30);
	
	   	    // disable buttons in the second column
	   	    chart.dataGrid().column(1).collapseExpandButtons(true);
	
	   	    // enable buttons in the first column
	   	    chart.dataGrid().column(0).collapseExpandButtons(false);
	   	    
	   	    chart.dataGrid().column(2).enabled(false);
	   	    
	       	// set the container id
	       	chart.container("containers");  
	
	       	// initiate drawing the chart
	       	chart.draw();    
	
	       	// fit elements to the width of the timeline
	       	chart.fitAll();
	       	
	           var timeline = chart.getTimeline();
	
		   // configure labels of elements
		   timeline.elements().labels().fontWeight(600);
		   timeline.elements().labels().fontSize("14px");
		   timeline.elements().labels().fontColor("#FF6F00");
	    
	        
	        /* ToolTip */
	        chart.getTimeline().tooltip().useHtml(true);    
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
			title.text("<%=projectDetails[2] %> ( <%=projectDetails[1] %> ) Gantt Chart");
			title.fontColor("#64b5f6");
			title.fontSize(18);
			title.fontWeight(600);
			title.padding(5);
	     
			
	        
	        /* Hover */
	        
	        chart.rowHoverFill("#8fd6e1 0.3");
	        chart.rowSelectedFill("#8fd6e1 0.3");
	        chart.rowStroke("0.5 #64b5f6");
	        chart.columnStroke("0.5 #64b5f6");
	      
	        
	        chart.defaultRowHeight(35);
	     	chart.headerHeight(90);
	     	
	     	/* Hiding the middle column */
	     	chart.splitterPosition("15.6%");
	     	
	     	var dataGrid = chart.dataGrid();
	     	dataGrid.rowEvenFill("gray 0.3");
	     	dataGrid.rowOddFill("gray 0.1");
	     	dataGrid.rowHoverFill("#ffd54f 0.3");
	     	dataGrid.rowSelectedFill("#ffd54f 0.3");
	     	dataGrid.columnStroke("2 #64b5f6");
	     	dataGrid.headerFill("#64b5f6 0.2");
	     	
	     
	     	/* Title */
	
	     	var column_1 = chart.dataGrid().column(1);
	     	column_1.labels().fontWeight(600);
	     	column_1.labels().useHtml(true);
	     	column_1.labels().fontColor("#055C9D");
	     	
	     	
	     	var column_2 = chart.dataGrid().column(1);
	     	column_2.title().text("Activity");
	     	column_2.title().fontColor("#145374");
	     	column_2.title().fontWeight(600);
	     	
	     	chart.dataGrid().column(0).width(25);
	     	
	     	chart.dataGrid().tooltip().useHtml(true);    
	        
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
		     	header.level(2).format("{%value}-{%endValue}");
		     	var header = chart.getTimeline().header();
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
	     	header.level(0).fill("#64b5f6 0.2");
	     	header.level(0).stroke("#64b5f6");
	     	header.level(0).fontColor("#145374");
	     	header.level(0).fontWeight(600);
	     	
	     	/* Marker */
	     	var marker_1 = chart.getTimeline().lineMarker(0);
	     	marker_1.value("current");
	     	marker_1.stroke("2 #dd2c00");
	     	
	     	/* Progress */
	     	var timeline = chart.getTimeline();
	     	
	     	timeline.tasks().labels().useHtml(true);
	     	timeline.tasks().labels().format(function() {
	     	  if (this.progress == 1) {
	     	    return "<span style='color:orange;font-weight:bold;font-family:'Lato';'></span>";
	     	  } else {
	     	    return "<span style='color:black;font-weight:bold'></span>";
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
	
	</script>


<%-- <script type="text/javascript">
var today = new Date(),
day = 1000 * 60 * 60 * 24;

//Set to 00:00:00:000 today
today.setUTCHours(0);
today.setUTCMinutes(0);
today.setUTCSeconds(0);
today.setUTCMilliseconds(0);
var dynamicData = [];

<% for(Object[]obj: mstaskList){%>
		dynamicData.push({
			id : '<%=obj[6].toString()%>',
			name : '<%=obj[6].toString()%>',
			
	
			start: Date.UTC(2014, 10, 27),
	        end: Date.UTC(2017, 10, 29),
	        completed: 0.25
		});

<%}%>

var   msTaskJs = <%=jsonArray%>;

console.log(msTaskJs);

var myData = [];

for(var i =0;i<msTaskJs.length;i++){
	 var startdate = new Date(msTaskJs[i][11]);
	 var endDate = new Date(msTaskJs[i][12]);
	 
	 var year1 = startdate.getUTCFullYear();
	 var month1 = startdate.getUTCMonth(); // Months are zero-based
	 var day1 = startdate.getUTCDate()+1;
	 
	 var year2 = endDate.getUTCFullYear();
	 var month2 = endDate.getUTCMonth();
	 var day2 = endDate.getUTCDate()+1;
	if(msTaskJs[i][8]===1){
		myData.push({
			id:msTaskJs[i][6],
			name:msTaskJs[i][6],
			start: Date.UTC(year1, month1, day1),
            end: Date.UTC(year2, month2, day2),
            completed: parseInt(msTaskJs[i][15])/100
		})
		/*  level 2 */
		for(var j=0;j<msTaskJs.length;j++){
			 var startdate1 = new Date(msTaskJs[j][11]);
			 var endDate1 = new Date(msTaskJs[j][12]);
			 
			 var year3 = startdate1.getUTCFullYear();
			 var month3 = startdate1.getUTCMonth(); // Months are zero-based
			 var day3 = startdate1.getUTCDate()+1;
			 
			 var year4 = endDate1.getUTCFullYear();
			 var month4 = endDate1.getUTCMonth();
			 var day4 = endDate1.getUTCDate()+1;
			
			if(msTaskJs[j][8]===2 && msTaskJs[i][6]===msTaskJs[j][7]){
				
				myData.push({
					id:msTaskJs[j][6],
					name:msTaskJs[j][6],
					start: Date.UTC(year3, month3, day3),
		            end: Date.UTC(year4, month4, day4),
		            parent: msTaskJs[j][7],
		            completed: parseInt(msTaskJs[j][15])/100
				})
				
				/* level 3  */
				for( var k =0;k<msTaskJs.length;k++){
					 var startdate1 = new Date(msTaskJs[k][11]);
					 var endDate1 = new Date(msTaskJs[k][12]);
					 
					 var year3 = startdate1.getUTCFullYear();
					 var month3 = startdate1.getUTCMonth(); // Months are zero-based
					 var day3 = startdate1.getUTCDate()+1;
					 
					 var year4 = endDate1.getUTCFullYear();
					 var month4 = endDate1.getUTCMonth();
					 var day4 = endDate1.getUTCDate()+1;
					if(msTaskJs[k][8]===3 && msTaskJs[j][6]===msTaskJs[k][7]){
						
						myData.push({
							id:msTaskJs[k][6],
							name:msTaskJs[k][6],
							start: Date.UTC(year3, month3, day3),
				            end: Date.UTC(year4, month4, day4),
				            parent: msTaskJs[k][7],
				            completed: parseInt(msTaskJs[k][15])/100
						})
						/* level 4  */
						
					for( var x=0; x<msTaskJs.length;x++){
						
						 var startdate1 = new Date(msTaskJs[x][11]);
						 var endDate1 = new Date(msTaskJs[x][12]);
						 
						 var year3 = startdate1.getUTCFullYear();
						 var month3 = startdate1.getUTCMonth(); // Months are zero-based
						 var day3 = startdate1.getUTCDate()+1;
						 
						 var year4 = endDate1.getUTCFullYear();
						 var month4 = endDate1.getUTCMonth();
						 var day4 = endDate1.getUTCDate()+1;
						
							if(msTaskJs[x][8]===4 && msTaskJs[k][6]===msTaskJs[x][7]){
								
								myData.push({
									id:msTaskJs[x][6],
									name:msTaskJs[x][6],
									start: Date.UTC(year3, month3, day3),
						            end: Date.UTC(year4, month4, day4),
						            parent: msTaskJs[x][7],
						            completed: parseInt(msTaskJs[x][15])/100
								})
								
							}
						 
					}	
						
					}
					
				}
				
				
			}
		}
		
	}
	
}



if(myData.length>0){ 
    Highcharts.ganttChart('container', {
    	
        title: {
            text: 'Gantt Chart '
        },
        
        xAxis: {
            min: Date.UTC(2018, 1, 27),
            max: Date.UTC(2030, 10, 29)
        },
        series: [{
            name: 'MTR-16',
            data: myData
        }
        ,]
    });
	}else{
		Swal.fire({
			  icon: "error",
			  title: "Oops...",
			  text: "No Data Found for this Project ",
			  allowOutsideClick :false
			});
	}
$('.swal2-confirm').click(function (){
	console.log("GHagshgaj")
	$('#submit').click(); 
})
</script> --%>


</body>
</html>

