
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

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
  String ProjectId=(String)request.getAttribute("ProjectId");
  
  List<Object[]> MilestoneActivityMain=(List<Object[]>)request.getAttribute("MilestoneActivityMain");
  List<Object[]> MilestoneActivityA=(List<Object[]>)request.getAttribute("MilestoneActivityA");
  List<Object[]> MilestoneActivityB=(List<Object[]>)request.getAttribute("MilestoneActivityB");
  List<Object[]> MilestoneActivityC=(List<Object[]>)request.getAttribute("MilestoneActivityC");
  List<Object[]> MilestoneActivityD=(List<Object[]>)request.getAttribute("MilestoneActivityD");
  List<Object[]> MilestoneActivityE=(List<Object[]>)request.getAttribute("MilestoneActivityE");



 %>
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header ">  

					<div class="row">
						<h3 class="col-md-4">
							Gantt Chart
						</h3>  
						<div class="col-md-3 justify-content-end">
						
							<form class="form-inline" method="post" action="GanttChart.htm" name="myform" id="myform" style="float:right">
                            	<label>Project : &nbsp;&nbsp;&nbsp; </label>
                            	<select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId" style="width:220px !important">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ProjectList) {%>
										<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>><%=obj[1]%> </option>
											<%} %>
  								</select>
                            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								<input type="hidden" name="ProjectId"  id="ProjectId" value="<%=ProjectId %>" /> 
											
							</form>						
						</div>
						
						<div class="col-md-3 justify-content-end" style="float:right">
							<label>Interval : &nbsp;&nbsp;&nbsp; </label>
							<select class="form-control selectdee " name="interval" id="interval" required="required"  data-live-search="true"  style="width:150px !important" >
                                <option value="quarter"> Quarterly </option>
                                <option value="half" >Half-Yearly</option>
                                <option value="year" >Yearly</option>
                            	<option value="month"> Monthly </option>
							</select>
						</div>
						
							
							<div class="col-md-2">
								<form action="GanttChart.htm" method="post" style="float: right;">
									<button type="submit" class="btn btn-info btn-sm shadow-nohover back"   >Back</button>		
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									<input type="hidden" name="ProjectId"  id="ProjectId" value="<%=ProjectId %>" /> 
								</form>			
							</div>
			   		</div>	   							

					</div>
						<div class="card-body " style="padding: 10px;"> 
							
								<div class="row" style="margin-bottom: 5px;font-weight: bold;"   >
										<div class="col-md-4"></div>
										<div class="col-md-4"></div>
										<div class="col-md-4">
											<div style="font-weight: bold; " >
												<span style="margin:0px 0px 10px  10px;">Original :&ensp; <span style=" background-color: #046582;  padding: 0px 15px; border-radius: 3px;"></span></span>
												<span style="margin:0px 0px 10px  15px;">Ongoing :&ensp; <span style=" background-color: #81b214;  padding: 0px 15px;border-radius: 3px;"></span></span>
												<span style="margin:0px 0px 10px  15px;">Revised :&ensp; <span style=" background-color: #f25287; opacity: 0.5; padding: 0px 15px;border-radius: 3px;"></span></span>
											</div>
										</div>
									</div>
							<div class="row" >
								
								<div class="col-md-12" style="float: right;" align="center">
							
					   				<div class="flex-container" id="containers" ></div>

                        		</div>
						   	</div>
						
						</div>
					
				</div>
					
		
		</div>
	</div>
</div>

<script>

$('#interval').on('change',function(){
	
	$('#containers').empty();
	var interval = $("#interval").val()
	chartprint('type',interval);
	
})

$('#ProjectId').on('change',function(){
	
	$('#myform').submit();
})

