<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page
	import="org.apache.logging.log4j.core.pattern.IntegerPatternConverter"%>
<%@page import="java.sql.Date"%>
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
<spring:url value="/resources/css/rodModule/rodScheduleView.css" var="rodScheduleView" />
<link href="${rodScheduleView}" rel="stylesheet" />

</head>
<body>

	<%
	String logintype = (String) request.getAttribute("logintype");
	int useraccess = Integer.parseInt(request.getAttribute("useraccess").toString());
	Object[] rodscheduleeditdata = (Object[]) request.getAttribute("rodscheduleeditdata");
	List<Object[]> rodagendalist = (List<Object[]>) request.getAttribute("rodagendalist");
	List<Object[]> employeelist = (List<Object[]>) request.getAttribute("employeelist");
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
	List<Object[]> invitedlist = (List<Object[]>) request.getAttribute("rodinvitedlist");
	List<Object[]> returndata = (List<Object[]>) request.getAttribute("ReturnData");
	List<Object[]> pfmscategorylist = (List<Object[]>) request.getAttribute("pfmscategorylist");
	String userview = (String) request.getAttribute("userview");
	String otp = (String) request.getAttribute("otp");
	int committeecons = (Integer) request.getAttribute("committeecons");
	List<Object[]> AgendaDocList = (List<Object[]>) request.getAttribute("AgendaDocList");
	String projectType = "P";
	String projectid = rodscheduleeditdata[9].toString();
	String divisionid = rodscheduleeditdata[16].toString();
	String initiationid = rodscheduleeditdata[17].toString();
	Object[] projectdetails = (Object[]) request.getAttribute("projectdetails");
	Object[] divisiondetails = (Object[]) request.getAttribute("divisiondetails");
	Object[] initiationdetails = (Object[]) request.getAttribute("initiationdetails");
	%>

	<%
	String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
			<%=StringEscapeUtils.escapeHtml4(ses1)%>
		</div>
	</div>
	<%
	}
	if (ses != null) {
	%>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=StringEscapeUtils.escapeHtml4(ses)%>
		</div>
	</div>
	<%
	}
	%>

	<div class="container-fluid">
		<div class="row">

			<div class="col-md-12 ">

				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-8 ">
								<h4>
									<%=rodscheduleeditdata[8]%>
									Meeting
									<%
									if (Long.parseLong(projectid) > 0) {
										projectType = "P";
									%>
									(Project :
									<%=projectdetails[4]%>)
									<%
									}
									%>
									<%
									if (Long.parseLong(divisionid) > 0) {
									%>
									(Division :
									<%=divisiondetails[1]%>)
									<%
									}
									%>
									<%
									if (Long.parseLong(initiationid) > 0) {
										projectType = "I";
									%>
									(Initiated Project :
									<%=initiationdetails[1]%>)
									<%
									}
									%>
								</h4>
							</div>
							<div class="col-md-4">

								<form action="RecordofDiscussion.htm" name="myfrm" method="post">
									<input type="submit" class="btn  btn-sm back custom-back"
										value="SCHEDULE LIST">
									<input type="hidden" name="rodNameId"
										value="<%=rodscheduleeditdata[0]%>"> <input
										type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" /> <input type="hidden"
										name="projectid" value="<%=projectid%>"> <input
										type="hidden" name="initiationId" value="<%=initiationid%>">
									<input type="hidden" name="projectType"
										value="<%=projectType%>">
								</form>

							</div>
						</div>
					</div>

					<div class="card-body">

						<%
						if (Integer.parseInt(rodscheduleeditdata[10].toString()) < 5) {
						%>
						<form action="RODScheduleDelete.htm" method="post">
							<%
							}
							%>
							<h5 class="custom-h5">
								Schedule (Meeting Id :
								<%=rodscheduleeditdata[11] != null ? StringEscapeUtils.escapeHtml4(rodscheduleeditdata[11].toString()) : " - "%>)
								<%
							if (Integer.parseInt(rodscheduleeditdata[10].toString()) < 5) {
							%>
								<button class="fa fa-trash btn btn-danger custom-trash" type="submit"
									onclick="return confirm('Are You Sure To Delete this Meeting?');"></button>
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden"
									name="scheduleid" value="<%=rodscheduleeditdata[6]%>">
								<%
								}
								%>
							</h5>
							<%
							if (Integer.parseInt(rodscheduleeditdata[10].toString()) < 5) {
							%>
						</form>
						<%
						}
						%>


						<hr>

						<form action="RODScheduleUpdate.htm" id="editform" method="post">

							<table class="custom-table">
								<tr>
									<td><label class="control-label">Meeting Date :
											&nbsp;</label></td>
									<td>
										<%
										LocalDate todaydate = LocalDate.now();
										LocalDate scheduledate = Date.valueOf(rodscheduleeditdata[2].toString()).toLocalDate();
										if (Integer.parseInt(rodscheduleeditdata[10].toString()) < 5) {
										%> <input class="form-control"
										data-date-format="dd/mm/yyyy" id="readonlystartdate"
										name="committeedate" readonly="readonly" required="required"
										value=" <%=sdf.format(sdf1.parse(rodscheduleeditdata[2].toString()))%>">
										<%
										} else {
										%> <input class="form-control"
										data-date-format="dd/mm/yyyy" id="startdate"
										name="committeedate" required="required" readonly="readonly"
										value=" <%=sdf.format(sdf1.parse(rodscheduleeditdata[2].toString()))%>">
										<%
										}
										%>

									</td>
									<td class="td-pl-20"><label
										class="control-label">Meeting Time : &nbsp;</label></td>
									<td><input class="form-control" type="text" id="starttime"
										name="committeetime" readonly="readonly" required="required"
										value="<%=rodscheduleeditdata[3]%>"></td>

									<th class="th-pl-40">
										<%-- <%if(useraccess>=1){ %> --%> <input type="hidden"
										name="scheduleid"
										value="<%=rodscheduleeditdata[6] != null ? StringEscapeUtils.escapeHtml4(rodscheduleeditdata[6].toString()) : " - "%>">
										<%
										if (Integer.parseInt(rodscheduleeditdata[10].toString()) < 6) {
										%>
										<input type="submit" id="update" class="btn  btn-sm submit"
										value="SUBMIT" onclick="Add(myfrm)"> <%
 } else {
 %> <script
											type="text/javascript">
						   									$("#startdate").prop('disabled', true);
						   									$("#starttime").prop('disabled', true);
						   									</script> <%
 }
 %> <input type="hidden"
										name="${_csrf.parameterName}" value="${_csrf.token}" /> <%-- <%} %>	 --%>
									</th>
								</tr>
							</table>
						</form>
						<br>
						<hr>
											<form action="RODVenueUpdate.htm" method="post" id="venuupdatefrm">
									<table class="table-venue">
										<tr>
											<td class="td-w-100"> 	<label class="control-label label-pl-10">Venue : &nbsp;</label></td>
											<td >	<input class="form-control" type="text" name="venue" id="venue" required="required"  placeholder="Enter the Venue" <%if(rodscheduleeditdata[12]!=null){ %> value="<%=StringEscapeUtils.escapeHtml4(rodscheduleeditdata[12].toString()) %>" <%} %> ></td>
				                       
		                  				<tr >  
		                  					<td> <label class="label-reference">Reference : &nbsp;</label></td>
						       				<td colspan="3"><input class="form-control" type="text" name="reference" id="reference"   placeholder="Reference for this Meeting" <%if(rodscheduleeditdata[14]!=null){ %> value="<%=StringEscapeUtils.escapeHtml4(rodscheduleeditdata[14].toString()) %>" <%} %> ></td>
		                  				</tr>
		                  				<tr >
		                  					<td colspan="4"  align="center"   >
							             			<%if(Integer.parseInt(rodscheduleeditdata[10].toString())<6) { %>
							             			
								             			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								             			<input type="hidden" name="scheduleid" value="<%=rodscheduleeditdata[6]%>">
								             				             					
								             			<button type="submit" class="btn  btn-sm edit" name="update" value="SUBMIT"  onclick="return VenueUpdate('venuupdatefrm');" >UPDATE</button>		             				
								             			
							             			<% }else{ %>
							             			
							             				<script type="text/javascript">
							             					$('#venue').prop('readonly','readonly');
							             					$('#isconfidential').attr('disabled',true);
							             					$('#reference').prop('readonly','readonly');
							             					$('#decisions').prop('readonly','readonly');
							             				</script>
							             				
							             			<%} %>	
						             			
						             		</td>
		             					</tr>
	             					</table>
	             			</form>	
						<hr>
						<br>
						<h5 class="custom-h5">Agenda</h5>
						<hr>
						<%
						if (!rodagendalist.isEmpty()) {
						%>

						<table
							class="table table-bordered table-hover table-striped table-condensed ">
							<thead>
								<tr>
									<th>SN</th>
									<th>Agenda Item</th>
									<th>Reference</th>
									<th>Remarks</th>
									<th>Presenter</th>
									<th>Duration (Mins)</th>
									<th>Attachment</th>
								</tr>
							</thead>
							<%
							int count = 0;
							for (Object[] obj : rodagendalist) {
								count++;
							%>

							<tbody>



								<tr>

									<td class="text-center"><%=count%></td>
									<td><%=obj[3] != null ? StringEscapeUtils.escapeHtml4(obj[3].toString()) : " - "%></td>
									<td><%=obj[4] != null ? StringEscapeUtils.escapeHtml4(obj[4].toString()) : " - "%>
									</td>
									<td><%=obj[6] != null ? StringEscapeUtils.escapeHtml4(obj[6].toString()) : " - "%></td>
									<td><%=obj[10] != null ? StringEscapeUtils.escapeHtml4(obj[10].toString()) : " - "%>(<%=obj[11] != null ? StringEscapeUtils.escapeHtml4(obj[11].toString()) : " - "%>)
									</td>
									<td><%=obj[12] != null ? StringEscapeUtils.escapeHtml4(obj[12].toString()) : " - "%></td>
									<td>

										<table>
											<%
											for (Object[] doc : AgendaDocList) {
												if (obj[0].toString().equalsIgnoreCase(doc[1].toString())) {
											%>
											<tr>
												<td><%=doc[3] != null ? StringEscapeUtils.escapeHtml4(doc[3].toString()) : " - "%>
													<%=" <span class='text-muted'> Ver " + StringEscapeUtils.escapeHtml4(doc[4] != null ? doc[4].toString() : "")
		+ "." + StringEscapeUtils.escapeHtml4(doc[5] != null ? doc[5].toString() : "") + "</span>"%></td>
												<td class="td-width"><a
													href="AgendaDocLinkDownload.htm?filerepid=<%=doc[2]%>"
													target="blank"><i class="fa fa-download text-success"
														 aria-hidden="true"></i></a></td>
											<tr>
												<%
												}
												}
												%>
											
										</table>

									</td>

								</tr>
							</tbody>
							<%
							}
							%>

						</table>

						<%
						} else if (Integer.parseInt(rodscheduleeditdata[10].toString()) < 5) {
						%>
						<br>
						<h6 align="center">Kindly Add Agenda ..!!</h6>

						<%
						} else {
						%>
						<br>
						<h6>No Agenda Defined ..!!</h6>
						<%
						}
						%>

						<div class="form-group mt-25" align="center">
							<%
							if (Integer.parseInt(rodscheduleeditdata[10].toString()) < 6
									&& (userview == null || userview.equalsIgnoreCase("CS") || userview.equalsIgnoreCase("CC"))) {
							%>
							<%
							if (!rodagendalist.isEmpty()) {
							%>
							<%-- <%if(useraccess>1){ %>	 --%>
							<form action="RODScheduleAgenda.htm" method="post">
								<input type="hidden" name="scheduleid"
									value="<%=rodscheduleeditdata[6]%>"> <input
									type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
								<button type="submit" class="btn  btn-sm  edit custom-edit"
									>EDIT</button>
							</form>
							<%-- <%} %> --%>

							<%
							} else if (!rodscheduleeditdata[4].toString().equalsIgnoreCase("MAA") && useraccess >= 1) {
							%>
							<form action="RODScheduleAgenda.htm" method="post">
								<input type="hidden" name="scheduleid"
									value="<%=rodscheduleeditdata[6]%>"> <input
									type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
								<button type="submit" class="btn  btn-sm  add custom-add"
									>ADD</button>
							</form>
							<%
							}
							%>
							<%
							}
							%>


						</div>
						<hr>
						<br>


						<div>
							<h5 class="custom-h5">Operations</h5>
						</div>



						<hr class="custom-hr">

						<div class="form-block">

							<form action="RODScheduleMinutes.htm" name="myfrm" id="myfrm"
								method="POST">

								<%
								if (rodscheduleeditdata[4].toString().equalsIgnoreCase("MKV")) {
								%>
								<button type="button" class="btn  btn-sm submit custom-kickoff">
									<i class="fa fa-check custom-check" aria-hidden="true"
										></i> Meeting Kicked Off
								</button>
								<%
								}
								%>


								<%
								if (rodagendalist.size() > 0) {
									if (Integer.parseInt(rodscheduleeditdata[10].toString()) < 3 && invitedlist.size() > 0) {
								%>
								<input type="submit" id="submit" class="btn  btn-sm back custom-part"
									value="Participants" formaction="RODInvitations.htm" />
								<%
								} else if (invitedlist.size() > 0 && Integer.parseInt(rodscheduleeditdata[10].toString()) < 8) {
								%>
								<input type="submit" id="submit" class="btn  btn-sm submit custom-part"
									value="Participants" formaction="RODInvitations.htm" />
								<%
								} else if (rodscheduleeditdata[4].toString().equalsIgnoreCase("MSC")) {
								%>
								<input type="submit" id="submit" class="btn  btn-sm submit custom-part"
									value="Invite" onclick="invite()"
									formaction="RODInvitations.htm"
								 />

								<%
								}
								}
								%>









								<%
								if (rodscheduleeditdata[4].toString().equalsIgnoreCase("MKV")) {
								%>

								<input type="submit" id="submit" class="btn  btn-sm submit custom-attend"
									value="Attendance" formaction="RODAttendance.htm" />
								<input type="hidden" name="membertype" value="CC" />

								<%
								}
								%>

								<%
								if (rodscheduleeditdata[4].toString().equalsIgnoreCase("MKV")) {
								%>

								<input type="submit" id="submit" class="btn  btn-sm submit custom-minute"
									value="Minutes" />


								<%
								}
								%>


								<input type="hidden" name="committeescheduleid"
									value="<%=rodscheduleeditdata[6]%>"> <input
									type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden"
									name="projectid" value="<%=projectid%>">

							</form>
							<form action="MeetingAgendaApproval.htm" name="myfrm1"
								id="myfrm1" method="post">
								<%
								if (rodagendalist.size() > 0 && invitedlist.size() > 0) {
								%>
								<%
								}
								%>

								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden"
									name="committeescheduleid" value="<%=rodscheduleeditdata[6]%>">

							</form>

							<form action="KickOffRODMeeting.htm" name="myfrm" id="myfrm"
								method="post">

								<%
								if (rodscheduleeditdata[4].toString().equalsIgnoreCase("MSC") && !todaydate.isBefore(scheduledate)
										&& invitedlist.size() > 0) {
								%>
								<input type="hidden" name="rodflag" value="Y"> <input
									type="submit" id="submit" name="sub"
									class="btn  btn-sm submit fa-input custom-kickoff"
									value=" &#xf017; &nbsp;&nbsp;Kick Off Meeting "
									onclick="return kickoff()" />

								<%
								}
								%>


								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden"
									name="committeescheduleid" value="<%=rodscheduleeditdata[6]%>">
								<input type="hidden" name="rodname"
									value="<%=rodscheduleeditdata[7]%>"> <input
									type="hidden" name="meetingdate"
									value="<%=rodscheduleeditdata[2]%>"> <input
									type="hidden" name="meetingtime"
									value="<%=rodscheduleeditdata[3]%>"> <input
									type="hidden" name="meetingid"
									value="<%=rodscheduleeditdata[11]%>"> <input
									type="hidden" name="projectid" value="<%=projectid%>">
								<input type="hidden" name="rodNameId"
									value="<%=rodscheduleeditdata[0]%>">

							</form>


							<hr class="custom-hr">
						</div>

					</div>

				</div>
			</div>
		</div>
	</div>
