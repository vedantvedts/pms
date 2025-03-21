<%@page import="java.util.stream.Collectors"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>
<title>OFFICER DETAILS</title>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

.table .font {
	font-family: 'Muli', sans-serif !important;
	font-style: normal;
	font-size: 13px;
	font-weight: 400 !important;
}

.table button {
	background-color: Transparent !important;
	background-repeat: no-repeat;
	border: none;
	cursor: pointer;
	overflow: hidden;
	outline: none;
	text-align: left !important;
}

.table td {
	padding: 5px !important;
}

.resubmitted {
	color: green;
}

.fa {
	font-size: 1.20rem;
}

.datatable-dashv1-list table tbody tr td {
	padding: 8px 10px !important;
}

.table-project-n {
	color: #005086;
}

#table thead tr th {
	padding: 0px 0px !important;
}

#table tbody tr td {
	padding: 2px 3px !important;
}

/* icon styles */
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

.width {
	width: 270px !important;
}

/* Container for the tabs */
.tabs-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    margin-top: 20px;
}

/* Individual tab styling */
.tab {
    padding: 10px 20px;
    margin: 5px;
    background-color: #81D4FA;
  /*   border: 1px solid #ccc; */
    border-radius: 5px;
    font-size:1rem;
    font-weight:600;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

/* Hover effect for tabs */
.tab:hover {
    background-color: #ddd;
}

/* Active tab styling */
.tab.active {
    background-color: #4CAF50;
    color: white;
    border-color: #4CAF50;
}

/* When clicked, show content */
.tab-content {
    display: none;
}

/* Display content of active tab */
.tab-content.active {
    display: block;
    margin-top: 20px;
}
.tab-content {
    display: none; /* Hide all tab contents initially */
    padding: 15px;
   
    margin-top: 10px;

}

/* Show the active content */
.tab-content.active {
    display: block;
}
</style>
</head>
<body>

	<%
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	List<Object[]> SpecificarionMasterList = (List<Object[]>) request.getAttribute("SpecificarionMasterList");
	List<String> specTypesList = Arrays.asList("FS", "OS", "PS", "DS", "IS", "MS", "ES", "MT", "IN", "CS");
	%>


	<% String ses=(String)request.getParameter("result");
	 	String ses1=(String)request.getParameter("resultfail");
		if(ses1!=null){
		%>
		<div align="center">
			<div class="alert alert-danger" role="alert">
		    <%=ses1 %>
		    </div>
		</div>
		<%}if(ses!=null){ %>
		<div align="center">
			<div class="alert alert-success" role="alert" >
		    	<%=ses %>
			</div>
		</div>
	<%} %>

	<div class="container-fluid">
		<div class="col-md-12">

			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md-7">
							<h4>
								<b>Specification Master List</b>
							</h4>
						</div>
						<div class="col-md-4">
							<form action=SpecificationMasterExcel.htm method="post"
								id="excelForm" enctype="multipart/form-data">
								<div class="row">

									<div class="col-md-12">
										Download Excel
										<button class="btn btn-sm" type="submit" name="Action"
											value="GenerateExcel" formaction="SpecificationMasterExcel.htm"
											formmethod="post" formnovalidate="formnovalidate">
											<i class="fa fa-file-excel-o" aria-hidden="true"
												style="color: green;"></i>
										</button>
									</div>
								</div>
								
								<input type="hidden" name="Type" id="specType" value="A">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

							</form>
						</div>
					</div>
				</div>
				<div class="tabs-container">
				    <div class="tab active" data-target="A">Total List</div>
				    <div class="tab" data-target="FS">Functional Specification</div>
				    <div class="tab" data-target="OS">Operational Specification</div>
				    <div class="tab" data-target="PS">Performance Specification</div>
				    <div class="tab" data-target="DS">Deployment Specification</div>
				    <div class="tab" data-target="IS">Interface Specification</div>
				    <div class="tab" data-target="MS">Mechanical Specification</div>
				    <div class="tab" data-target="ES">Electrical Specification</div>
				    <div class="tab" data-target="MT">Maintenance Specification</div>
				    <div class="tab" data-target="IN">Installation Specification</div>
				    <div class="tab" data-target="CS">Constraints Specification</div>
				</div>
				
				<form action="SpecificationMasterAdd.htm" method="post" name="frm1">	
				
					<div class="card-body tab-content active" id="A">
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped table-condensed mytable" id="myTable">
								<thead style="text-align: center;">
									<tr>
										<th style="width:5%;">SN</th>
										<!--<th>Specification Name</th> -->
										<th style="width:20%;">Specification Code</th>
									
										<th style="width:20%;">Parameter</th>
										<th style="width:10%;">Minimum Value</th>
										<th style="width:10%;"> Typical Value</th>
										<th style="width:10%;">Maximum Value</th>
										<th style="width:10%;"> Unit</th>
									</tr>
								</thead>
								<tbody>
									<% for (Object[] obj : SpecificarionMasterList) { %>
										<tr<%if(obj[14].toString().equalsIgnoreCase("0")){ %> style="background: #9ae59a;"	 <%} %>>
								  	 		<td align="center">
									   			<input type="radio" name="Did" value=<%=obj[0]%> <%if(!obj[14].toString().equalsIgnoreCase("0")){ %>class="subDid" <%} else {%>class="Did"<%} %> > 
											</td>
									
											<td><%=obj[5]%></td>
									
											<td><%=obj[3]%></td>
											<td><%=obj[16]!=null?obj[16]:"-"%></td>
											<td><%=obj[6]!=null?obj[6]:"-"%></td>
											<td><%=obj[15]!=null ? obj[15]:"-"%></td>
										 	<td><%=obj[4]!=null?obj[4]:"" %></td> 
										</tr>
									<% } %>
								</tbody>
							</table>
						</div>
					</div>
							
	
					<%for(String specType : specTypesList) {%>
						
						<div class="card-body tab-content" id="<%=specType%>">
							<div class="table-responsive">
								<table
									class="table table-bordered table-hover table-striped table-condensed mytable"
									id="myTable1">
									<thead style="text-align: center;">
									<tr>
									<th style="width:5%;">SN</th>
									<!--<th>Specification Name</th> -->
									<th style="width:20%;">Specification Code</th>
									<!-- <th style="width:10%;">Specification Type</th> -->
									<th style="width:20%;">Parameter</th>
									<th style="width:10%;">Minimum Value</th>
									<th style="width:10%;"> Typical Value</th>
									<th style="width:10%;">Maximum Value</th>
									<th style="width:10%;"> Unit</th>
									</tr>
									</thead>
									<tbody>
										<%
										List<Object[]>fsList=SpecificarionMasterList!=null&&SpecificarionMasterList.size()>0
															?SpecificarionMasterList.stream().filter(e->e[18]!=null &&  e[18].toString().equalsIgnoreCase(specType))
																	.collect(Collectors.toList()):new ArrayList<>();
																			
										
										for (Object[] obj : fsList) {
										%>
											<tr<%if(obj[14].toString().equalsIgnoreCase("0")){ %> style="background: #9ae59a;"	 <%} %>>
									   			<td align="center">
									   				<input type="radio" name="Did" value=<%=obj[0]%> <%if(!obj[14].toString().equalsIgnoreCase("0")){ %>class="subDid" <%} else {%>class="Did"<%} %> > 
									   			</td>
												<%-- <td><%=obj[1]%></td> --%>
												<td><%=obj[5]%></td>
											
												<td><%=obj[3]%></td>
												<td><%=obj[16]!=null?obj[16]:"-"%></td>
												<td><%=obj[6]!=null?obj[6]:"-"%></td>
												<td><%=obj[15]!=null ? obj[15]:"-"%></td>
												 <td><%=obj[4]!=null?obj[4]:"-" %></td> 
											</tr>
										<% } %>
									</tbody>
								</table>
							</div>
						</div>
					<%} %>
					
				
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="hidden" name="levelType" id="levelType">
					<div align="center">

						<div class="button-group mb-2">
							<button type="submit" class="btn btn-sm add" name="sub" value="add">ADD</button>
							<button type="submit" class="btn btn-sm edit" name="sub" value="edit" onclick="Edit(frm1)">EDIT</button>
							<button type="submit" class="btn btn-danger btn-sm delete" name="sub" value="delete" formaction="SpecificationMasterDelete.htm" formmethod="get" onclick="return deleteSpecification()">DELETE</button>
						</div>
					</div>
				</form>

			</div>
		</div>

	</div>



	<div class="modal" id="loader">
		<!-- Place at bottom of page -->
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".mytable").DataTable({
				'aoColumnDefs' : [ {
					'bSortable' : false,

					'aTargets' : [ -1 ]
				/* 1st one, start by the right */
				} ]
			});
		});
		
		function Edit(myfrm){
			 var fields = $("input[name='Did']").serializeArray();

			  if (fields.length === 0){
			alert("Please Select A Record");
			 event.preventDefault();
			return false;
			}
				  return true;	
		}
		
