<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Map"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<!-- Pdfmake  -->
	<spring:url value="/resources/pdfmake/pdfmake.min.js" var="pdfmake" />
	<script src="${pdfmake}"></script>
	<spring:url value="/resources/pdfmake/vfs_fonts.js" var="pdfmakefont" />
	<script src="${pdfmakefont}"></script>
	<spring:url value="/resources/pdfmake/htmltopdf.js" var="htmltopdf" />
	<script src="${htmltopdf}"></script>
	
<style type="text/css">
.control-label {
	font-size: 17px;
	font-weight: bold;
}

.dropdownstable {
	width: 100%;
	float: right;
	margin-top: -0.5rem;
}
.dropdownstable td{
	padding: 3px;
}

.table thead {
	text-align: center;
	background-color: #2883c0;
	color: white;
	position: sticky;
	top: 0; /* Keeps the header at the top */
	z-index: 10; /* Ensure the header stays on top of the body */
	/* background-color: white; */ /* For visibility */
}

.table-wrapper {
    max-height: 800px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: hidden; /* Enable vertical scrolling */
}

.table .btn-outline-info{
	
	background-color: white !important;
	border: 3px solid #17a2b8;
	padding: .275rem .5rem !important;
}

.table .btn-outline-info:hover {
	color: black !important;
	
}

.left {
	text-align: left;
}
.center{
	text-align: center;
}
.right{
	text-align: right;
}


.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 108px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 28px;
	height: 52px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
}

.cc-rockmenu .rolling .rolling_icon:hover .rolling {
	width: 312px;
}

.cc-rockmenu .rolling i.fa {
	font-size: 20px;
	padding: 6px;
}

.cc-rockmenu .rolling span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 14px;
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu .rolling p {
	margin: 0;
}

