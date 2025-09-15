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
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>OFFICER MASTER EDIT</title>
<spring:url value="/resources/css/admin/DesignationEdit.css" var="designationEdit" />
<link href="${designationEdit}" rel="stylesheet" />

</head>
<body>

	<%
	Object[] designationdata = (Object[]) request.getAttribute("designationdata");
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

			<div class="col-sm-12 mt-3" >
				<div class="card shadow-nohover">
					<div class="card-header bg-header">
						<b class="text-white">Designation Edit </b>
					</div>
					<div class="card-body">


						<form name="myfrm" action="DesignationEditSubmit.htm" id="editfrm"
							method="POST">

							<div class="row">
								<div class="col-md-1"></div>
								<div class="col-md-2">
									<div class="form-group">
										<label>Designation Code:<span class="mandatory">*</span></label> <input
											class="form-control field-w80 form-control description-input" type="text"
											name="desigcode" id="desigcode" required="required"
											maxlength="10"
											value="<%=designationdata[1]!=null?StringEscapeUtils.escapeHtml4(designationdata[1].toString()): ""%>">
									</div>
								</div>


								<div class="col-md-2">
									<div class="form-group">
										<label>Designation :<span class="mandatory">*</span></label> <input
											class="form-control field-w100 form-control description-input" type="text"
											name="designation" id="designation" required="required"
											maxlength="100" 
											value="<%=designationdata[2]!=null?StringEscapeUtils.escapeHtml4(designationdata[2].toString()): ""%>">
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label>Limit :<span class="mandatory">*</span></label> <input
											class="form-control field-w80 form-control numeric-only" type="number" name="limit"
											required="required"
											value="<%=designationdata[3]!=null?StringEscapeUtils.escapeHtml4(designationdata[3].toString()): ""%>">
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label>SrNo :<span class="mandatory">*</span></label> <input
											class="form-control field-w80 numeric-only " type="number"
											name="desigsr" required="required"
											value="<%=designationdata[4]!=null?StringEscapeUtils.escapeHtml4(designationdata[4].toString()): ""%>">
									</div>
								</div>
								
								<div class="col-md-2">
									<div class="form-group">
										<label>Desig Cadre :<span class="mandatory">*</span></label> 
										<select class="form-control" name="desigCadre">
											<option value="DRDS" <%if(designationdata[5]!=null && designationdata[5].toString().equalsIgnoreCase("DRDS")) {%>selected<%} %> >DRDS</option>
											<option value="DRTC" <%if(designationdata[5]!=null && designationdata[5].toString().equalsIgnoreCase("DRTC")) {%>selected<%} %>>DRTC</option>
											<option value="Others" <%if(designationdata[5]!=null && designationdata[5].toString().equalsIgnoreCase("Others")) {%>selected<%} %>>Others</option>
										</select>
									</div>
								</div>
								
								<div class="col-md-2"></div>
								<input type="hidden" name="olddesigsr" value="<%=designationdata[4]%>" />
							</div>



							<div align="center">
								<button type="button" class="btn btn-sm submit"
									onclick="return Designationcheck('editfrm');">SUBMIT</button>
								<a class="btn  btn-sm  back" href="DesignationMaster.htm">BACK</a>
							</div>

							<input type="hidden" name="desigid"
								value="<%=designationdata[0]%>"> <input type="hidden"
								name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>


					</div>
				</div>
			</div>

		</div>

	</div>


</body>


<script type="text/javascript">
	function Designationcheck(frmid) {

		 var desigcode = $('#desigcode').val().trim();
		 var designation = $('#designation').val().trim();
		 
		   if (!desigcode) {
		        alert('Designation Code is required.');
		        return;
		    }
		    if (!designation) {
		        alert('Designation Name is required.');
		        return;
		    }
		 
		$.ajax({
			type : "GET",
			url : "DesignationEditCheck.htm",
			data : {
				dcode : desigcode,
				dname : designation,
				desigid :<%=designationdata[0]%>
	},
			datatype : 'json',
			success : function(result) {
				var ajaxresult = JSON.parse(result);
				 var messages = [];
				if (ajaxresult[0] == 1) {
					 messages.push('Designation Code Already Exists');
				}
				if (ajaxresult[1] == 1) {
					 messages.push('Designation Name Already Exists');
				}

			  if (messages.length > 0) {
	                alert(messages.join('\n'));
	            } else {
	                var ret = confirm('Are you sure you want to submit?');
	                if (ret) {
	                    $('#' + frmid).submit();
	                }
	            }
			}
		});
	}
</script>


</html>