</script>

									<script>
								      /* anychart.onDocumentReady(function () {  */  
								    	  
									function chartprint(type,interval){


								    	var data = [
								    		  
								    	<% for(Object[] obj : MilestoneActivityMain){ %>
								    	
								    	  {
								    		  
								    		 
								    		    id: "<%=obj[0]%>",
								    		    name: "<%=obj[2]%>",
								    		    <%if(!obj[8].toString().equalsIgnoreCase("0")){%>
								    		    baselineStart: "<%=obj[3]%>",
								    		    baselineEnd: "<%=obj[4]%>",
								    		    baseline: {fill: "#f25287 0.5", stroke: "0.5 #dd2c00"},
								    		    <%}%>
								    		    
								    		    actualStart: "<%=obj[5]%>",
								    		    actualEnd: "<%=obj[6]%>",
								    		    actual: {fill: "red", stroke: "0.8 #150e56"},
								    		    baselineProgressValue: "<%= Math.round((int)obj[7])%>%",
								    		    progressValue: "<%= Math.round((int)obj[7])%>%",
								    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
								    		    rowHeight: "35",	
								    		
								    		    
								  /* ----------------------------------------------------- LEVEL A ---------------------------------------------------- */
								    		    children: [
								    		    <% for(Object[] objA : MilestoneActivityA){ %>
								    		    		
								    		   		<% if(obj[0].toString().equalsIgnoreCase(objA[1].toString()) ) {%>	
								    		   			{
											    		    id: "<%=obj[0]%>_<%=objA[0]%>",
											    		    name: "<%=objA[2]%>",
											    		    <%if(!objA[8].toString().equalsIgnoreCase("0")){%>
											    		    baselineStart: "<%=objA[3]%>",
											    		    baselineEnd: "<%=objA[4]%>",
											    		    baseline: {fill: "#f25287 0.5", stroke: "0.5 #dd2c00"},
											    		    <%}%>
											    		    
											    		    actualStart: "<%=objA[5]%>",
											    		    actualEnd: "<%=objA[6]%>",
											    		    actual: {fill: "#046582", stroke: "0.8 #150e56"},
											    		    baselineProgressValue: "<%= Math.round((int)objA[7])%>%",
											    		    progressValue: "<%= Math.round((int)objA[7])%>%",
											    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
											    		    rowHeight: "35",
											    
											    		    
											 		/* ----------------------------------------------------- LEVEL B ---------------------------------------------------- */
											    		    children: [
												    		    <% for(Object[] objB : MilestoneActivityB){ %>
												    		    		
												    		   		<% if(objA[0].toString().equalsIgnoreCase(objB[1].toString()) ) {%>	
												    		   			{
															    		    id: "<%=objA[0]%>_<%=objB[0]%>",
															    		    name: "<%=objB[2]%>",
															    		    <%if(!objB[8].toString().equalsIgnoreCase("0")){%>
															    		    baselineStart: "<%=objB[3]%>",
															    		    baselineEnd: "<%=objB[4]%>",
															    		    baseline: {fill: "#f25287 0.5", stroke: "0.5 #dd2c00"},
															    		    <%}%>
															    		    
															    		    actualStart: "<%=objB[5]%>",
															    		    actualEnd: "<%=objB[6]%>",
															    		    actual: {fill: "#046582", stroke: "0.8 #150e56"},
															    		    progressValue: "<%= Math.round((int)objB[7])%>%",
															    		    baselineProgressValue: "<%= Math.round((int)objB[7])%>%",
															    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
															    		    rowHeight: "35",
															    		    
															  		/* ----------------------------------------------------- LEVEL C ---------------------------------------------------- */    		    
															    		    children: [
																    		    <% for(Object[] objC : MilestoneActivityC){ %>
																    		    		
																    		   		<% if(objB[0].toString().equalsIgnoreCase(objC[1].toString()) ) {%>	
																    		   			{
																			    		    id: "<%=objB[0]%>_<%=objC[0]%>",
																			    		    name: "<%=objC[2]%>",
																			    		    <%if(!objC[8].toString().equalsIgnoreCase("0")){%>
																			    		    baselineStart: "<%=objC[3]%>",
																			    		    baselineEnd: "<%=objC[4]%>",
																			    		    baseline: {fill: "#f25287 0.5", stroke: "0.5 #dd2c00"},
																			    		    <%}%>
																			    		    
																			    		    actualStart: "<%=objC[5]%>",
																			    		    actualEnd: "<%=objC[6]%>",
																			    		    actual: {fill: "#046582", stroke: "0.8 #150e56"},
																			    		    progressValue: "<%= Math.round((int)objC[7])%>%",
																			    		    baselineProgressValue: "<%= Math.round((int)objB[7])%>%",
																			    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																			    		    rowHeight: "35",
																			    		    
																			/* ----------------------------------------------------- LEVEL D ---------------------------------------------------- */  		    
																			    		    children: [
																				    		    <% for(Object[] objD : MilestoneActivityD){ %>
																				    		    		
																				    		   		<% if(objC[0].toString().equalsIgnoreCase(objD[1].toString()) ) {%>	
																				    		   			{
																							    		    id: "<%=objC[0]%>_<%=objD[0]%>",
																							    		    name: "<%=objD[2]%>",
																							    		    <%if(!objD[8].toString().equalsIgnoreCase("0")){%>
																							    		    baselineStart: "<%=objD[3]%>",
																							    		    baselineEnd: "<%=objD[4]%>",
																							    		    baseline: {fill: "#f25287 0.5", stroke: "0.5 #dd2c00"},
																							    		    <%}%>
																							    		    
																							    		    actualStart: "<%=objD[5]%>",
																							    		    actualEnd: "<%=objD[6]%>",
																							    		    actual: {fill: "#046582", stroke: "0.8 #150e56"},
																							    		    progressValue: "<%= Math.round((int)objD[7])%>%",
																							    		    baselineProgressValue: "<%= Math.round((int)objD[7])%>%",
																							    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																							    		    rowHeight: "35",
																							    		    
																					/* ----------------------------------------------------- LEVEL E ---------------------------------------------------- */				    		    
																							    		    children: [
																								    		    <% for(Object[] objE : MilestoneActivityE){ %>
																								    		    		
																								    		   		<% if(objD[0].toString().equalsIgnoreCase(objE[1].toString()) ) {%>	
																								    		   			{
																											    		    id: "<%=objD[0]%>_<%=objE[0]%>",
																											    		    name: "<%=objE[2]%>",
																											    		    <%if(!objE[8].toString().equalsIgnoreCase("0")){%>
																											    		    baselineStart: "<%=objE[3]%>",
																											    		    baselineEnd: "<%=objE[4]%>",
																											    		    baseline: {fill: "#f25287 0.5", stroke: "0.5 #dd2c00"},
																											    		    <%}%>
																											    		    
																											    		    actualStart: "<%=objE[5]%>",
																											    		    actualEnd: "<%=objE[6]%>",
																											    		    actual: {fill: "#046582", stroke: "0.8 #150e56"},
																											    		    progressValue: "<%= Math.round((int)objE[7])%>%",
																											    		    baselineProgressValue: "<%= Math.round((int)objE[7])%>%",
																											    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																											    		    rowHeight: "35",
																											    		    
																								    		   			},
																								    		    	<%}%>
																								    		    
																								    		    
																								    		    <% } %>
																								    	  		] 
																					/* ----------------------------------------------------- LEVEL E ---------------------------------------------------- */
																							    		    
																				    		   			},
																				    		    	<%}%>
																				    		    
																				    		    
																				    		    <% } %>
																				    	  		] 
																			/* ----------------------------------------------------- LEVEL D ---------------------------------------------------- */   		    
																			    		    
																    		   			},
																    		    	<%}%>
																    		    
																    		    
																    		    <% } %>
																    	  		] 
															    	/* ----------------------------------------------------- LEVEL C ---------------------------------------------------- */	    
															    		    
												    		   			},
												    		    	<%}%>
												    		    
												    		    
												    		    <% } %>
												    	  		] 
											    		    
											    	/* ----------------------------------------------------- LEVEL B ---------------------------------------------------- */
											    		    
											    		    
											    		    
											    		    
											    		    
											    		    
								    		   			},
								    		    	<%}%>
								    		    
								    		    
								    		    <% } %>
								    	  		] 
								    	  
								  /* ----------------------------------------------------- LEVEL A ---------------------------------------------------- */		   
								    		    
								    		    
								    	  },
								    		  
								    	<%}%>
								    	
								    	];
								    		    
								    		 
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
								        
								        
								        /* ToolTip */
								        
								        
								        chart.getTimeline().tooltip().useHtml(true);    
								        chart.getTimeline().tooltip().format(
								          "<span style='font-weight:600;font-size:10pt'> Actual : " +
								          "{%actualStart}{dateTimeFormat:dd MMM yyyy} - " +
								          "{%actualEnd}{dateTimeFormat:dd MMM yyyy}</span><br>" +
								          "<span style='font-weight:600;font-size:10pt'> Revised : " +
								          "{%baselineStart}{dateTimeFormat:dd MMM yyyy} - " +
								          "{%baselineEnd}{dateTimeFormat:dd MMM yyyy}</span><br>" +
								          "Progress: {%baselineProgressValue}<br>" 
								          
								        ); 
								        
								        
								        
								        <%if(ProjectId!=null){
											Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");
										%>

									        /* Title */
									        
									        var title = chart.title();
											title.enabled(true);
											title.text("<%=ProjectDetail[2] %> ( <%=ProjectDetail[1] %> ) Gantt Chart");
											title.fontColor("#64b5f6");
											title.fontSize(18);
											title.fontWeight(600);
											title.padding(5);
								        
										<%} %>
										
								        
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
																	
                        		


</body>

</html>