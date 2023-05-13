<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat ,  java.util.stream.Collectors"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<style>
#projectname {
	display: flex;
	align-items: center;
	justify-content: flex-start;
}

#div1 {
	display: flex;
	align-items: center;
	justify-content: center;
}
#modalreqheader {
	background: #145374;
	height: 44px;
	display: flex;
	font-family: 'Muli';
	align-items: center;
	color: white;
}
.addreq {
	margin-left: -10%;
	margin-top: 5%;
}
.label{
color:#145374;
font-weight:bold;
}
.label>label{
font-size: 14px;
}
#main{
display: block;
}
#Approvededit,#Approve{
margin-left: -6%;
}
</style>
</head>
<body>
	<%List<Object[]> ProjectIntiationList=(List<Object[]>)request.getAttribute("ProjectIntiationList"); 
	String projectshortName=(String)request.getAttribute("projectshortName");
    String initiationid=(String)request.getAttribute("initiationid");
    String projectTitle=(String)request.getAttribute("projectTitle");
    List<Object[]>DemandList=(List<Object[]>)request.getAttribute("DemandList");
    List<Object[]>ProcurementList=(List<Object[]>)request.getAttribute("ProcurementList");
    %>
    	<%String ses=(String)request.getParameter("result"); 
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
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</div>
	<%} %>
	
			<div class="container-fluid" id="main">
			<div class="row">
				<div class="col-md-12">
					<div class="card shadow-nohover" style="box-shadow: 0px 5px 25px 0px rgba(0, 0, 0, 0.2);">
						<div class="row card-header"
							style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
							<div class="col-md-6" id="projecthead">
								<h5>
									<%="Procurement Plan for  Project "+projectshortName %>
								</h5>
							</div>
							<div class="col-md-6">
							<form class="form-inline" method="POST" action="ProjectProcurement.htm">
		<div class="row W-100" style="width:100%; margin-top: -1.5%;">
		<div class="col-md-4"></div>
			<div class="col-md-4" id="div1">
				<label class="control-label"
					style="font-size: 15px; color: #07689f;"><b>Project
						Name :</b></label>
			</div>
			<div class="col-md-4" style="margin-top: 3px;" id="projectname">
				<select class="form-control selectdee" id="project"
					required="required" name="project">
					<%
					if (!ProjectIntiationList.isEmpty()) {
						for (Object[] obj : ProjectIntiationList) {
					%>
					<option value="<%=obj[0] + "/" + obj[4] + "/" + obj[5]%>"
						<%if (obj[4].toString().equalsIgnoreCase(projectshortName)) {%>
						selected <%}%>><%=obj[4]%></option>
					<%
					}
					}
					%>
				</select>
			</div>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input id="submit" type="submit"
				name="submit" value="Submit" hidden="hidden">
		</div>
	</form>
							
							
							</div>
							</div>
							<div class="card-body" style="background: white; box-shadow: 2px 2px 2px gray;">
							 <div class="row" style="margin-top: 20px;">
     						 <div class="col-md-12">
 							<div class="table-responsive">
	   						<table class="table table-bordered table-hover table-striped table-condensed" id="myTable"> 
	   						<thead style=" text-align: center;">
	   						<tr>
	   						<th style="width:3%">Select</th>
	   						<th style="width:3%">SN</th>
	   						<th style="width:15%">Name of the item</th>
	   						<th style="width:30%">Purpose</th>
	   						<th style="width:15%">Source of supply</th>
	   						<th style="width:10%">Mode</th>
	   						<th style="width:5%">Cost</th>
	   						<th style="width:5%">Month</th>
	   						<th style="width:3%">Approval</th>
	   						</tr>
	   						</thead>
	   						<tbody>
	   						<%int count=1;
	   						if(!ProcurementList.isEmpty()){
	   						for(Object[]obj:ProcurementList)	{%>
	   						<tr align="center">
	   						<td ><input type="radio" id="Planid" name="Planid" value="<%=obj[0]%>" onchange="radioValue(<%=obj[0]%>)"></td>
	   						<td><%=count++ %></td>
	   						<td align="left"><%=obj[2] %></td>
	   						<td align="left"><%if(obj[3].toString().length()>100){%><%=obj[3].toString().substring(0, 100) %><%} else{%><%=obj[3]%><%} %></td>
	   						<td align="left"><%=obj[4] %></td>
	   						<td><%=obj[5] %></td>
	   						<td align="right"><%=obj[6] %></td>
	   						<td><%=obj[10] %></td>
	   						<td><%if(obj[11].toString().equalsIgnoreCase("Y")) {%>YES<%}else{ %>NO<%} %></td>		
	   						</tr>
	   						<%} }%>
	   						</tbody>
	   						</table>
	   						<span class="radiovalue"><input type="hidden" value="0" id="radio"></span>
	   						<div class="center">
	   						<button type="button" class="btn btn-sm btn-info " onclick="show()"  style="font-weight: 500;">ADD</button>
	   						<button type="button" class="btn btn-sm btn-warning" onclick="showEditModal()" style="font-weight: 500;">EDIT</button>
	   						</div>
	   						</div>
	   						</div>
	   						</div>
							</div>
							</div>
							</div>
							</div>
							</div>



	<form class="form-horizontal" role="form"
		action="ProjectProcurementSubmit.htm" method="POST" id="myform1">
		<div class="modal fade bd-example-modal-lg" id="exampleModalLong"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content addreq" style="width: 130%;">
					<div class="modal-header" id="modalreqheader">
						<h5 class="modal-title" id="exampleModalLabel">Procurement
							Plan</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close" style="color: white">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="col-md-12">
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label>Item:</label><span class="mandatory" style="color: red;">*</span>
								</div>
								<div class="col-md-7">
									<input type="text" class="form-control" id="Item" name="Item"
										maxlength="300" >
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label>Purpose:</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-7">
									<input type="text" class="form-control" id="Purpose"
										name="Purpose" maxlength="450" style="line-height: 3rem"
										required="required">
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label>Source:</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-7">
									<input type="text" class="form-control" id="Source"
										name="Source" maxlength="300" required="required">
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label>Mode:</label><span class="mandatory" style="color: red;">*</span>
								</div>
								<div class="col-md-5">
									<div class="form-group">


										<select class="form-control" name="Mode" id="Mode"
											data-width="80%" data-live-search="true">
											<option value="" disabled="disabled" selected="selected">---Choose----</option>
											<%
											for (Object[] obj : DemandList) {
											%>
											<option value="<%=obj[0]%>"><%=obj[2]%></option>
											<%
											}
											%>
										</select>

									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-2 label">
									<label>Cost (in &#8377;):</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-3">
									<input type="text" id="cost" class="form-control" name="cost"
										placeholder="0.0" required="required"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								</div>
								<div class="col-md-3 label">
									<label>EPC Approval required</label><span class="mandatory"
										style="color: red;">*</span>
								</div>
								<div class="col-md-2" id="Approve">
									<input type="radio" name="Approved" value="Y">
									&nbsp;YES <input style="margin-left: 15px;" type="radio"
										name="Approved" value="N" checked> &nbsp;NO
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-6 label">
									<label>Estimated months after Project Sanction Date
										&nbsp;&nbsp;(T<sub>0</sub>)
									</label>
									<hr style="margin-left: 0% !important; width: 80%">
								</div>
							</div>
							<div class="row" style="margin-top: 1%">
								<div class="col-md-1 label">
									<label>Demand:</label>
								</div>
								<div class="col-md-2">
									<input style="width: 59%;" type="text" id="Demand"
										class="form-control" name="Demand" placeholder="Months"
										required="required" 
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								</div>
								<div class="col-md-1 label">
									<label>Tender:</label>
								</div>
								<div class="col-md-2">
									<input type="text" style="width: 59%;" id="Tender"
										class="form-control" name="Tender" placeholder="Months" onchange="checKDemand()"
										required="required"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								</div>
								<div class="col-md-1 label">
									<label>Order:</label>
								</div>
								<div class="col-md-2">
									<input type="text" id="Order" style="width: 59%;"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
										class="form-control" name="Order" placeholder="Months"
										required="required"onchange="chechKTender()">
								</div>
								<div class="col-md-1 label">
									<label>Payment:</label>
								</div>
								<div class="col-md-2">
									<input type="text" style="width: 59%;" id="Payout"
										class="form-control" name="Payout" placeholder="Months"
										required="required" onchange="chechkOrder()"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
								</div>
							</div>

							<input type="hidden" name="IntiationId"
								value="<%=initiationid %>" /> <input type="hidden"
								name="projectshortName" value="<%=projectshortName %>" />
							<div class="form-group" align="center" style="margin-top: 3%;">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
								<button type="submit" class="btn btn-primary btn-sm submit"
									id="add" name="action" value="SUBMIT"
									onclick="return reqCheck('myform1');">SUBMIT</button>

							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>

	</form>

	<!--  modal for edit-->
						
			<form class="form-horizontal" role="form"
			action="ProjectProcurementEdit.htm" method="POST" id="myform2">
			<div class="modal fade bd-example-modal-lg" id="exampleModalLongEdit"
				tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content addreq" style="width: 130%;">
						<div class="modal-header" id="modalreqheader">
							<h5 class="modal-title" id="exampleModalLabel">Procurement Plan 
							</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close" style="color: white">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
						<div class="col-md-12"> 
						<div class="row" style="margin-top: 1%">
						<div class="col-md-2 label">
						<label>Item:</label><span class="mandatory" style="color: red;">*</span>
						</div>
						<div class="col-md-7">
						<input type="text" class="form-control" id="Itemedit" name="Item" maxlength="300" required >
						</div>
						</div>
						<div class="row" style="margin-top: 1%">
						<div class="col-md-2 label"><label>Purpose:</label><span class="mandatory" style="color: red;">*</span></div>
						<div class="col-md-7">
						<input type="text" class="form-control" id="Purposeedit" name="Purpose" maxlength="450" style="line-height: 3rem" required >
						</div>
						 </div>
						 	<div class="row" style="margin-top: 1%">
						<div class="col-md-2 label"><label>Source:</label><span class="mandatory" style="color: red;">*</span></div>
						<div class="col-md-7">
						<input type="text" class="form-control" id="Sourceedit" name="Source" maxlength="300" required >
						</div>
						 </div>
						  	<div class="row" style="margin-top: 1%">
						<div class="col-md-2 label"><label>Mode:</label><span class="mandatory" style="color: red;">*</span></div>
						<div class="col-md-5">
									<div class="form-group">
										<select class="form-control"
											name="Mode" id="Modeedit" 
											data-width="80%" data-live-search="true"
											>
											<option value="" disabled="disabled" >---Choose----</option>
											<%
											for (Object[] obj : DemandList) {
											%>
											<option value="<%=obj[0]%>"><%=obj[2]%></option>
											<%
											}
											%>
										</select>
									</div>
								</div>
						 </div>
						 <span class="spanedit"></span>
						 <div class="row" style="margin-top: 1%">
						 <div class="col-md-2 label"><label>Cost (&#8377;):</label><span class="mandatory" style="color: red;">*</span></div>
						 <div class="col-md-3"><input type="text" id="costedit" class="form-control" name="cost" placeholder="0.0"
						 oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
						 ></div>
							  <div class="col-md-3 label" ><label>EPC Approval required</label><span class="mandatory" style="color: red;">*</span></div>
						  <div class="col-md-2" id="Approvededit" >								
						  </div>
						 </div>
						 	 <div class="row" style="margin-top: 1%">
						 <div class="col-md-6 label">
						 <label>Estimated months after Project Sanction Date &nbsp;&nbsp; (T<sub>0</sub>)</label><hr style="margin-left: 0%!important; width: 80%">
						 </div>
						 </div>
						 <div class="row" style="margin-top: 1%">
						 <div class="col-md-1 label"><label>Demand:</label></div>
						 <div class="col-md-2"><input style="width: 59%;"  type="text" id="Demandedit" class="form-control" name="Demand" placeholder="Months"required 
						 oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
						 ></div>
						  <div class="col-md-1 label"><label>Tender:</label></div>
						 <div class="col-md-2"><input style="width: 59%;"  type="text" id="Tenderedit" class="form-control" name="Tender" placeholder="Months"required 
						 oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"></div>
						   <div class="col-md-1 label"><label>Order:</label></div>
						 <div class="col-md-2"><input style="width: 59%;"  type="text" id="Orderedit" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" class="form-control" name="Order" placeholder="Months"required ></div>
						   <div class="col-md-1 label"><label>Payment:</label></div>
						 <div class="col-md-2"><input style="width: 59%;"  type="text" id="Payoutedit" class="form-control" name="Payout" placeholder="Months"required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" ></div>
						 </div>
						 
						 		<input type="hidden" name="IntiationId"
										value="<%=initiationid %>" /> <input type="hidden"
										name="projectshortName" value="<%=projectshortName %>" />
									<div class="form-group" align="center" style="margin-top: 3%;">
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />
										<button type="submit" class="btn btn-primary btn-sm submit"
											id="add" name="action" value="SUBMIT"
											onclick="return reqCheckedit('myform');">SUBMIT</button>

									</div>
						
						</div>
						</div>
						</div>
						</div>
						</div>
						
						</form>			
						
							
							
							
	<script>
	$(document).ready(function() {
		   $('#project').on('change', function() {
			   var temp=$(this).children("option:selected").val();
			   $('#submit').click(); 
		   });
		});		

	$("#myTable").DataTable({		 
		 "lengthMenu": [5,10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 5,
		 "language": {
		      "emptyTable": "No Data available"
		    }
	});
	function show(){
		$('#exampleModalLong').modal('show');
	}
	
	function reqCheck(frmid){
	 	var Item=$('#Item').val().trim();
	 	var Purpose=$('#Purpose').val().trim();
	 	var Source=$('#Source').val().trim();
	 	var Mode=$('#Mode').val();
	 	var cost=$('#cost').val().trim();
	 	console.log(Item)
	 	if(Item===""||Purpose===""||Source===""||Mode===""||cost===""){
	 		alert("Please fill all the fields")
	 		event.preventDefault();
	 	}else{
	 	
		if(window.confirm('Are you sure, you want to submit?')){
			document.getElementById(frmid).submit(); 
		}else{
			event.preventDefault();
			return false;
		}
	 	}
	}
	function reqCheckedit(frmid){
		if(window.confirm('Are you sure, you want to submit?')){
			document.getElementById(frmid).submit(); 
		}else{
			event.preventDefault();
			return false;
		}
	}
	
	function showEditModal(){
		var Planid=$('#radio').val();
		console.log(Planid)
		if(Planid==0){
			alert("Please select one plan for edit");
		}else{
				$.ajax({
					type:'GET',
					url:'PocurementPlanEditDetails.htm',
					datatype:'json',
					data:{
					Planid:Planid,
					},
					success:function(result){
						 var ajaxresult=JSON.parse(result);
						 console.log(ajaxresult)
						 $('#Itemedit').val(ajaxresult[0]);
						 $('#Purposeedit').val(ajaxresult[1]);
						 $('#Sourceedit').val(ajaxresult[2]); 
						 $('#Modeedit').val(ajaxresult[3]);
						 $('#costedit').val(ajaxresult[4]);
					/* 	 $('#Approvededit').val(ajaxresult[9]); */
						 if(ajaxresult[9]=="Y"){
							 $('#Approvededit').html('<input type="radio" name="Approved"  value="YES" checked>  YES  <input style="margin-left: 15px;" type="radio" name="Approved" value="NO">  NO');
						 }else{
							 $('#Approvededit').html('<input type="radio" name="Approved"  value="Y" >  YES  <input style="margin-left: 10px;" type="radio" name="Approved" value="N" checked>  NO');
 
						 }
						 
						 $('#Demandedit').val(ajaxresult[5]);
						 $('#Tenderedit').val(ajaxresult[6]);
						 $('#Orderedit').val(ajaxresult[7]);
						 $('#Payoutedit').val(ajaxresult[8]);
						 $('.spanedit').html('<input type="hidden" id="planidedit" value="'+Planid+'" name="planidedit">');
					}
				})	
			
			$('#exampleModalLongEdit').modal('show');
			
		}
	}
	
	function radioValue(a){
		$('.radiovalue').html('<input type="hidden" value="'+a+'" id="radio">')
	}
	function checKDemand(){
		var Demand=$('#Demand').val().trim();
		var tender=$('#Tender').val().trim();
		if(Number(Demand)>Number(tender)){
		alert("Tender Month should be more than demand month!")
		document.getElementById("Tender").value="";
		}
	
	
		
	}
	
	function chechKTender(){
		var tender=$('#Tender').val().trim();
		var Order=$('#Order').val().trim();
		if(Number(tender)>Number(Order)){
		alert("Order Month should be more than tender month!")
		document.getElementById("Order").value="";
		}
		
	}

	function chechkOrder(){
		var Order=$('#Order').val().trim();
		var Payment=$('#Payout').val();
		if(Number(Order)>Number(Payment)){
		alert("Payment Month should be more than Order month!")
		document.getElementById("Payout").value="";
		}
		
	}
	</script>
</body>
</html>