</style>
</head>
<body>
	<%
	  	String empId = (String)request.getAttribute("empId");
	  	String projectId = (String)request.getAttribute("projectId");
	  	String type = (String)request.getAttribute("type");
	  	String status = (String)request.getAttribute("status");
	  	
	  	List<Object[]> projectList = (List<Object[]>)request.getAttribute("projectList");
		List<Object[]> roleWiseEmployeeList = (List<Object[]>)request.getAttribute("roleWiseEmployeeList");
		List<Object[]> allActionsList = (List<Object[]>)request.getAttribute("allActionsList");
		
		Map<String, List<Object[]>> allActionsListToListMap = allActionsList!=null && allActionsList.size()>0?allActionsList.stream()
				  .collect(Collectors.groupingBy(array -> array[18] + "", LinkedHashMap::new, Collectors.toList())) : new HashMap<>();

		
		FormatConverter fc = new FormatConverter();
		
		String EmpId = ((Long) session.getAttribute("EmpId")).toString();
		
		String projectName = "", assigneeName = "", typeName = "", statusName = "";
		
	%>
	<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">	
				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-4">
								<h4 class="">Action Report</h4>
							</div>
							<div class="col-md-8">
					   			<form method="post" action="ActionReport.htm">
					   				<table class="dropdownstable">
					   					<tr>
					   						<td>
					   							<label class="control-label">Project: </label>
					   						</td>
					   						<td>
                                            	<select class="form-control selectdee " name="projectId" id="projectId" required="required"  data-live-search="true" onchange="this.form.submit()" >
	                                                <option value="A"  <%if(projectId.equalsIgnoreCase("A")){ projectName = "All";%> selected="selected" <%}%>>All</option>	
	                                      		<%-- <option value="0"  <%if(Project.equalsIgnoreCase("0")){%> selected="selected" <%}%>>General</option> --%>	
	                                           		<%for(Object[] obj:projectList){
	                                                    String projectShortName=(obj[17]!=null)?" ("+obj[17].toString()+")":"";
	                                                %>
														<option value="<%=obj[0] %>" <%if(projectId.equalsIgnoreCase(obj[0].toString())){ projectName = obj[4]+projectShortName; %> selected="selected" <%}%>><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - "%> <%= projectShortName!=null?StringEscapeUtils.escapeHtml4(projectShortName):" - " %></option>	
													<%}%>
												</select>	        
											</td>
											<td>
					   							<label class="control-label">Assignee: </label>
					   						</td>
					   						<td>
                                            	<select class="form-control selectdee " name="empId" id="empId" required="required"  data-live-search="true" onchange="this.form.submit()" >
	                                                <option value="A"  <%if(empId.equalsIgnoreCase("A")){ assigneeName = "All";%> selected="selected" <%}%>>All</option>	
	                                      		<%-- <option value="0"  <%if(Project.equalsIgnoreCase("0")){%> selected="selected" <%}%>>General</option> --%>	
	                                           		<%if(roleWiseEmployeeList!=null && roleWiseEmployeeList.size()>0) {
														for(Object[] obj : roleWiseEmployeeList) {%>
															<option value="<%=obj[0]%>" 
																<%if(empId.equalsIgnoreCase(obj[0]+"")) { assigneeName = (obj[1]!=null?obj[1]:(obj[2]!=null?obj[2]:""))+" "+obj[5]+", "+obj[6];%>
																	selected
																<%} %> >
																<%= (obj[1] != null ? StringEscapeUtils.escapeHtml4(obj[1].toString()): (obj[2] != null ? StringEscapeUtils.escapeHtml4(obj[2].toString()) : ""))
																+ " " + (obj[5] != null ? StringEscapeUtils.escapeHtml4(obj[5].toString()) : " - ")+ ", "+ (obj[6] != null ? StringEscapeUtils.escapeHtml4(obj[6].toString()) : " - ")
%>

															</option>
													<%} }%>
												</select>	        
											</td>
											<td>
					   							<label class="control-label">Type: </label>
					   						</td>
					   						<td>
                                                <select class="form-control selectdee " name="type" id="type" required="required"  data-live-search="true" onchange="this.form.submit()" >
                                                    <option value="A" <%if("A".equalsIgnoreCase(type)){ typeName = "All";%> selected="selected" <%}%>>All</option>
													<option value="N" <%if("N".equalsIgnoreCase(type)){ typeName = "Action";%> selected="selected" <%}%>>Action</option>	
													<option value="S" <%if("S".equalsIgnoreCase(type)){ typeName = "Meeting";%> selected="selected" <%}%>>Meeting</option>	
													<option value="M" <%if("M".equalsIgnoreCase(type)){ typeName = "Milestone";%> selected="selected" <%}%>>Milestone</option>		
												</select>
											</td>
					   						 <td>
					   							<label class="control-label">Status: </label>
					   						</td>
					   						<td>
                                           		<select class="form-control selectdee " name="status" id="status" required="required"  data-live-search="true" onchange="this.form.submit()" >
                                            		<option value="N" <%if("N".equalsIgnoreCase(status)){ statusName = "All";%> selected="selected" <%} %>>All</option>
													<option value="A" <%if("A".equalsIgnoreCase(status)){ statusName = "Not Started";%> selected="selected" <%} %>>Not Started</option>	
													<option value="I" <%if("I".equalsIgnoreCase(status)){ statusName = "In-Progress";%> selected="selected" <%} %>>In-Progress</option>	
													<option value="C" <%if("C".equalsIgnoreCase(status)){ statusName = "Closed";%> selected="selected" <%} %> >Closed</option>		
												</select>					   						
											</td> 	
											<td>
												<button type="button" class="btn btn-sm" onclick="downloadPDF()" formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="" data-original-title="PDF Download">
										        	<i style="color: #cc0000" class="fa fa-download"></i>
									       		</button>
											</td>   									
					   					</tr>   					   				
					   				</table>
					   				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					   			</form>
							</div>
						</div>
					</div>
					
					<div class="card-body">
					
            			<div class="table-wrapper table-responsive">
            				<!-- <input type="text" id="searchBar" class="search-bar form-control" placeholder="Search..." style="float: right;width: auto;" />
       						<br> -->
							<table class="table table-condensed table-striped table-bordered table-hover" id="myTable">
	                        	<thead class="center">
	                        		<tr>
										<th width="5%">SN</th>
										<th width="20%">Action Id</th>	
										<th width="10%">PDC</th>	
										<th width="20%">Assignee</th>
										<th width="20%">Assignor</th>																						
									 	<!-- <th width="20%">Mob No</th> -->
									 	<th width="15%">Progress</th>
									 	<th width="10%">Action</th>
									</tr>
								</thead>
								<tbody>
									<%if (allActionsListToListMap!=null && allActionsListToListMap.size() > 0) {
										int slno = 0;
										for (Map.Entry<String, List<Object[]>> map : allActionsListToListMap.entrySet()) {
			                  							
			                  				List<Object[]> values = map.getValue();
			                  				int i=0;
			                  				for (Object[] obj : values) {
			                  					String actionName = obj[7]!=null?obj[7].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-";
									%>
											<tr>
												<td class="center"><%=++slno %></td>
												<%-- <%if(i==0) {%>
										    		<td rowspan="<%=values.size() %>" style="vertical-align: middle;">
										    			<%=obj[1]%>, <%=obj[2]%>
										    		</td>
			         							<%} %> --%>
			         								
												<td class="center">
													<button type="submit" class="btn btn-outline-info" onclick="showSubListDetails('<%=slno %>')" ><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):"" %></button>
                                                </td>
												<td class="center"><%=obj[6]!=null?fc.sdfTordf(obj[6].toString()):"-"%></td>																		
											  	<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):" - "%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - "%></td>
											  	<td><%=obj[19]!=null?StringEscapeUtils.escapeHtml4(obj[19].toString()):" - "%>, <%=obj[20]!=null?StringEscapeUtils.escapeHtml4(obj[20].toString()):" - "%></td>
												<td class="center">
													<%if(obj[12]!=null && !obj[12].toString().equalsIgnoreCase("0")){ %>
										            	<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										            		<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[12]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
										            			<%=StringEscapeUtils.escapeHtml4(obj[12].toString()) %>
										            		</div> 
										            	</div> 
										            <%}else{ %>
									            		<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										            		<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
										            			Not Yet Started .
										            		</div>
									            		</div> 
									            	<%} %>
									            </td>	
									            <td class="center">
									            	<form id="myForm_<%=slno %>" action="#">
									            		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									            		<input type="hidden" name="ActionLinkId" id="actionLinkId_<%=slno %>" value="<%=obj[11]%>"/>
											           	<input type="hidden" name="Assignee" id="assignee_<%=slno %>" value="<%=obj[1]%>,<%=obj[2]%>"/>
											           	<input type="hidden" name="Assigner" id="assigner_<%=slno %>" value="<%=obj[19]%>,<%=obj[20]%>"/>
											           	<input type="hidden" name="ActionMainId" id="actionMainId_<%=slno %>" value="<%=obj[10]%>"/>
											           	<input type="hidden" name="ActionAssignId" id="actionAssignId_<%=slno %>" value="<%=obj[14]%>"/>
											           	<input type="hidden" name="ActionAssignid" id="actionAssignId_<%=slno %>" value="<%=obj[14]%>"/>
											           	<input type="hidden" name="ActionNo" id="actionNo_<%=slno %>" value="<%=obj[0]%>"/>
											           	<textarea name="ActionName" id="actionName_<%=slno %>" style="display: none;"><%=actionName!=null?actionName:""%></textarea>
											           	<input type="hidden" name="ProjectId" value="<%=obj[18]%>"/>
											           	<input type="hidden" name="projectid" value="<%=projectId%>"/>
											           	<input type="hidden" name="empId" value="<%=empId%>"/>
											           	<input type="hidden" name="type" value="<%=type%>"/>
											           	<input type="hidden" name="status" value="<%=status%>"/>
											           	<input type="hidden" name="flag" value="R"/>
											           	
											           	<%if(EmpId.equalsIgnoreCase(obj[16].toString())) {%>
											           		
											           		<button class="btn btn-sm editable-click" name="sub" value="Details" formaction="ActionSubLaunch.htm" formmethod="POST"	>
																<div class="cc-rockmenu">
																	<div class="rolling">
																		<figure class="rolling_icon">
																			<img src="view/images/preview3.png">
																		</figure>
																		<span>Details</span>
																	</div>
																</div>
															</button>
															
											           	<%} else if("F".equalsIgnoreCase(obj[8].toString()) && EmpId.equalsIgnoreCase(obj[17].toString())) {%>

															<button class="editable-click" name="sub" value="Details" formaction="ForwardSub.htm" formmethod="POST"	>
																<div class="cc-rockmenu">
																	<div class="rolling">
																		<figure class="rolling_icon">
																			<img src="view/images/preview3.png">
																		</figure>
																		<span>Details</span>
																	</div>
																</div>
															</button> 
									            		<%} %>
									            	</form>
									            </td>			
											</tr>
										<% ++i; } } } else{%>
											<tr>
												<td colspan="7" style="text-align: center;">No Data Available</td>
											</tr>
										<%} %>
								</tbody>
							</table>
						</div>			
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- -------------------------------------------- Action Sub List Modal ------------------------------------------------------------- -->
	<div class="modal fade" id="actionSubListDetailsModal" tabindex="-1" role="dialog" aria-labelledby="actionSubListDetailsModal" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
			<div class="modal-content" style="width:135%;margin-left:-20%;">
				<div class="modal-header" style="background: #055C9D;color: white;">
		        	<h5 class="modal-title actionSubListHeader "></h5>
			        <button type="button" class="close" style="text-shadow: none !important" data-dismiss="modal" aria-label="Close">
			          <span class="text-light" aria-hidden="true">&times;</span>
			        </button>
		      	</div>
     			<div class="modal-body">
     				<div class="container-fluid mt-3">
     					<div class="row">
							<div class="col-md-12 " align="left">
								<div>
									<h5 style="color: #346691;">Action: <span id="actionName" style="font-size: 17px;font-weight: 500;color: black;"></span></h5>
									
									<h5 style="color: #346691;">Assignor: <span id="assignorName" style="font-size: 17px;font-weight: 500;color: black;"></span></h5>
									
									<h5 style="color: #346691;">Assignee: <span id="assigneeName" style="font-size: 17px;font-weight: 500;color: black;"></span></h5>
									
								</div>
								<div class="table-responsive">
    								<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" style="margin-top: 20px;">
										<thead class="center">
											<tr>
												<th colspan="4" style="background-color: #055C9D; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;text-transform: capitalize;" >Action Updated Details </th>									
											</tr>	
											<tr>					
												<th>As On Date</th>
												<th style="">Progress %</th>
												<th style="">Remarks</th>								
											 	<th style="">Attachment</th>
											</tr>
										</thead>
										<tbody id="actionSubListTBody"></tbody>
									</table>
								</div> 
							</div>
						</div>
     				</div>
     			</div>
     		</div>
		</div>
	</div>				
	<!-- -------------------------------------------- Action Sub List Modal End ------------------------------------------------------------- -->