/* 		document.querySelectorAll('.tab').forEach(function(tab) {
		    tab.addEventListener('click', function() {
		        // Remove 'active' class from all tabs
		        document.querySelectorAll('.tab').forEach(function(tab) {
		            tab.classList.remove('active');
		        });

		        // Add 'active' class to clicked tab
		        tab.classList.add('active');

		        // Optionally, display corresponding content for each tab here
		        // Example:
		        // let index = Array.from(tab.parentElement.children).indexOf(tab);
		        // showContentForTab(index);
		    });
		}); */
		
		
		$('.tab').on('click', function () {
		    // Remove 'active' class from all tabs
		    $('.tab').removeClass('active');
		    // Add 'active' class to the clicked tab
		    $(this).addClass('active');

		    // Hide all tab contents
		    $('.tab-content').removeClass('active');
		    // Show the content corresponding to the clicked tab
		    const targetId = $(this).data('target');
			
		    $('#specType').val(targetId)
		    $('#' + targetId).addClass('active');
		});
		
		
		// Disable and Enable Edit button based on main and sub-level
		$('.subDid').on('click', function() {
			$('.edit').prop('disabled', true);
		});
		$('.Did').on('click', function() {
			$('.edit').prop('disabled', false);
		});
		
		
		function deleteSpecification() {

			var fields = $("input[name='Did']").serializeArray();

			var checkedInput = $("input[name='Did']:checked");
			var className = checkedInput.attr("class");

			console.log("Class Name:", className);

			if (fields.length === 0){
				alert("Please Select A Record");
				event.preventDefault();
				return false;
			}else {
				if(className=="Did") {
					$('#levelType').val('M');
					return confirm('Are you sure you want to Delete?\nDeleting a main level will also remove all its sub-levels.');
				}else {
					$('#levelType').val('S');
					return confirm("Are you sure to Delete?");
				}
			}
		}
		
	</script>
</body>
</html>