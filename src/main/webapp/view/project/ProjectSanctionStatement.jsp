<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../static/header.jsp"></jsp:include>
<meta charset="ISO-8859-1">
<title>PMS</title>
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

.addreq {
	margin-left: -10%;
	margin-top: 5%;
}

.costreq {
	margin-left: -25%;
	margin-top: 5%;
}

h5 {
	font-size: 18px;
	font-family: 'FontAwesome';
}

.details>h5 {
	text-align: left;
	background: white;
	padding: 5px;
	color: balck;
	font-family: 'FontAwesome';
	box-shadow: 2px 2px 2px cadetblue;
	border-radius: 5px;
	margin-left: 0%;
}

p {
	font-size: 18px;
	text-align: left;
	background: white;
	padding: 5px;
	color: balck;
	font-family: 'FontAwesome';
	box-shadow: 2px 2px 2px cadetblue;
	border-radius: 5px;
	margin-left: 0%;
}

.table-striped>tbody>tr:nth-child(even) {
	/*   background-color: #D6EEEE !important; */
	background-color: white;
}

#page1, #page2, #page3 {
	padding-left: 15px;
	padding-right: 15px;
	margin-left: 3px;
	font-family: 'Montserrat', sans-serif;
}

strong {
	font-weight: 100;
}
</style>
</head>
<body>
	<%
	List<Object[]> ProjectIntiationList = (List<Object[]>) request.getAttribute("ProjectIntiationList");
	Object[] ProjectDetailes = (Object[]) request.getAttribute("ProjectDetailes");
	String projectshortName = (String) request.getAttribute("projectshortName");
	String initiationid = (String) request.getAttribute("initiationid");
	String projectTitle = (String) request.getAttribute("projectTitle");
	NFormatConvertion nfc = new NFormatConvertion();
	List<Object[]> sanctionlistdetails = (List<Object[]>) request.getAttribute("sanctionlistdetails");
	List<Object[]> DetailsList = (List<Object[]>) request.getAttribute("DetailsList");
	List<Object[]> ProjectInitiationLabList = (List<Object[]>) request.getAttribute("ProjectInitiationLabList");
	List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
	%>



	<form class="form-inline" method="POST" action="ProjectSanction.htm">
		<div class="row W-100" style="width: 80%; margin-top: -0.5%;">
			<div class="col-md-2" id="div1">
				<label class="control-label"
					style="font-size: 15px; color: #07689f;"><b>Project
						Name :</b></label>
			</div>
			<div class="col-md-2" style="margin-top: 3px;" id="projectname">
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
	<div class="container-fluid" style="display: block;"main">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: 5px;">
					<div class="row card-header"
						style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
						<div class="col-md-7" id="projecthead" align="center">
							<h5 id="text" style="margin-left: 1%; font-weight: 600">STATEMENT
								OF CASE FOR SANCTION OF PROJECT/PROGRAMME</h5>
						</div>
						<div class="col-md-1"></div>
						<div class="col-md-3" align="right"
							style="margin-right: 0%; margin-top: -4px;">
							<button class="btn btn-sm" id="page1"
								style="box-shadow: 2px 2px 2px darkslategray">Main</button>
							<button class="btn btn-sm" id="page2"
								style="box-shadow: 2px 2px 2px darkslategray">Part 1</button>
							<button class="btn btn-sm" id="page3"
								style="box-shadow: 2px 2px 2px darkslategray">Part 2</button>
						</div>


						<div class="col-md-1" id="download" align="right">
							<form action="#">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden"
									name="projectshortName" value="<%=projectshortName%>" /> <input
									type="hidden" name="IntiationId" value="<%=initiationid%>" />
								<button type="submit" class="btn btn-sm" formmethod="GET"
									style="margin-top: -5%" formtarget="_blank"
									formaction="ProjectSanctionDetailsDownload.htm"
									data-toggle="tooltip" data-placement="top"
									title="Download file">
									<i class="fa fa-download fa-sm" aria-hidden="true"></i>
								</button>
							</form>
						</div>
					</div>
					<!-- <div class="col-md-12" align="right" style="margin-right:4%;margin-top:5px;;">
					<button class="btn btn-sm" id="page1">Main</button>
					<button class="btn btn-sm" id="page2">Part 1</button>
					<button class="btn btn-sm" id="page3">Part 2</button>
					</div> -->



					<div class="card-body" id="cardbody"
						style="background: white; padding-top: 0%; color: black; height: 520px;">
						<div class="row">
							<%
							if (ProjectDetailes != null) {
							%>
							<div class="col-md-6">
								<table class="table table-striped" id="table1"
									style="width: 100%; margin-top: 2%;">
									<tbody>
										<tr>
											<td style="width: 60%"><h5>1. Name of laboratory:</h5></td>
											<td>
												<h5>MTRDC</h5>
											</td>
										</tr>
										<tr>
											<td><h5>2. Title of the Project/Programme:</h5></td>
											<td><h5><%=ProjectDetailes[7] + "(" + ProjectDetailes[6] + ")"%></h5></td>
										</tr>
										<tr>
											<td><h5>3. Category of Project:</h5></td>
											<td><h5>
													<%=ProjectDetailes[4]%></h5></td>
										</tr>
										<tr>
											<td><h5>4. Security classification of
													Project/Programme:</h5></td>
											<td><h5><%=ProjectDetailes[5]%></h5></td>
										</tr>
										<tr>
											<td><h5>5. Name of the Project Director/Programme
													Director (for approval of Competent Authority) :</h5></td>
											<td><h5><%=ProjectDetailes[1]%></h5></td>
										</tr>
										<tr>
											<td><h5>6. Cost(in Cr):</h5></td>
											<td>
												<h5>
													<%
													if (ProjectDetailes[8] != null && Double.parseDouble(ProjectDetailes[8].toString()) > 0) {
													%><%=nfc.convert(Double.parseDouble(ProjectDetailes[8].toString()) / 10000000)%>
													&nbsp;&nbsp;<%
													} else if (ProjectDetailes[20] != null && Double.parseDouble(ProjectDetailes[20].toString()) > 0) {
													%><%=nfc.convert(Double.parseDouble(ProjectDetailes[20].toString()) / 10000000)%>&nbsp;&nbsp;<%
													} else {
													%>-<%
													}
													%>
												</h5>
											</td>
										</tr>
										<tr>
											<td><h5>7. Schedule (Months):</h5></td>
											<td>
												<h5>
													<%
													if (ProjectDetailes[9] != null && Integer.parseInt(ProjectDetailes[9].toString()) > 0) {
													%><%=ProjectDetailes[9]%>
													<%
													} else if (ProjectDetailes[18] != null) {
													%><%=ProjectDetailes[18]%>
													<%
													} else {
													%>-<%
													}
													%>
												</h5>
											</td>
										</tr>
										<tr>
											<td><h5>8. Project Deliverables/Output:</h5></td>
											<td><h5>
													<%
													if (ProjectDetailes[12] != null && !ProjectDetailes[12].toString().equalsIgnoreCase("")) {
													%>
													<%=ProjectDetailes[12]%>
													<%
													} else {
													%>-<%
													}
													%>
												</h5></td>
										</tr>
										<tr>
											<td>
												<h5>9. PSQR/GSQR/NSQR/ASQR/JSQR No(for MM/ TD(S)
													Projects):</h5>
											</td>

											<%
											if (!ProjectDetailes[21].toString().equalsIgnoreCase("1") || ProjectDetailes[21].toString().equalsIgnoreCase("8")) {
											%>
											<td><h5>Not Applicable</h5></td>
											<%
											} else {
											int i = 1;
											for (Object[] obj : sanctionlistdetails) {
												if (i == 10) {
													if (obj[4] != null) {
											%>
											<td colspan="2"><input class="form-control"
												id="PGNAJedit" style="width: 70%" type="text" required
												maxlength="250" placeholder="" value="<%=obj[4]%>"
												oninput="this.value = this.value.replace(/[^A-Za-z0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
												<button type="button" style="float: right; margin-top: -13%"
													onclick="editPGNAJ(<%=obj[0]%>)" class="btn btn-warning ">EDIT</button></td>

											<%
											} else {
											%>
											<td colspan="2" class="pgnaj"><input
												class="form-control" id="PGNAJ" style="width: 70%"
												type="text" required maxlength="250"
												placeholder="PSQR/GSQR/NSQR/ASQR/JSQR No"
												oninput="this.value = this.value.replace(/[^A-Za-z0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
												<button type="button" style="float: right; margin-top: -11%"
													onclick="addPGNAJ(<%=obj[0]%>)"
													class="btn btn-success btn-sm">SUBMIT</button></td>
											<%
											}
											}
											i++;
											}
											%>
											<%
											}
											%>
										</tr>

									</tbody>
								</table>
							</div>
							<div class="col-md-6">
								<div class="row"
									style="color: black; font-family: 'FontAwesome' !important;">
									<div class="col-md-12">
										<table class="table table-striped"
											style="width: 100%; margin-top: 2%;">
											<tr>
												<td style="width: 63%">
													<h5>10. Trial Directive No:(for UT Projects)</h5>
												</td>
												<%
												if (!ProjectDetailes[21].toString().equalsIgnoreCase("6")) {
												%>
												<td colspan="2"><h5>Not Applicable</h5></td>
												<%
												} else {
												int i = 1;
												for (Object[] obj : sanctionlistdetails) {
													if (i == 9) {
														if (obj[3] != null) {
												%>
												<td colspan="2"><input class="form-control"
													id="TDNedit" style="width: 70%" type="text" required
													maxlength="250" placeholder="Trial Directive No"
													value="<%=obj[3]%>"
													oninput="this.value = this.value.replace(/[^A-Za-z0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
													<button type="button"
														style="float: right; margin-top: -14%"
														onclick="editTDN('<%=obj[0]%>')"
														class="btn btn-warning btn-sm">EDIT</button></td>

												<%
												} else {
												%>
												<td colspan="2" class="tdn"><input class="form-control"
													id="TDN" style="width: 70%" type="text" required
													maxlength="250" placeholder="Trial Directive No"
													oninput="this.value = this.value.replace(/[^A-Za-z0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
													<input type="hidden" value="<%=obj[0]%>">
													<button type="button"
														style="float: right; margin-top: -13%"
														onclick="addTDN('<%=obj[0]%>')"
														class="btn btn-success btn-sm">SUBMIT</button></td>
												<%
												}
												}
												i++;
												}
												%>
												<%
												}
												%>
											</tr>
											<%
											int i = 1;
											for (Object[] obj : sanctionlistdetails) {
											%>
											<tr>
												<td><h5><%=Integer.parseInt(obj[0].toString()) + 10 + "." + " " + obj[1]%></h5></td>
												<%
												if (i == 5 && !ProjectDetailes[21].toString().equalsIgnoreCase("1")) {
												%>
												<td><h5>Not Applicable</h5></td>
												<%
												} else {
												%>
												<td style="width: 20%"><input name="toggle"
													id="toggle_<%=obj[0]%>"
													onchange="updateAnswer('<%=obj[0]%>')" type="checkbox"
													<%if (obj[2] != null && (obj[2]).toString().equalsIgnoreCase("1")) {%>
													checked <%}%> data-toggle="toggle" data-onstyle="success"
													data-offstyle="danger" data-width="112" data-height="15"
													data-on="<i class='fa fa-check' aria-hidden='true'></i> YES"
													data-off="<i class='fa fa-times' aria-hidden='true'></i> NO">
												</td>
												<%
												}
												%>
												<td class="tddownload<%=obj[0]%>">
													<%
													if (obj[2] != null && (obj[2]).toString().equalsIgnoreCase("1")) {
													%><button class="btn btn-sm" type="button">
														<i class="fa fa-download fa-sm" aria-hidden="true"></i>
													</button> <%
 }
 %>
												</td>
											</tr>
											<%
											i++;
											if (i == 9)
												break;
											%>
											<%
											}
											%>

										</table>
									</div>
								</div>
							</div>
						</div>
					</div>

					<%
					}
					%>
					<div class="card-body" id="cardbody1" style="display: none;">
					<div class="row">
					<div class="col-md-6">
					<div class="row">
					<div class="col-md-5">
					<h5><b>1.a.Title of the Project</b></h5>
					</div>
					<div class="col-md-7 details">
					<h5><%=ProjectDetailes[7]%></h5>
					</div>
					</div>
					<div class="row" style="margin-top:3px;"> 
					<div class="col-md-5"><h5><b>&nbsp;&nbsp;&nbsp;b. Short Name or Acronym</b></h5></div>
					<div class="col-md-7 details"><h5><%=ProjectDetailes[6]%></h5></div>
					</div>
					
					<div class="row">
					<div class="col-md-5"><b>3.Objective </b></div>
					<div class="col-md-7 details">
												<%
												for (Object[] obj : DetailsList) {
													if (obj[1] != null) {
														if (obj[1].toString().length() > 75) {
												%>
												<%=obj[1].toString().substring(0,75)%>
												<button class="btn" style="background: transparent;"
													type="button" onclick="showModal('Objective')">
													<span
														style="color: #1176ab; text-decoration: underline; font-size: 18px; font-weight: 900">View
														more</span>
												</button>
												<%
												} else {
												%>
												<%=obj[1]%>
												<%
												}
												}
												}
												%>
					</div>
					</div>
					<div class="row">
					<div class="col-md-5">
					<h5><b>4.Scope</b></h5>
					</div>
					<div class="col-md-7 details">
					<%
												for (Object[] obj : DetailsList) {
													if (obj[2] != null) {
														if (obj[2].toString().length() > 75) {
												%>
												<%=obj[2].toString().substring(0, 75)%>

												<button class="btn" style="background: transparent;"
													type="button" onclick="showModal('Scope')">
													<span
														style="color: #1176ab; text-decoration: underline; font-size: 18px; font-weight: 900">View
														more</span>
												</button>
												<%
												} else {
												%>
												<%=obj[2]%>
												<%
												}
												}
												}
												%>
					</div>
					</div>
					<div class="row">
					<div class="col-md-5">
					<h5><b>5.Is it a Multi-lab Project?</b></h5>
					</div>
					<div class="col-md-2 details">
						<%
										if (ProjectDetailes[11] != null && ProjectDetailes[11].toString().equalsIgnoreCase("Y")) {
										%><h5>Yes</h5>
										<%
										} else {
										%><h5>No</h5>
										<%
										}
										%>
										</div>
									<%
									int count = 1;
									if (!ProjectInitiationLabList.isEmpty()) {
									%>
									<div class="col-md-1">
										<button class="btn btn-sm btn-info"
											style="box-shadow: 2px 2px 2px gray; font-family: FontAwesome"
											data-toggle="tooltip" data-placement="right"
											title="<%for (Object[] obj : ProjectInitiationLabList) {%><%=count + ". " + obj[2] + '\n'%><%count++;}%>">
											View Labs</button>
									</div>
									<%
									}
									%>
					
					</div>
					</div>
					<div class="col-md-6">
					<div class="row">
					<div class="col-md-10">
					<h5><b>11. Proposed Six monthly milestones along-with financial outlay (in Cr):</b></h5></div>
					<div class="col-md-2"><button class="btn  btn-info" style="box-shadow:2px 2px 2px gray;" onclick="showSchedule()">show</button></div>
					</div>
					</div>
					</div>
					</div>


					<div class="card-body" id="cardbody2" style="display: none;">
						MACRO DETAILS OF PROJECT/PROGRAMME (PART-II)</div>

				</div>
			</div>
		</div>
	</div>
	<!--View More Modal  -->
	<div class="modal fade bd-example-modal-lg" id="exampleModalLong"
		tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content addreq" style="width: 120%;">
				<div class="modal-header" style="background: #145374; height: 50px;">
					<h5 id="modalreqheader" style="font-size: 20px; color: white;"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" style="color: white">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modalbody"></div>
			</div>
		</div>
	</div>
	
	<!--schedule and finacial outlay modal  -->
		<div class="modal fade bd-example-modal-lg" id="exampleschduleModal"
		tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content costreq" style="width: 150%;">
				<div class="modal-header" style="background: #145374; height: 50px;">
					<h5 id="modalreqheader" style="font-size: 20px; color: white;">Six monthly milestones along-with financial outlay</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" style="color: white">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modalSchedulebody">
					<div class="col-md-12">
						<table class="table table-striped table-bordered"
							style="width: 100%">
							<thead>
								<tr>
								<th style="width:5%">SL No.</th>
								<th style="width:15%">Time(Months)</th>
								<th style="width:40%">Six Monthly Technical Milestone</th>
								<th style="width:40%">FinancialOutlay (in Cr.)</th>
								</tr>
							</thead>
							<tbody>
							<%if(ScheduleList.isEmpty()){%>
							<tr><td colspan="4" align="center"><h5>Please add Schedule for the project in Project Initiation</h5><td></tr>
							<%}else{
							for(Object[]obj:ScheduleList){	
								%>
							<tr>
							<td><%=obj[0]%></td>
							</tr>
							<%}} %>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--Cost Modal  -->
	<div class="modal fade bd-example-modal-lg" id="exampleCostModal"
		tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content costreq" style="width: 150%;">
				<div class="modal-header" style="background: #145374; height: 50px;">
					<h5 id="modalreqheader" style="font-size: 20px; color: white;">Breakup
						of Cost</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" style="color: white">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modalCostbody">
					<div class="col-md-12">
						<table class="table table-striped table-bordered"
							style="width: 100%">
							<thead>
								<tr>
									<th style="width: 30%"><h5>Item</h5></th>
									<th style="width: 30%"><h5>Details</h5></th>
									<th style="width: 40%"><h5>Cost(in Cr.)</h5></th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script>
	function showCostModal(){
		$('#exampleCostModal').modal('show');
	}
	function showSchedule(){
		$('#exampleschduleModal').modal('show');
	}
	$(document).ready(function() {
		$('#project').on('change', function() {
			var temp = $(this).children("option:selected").val();
			$('#submit').click();
		});
	});

		function updateAnswer(StatementId) {

			$
					.ajax({
						type : "GET",
						url : "SanctionDataUpdate.htm",
						data : {
							initiationid :
						<%=initiationid%>
							,
							StatementId : StatementId,
						},
						datatype : "json",
						success : function(result) {
							console.log(result);
							console.log(typeof (result));
							if (Number(result) > 0) {
								alert('Statement Updated');
								$('.tddownload' + StatementId)
										.html(
												'<button class="btn btn-sm" type="button" ><i class="fa fa-download fa-sm" aria-hidden="true"></i></button>');
							} else if (Number(result) === 0) {
								alert('Statement Updated');
								$('.tddownload' + StatementId).html('');
							} else {
								alert('Operation Failed');
							}
						}
					})

		}

		function addTDN(a) {
			var TDN = $('#TDN').val().trim();
			console.log(TDN.length+"--- "+TDN.substring(0,2).length)
			if(TDN===""){
				alert("The field can not be empty.")
			}else{
			if (confirm("Are you sure, you want to add Trial Directive No-"+TDN+"?")) {
				console.log(TDN)
				$.ajax({
					type : "GET",
					url : "SanctionDataUpdate.htm",
					data : {
						initiationid :
	<%=initiationid%>,
					StatementId:a,
					TDN:TDN,
				},
			datatype:"json",
			success : function (result){
				console.log(result);
				if(Number(result)>0){
					alert("Data Added Succesfully")
				}
				$('.tdn').html('<input id="TDNedit" class="form-control" style="width:70%" type="text" maxlength="250" value="'+TDN+'"><button type="button" onclick="editTDN('+a+')" style="float: right; margin-top: -13%" class="btn btn-warning btn-sm">EDIT</button>');
			}
			}) 
			
		}else{
			event.preventDefault();
			return false;
		}
			}
	}
	$(function () {
		  $('[data-toggle="tooltip"]').tooltip()
		})

	function editTDN(a){
		const tdn=$('#TDNedit').val().trim();
		if(tdn===""){
			alert("The field can not be empty.")
		}else{
			if (confirm("Are you sure, you want to update Trial Directive No-"+tdn+"?")){
				$.ajax({
					type:'GET',
					url:'ProjectTdnUpdate.htm',
					data:{
						initiationid :<%=initiationid%>,
					    StatementId:a,
						TDN:tdn,
						
					},
				datatype:'json',
				success:function(result){
					if(Number(result)>0){
						alert("Data edited succesfully")
					}
				}
				})
				
				}
			else{
				event.preventDefault();
				return false;
			}
			}
			
	}

	function addPGNAJ(a) {
		var PGNAJ = $('#PGNAJ').val().trim();
	
		if(PGNAJ===""){
			alert("The field can not be empty.")
		}else{
		if (confirm("Are you sure, you want to add PSQR/GSQR/NSQR/ASQR/JSQR No-"+PGNAJ+"?")) {
			
			$.ajax({
				type : "GET",
				url : "SanctionUpdatePGNAJ.htm",
				data : {
					initiationid :
				<%=initiationid%>,
				StatementId:a,
				PGNAJ:PGNAJ,
			},
			datatype:"json",
			success:function(result){
				console.log(result);
				if(Number(result)>0){
					alert("Data Added succesfully")
				}
				$(".pgnaj").html('<input type="text" id="PGNAJedit" style="width:70%;" class="form-control" value="'+PGNAJ+'"> <button type="b"style="float: right; margin-top: -13%"onclick="editPGNAJ(10)" class="btn btn-warning btn-sm">EDIT</button>')
			}
	
		}) 
		
	}else{
		event.preventDefault();
		return false;
	}
		}
}
	function editPGNAJ(a){
		const PGNAJedit=$('#PGNAJedit').val().trim();
		console.log(PGNAJedit)
		if(PGNAJedit===""){
			alert("This field can not be empty!")
		}else{
			if (confirm("Are you sure, you want to update PSQR/GSQR/NSQR/ASQR/JSQR No-"+PGNAJedit+"?")){
				 	$.ajax({
					type:'GET',
					url:'ProjectPGNAJUpdate.htm',
					data:{
						initiationid :<%=initiationid%>,
					    StatementId:a,
					    PGNAJ:PGNAJedit,
						
					},
				datatype:'json',
				success:function(result){
					if(Number(result)>0){
						alert("Data edited succesfully")
					}
				}
				})
				}
			else{
				event.preventDefault();
				return false;
			}
			}
		}

	/* Second page clcik function */
		$('#page2').click(function(){
		$('#text').html('MACRO DETAILS OF PROJECT/PROGRAMME (PART-I)');
		$('#cardbody').css("display","none");
		$('#cardbody2').css("display","none");
		$('#cardbody1').css("display","block");
		$('#page2').css("background","#28a745");
		$('#page2').css("color","white");
		$('#page1').css("background","rgb(210 213 215)");
		$('#page1').css("color","black");
		$('#page3').css("background","rgb(210 213 215)");
		$('#page3').css("color","black");
		$('#page2').css("font-weight","800");
		$('#page3').css("font-weight","600");
		$('#page1').css("font-weight","600");
		})
		/*Third page click function */
		$('#page3').click(function(){
		$('#text').html('MACRO DETAILS OF PROJECT/PROGRAMME (PART-II)');
		$('#cardbody').css("display","none");
		$('#cardbody1').css("display","none");
		$('#cardbody2').css("display","block");
		$('#page3').css("background","#28a745");
		$('#page3').css("color","white");
		$('#page2').css("background","rgb(210 213 215)");
		$('#page2').css("color","black");
		$('#page1').css("background","rgb(210 213 215)");
		$('#page1').css("color","black");
		$('#page2').css("font-weight","600");
		$('#page3').css("font-weight","800");
		$('#page1').css("font-weight","600");
		})
		/* First page click function  */
		$('#page1').click(function(){
		$('#text').html('STATEMENT OF CASE FOR SANCTION OF PROJECT/PROGRAMME');
		$('#cardbody1').css("display","none");
		$('#cardbody2').css("display","none");
		$('#cardbody').css("display","block");
		$('#page1').css("background","#28a745");
		$('#page1').css("color","white");
		$('#page2').css("background","rgb(210 213 215)");
		$('#page2').css("color","black");
		$('#page3').css("background","rgb(210 213 215)");
		$('#page3').css("color","black");
		$('#page2').css("font-weight","600");
		$('#page3').css("font-weight","600");
		$('#page1').css("font-weight","800");
		})
		/*First page clicked function when page loaded  */
		$(document).ready(function(){
		$('#page1').click();	
		})
		
		/*for modal  */
		function showModal(a){
			var initiaionid=
			$.ajax({
				type:'GET',
				url:'ProjectInitiationDetailsJsonValue.htm',
				data:{
					initiationid :<%=initiationid%>,
				},
				datatype:'json',
				success:function(result){
					 var ajaxresult=JSON.parse(result);
					if(a==="Objective"){
					$('#modalreqheader').html(a);
					$('#modalbody').html(ajaxresult[0][1]);
					}
					if(a==="Scope"){
						$('#modalreqheader').html(a);
						$('#modalbody').html(ajaxresult[0][2]);}
					
				}
			})
			
		
			$('#exampleModalLong').modal('show');
		}
		
		
	</script>
</body>
</html>