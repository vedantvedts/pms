<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.TextStyle"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}

h6 {
	text-decoration: none !important;
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

.width {
	width: 270px !important;
}

a:hover {
	color: white;
}

#table thead tr th, #table tbody tr td{
	text-align: center;
}

.modal_table tr th, .modal_table tr td
{
	padding:5px;
}
.modal-dialog-jump {
  animation: jumpIn 0.8s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.1);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}
</style>
</head>

<body>
	<%

  List<Object[]> BriefingScheduleList=(List<Object[]>)request.getAttribute("BriefingScheduleList");
  SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
  SimpleDateFormat sdf1=new SimpleDateFormat("HH:mm:ss");
  String projectid=(String)request.getAttribute("projectid");
  String committeecode=(String)request.getAttribute("committeecode");
  List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist");
  
 %>


	<%
	String ses=(String)request.getParameter("result"); 
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

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header row">
						<div class="col-md-6">
							<h4 class="">Schedule Briefing History List</h4>
						</div>
						<div class="col-md-6" align="right" style="margin-top: -8px;">
							<form method="post" action="FroozenBriefingList.htm" >
								<table>
									<tr>
										<td>
											<b>Project : </b>
										</td>
										<td>
											<select class="form-control items selectdee" name="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="this.form.submit();">
												<%for(Object[] obj : projectslist){ %>
													<option <%if(projectid!=null && projectid.equals(obj[0].toString())) { %>selected <%} %>value=<%=obj[0]%> ><%=obj[4] %></option>
												<%} %>
											</select>
										</td>
										<td style="padding-left: 10px;">
											<b>Committee : </b>
										</td>
										<td>
											<select class="form-control items" name="committeecode"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="this.form.submit();" >
												<option <%if(committeecode!=null && committeecode.equalsIgnoreCase("PMRC")) { %>selected <%} %>value="PMRC" >PMRC</option>
												<option <%if(committeecode!=null && committeecode.equalsIgnoreCase("EB")) { %>selected <%} %>value="EB" >EB</option>
											</select>
										</td>
									</tr>
								</table>
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
							</form>
						</div>
					</div>
					<div class="card-body">
					
						<div class="data-table-area mg-b-15">
							<form method="get">
							<div class="container-fluid">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">

										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
													<select class="form-control dt-tb">
														<option value="">Export Basic</option>
														<option value="all">Export All</option>
														<option value="selected">Export Selected</option>
													</select>
												</div>
												<table id="table" data-toggle="table" data-pagination="true" data-search="true" data-show-columns="true" data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true" data-resizable="true" data-cookie="true" data-cookie-id-table="saveId" data-show-export="true" data-click-to-select="true" data-toolbar="#toolbar">
													<thead>
														<tr>
															<th >Committee</th>
															<th >Meeting Id</th>
															<th >Schedule Date & Time</th>
															<th >Status</th>
															<th >Action</th>
														</tr>
													</thead>
													<tbody>
														<%for(Object[] schedule : BriefingScheduleList){%>
															<tr>
																<td><%=schedule[2] %></td>
																<td><b><%=schedule[9] %></b></td>
																<td>
																	<%LocalTime starttime = LocalTime.parse(LocalTime.parse(schedule[5].toString(),DateTimeFormatter.ofPattern("HH:mm:ss")).format( DateTimeFormatter.ofPattern("HH:mm") ));   %>
																	<%=rdf.format(sdf.parse(schedule[4].toString()))  %> - <%=starttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) %>
																</td>
																<td><%=schedule[6] %></td>
																<td>
																	<%if(schedule[7].toString().equalsIgnoreCase("Y") ){ %>
																		<button type="button" class="btn btn-sm " style="color:white;margin:5px; " 
																		onclick="showmodal('U', <%=schedule[0]%>,
																		'<%=schedule[9] %>', 
																		'<%=rdf.format(sdf.parse(schedule[4].toString()))  %> - <%=starttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) %>',
																		'<%=schedule[11] %>',
																		'<%=schedule[3] %>'
																		)" data-toggle="tooltip" data-placement="top" title="Update">
																			<i class="fa fa-pencil-square-o fa-lg	" aria-hidden="true"></i>
																		</button>
																		<button class="btn btn-sm" style="margin:5px;" formaction="MeetingBriefingPaper.htm" name="scheduleid" value="<%=schedule[0]%>" formmethod="get" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="View">
																			<i class="fa fa-eye" aria-hidden="true"></i>
																		</button>
																		<%if(schedule[12]!=null) {%>
																			<button type="submit" class="btn btn-sm" style="border: 0 ;border-radius: 3px;"  formmethod="GET" name="scheduleid" value="<%=schedule[0]%>" formaction="MeetingBriefingPresenttaion.htm" formtarget="_blank"  data-toggle="tooltip" data-placement="top" title="Presentation">
																			<img alt="" src="view/images/presentation.png" style="width:19px !important"><i class="fa fa-eye" aria-hidden="true" style="margin-left:6px;"></i>
																			</button>
																			<%} %>
																			<%if(schedule[8]!=null && schedule[8].toString().equalsIgnoreCase("Y")) {%>
																			<button type="submit" class="btn btn-sm" style="border: 0 ;border-radius: 3px;"  formmethod="GET" name="scheduleid" value="<%=schedule[0]%>" formaction="MeetingMom.htm" formtarget="_blank"  data-toggle="tooltip" data-placement="top" title="MOM">
																			<img alt="" src="view/images/requirement.png" style="width:19px !important"><i class="fa fa-eye" aria-hidden="true" style="margin-left:6px;"></i>
																			</button>
																			<%} %>
																	<%}else{ %>
																		<button type="button" class="btn btn-sm " style="background-color:#0e49b5 ;color:white;margin:5px; " 
																		onclick="showmodal('A', <%=schedule[0]%>,
																		'<%=schedule[9] %>', 
																		'<%=rdf.format(sdf.parse(schedule[4].toString()))  %> - <%=starttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) %>',
																		'<%=schedule[11] %>',
																		'<%=schedule[3] %>'
																		)" data-toggle="tooltip" data-placement="top" title="Add">
																			<i class="fa fa-plus-square" aria-hidden="true"></i>
																		</button>
																	<%} %>
																</td>
															</tr>
														<%} %>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
							</form>
						</div>

					</div>


				</div>


			</div>

		</div>

	</div>

