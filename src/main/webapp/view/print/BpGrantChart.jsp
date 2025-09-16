<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>




 
</head>
<body>
  <%

 
  
  List<Object[]> MilestoneActivityMain=(List<Object[]>)request.getAttribute("MilestoneActivityMain0");
  List<Object[]> MilestoneActivityA=(List<Object[]>)request.getAttribute("MilestoneActivityA0");
  List<Object[]> MilestoneActivityB=(List<Object[]>)request.getAttribute("MilestoneActivityB0");
  List<Object[]> MilestoneActivityC=(List<Object[]>)request.getAttribute("MilestoneActivityC0");
  List<Object[]> MilestoneActivityD=(List<Object[]>)request.getAttribute("MilestoneActivityD0");
  List<Object[]> MilestoneActivityE=(List<Object[]>)request.getAttribute("MilestoneActivityE0");


String lastEnddate = MilestoneActivityMain!=null && !MilestoneActivityMain.isEmpty()?MilestoneActivityMain.get(0)[9].toString():LocalDate.now().toString();
 %>
 
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header ">  

					<div class="row">
						 
				
						
				
						
							
							
			   		</div>	   							

					</div>
						<div class="card-body p-1"> 
							<div  class="row mb-2">
							<div class="col-md-2 text-right" >
								<label>Interval : &nbsp;&nbsp;&nbsp; </label>
							</div>
							<div align="left" class="col-md-3 justify-content-end">
							<select class="form-control selectdee width150" name="interval" id="interval" required="required"  data-live-search="true"   >
                                <option value="quarter"> Quarterly </option>
                                <option value="half" >Half-Yearly</option>
                                <option value="year" >Yearly</option>
                            	<option value="month"> Monthly </option>
							</select>
						</div>
							</div>
						
							
								<div class="row mb-1 font-weight-bold"    >
										<div class="col-md-4"></div>
										<div class="col-md-4"></div>
										<div class="col-md-4">
											<div class="font-weight-bold" >
												<span class="mar-1">Original :&ensp; <span class="span-bg1"></span></span>
												<span class="mar-2">Ongoing :&ensp; <span class="span-bg2"></span></span>
												<span class="mar-2">Revised :&ensp; <span class="span-bg3"></span></span>
											</div>
										</div>
									</div>
							<div class="row" >
								
								<div class="col-md-12 bp-51" align="center">
							
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
	console.log(interval+"----")
	chartprint('type',interval);
	
})

/* $('#ProjectId').on('change',function(){
	
	$('#myform').submit();
}) */

