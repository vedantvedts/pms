<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>TCC VIEW</title>
<style type="text/css">
.input-group-text {
	font-weight: bold;
}

label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

hr {
	margin-top: -2px;
	margin-bottom: 12px;
}

b {
	font-family: 'Lato', sans-serif;
}
</style>
</head>
<body>
	<%
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

	List<Object[]> TccMemberList = (List<Object[]>) request.getAttribute("TccMemberList");
	Object[] TccData = (Object[]) request.getAttribute("TccData");
	%>

	<%
		String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%><center>
		<div class="alert alert-danger" role="alert">
			<%=ses1%>
		</div>
	</center>
	<%
		}
	if (ses != null) {
	%>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses%>
		</div>
	</center>
	<%
		}
	%>



	<div class="container">
		<div class="row" style="">
			<div class="col-md-12">

				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-12 " align="center">
								<h4>Technology Council Committee</h4>
							</div>
						</div>
					</div>

					<div class="card-body">


						<input type="hidden" name="pfmstccid" value="<%=TccData[0]%>">
						<div  class="col-md-12">
						 <table border='0'>

							<tbody>
								<tr>

									<td><label class="control-label">Chairperson </label></td><td>&emsp; : &emsp;</td><td><%=TccData[3]%> (<%= TccData[5]%>)</td>

								</tr>
								<tr>

									<td><label class="control-label">Member Secretary   </label></td><td>&emsp; : &emsp;</td><td><%=TccData[4]%> (<%=TccData[6]%>)</td>

								</tr>
								<%
									int count = 0;
									for (Object[] obj : TccMemberList) {
									count++;
								%>


								<tr>

									<td><label class="control-label">Member</label></td><td>&emsp; :&emsp;</td> <td><%=obj[1]%> (<%=obj[3]%>)</td>

								</tr>
								<%	}	%>
							</tbody>
						</table><br/><hr></br>
						  <label class="control-label">Valid From &emsp; :&emsp; </label> <b> <%=sdf.format(TccData[1])%> </b> &emsp; &emsp; &emsp;
						    <label class="control-label">Valid To &emsp; :&emsp; </label> <b> <%=sdf.format(TccData[2])%> </b> 
						
						</div>
					</div>
					
					<div class="card-footer">
						<div class="row">
							<div class="col-md-12 " align="center">
								<form action="TCCModify.htm" method="POST" name="myfrm" id="myfrm">

							<div class="form-group" align="center">
								<a class="btn  btn-sm  add"
									href="TCCAdd.htm">ADD</a>



								<button type="submit" class="btn  btn-sm  edit"
									formaction="TCCModify.htm">EDIT</button>
								<input type="hidden" name="Pfmstccid" value="<%=TccData[0]%>">

								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <a class="btn  btn-sm  prints"
									href="TechnicalCommeetList.htm">LIST</a>


							</div>

						</form>
							</div>
						</div>
					</div>
					
				</div>
				<!-- card end -->

			</div>
		</div>
	</div>




	<script type="text/javascript">
		function MemberAdd() {

			var colnerow = $('#myTable20 tr:last').attr('id');

			var MemberRowId = colnerow.split("Memberrow");
			var MemberId = Number(MemberRowId[1]) + 1
			var row = $("#myTable20 tr").last().clone().find('textarea')
					.val('').end();

			row.attr('id', 'Memberrow' + MemberId);

			row.find('#Member' + MemberRowId[1])
					.attr('id', 'Member' + MemberId);

			row.find('#MemberMinus' + MemberRowId[1]).attr('id',
					'MemberMinus' + MemberId);

			$("#myTable20").append(row);

			$("#MemberAdd").val(PaymentRowId);
		}

		function Memberremove(elem) {

			var id = $(elem).attr("id");
			var Membersplitid = id.split("MemberMinus");
			var Memberremoveid = "#Memberrow" + Membersplitid[1];

			$(Memberremoveid).remove();

			$('#Member' + Membersplitid[0]).prop("required", false);

		}
	</script>
</body>
</html>