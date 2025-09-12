<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<spring:url value="/resources/css/admin/IndividualNoticeList.css" var="individualNoticeList" />
<link href="${individualNoticeList}" rel="stylesheet" />

<title>NOTICE LIST</title>
</head>
<body>
	<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> notiecList=(List<Object[]>)request.getAttribute("NotiecList");
String Fromdate=(String)request.getAttribute("fdate");
String Todate=(String)request.getAttribute("tdate");

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


	<br>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row m-minus">
							<h5>Notice List</h5>
							<div class="col-lg-5"></div>
							<form class="form-inline " method="POST"
								action="${pageContext.request.contextPath}/IndividualNoticeList.htm">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <label class="label">From
									Date:</label> <input class="form-control form-control date w-120"
									data-date-format="dd-mm-yyyy" id="datepicker1" name="fdate"
									required="required"
									<%if(Fromdate!=null){%> value="<%=StringEscapeUtils.escapeHtml4(Fromdate) %>" <%} %>>


								<label class="label-toDate">To
									Date:</label> <input class="form-control w-120" data-date-format="dd-mm-yyyy"
									id="datepicker3" name="tdate"
									<%if(Todate!=null){%> value="<%=StringEscapeUtils.escapeHtml4(Todate) %>" <%} %>>

								<button type="submit" class="btn btn-primary btn-sm submit ml-3" id="submit">SUBMIT</button>


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
									<th class="w-9">From Date</th>
									<th class="w-9">To Date</th>
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
									<td><%=notiec[2]!=null?sdf.format(notiec[2]):" - "%></td>
									<td><%=notiec[3]!=null?sdf.format(notiec[3]):" - "%></td>
									<td class="break" ><%=notiec[1]!=null?StringEscapeUtils.escapeHtml4(notiec[1].toString()): " - "%></td>

									<td class="left width">


										<form action="NoticeEditRevoke.htm" method="POST" name="myfrm" class="d-inline">
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