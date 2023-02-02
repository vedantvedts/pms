<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>NOTICE LIST</title>
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
</style>
</head>
<body>
	<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> notiecList=(List<Object[]>)request.getAttribute("NotiecList");
String Fromdate=(String)request.getAttribute("fdate");
String Todate=(String)request.getAttribute("tdate");

%>

	<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>


	<center>

		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</center>
	<%}if(ses!=null){ %>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</center>


	<%} %>



	<br>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header">
						<div class=row>
							<h5>Notice List</h5>
							<div class="col-lg-5"></div>
							<form class="form-inline " method="POST"
								action="${pageContext.request.contextPath}/IndividualNoticeList.htm">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <label
									style="margin-left: 80px; margin-right: 20px; font-weight: 800">From
									Date:</label> <input class="form-control form-control date"
									data-date-format="dd-mm-yyyy" id="datepicker1" name="fdate"
									required="required" style="width: 120px;"
									<%if(Fromdate!=null){%> value="<%=(Fromdate) %>" <%} %>>


								<label
									style="margin-left: 20px; margin-right: 20px; font-weight: 800">To
									Date:</label> <input class="form-control" data-date-format="dd-mm-yyyy"
									id="datepicker3" name="tdate" style="width: 120px;"
									<%if(Todate!=null){%> value="<%=(Todate) %>" <%} %>>

								<button type="submit" class="btn btn-primary btn-sm submit"
									style="margin-left: 12px;" id="submit">SUBMIT</button>


							</form>
						</div>
					</div>
					<div class="card-body">
						<table
							class="table table-bordered table-hover table-striped table-condensed "
							id="myTable">
							<thead>
								<tr>
									<th>Sr No.</th>
									<th style="width: 9%;">From Date</th>
									<th style="width: 9%;">To Date</th>
									<th>Notice</th>
									<th>Edit/Revoke</th>
								</tr>
							</thead>
							<tbody>
								<%if(notiecList!=null){
			                                        int srno=1;
			                                        %>
								<%for(Object[] notiec:notiecList){ %>
								<tr>
									<td><%=srno++%></td>
									<td><%=sdf.format(notiec[2])%></td>
									<td><%=sdf.format(notiec[3])%></td>
									<td style="word-break: break-all;"><%=notiec[1]%></td>

									<td class="left width">


										<form action="NoticeEditRevoke.htm" method="POST" name="myfrm"
											style="display: inline">
							<!-- 				onsubmit="return confirm('Do you really want to Edit or Revoke');"> -->
											<button class="editable-click" name="sub" value="edit" >
												<div class="cc-rockmenu">
													<div class="rolling">
														<figure class="rolling_icon">
															<img src="view/images/edit.png">
														</figure>
														<span>Edit</span>
													</div>
												</div>
											</button>
											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" />


											<button  type="submit" name="sub" value="revoke" onclick="return deleteThis()">
												<div class="cc-rockmenu">
													<div class="rolling">
														<figure class="rolling_icon">
															<img src="view/images/remove.png">
														</figure>
														<span>Revoke</span>
													</div>
												</div>
											</button>
											<input type="hidden" id="noticeId" name="noticeId"
												value="<%=notiec[0]%>" /> <input type="hidden"
												name="${_csrf.parameterName}" value="${_csrf.token}" />

										</form>

									</td>

								</tr>
								<%}%>
								<%} %>
							</tbody>
							<tfoot>
								<tr>

									<td colspan="8" align="right"></td>
								</tr>

							</tfoot>

						</table>
					</div>
				</div>

			</div>
		</div>

	</div>

	<script type="text/javascript">
	$(function() {
		$('[data-toggle="tooltip"]').tooltip()
	})

	function Prints(myfrm) {

		var fields = $("input[name='btSelectItem']").serializeArray();

		if (fields.length === 0) {
			myalert();
			event.preventDefault();
			return false;
		}

		return true;

	}


</script>
	<script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
  

</script>
	<!-- <script type="text/javascript">


$('#fdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});





$('#tdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
</script> -->
	<script type="text/javascript">

var fromDate=null;
$("#datepicker1").change(function(){
	
	 fromDate = $("#datepicker1").val();


$('#datepicker3').daterangepicker({

	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	"minDate":fromDate,
	
	locale: {
    	format: 'DD-MM-YYYY'
		}
		
});
});
$('#datepicker1').daterangepicker({
	
	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	
	locale: {
    	format: 'DD-MM-YYYY'
		}
});

function deleteThis(){
	if ((window.confirm("Are you Sure To delete this notice?"))) {
			return true;
		}else{
			event.preventDefault();
			return false;
		}
}
</script>
</body>
</html>