<!-- -------------------------------------------------------------- action modal ----------------------------------------------------- -->

	<div class=" modal bd-example-modal-lg" tabindex="-1" role="dialog" id="briefing_modal">
		<div class="modal-dialog modal-dialog-centered modal-dialog-jump modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #FFE0AD; ">
					<div class="row w-100"  >
						<div class="col-md-12" >
							<h5 class="modal-title" id="briefing_modal_header" style="font-weight:700; color: #A30808;"></h5>
						</div>
					</div>
					
					 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" align="center">
					<form action="#" method="post" autocomplete="off" enctype="multipart/form-data"  >
						<table style="width: 100%;" class="modal_table">
							<tr>
								<th >Meeting Id :</th>
								<td id="modal_meetingid"></td>
								<th>Meeting Date & Time:</th>
								<td id="modal_datetime"></td>
							</tr>
							<tr>
								<th>Project :</th>
								<td id="modal_projectcode"></td>
								<th></th>
								<td></td>
							</tr>
							<tr>
								<th >Briefing Paper :</th>
								<td colspan="3" >
									<input type="file" accept=".pdf" id="briefingpaper" name="briefingpaper" class="form-control" required="required">
								</td>
							</tr>
							<tr><th> Briefing <br> Presentation : </th>
							<td colspan="3">
							<input type="file" accept=".pdf" id="briefingpresent" name="briefingpresent" class="form-control" required="required">
							</td>
							</tr>
							<tr>
							<th> MOM  :</th>
							<td colspan="3">
							<input type="file" accept=".pdf" id="Momfile" name="Momfile" class="form-control" required="required" >
							</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="4">
									<button class="btn btn-sm submit" formaction="FrozenBriefingAdd.htm" formmethod="post"  onclick="return confirm('Are You Sure to Submit?');" id="modal_add_btn">Submit</button>
									<button class="btn btn-sm edit" formaction="FrozenBriefingUpdate.htm" formmethod="post" onclick="Update()" id="modal_update_btn">Update</button>
								</td>
							</tr>
						</table>
						<input type="hidden" name="projectid" id="modal_projectid" value="">
						<input type="hidden" name="committeecode" value=<%=committeecode %>>
						<input type="hidden" name="scheduleid" id="modal_scheduleid" value="">
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					</form>
					
				</div>
				
			</div>
		</div>
	</div>

<!-- -------------------------------------------------------------- action modal ----------------------------------------------------- -->
</body>
<script type="text/javascript">

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
});


function showmodal(addupdate,scheduleid,meetingid,datetime,projectcode, projectid )
{
	$('#modal_scheduleid').val(scheduleid);
	$('#modal_projectid').val(projectid);
	
	$('#modal_meetingid').html(meetingid);
	$('#modal_datetime').html(datetime);
	$('#modal_projectcode').html(projectcode);
	
	if(addupdate === 'A'){
		$('#briefing_modal_header').html('Add Briefing Details');
		$('#modal_add_btn').show();
		$('#modal_update_btn').hide();
		var briefingpaper=document.getElementById('briefingpaper');
		briefingpaper.setAttribute("required","required");
		var briefingpresent=document.getElementById('briefingpresent');
		briefingpresent.setAttribute("required","required");
		
	}else
	{
		$('#briefing_modal_header').html('Update Existing Briefing Details');
		$('#modal_add_btn').hide();
		$('#modal_update_btn').show();	
		var briefingpaper=document.getElementById('briefingpaper');
		briefingpaper.removeAttribute("required");
		var briefingpresent=document.getElementById('briefingpresent');
		briefingpresent.removeAttribute("required");
		var Momfile=document.getElementById('Momfile');
		Momfile.removeAttribute("required");
	}
	
	$('#briefing_modal').modal('toggle');
}

function Update(){
	var briefingpaper=$('#briefingpaper').val();
	var briefingpresent=$('#briefingpresent').val();
	var Momfile=$('#Momfile').val();
	if(briefingpresent.length==0 && briefingpaper.length==0 && Momfile.length==0){
		alert("please upload anyone file!");
		event.preventDefault();
		return false;
	}
	if(confirm("Are you sure , you want to update?")){
		return true;
	}else{
		event.preventDefault();
		return false;
	}
	
}
</script>
</html>