</body>


<script type="text/javascript">
function char_count(str, letter) 
{
 var letter_Count = 0;
 for (var position = 0; position < str.length; position++) 
 {
    if (str.charAt(position) == letter) 
      {
      letter_Count += 1;
      }
  }
  return letter_Count;
}

 function VenueUpdate(frmid){
		var venue=$('#venue').val();
		var charcou=char_count(venue,' ');
		if(venue!='' && char_count(venue,' ')==venue.length  )
			{
				event.preventDefault();
				alert('Please Enter Valid Venue Name');
				return false;
			}
		else{
			var ret=confirm('Are You Sure To Save This venue?');
			return ret;
		}
	} 
	


	function kickoff(){
		<%if (rodscheduleeditdata[12] != null) {%>
		var venue='<%=rodscheduleeditdata[12]%>';
		<%} else {%>
		var venue='';
		<%}%>
		if(venue=='' || char_count(venue,' ')==venue.length)
			{				
				event.preventDefault();
				alert('Please Update Proper Venue Details !');
			}else{
				
				var ret=confirm('Are you to sure to Kick off the Meeting ?');
				if (ret==false){
					event.preventDefault();
				}
			}
		}	
	
	function invite(){
		<%if (rodscheduleeditdata[12] != null) {%>
		var venue='<%=rodscheduleeditdata[12]%>
	';
<%} else {%>
	var venue = '';
<%}%>
	if (venue == '' || char_count(venue, ' ') == venue.length) {
			event.preventDefault();
			alert('Please Update Proper Venue Details !');
		} else {

			if (ret == false) {
				event.preventDefault();
				return false;
			} else if (ret == true) {
				return true;
			}
		}
	}