</body>

<script type="text/javascript">
$(document).ready(function () {
    $('#searchBar').on('keyup', function () {
        const searchTerm = $(this).val().toLowerCase();
        $('#dataTable tbody tr').filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
        });
    });
    $('#searchBar2').on('keyup', function () {
        const searchTerm = $(this).val().toLowerCase();
        $('#dataTable2 tbody tr').filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
        });
    });
});

$("#myTable1,#myTable").DataTable({
    "lengthMenu": [10, 25, 50, 75, 100],
    "pagingType": "simple"

});

function showSubListDetails(rowSlNo) {
	var actionLinkId = $('#actionLinkId_'+rowSlNo).val();
	var assignee = $('#assignee_'+rowSlNo).val();
	var assigner = $('#assigner_'+rowSlNo).val();
	var actionMainId = $('#actionMainId_'+rowSlNo).val();
	var actionAssignId = $('#actionAssignId_'+rowSlNo).val();
	var actionNo = $('#actionNo_'+rowSlNo).val();
	var actionName = $('#actionName_'+rowSlNo).val();
	
	$.ajax({
		type : "GET",
		url : "ActionProgressSubList.htm",	
		datatype : 'json',
		data : {
			actionAssignId : actionAssignId,							
		},
		success : function(result) {
			var values = JSON.parse(result);
			
			console.log(values);
			var x = '';
			for(var i =0 ; i<values.length; i++) {
				x += '<tr>';
				x += '<td class="center">'+(values[i][3]!=null? formatDateToDDMMYYYY(values[i][3]) : "-")+'</td>';
				x += '<td><div class="progress" style="background-color:#cdd0cb !important"><div class="progress-bar progress-bar-striped" role="progressbar" style="width:'+values[i][2]+'%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">'+values[i][2]+'</div></div></td>';
				x += '<td>'+values[i][4]+'</td>';
				x += '<td class="center">' +  (values[i][5] != null ? '<a href="ActionDataAttachDownload.htm?ActionSubId=' + values[i][6] + '" target="_blank"><i class="fa fa-download"></i></a>' : "-") +  '</td>';
				x += '</tr>';
			}
			
			$('#actionSubListTBody').html(x);
		}
	});
	
	$('#actionName').html(actionName);
	$('#assignorName').html(assigner);
	$('#assigneeName').html(assignee);
	$('.actionSubListHeader').html(actionNo);
	$('#actionSubListDetailsModal').modal('show');
}

