<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
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
<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
<link href="${sweetalertCss}" rel="stylesheet" />
<script src="${sweetalertJs}"></script>

<style type="text/css">
.left {
	text-align: left;
}

.center {
	text-align: center;
}

.right {
	text-align: right;
}
</style>
</head>
<body>
	<%
		List<Object[]> msProcurementList = (List<Object[]>)request.getAttribute("msProcurementList");
		Object[] projectDetails = (Object[])request.getAttribute("projectDetails");
		String projectId = (String)request.getParameter("ProjectId");
		FormatConverter fc = new FormatConverter();
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
	
	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
		
			<div class="card-header" style="background-color: transparent;height: 3rem;">
 				<div class="row">
 					<div class="col-md-7">
 						<h3 class="text-dark" style="font-weight: bold;">Procurement List - <%=projectDetails!=null?(projectDetails[3]!=null?StringEscapeUtils.escapeHtml4(projectDetails[3].toString()):" - "+" ("+projectDetails[1]!=null?StringEscapeUtils.escapeHtml4(projectDetails[1].toString()):" - "+")"):"" %> </h3>
 					</div>
 					<div class="col-md-3"></div>
 					<div class="col-md-2 right">
	 					<a class="btn btn-sm back" href="MSprojectProcurementStatus.htm?ProjectId=<%=projectId%>">Procurement Status</a>
	 					<a class="btn btn-sm back" href="MSProjectMilestone.htm?ProjectId=<%=projectId%>">Back</a>
 					</div>
 					
 				</div>
       		</div>
       		
			<!-- <div class="row" style="margin: 1rem;">
				<div class="col-12">
         			<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  				<li class="nav-item" style="width: 50%;"  >
		    				<div class="nav-link active" style="text-align: center;" id="pills-tab-1" data-toggle="pill" data-target="#tab-1" role="tab" aria-controls="tab-1" aria-selected="true">
			   					<span>Demand List</span> 
		    				</div>
		  				</li>
		  				<li class="nav-item"  style="width: 50%;">
		    				<div class="nav-link" style="text-align: center;" id="pills-tab-2" data-toggle="pill" data-target="#tab-2" role="tab" aria-controls="tab-2" aria-selected="false">
		    	 				<span>Procurement Chart</span> 
		    				</div>
		  				</li>
					</ul>
	   			</div>
			</div> -->
	
       		<div class="card-body">
       			<div class="tab-content" id="pills-tabContent">
            		<div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="pills-tab-1">
             			<div class="table-responsive">
              				<table class="table  table-hover table-bordered" id="myTable" style="width: 100%;">
								<thead class="center">
									<tr>
										<th width="5%">Expand</th>
										<th width="5%">SN</th>
										<th width="10%">Task No.</th>
										<th width="20%">Task Name</th>
										<th width="20%">Assignee</th>
										<th width="10%">Start Date</th>
										<th width="10%">Finish Date</th>
										<th width="10%">Demand No</th>
										<th width="10%">Progress</th>
									</tr>
								</thead>
                 				<tbody>
                       				<%if(msProcurementList!=null && msProcurementList.size()>0) {
	                       				int count = 0;
	                               	 	List<Object[]> level1msProcurementList = msProcurementList.stream().filter(e -> e[8].toString().equalsIgnoreCase("1") ).collect(Collectors.toList());
	                       				for(Object[] level1 : level1msProcurementList) {
	                                    	List<Object[]> level2msProcurementList = msProcurementList.stream().filter(e -> e[8].toString().equalsIgnoreCase("2") && e[7].toString().equalsIgnoreCase(level1[6].toString())).collect(Collectors.toList());

                       				%>
                       					<tr>
											<td class="center">
												<%if(level2msProcurementList!=null && level2msProcurementList.size()>0) {%>
													<span class="clickable" data-toggle="collapse" id="row_<%=level1[0] %>" data-target=".row_<%=level1[0]  %>">
														<button class="btn btn-sm btn-success" id="btn<%=level1[0]  %>"  onclick="loadSubTasks('<%=level1[0]  %>','<%=level1[6]  %>', 2)">
															<i class="fa fa-plus"  id="fa<%=level1[0] %>"></i> 
														</button>
													</span>
												<%} %>
											</td> 
											<td class="center"><%=++count %></td>
											<td><%=level1[9]!=null?StringEscapeUtils.escapeHtml4(level1[9].toString()):"-" %></td>
											<td><%=level1[10]!=null?StringEscapeUtils.escapeHtml4(level1[10].toString()):"-" %></td>
											<td><%=level1[4]!=null?StringEscapeUtils.escapeHtml4(level1[4].toString()):"-" %>, <%=level1[5]!=null?StringEscapeUtils.escapeHtml4(level1[5].toString()):"-" %></td>
											<td class="center"><%=level1[11]!=null?fc.sdfTordf(level1[11].toString()):"-" %></td>
											<td class="center"><%=level1[12]!=null?fc.sdfTordf(level1[12].toString()):"-" %></td>
											<td><%=level1[19]!=null?StringEscapeUtils.escapeHtml4(level1[19].toString()):"-" %></td>
							 				<td>
							 
							 					<%if(Integer.parseInt(level1[15].toString())>0){ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
														<div class="progress-bar progress-bar-striped
															<%if(Integer.parseInt(level1[15].toString())<=100 && Integer.parseInt(level1[15].toString())>75){ %>
																bg-success
															<%} else if(Integer.parseInt(level1[15].toString())<=75 && Integer.parseInt(level1[15].toString())>50){ %>
																bg-info
															<%} else if(Integer.parseInt(level1[15].toString())<=50 && Integer.parseInt(level1[15].toString())>25){ %>
																bg-warning 
															<%} else if(Integer.parseInt(level1[15].toString())<=25 && Integer.parseInt(level1[15].toString())>0){ %>
																bg-danger
															<%}  %>
															" role="progressbar" style=" width: <%=level1[15].toString() %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=level1[15]!=null?StringEscapeUtils.escapeHtml4(level1[15].toString()):" - " %>
														</div> 
													</div> 
												<%}else{ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:red !important;color: #fff;font-weight: bold;  "  >
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
<script type="text/javascript">

$(document).ready(function() {
    $('#myTable').DataTable({
        "lengthMenu": [10, 25, 50, 75, 100],
        "pagingType": "simple",
        "pageLength": 10,
        "order": [[1, 'asc']],
        "columnDefs": [
            { "orderable": false, "targets": 0 }
        ],
    });
});

function loadSubTasks(msTaskId, parentId, level) {
    var button = $("#btn" + msTaskId);
    var icon = $("#fa" + msTaskId);

    if (button.hasClass("btn-success")) {
        // Prevent duplicate rendering
        if ($(".trclass" + msTaskId).length > 0) {
            $(".row_" + msTaskId).collapse("show");
            button.removeClass("btn-success").addClass("btn-danger");
            icon.removeClass("fa-plus").addClass("fa-minus");
            return;
        }

        Swal.fire({ title: 'Loading...', allowOutsideClick: false, didOpen: function () { Swal.showLoading(); } });

        $.ajax({
            url: 'MSProjectSubLevelsList.htm',
            type: 'GET',
            data: {
                parentId: parentId,
                level: level,
                projectId: '<%=projectId%>',
                listfor: 'P',
            },
            success: function (data) {
                var tasks = JSON.parse(data);
                var rowsHtml = "";

                tasks.forEach(function (item) {
                    var task = item.data;
                    var hasChild = item.hasChild;

                    var taskId = task[0];
                    var taskNo = task[9] || "-";
                    var taskName = task[10] || "-";
                    var assignee = (task[4] || "-") + ", " + (task[5] || "-");
                    var startDate = task[11] ? formatDate(task[11]) : "-";
                    var finishDate = task[12] ? formatDate(task[12]) : "-";
                    var progress = parseInt(task[15]) || 0;
                    var demandNo = task[19] || "-";
                    var childId = task[6]; // Parent reference for next level

                    var progressBar = "";

                    if (progress > 0) {
                        var bgColor = "bg-danger";
                        if (progress > 75) bgColor = "bg-success";
                        else if (progress > 50) bgColor = "bg-info";
                        else if (progress > 25) bgColor = "bg-warning";

                        progressBar += '<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">';
                        progressBar += '<div class="progress-bar progress-bar-striped ' + bgColor + '" role="progressbar"';
                        progressBar += ' style="width: ' + progress + '%;" aria-valuenow="' + progress + '" aria-valuemin="0" aria-valuemax="100">';
                        progressBar += progress + '</div></div>';
                    } else {
                        progressBar += '<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">';
                        progressBar += '<div class="progress-bar" role="progressbar"';
                        progressBar += ' style="width: 100%; background-color:red !important;color: #fff;font-weight: bold;">';
                        progressBar += 'Not Started</div></div>';
                    }

                    rowsHtml += '<tr class="collapse show row_' + msTaskId + ' trclass' + msTaskId + '">';
                    rowsHtml += '<td></td>';
                    if (hasChild) {
                        rowsHtml += '<td class="center">';
                        rowsHtml += '<span class="clickable" id="row_' + taskId + '" data-toggle="collapse" data-target=".row_' + taskId + '">';
                        rowsHtml += '<button class="btn btn-sm btn-success" id="btn' + taskId + '" onclick="loadSubTasks(\'' + taskId + '\', \'' + childId + '\', ' + (level + 1) + ')">';
                        rowsHtml += '<i class="fa fa-plus" id="fa' + taskId + '"></i>';
                        rowsHtml += '</button></span></td>';
                    } else {
                        rowsHtml += '<td></td>';
                    }

                    var indent = '';
                    for (var i = 1; i < level; i++) {
                        indent += '&emsp;';
                    }
                    rowsHtml += '<td>' + indent + taskNo + '</td>';

                    rowsHtml += '<td>' + taskName + '</td>';
                    rowsHtml += '<td>' + assignee + '</td>';
                    rowsHtml += '<td class="center">' + startDate + '</td>';
                    rowsHtml += '<td class="center">' + finishDate + '</td>';
                    rowsHtml += '<td>' + demandNo + '</td>';
                    rowsHtml += '<td>' + progressBar + '</td>';
                    rowsHtml += '</tr>';
                });

                $("#row_" + msTaskId).closest("tr").after(rowsHtml);
                button.removeClass("btn-success").addClass("btn-danger");
                icon.removeClass("fa-plus").addClass("fa-minus");

                Swal.close();
            },
            error: function () {
                Swal.fire("Error loading sub-tasks", "", "error");
            }
        });
    } else {
        $(".row_" + msTaskId).collapse("hide");
        button.removeClass("btn-danger").addClass("btn-success");
        icon.removeClass("fa-minus").addClass("fa-plus");
    }
}

function formatDate(dateStr) {
    var date = new Date(dateStr);
    var dd = String(date.getDate()).padStart(2, '0');
    var mm = String(date.getMonth() + 1).padStart(2, '0'); // January is 0!
    var yyyy = date.getFullYear();
    return dd + '-' + mm + '-' + yyyy;
}

</script>			
</body>
</html>