</script>

									<script>
								      /* anychart.onDocumentReady(function () {  */  
								    	  
									function chartprint(type,interval){

								    	var data = [
								    		  
									    	<% for(Object[] obj : MilestoneActivityMain){ %>
									    	
									    	  {
									    		  
									    		 
									    		    id: "<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%>",
									    		    name: "<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>",
									    		    <%if(!obj[8].toString().equalsIgnoreCase("0") && !obj[8].toString().equalsIgnoreCase("1")){%>
									    		    baselineStart: "<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%>",
									    		    baselineEnd: "<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>",
									    		    baseline: {fill: "#F5A623 0.5", stroke: "0.5 #dd2c00"},
									    		    actualStart: "<%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - "%>",
									    		    actualEnd: "<%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "%>",
									    		    actual: {fill: "#455a64", stroke: "0.8 #455a64"},
									    		    baselineProgressValue: "<%= Math.round((int)obj[7])%>%",
									    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
									    		    progressValue: "<%= Math.round((int)obj[7])%>%", 
									    		    <%} else{%>
									    		    baselineStart: "<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%>",
									    		    baselineEnd: "<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>",
									    		    baseline:{fill: "#455a64", stroke: "0.8 #455a64"},
									    		    baselineProgressValue: "<%= Math.round((int)obj[7])%>%",
									    		    progressValue: "<%= Math.round((int)obj[7])%>%",
									    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
									    		    <%}%>
									    		    rowHeight: "55",	
									    		
									    		    
									  /* ----------------------------------------------------- LEVEL A ---------------------------------------------------- */
									    		    children: [
									    		    <% for(Object[] objA : MilestoneActivityA){ %>
									    		    		
									    		   		<% if(obj[0].toString().equalsIgnoreCase(objA[1].toString()) ) {%>	
									    		   			{
												    		    id: "<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%>_<%=objA[0]!=null?StringEscapeUtils.escapeHtml4(objA[0].toString()): " - "%>",
												    		    name: "<%=objA[2]!=null?StringEscapeUtils.escapeHtml4(objA[2].toString()): " - "%>",
												    		    <%if(!objA[8].toString().equalsIgnoreCase("0") && !objA[8].toString().equalsIgnoreCase("1")){%>
												    		    baselineStart: "<%=objA[3]!=null?StringEscapeUtils.escapeHtml4(objA[3].toString()): " - "%>",
												    		    baselineEnd: "<%=objA[4]!=null?StringEscapeUtils.escapeHtml4(objA[4].toString()): " - "%>",
												    		    baseline: {fill: "#F5A623 0.5", stroke: "0.5 #dd2c00"},
												    		    actualStart: "<%=objA[5]!=null?StringEscapeUtils.escapeHtml4(objA[5].toString()): " - "%>",
												    		    actualEnd: "<%=objA[6]!=null?StringEscapeUtils.escapeHtml4(objA[6].toString()): " - "%>",
												    		    actual: {fill: "#455a64", stroke: "0.8 #455a64"},
												    		    baselineProgressValue: "<%= Math.round((int)objA[7])%>%",
												    		    progressValue: "<%= Math.round((int)objA[7])%>%",
												    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
												    		    rowHeight: "55",
												    		    <%}else{%>
												    		    baselineStart: "<%=objA[5]!=null?StringEscapeUtils.escapeHtml4(objA[5].toString()): " - "%>",
												    		    baselineEnd: "<%=objA[6]!=null?StringEscapeUtils.escapeHtml4(objA[6].toString()): " - "%>",
												    		    baseline:{fill: "#455a64", stroke: "0.8 #455a64"},
												    		    baselineProgressValue: "<%= Math.round((int)objA[7])%>%",
												    		    progressValue: "<%= Math.round((int)objA[7])%>%",
												    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
												    		    rowHeight: "55",
												    		    <%}%>
												 		/* ----------------------------------------------------- LEVEL B ---------------------------------------------------- */
												    		    children: [
													    		    <% for(Object[] objB : MilestoneActivityB){ %>
													    		    		
													    		   		<% if(objA[0].toString().equalsIgnoreCase(objB[1].toString()) ) {%>	
													    		   			{
																    		    id: "<%=objA[0]!=null?StringEscapeUtils.escapeHtml4(objA[0].toString()): " - "%>_<%=objB[0]!=null?StringEscapeUtils.escapeHtml4(objB[0].toString()): " - "%>",
																    		    name: "<%=objB[2]!=null?StringEscapeUtils.escapeHtml4(objB[2].toString()): " - "%>",
																    		    <%if(!objB[8].toString().equalsIgnoreCase("0") && !objB[8].toString().equalsIgnoreCase("1")){%>
																    		    actualStart: "<%=objB[5]!=null?StringEscapeUtils.escapeHtml4(objB[5].toString()): " - "%>",
																    		    actualEnd: "<%=objB[6]!=null?StringEscapeUtils.escapeHtml4(objB[6].toString()): " - "%>",
																    		    actual: {fill: "#455a64", stroke: "0.8 #455a64"},
																    		    baselineProgressValue: "<%= Math.round((int)objB[7])%>%",
																    		    baselineStart: "<%=objB[3]!=null?StringEscapeUtils.escapeHtml4(objB[3].toString()): " - "%>",
																    		    baselineEnd: "<%=objB[4]!=null?StringEscapeUtils.escapeHtml4(objB[4].toString()): " - "%>",
																    		    baseline: {fill: "#F5A623 0.5", stroke: "0.5 #dd2c00"},
																    		    progressValue: "<%= Math.round((int)objB[7])%>%",
																    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																    		    rowHeight: "55",
																    		    <%}else{%>
																    		    baselineStart: "<%=objB[5]!=null?StringEscapeUtils.escapeHtml4(objB[5].toString()): " - "%>",
																    		    baselineEnd: "<%=objB[6]!=null?StringEscapeUtils.escapeHtml4(objB[6].toString()): " - "%>",
																    		    baseline: {fill: "#455a64", stroke: "0.8 #455a64"},
																    		    baselineProgressValue: "<%= Math.round((int)objB[7])%>%",
																    		    progressValue: "<%= Math.round((int)objB[7])%>%",
																    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																    		    rowHeight: "55",
																    		    <%}%>
																    		    
																    		   
																    		    
																  		/* ----------------------------------------------------- LEVEL C ---------------------------------------------------- */    		    
																    		    children: [
																	    		    <% for(Object[] objC : MilestoneActivityC){ %>
																	    		    		
																	    		   		<% if(objB[0].toString().equalsIgnoreCase(objC[1].toString()) ) {%>	
																	    		   			{
																				    		    id: "<%=objB[0]!=null?StringEscapeUtils.escapeHtml4(objB[0].toString()): " - "%>_<%=objC[0]!=null?StringEscapeUtils.escapeHtml4(objC[0].toString()): " - "%>",
																				    		    name: "<%=objC[2]!=null?StringEscapeUtils.escapeHtml4(objC[2].toString()): " - "%>",
																				    		    <%if(!objC[8].toString().equalsIgnoreCase("0") && !objC[8].toString().equalsIgnoreCase("1")){%>
																				    		    actualStart: "<%=objC[5]!=null?StringEscapeUtils.escapeHtml4(objC[5].toString()): " - "%>",
																				    		    actualEnd: "<%=objC[6]!=null?StringEscapeUtils.escapeHtml4(objC[6].toString()): " - "%>",
																				    		    actual: {fill: "#455a64", stroke: "0.8 #455a64"},
																				    		    baselineStart: "<%=objC[3]!=null?StringEscapeUtils.escapeHtml4(objC[3].toString()): " - "%>",
																				    		    baselineEnd: "<%=objC[4]!=null?StringEscapeUtils.escapeHtml4(objC[4].toString()): " - "%>",
																				    		    baseline: {fill: "#F5A623 0.5", stroke: "0.5 #dd2c00"},
																				    		    progressValue: "<%= Math.round((int)objC[7])%>%",
																				    		    baselineProgressValue: "<%= Math.round((int)objB[7])%>%",
																				    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																				    		    rowHeight: "55",
																				    		    <%}else{%>
																				    		    baselineStart: "<%=objC[5]!=null?StringEscapeUtils.escapeHtml4(objC[5].toString()): " - "%>",
																				    		    baselineEnd: "<%=objC[6]!=null?StringEscapeUtils.escapeHtml4(objC[6].toString()): " - "%>",
																				    		    baseline: {fill: "#455a64", stroke: "0.8 #dd2c00"},
																				    		    progressValue: "<%= Math.round((int)objC[7])%>%",
																				    		    baselineProgressValue: "<%= Math.round((int)objB[7])%>%",
																				    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																				    		    rowHeight: "55",
																				    		    <%}%>
																				    		  
																				    		    
																				/* ----------------------------------------------------- LEVEL D ---------------------------------------------------- */  		    
																				    		    children: [
																					    		    <% for(Object[] objD : MilestoneActivityD){ %>
																					    		    		
																					    		   		<% if(objC[0].toString().equalsIgnoreCase(objD[1].toString()) ) {%>	
																					    		   			{
																								    		    id: "<%=objC[0]!=null?StringEscapeUtils.escapeHtml4(objC[0].toString()): " - "%>_<%=objD[0]!=null?StringEscapeUtils.escapeHtml4(objD[0].toString()): " - "%>",
																								    		    name: "<%=objD[2]!=null?StringEscapeUtils.escapeHtml4(objD[2].toString()): " - "%>",
																								    		    <%if(!objD[8].toString().equalsIgnoreCase("0") && !objD[8].toString().equalsIgnoreCase("1")){%>
																								    		    actualStart: "<%=objD[5]!=null?StringEscapeUtils.escapeHtml4(objD[5].toString()): " - "%>",
																								    		    actualEnd: "<%=objD[6]!=null?StringEscapeUtils.escapeHtml4(objD[6].toString()): " - "%>",
																								    		    actual: {fill: "#455a64", stroke: "0.8 #455a64"},
																								    		    baselineStart: "<%=objD[3]!=null?StringEscapeUtils.escapeHtml4(objD[3].toString()): " - "%>",
																								    		    baselineEnd: "<%=objD[4]!=null?StringEscapeUtils.escapeHtml4(objD[4].toString()): " - "%>",
																								    		    baseline: {fill: "#F5A623 0.5", stroke: "0.5 #dd2c00"},
																								    		    progressValue: "<%= Math.round((int)objD[7])%>%",
																								    		    baselineProgressValue: "<%= Math.round((int)objD[7])%>%",
																								    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																								    		    rowHeight: "55",
																								    		    <%}else{%>
																								    		    baselineStart: "<%=objD[5]!=null?StringEscapeUtils.escapeHtml4(objD[5].toString()): " - "%>",
																								    		    baselineEnd: "<%=objD[6]!=null?StringEscapeUtils.escapeHtml4(objD[6].toString()): " - "%>",
																								    		    baseline: {fill: "#455a64", stroke: "0.5 #455a64"},
																								    		    progressValue: "<%= Math.round((int)objD[7])%>%",
																								    		    baselineProgressValue: "<%= Math.round((int)objD[7])%>%",
																								    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																								    		    rowHeight: "55",
																								    		    <%}%>
																								    		    
																						/* ----------------------------------------------------- LEVEL E ---------------------------------------------------- */				    		    
																								    		    children: [
																									    		    <% for(Object[] objE : MilestoneActivityE){ %>
																									    		    		
																									    		   		<% if(objD[0].toString().equalsIgnoreCase(objE[1].toString()) ) {%>	
																									    		   			{
																												    		    id: "<%=objD[0]!=null?StringEscapeUtils.escapeHtml4(objD[0].toString()): " - "%>_<%=objE[0]!=null?StringEscapeUtils.escapeHtml4(objE[0].toString()): " - "%>",
																												    		    name: "<%=objE[2]!=null?StringEscapeUtils.escapeHtml4(objE[2].toString()): " - "%>",
																												    		    <%if(!objE[8].toString().equalsIgnoreCase("0") && !objE[8].toString().equalsIgnoreCase("1")){%>
																												    		    actualStart: "<%=objE[5]!=null?StringEscapeUtils.escapeHtml4(objE[5].toString()): " - "%>",
																												    		    actualEnd: "<%=objE[6]!=null?StringEscapeUtils.escapeHtml4(objE[6].toString()): " - "%>",
																												    		    actual: {fill: "#455a64", stroke: "0.8 #455a64"},
																												    		    baselineStart: "<%=objE[3]!=null?StringEscapeUtils.escapeHtml4(objE[3].toString()): " - "%>",
																												    		    baselineEnd: "<%=objE[4]!=null?StringEscapeUtils.escapeHtml4(objE[4].toString()): " - "%>",
																												    		    baseline: {fill: "#F5A623 0.5", stroke: "0.5 #dd2c00"},
																												    		    progressValue: "<%= Math.round((int)objE[7])%>%",
																												    		    baselineProgressValue: "<%= Math.round((int)objE[7])%>%",
																												    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																												    		    rowHeight: "55",
																												    		    <%}else{%>
																												    		    baselineStart: "<%=objE[5]!=null?StringEscapeUtils.escapeHtml4(objE[5].toString()): " - "%>",
																												    		    baselineEnd: "<%=objE[6]!=null?StringEscapeUtils.escapeHtml4(objE[6].toString()): " - "%>",
																												    		    baseline: {fill: "#455a64", stroke: "0.5 #455a64"},
																												    		    progressValue: "<%= Math.round((int)objE[7])%>%",
																												    		    baselineProgressValue: "<%= Math.round((int)objE[7])%>%",
																												    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
																												    		    rowHeight: "55",
																												    		    <%}%>
																												    		   
																												    		    
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
								        	
								            var timeline = chart.getTimeline();

								            
										   // configure labels of elements
										   timeline.elements().labels().fontWeight(600);
										   timeline.elements().labels().fontSize("14px");
										   timeline.elements().labels().fontColor("#FF6F00");
										   
										   var maxDate = '<%=lastEnddate%>';
										   maxDate = new Date(maxDate);
										   maxDate.setMonth(maxDate.getMonth() + 2);
										   chart.getTimeline().scale().maximum(maxDate);
								        
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
								        		        	html= "<span class='mar3'> Actual : " +
								        		               anychart.format.dateTime(actualStart, 'dd MMM yyyy') + " - " +
								        		               anychart.format.dateTime(actualEnd, 'dd MMM yyyy') + "</span><br>" +
								        		               "Progress: " + this.getData("baselineProgressValue") + "<br>"
								        		        }else{
								        		        	html="";
								        		        html="<span class='mar3'> Actual : " +
								        		               anychart.format.dateTime(actualStart, 'dd MMM yyyy') + " - " +
								        		               anychart.format.dateTime(actualEnd, 'dd MMM yyyy') + "</span><br>" +
								        		               "<span class='mar3'> Revised : " +
								        		               anychart.format.dateTime(this.getData("baselineStart"), 'dd MMM yyyy') + " - " +
								        		               anychart.format.dateTime(this.getData("baselineEnd"), 'dd MMM yyyy') + "</span><br>" +
								        		               "Progress: " + this.getData("baselineProgressValue") + "<br>"
								        		        }
								        		        
								        		        return html;
								        		    }		
								        
								       /*    "<span style='font-weight:600;font-size:10pt'> Actual : " +
								          "{%actualStart}{dateTimeFormat:dd MMM yyyy} - " +
								          "{%actualEnd}{dateTimeFormat:dd MMM yyyy}</span><br>" +
								          "<span style='font-weight:600;font-size:10pt'> Revised : " +
								          "{%baselineStart}{dateTimeFormat:dd MMM yyyy} - " +
								          "{%baselineEnd}{dateTimeFormat:dd MMM yyyy}</span><br>" +
								          "Progress: {%baselineProgressValue}<br>"  */
								          
								        ); 
								        
								        
								        
								      
										
								        
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
								    	column_1.labels().fontWeight(900);
								     	column_1.labels().fontSize("16px");
								     	column_1.labels().useHtml(true);
								     	column_1.labels().fontColor("#055C9D");
								     	
								     	
								     	var column_2 = chart.dataGrid().column(1);
								     	column_2.title().text("Activity");
								     	column_2.title().fontColor("#145374");
								     	column_2.title().fontWeight(600);
								     	
								     	chart.dataGrid().column(0).width(25);
								     	chart.dataGrid().column(1).width(250);
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
								     	    return "<span class='font-weight-bold'></span>";
								     	  } else {
								     	    return "<span class='font-weight-bold'></span>";
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
 							  var interval = $("#interval").val();
								    	  
								    	
								      })
								      
								      
								      function ChartPrint(){
									   		
								    	  var interval = $("#interval").val();
								    	  
								
								    	  
								    	  $('#containers').empty();
								    	  chartprint('print',interval);
								     }
								     
								    </script>
																	
                        		


</body>
</html>