function formatDateToDDMMYYYY(sqlDate) {
    if (!sqlDate) return "-"; // Return '-' if the date is null or undefined

    var date = new Date(sqlDate); // Convert the SQL date to a JavaScript Date object
    var day = String(date.getDate()).padStart(2, '0'); // Get day and pad with 0 if needed
    var month = String(date.getMonth() + 1).padStart(2, '0'); // Get month (0-indexed) and pad with 0
    var year = date.getFullYear(); // Get the full year

    return day + "-" + month + "-" + year; // Format in dd-MM-yyyy
}

function downloadPDF(){

	var docDefinition = {
			pageOrientation: 'landscape',
            content: [
                
                
                /* ************************************** Action Report List *********************************** */ 
                {
                    text: 'Action Report',
                    style: 'chapterHeader',
                    tocItem: false,
                    id: 'chapter1',
                    alignment: 'center',
                },
                
                {
                    table: {
                        headerRows: 1,
                        widths: ['7%', '15%', '5%', '8%', '22%', '5%', '6%', '10%', '5%', '7%', '10%'],
                        body: [
                            // Table header
                            [
                                { text: 'Project: ',bold: true,  },
                                { text: '<%=projectName%>',  },
                                { text: '', },
                                
                                { text: 'Assignee:',bold: true, }, 
                                { text: '<%=assigneeName%>', }, 
                                { text: '', },
                                
                                { text: 'Type:',bold: true, }, 
                                { text: '<%=typeName%>', }, 
                                { text: '', }, 
                                
                                { text: 'Status:',bold: true, }, 
                                { text: '<%=statusName%>', }, 
                            ],
                            
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return 0;
                        },
                        vLineWidth: function(i) {
                            return 0;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                
                {text: '\n'},
                
                {
                    table: {
                        headerRows: 1,
                        widths: ['7%', '27%', '10%', '23%', '23%', '10%'],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Action Id', style: 'tableHeader' },
                                { text: 'PDC', style: 'tableHeader' },
                                { text: 'Assignee', style: 'tableHeader' }, 
                                { text: 'Assignor', style: 'tableHeader' }, 
                                { text: 'Progress', style: 'tableHeader' }, 
                            ],
                            // Populate table rows
                            <%if (allActionsListToListMap!=null && allActionsListToListMap.size() > 0) {
								int slno = 0;
								for (Map.Entry<String, List<Object[]>> map : allActionsListToListMap.entrySet()) {
	                  							
	                  				List<Object[]> values = map.getValue();
	                  				int i=0;
	                  				for (Object[] obj : values) {
	                  					String actionName = obj[7]!=null?obj[7].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-";
	                  		%>
	                            [
	                                { text: '<%= ++slno %>', style: 'tableData',alignment: 'center' },
	                                { text: '<%= obj[0] %>', style: 'tableData',alignment: 'left' },
	                                { text: '<%=obj[6]!=null?fc.sdfTordf(obj[6].toString()):"-"%>', style: 'tableData',alignment: 'center' },
	                                { text: '<%=obj[1]%>, <%=obj[2]%>', style: 'tableData' },
	                                { text: '<%=obj[19]%>, <%=obj[20]%>', style: 'tableData' },
	                                { text: '<%=obj[12]!=null && !obj[12].toString().equalsIgnoreCase("0")?obj[12]+"%":"Not Yet Started"%>', style: 'tableData',alignment: 'center' },
	                            ],
	                        <% ++i; } } } else{%>
                            	[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 7 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* ************************************** Action Report List End*********************************** */

                
			],
			styles: {
				chapterHeader: { fontSize: 16, bold: true, margin: [0, 0, 0, 10] },
                tableHeader: { fontSize: 12, bold: true, fillColor: '#f0f0f0', alignment: 'center', margin: [10, 5, 10, 5], fontWeight: 'bold' },
                tableData: { fontSize: 11.5, margin: [0, 5, 0, 5] },
            },
            footer: function(currentPage, pageCount) {
                /* if (currentPage > 2) { */
                    return {
                        stack: [
                        	{
                                canvas: [{ type: 'line', x1: 30, y1: 0, x2: 820, y2: 0, lineWidth: 1 }]
                            },
                            {
                                columns: [
                                    { text: '', alignment: 'left', margin: [30, 0, 0, 0], fontSize: 8 },
                                    { text: currentPage.toString() + ' of ' + pageCount, alignment: 'right', margin: [0, 0, 30, 0], fontSize: 8 }
                                ]
                            },
                            { text: '', alignment: 'center', fontSize: 8, margin: [0, 5, 0, 0], bold: true }
                        ]
                    };
                /* }
                return ''; */
            },
            /* header: function (currentPage) {
                return {
                    stack: [
                        
                        {
                            columns: [
                                {
                                    // Center: Text
                                    text: 'Restricted',
                                    alignment: 'center',
                                    fontSize: 10,
                                    bold: true,
                                    margin: [0, 10, 0, 0]
                                },
                            ]
                        },
                        
                    ]
                };
            }, */
			pageMargins: [30, 40, 20, 20],
            
            defaultStyle: { fontSize: 12, color: 'black', }
        };
		
        pdfMake.createPdf(docDefinition).open();
}

const setImagesWidth = (htmlString, width) => {
    const container = document.createElement('div');
    container.innerHTML = htmlString;
  
    const images = container.querySelectorAll('img');
    
    images.forEach(img => {
    	
      img.style.width = width+'px';
      img.style.textAlign = 'center';
    });
  
    const textElements = container.querySelectorAll('p, h1, h2, h3, h4, h5, h6, span, div, td, th, table, v, figure, hr, ul, li');
    textElements.forEach(element => {
      if (element.style) {
        element.style.fontFamily = '';
        element.style.margin = '';
        element.style.marginTop = '';
        element.style.marginRight = '';
        element.style.marginBottom = '';
        element.style.marginLeft = '';
        element.style.lineHeight = '';
        element.style.height = '';
        element.style.width = '';
        element.style.padding = '';
        element.style.paddingTop = '';
        element.style.paddingRight = '';
        element.style.paddingBottom = '';
        element.style.paddingLeft = '';
        element.style.fontSize = '';
        element.id = '';
        
        const elementColor = element.style.color;
        if (elementColor && elementColor.startsWith("var")) {
            // Replace `var(...)` with a fallback or remove it
            element.style.color = 'black'; // Default color
        }
        
        const elementbackgroundColor = element.style.backgroundColor;
        if (elementbackgroundColor && elementbackgroundColor.startsWith("var")) {
            // Replace `var(...)` with a fallback or remove it
            element.style.backgroundColor = 'transparent'; // Set a default or fallback background color
        }
        
      }
    });
  
    const tables = container.querySelectorAll('table');
    tables.forEach(table => {
      if (table.style) {
        table.style.borderCollapse = 'collapse';
        table.style.width = '100%';
      }
  
      const cells = table.querySelectorAll('th, td');
      cells.forEach(cell => {
        if (cell.style) {
          cell.style.border = '1px solid black';
  
          if (cell.tagName.toLowerCase() === 'th') {
            cell.style.textAlign = 'center';
          }
        }
      });
    });
  
    return container.innerHTML;
 	}; 	
 
 
 
 	function splitTextIntoLines(text, maxLength) {
	const lines = [];
  	let currentLine = '';

	for (const word of text.split(' ')) {
		if ((currentLine + word).length > maxLength) {
	    	lines.push(currentLine.trim());
	    	currentLine = word + ' ';
		} else {
		  currentLine += word + ' ';
		}
	}
  	lines.push(currentLine.trim());
  	return lines;
}

// Generate rotated text image with line-wrapped text
function generateRotatedTextImage(text) {
	const maxLength = 260;
	const lines = splitTextIntoLines(text, maxLength);
	
	const canvas = document.createElement('canvas');
	const ctx = canvas.getContext('2d');
	
	// Set canvas dimensions based on anticipated text size and rotation
	canvas.width = 200;
	canvas.height = 1560;
	
	// Set text styling
	ctx.font = '14px Roboto';
	ctx.fillStyle = 'rgba(128, 128, 128, 1)'; // Gray color for watermark
	
	// Position and rotate canvas
	ctx.translate(80, 1480); // Adjust position as needed
	ctx.rotate(-Math.PI / 2); // Rotate 270 degrees
	
	// Draw each line with a fixed vertical gap
	const lineHeight = 20; // Adjust line height if needed
	lines.forEach((line, index) => {
	  ctx.fillText(line, 0, index * lineHeight); // Position each line below the previous
	});
	
	return canvas.toDataURL();
}
</script>
</html>