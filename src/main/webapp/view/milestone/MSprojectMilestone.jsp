<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
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
label {
	font-weight: bold;
	font-size: 14px;
}

.table thead tr, tbody tr {
	font-size: 14px;
}

body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}

h6 {
	text-decoration: none !important;
}

.multiselect-container>li>a>label {
	padding: 4px 20px 3px 20px;
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
	width: 120px;
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

.width {
	width: 210px !important;
}

.bootstrap-select {
	width: 400px !important;
}

input[type=checkbox] {
	accent-color: green;
}
</style>

</head>
<body>
	<%
List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
List<Object[]> mstaskList=(List<Object[]>)request.getAttribute("mstaskList");
String ProjectId=(String)request.getAttribute("ProjectId");

FormatConverter fc = new FormatConverter();
%>
	<div class="row">
		<div class="col-md-7"></div>
		<div class="col-md-2">
			<label class="control-label" style="float: right">Project
				Name :</label>
		</div>
		<div class="col-md-2" style="margin-top: -7px;">
			<form class="form-inline" method="POST"
				action="MSProjectMilestone.htm">
				<select class="form-control selectdee" id="ProjectId"
					required="required" name="ProjectId">
					<option disabled="disabled" selected value="">Choose...</option>
					<% for (Object[] obj : ProjectList) {
    										String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
    										%>
					<option value="<%=obj[0]%>"
						<%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>
						selected="selected" <%} %>>
						<%=obj[4]+projectshortName%>
					</option>
					<%} %>
				</select> <input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input id="submit" type="submit"
					name="submit" value="Submit" hidden="hidden">
			</form>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0px;">
					<div class="row card-header" style="background: transparent;">
						<div class="col-md-6">
							<h5>
								<%if(ProjectId!=null){
						Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");
						%>
								<%=ProjectDetail[2] %>
								(
								<%=ProjectDetail[1] %>
								)
								<%} %>
							</h5>
						</div>
						<div class="col-md-6">
							<form action="#" style="margin-top: -0.3rem;">
								<div class="d-flex justify-content-around">
									<button type="submit" class="btn btn-sm btn-outline-info" formaction="MSprojectGanttChart.htm" >Gantt Chart</button>
									<button type="submit" class="btn btn-sm btn-outline-info" formaction="MSprojectCriticalPath.htm" >Critical Paths</button>
									<button type="submit" class="btn btn-sm btn-outline-info" formaction="MSprojectProcurementList.htm" >Procurement List</button>
									<button type="submit" class="btn btn-sm btn-outline-info" formaction="MSprojectProcurementStatus.htm" >Procurement Status</button>
									<button type="submit" class="btn btn-sm btn-outline-info" formaction="MSprojectProcurementGanttChart.htm" >Procurement Gantt Chart</button>
								</div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="ProjectId" value="<%=ProjectId%>">
							</form>
						</div>
					</div>
				</div>
				<div class="card-body" style="background: white">
					<div class="table-responsive">
						<table class="table  table-hover table-bordered" id="myTable" style="width: 100%;">
							<thead class="center">
								<tr>
									<th width="5%">Expand</th>
									<th width="5%">SN</th>
									<th width="10%">Task No.</th>
									<th width="30%">Task Name</th>
									<th width="20%">Assignee</th>
									<th width="10%">Start Date</th>
									<th width="10%">Finish Date</th>
									<th width="10%">Progress</th>
								</tr>
							</thead>
							<tbody>
								<%if(mstaskList!=null && mstaskList.size()>0) {
                       				int count = 0;
                               	 	List<Object[]> level1mstaskList = mstaskList.stream().filter(e -> e[8].toString().equalsIgnoreCase("1") ).collect(Collectors.toList());
                       				for(Object[] level1 : level1mstaskList) {
                                    	List<Object[]> level2mstaskList = mstaskList.stream().filter(e -> e[8].toString().equalsIgnoreCase("2") && e[7].toString().equalsIgnoreCase(level1[6].toString())).collect(Collectors.toList());

                       			%>
                      				<tr>
										<td class="center">
											<%if(level2mstaskList!=null && level2mstaskList.size()>0) {%>
												<span class="clickable" data-toggle="collapse" id="row_<%=level1[0] %>" data-target=".row_<%=level1[0]  %>">
													<button class="btn btn-sm btn-success" id="btn<%=level1[0]  %>" onclick="loadSubTasks('<%=level1[0]  %>','<%=level1[6]  %>', 2)">
														<i class="fa fa-plus"  id="fa<%=level1[0] %>"></i> 
													</button>
												</span>
											<%} %>
										</td> 
										<td class="center"><%=++count %></td>
										<td><%=level1[9]!=null?level1[9]:"-" %></td>
										<td><%=level1[10]!=null?level1[10]:"-" %></td>
										<td><%=level1[4]!=null?level1[4]:"-" %>, <%=level1[5]!=null?level1[5]:"-" %></td>
										<td class="center"><%=level1[11]!=null?fc.sdfTordf(level1[11].toString()):"-" %></td>
										<td class="center"><%=level1[12]!=null?fc.sdfTordf(level1[12].toString()):"-" %></td>
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
														<%=level1[15].toString() %>
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
</body>

<script type="text/javascript">

$(document).ready(function() {
   $('#ProjectId').on('change', function() {
     $('#submit').click();

   });
});

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
                projectId: '<%=ProjectId%>',
                listfor: 'L'
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
</html>