</script>



<script>
	$('#startdate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"cancelClass" : "btn-default",
		/* "minDate" :new Date(), */
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	$('#readonlystartdate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		/* "minDate":new Date(), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	$(function() {
		$('#starttime').daterangepicker({
			timePicker : true,
			singleDatePicker : true,
			timePicker24Hour : true,
			timePickerIncrement : 1,
			timePickerSeconds : false,
			locale : {
				format : 'HH:mm'
			}
		}).on('show.daterangepicker', function(ev, picker) {
			picker.container.find(".calendar-table").hide();
		});
	})

	function Add(myfrm) {

		event.preventDefault();

		var date = $("#readonlystartdate").val();
		var time = $("#starttime").val();

		bootbox
				.confirm({

					size : "large",
					message : "<center></i>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>Are You Sure To Update Schedule to "
							+ date + " &nbsp;(" + time + ") ?</b></center>",
					buttons : {
						confirm : {
							label : 'Yes',
							className : 'btn-success'
						},
						cancel : {
							label : 'No',
							className : 'btn-danger'
						}
					},
					callback : function(result) {

						if (result) {

							$("sub").value;
							$("#editform").submit();
						} else {
							event.preventDefault();
						}
					}
				})

	}

	function checkagenda() {
<%if (rodagendalist.size() == 0) {%>
	alert('Kindly Add Agenda Inorder to Forward ..!');
		event.preventDefault();
<%} else {%>
	if (confirm('Are you sure to Forward for Agenda Approval') == false) {

			event.preventDefault();
		}
<%}%>
	}

	function resendotp() {

		$('#otp').prop('required', false);
	}
</script>
<br>
<br>
</html>
