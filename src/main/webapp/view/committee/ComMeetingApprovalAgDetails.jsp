<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="com.vts.pfms.committee.model.CommitteeSchedule"%>
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
<spring:url value="/resources/css/committeeModule/ComMeetingApprovalAgDetails.css" var="ComMeetingApprovalAgDetails" />
<link href="${ComMeetingApprovalAgDetails}" rel="stylesheet" />
<title>COMMITTEE SCHEDULE VIEW</title>
</head>
<body>
	<%
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
	List<Object[]> agendalist = (List<Object[]>) request.getAttribute("agendalist");

	Object[] scheduledata = (Object[]) request.getAttribute("scheduledata");
	List<Object[]> empscheduledata = (List<Object[]>) request.getAttribute("empscheduledata");

	String CommitteeName = scheduledata[8].toString();
	List<Object[]> invitedlist = (List<Object[]>) request.getAttribute("invitedlist");

	List<Object[]> AgendaDocList = (List<Object[]>) request.getAttribute("AgendaDocList");

	List<Object[]> agendaList = (List<Object[]>) request.getAttribute("agendaList");
	CommitteeSchedule ccmSchedule = (CommitteeSchedule) request.getAttribute("ccmScheduleData");
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


	<div class="container-fluid">
		<div class="row">

			<div class="col-md-12 ">

				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-3">
								<h4>
									<%=CommitteeName!=null?StringEscapeUtils.escapeHtml4(CommitteeName): " - " %>
									Meeting
								</h4>
							</div>
							<div class="col-md-9">
								<h5 class="mt-6px float-right whiteColor">
									(Meeting Id :
									<%=scheduledata[11]!=null?StringEscapeUtils.escapeHtml4(scheduledata[11].toString()): " - "  %>)
									&nbsp;&nbsp; - &nbsp;&nbsp;(Meeting Date and Time :
									<%= sdf.format(sdf1.parse( scheduledata[2].toString()))%>
									&
									<%=scheduledata[3]!=null?StringEscapeUtils.escapeHtml4(scheduledata[3].toString()): " - " %>)
								</h5>
							</div>
						</div>
					</div>

					<div class="card-body">

						<h5 class="agendah5Color">Agenda</h5>
						<hr>
						<br>

						<%if(agendalist!=null && agendalist.size()>0){ %>

						<table
							class="table table-bordered table-hover table-striped table-condensed ">
							<thead>
								<tr>
									<th>SN</th>
									<th>Agenda Item</th>
									<th>Project</th>
									<th>Remarks</th>
									<th>Presenter</th>
									<th>Duration <span>(Minutes)</span></th>
									<th>Attachment</th>
								</tr>
							</thead>
							<tbody>
								<%	int count=0;
								for(Object[] obj:agendalist){ count++;%>
								<tr>
									<td><%=count%></td>
									<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
									<td><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %>
									</td>
									<td><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %></td>
									<td><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - "%>(<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %>)
									</td>
									<td><%=obj[12]!=null?StringEscapeUtils.escapeHtml4(obj[12].toString()): " - " %></td>
									<td>
										<table>
											<%for(Object[] doc : AgendaDocList) { 
												if(obj[0].toString().equalsIgnoreCase(doc[1].toString())){%>
											<tr>
												<td><%=doc[3]!=null?StringEscapeUtils.escapeHtml4(doc[3].toString()): " - " %></td>
												<td class="agendaTdWidth"><a
													href="AgendaDocLinkDownload.htm?filerepid=<%=doc[2]%>"
													target="blank"><i class="fa fa-download text-success" aria-hidden="true"></i></a></td>
											<tr>
												<%} }%>
											
										</table>
									</td>
								</tr>
								<%} %>
							</tbody>
						</table>
						<%} else if(agendaList!=null && agendaList.size()>0) {%>
						<table class="table table-bordered table-hover table-condensed w-100 mt-10">
							<thead>
								<tr>
									<th>Expand</th>
									<th class="width-5">SN</th>
									<th class="width-22">Agenda Item</th>
									<th class="width-24">Presenter</th>
									<th class="width-14">Duration</th>
									<th class="width-14">File</th>
								</tr>
							</thead>
							<tbody>
								<%//LocalTime starttime = LocalTime.parse(LocalTime.parse(scheduledata[3].toString(),DateTimeFormatter.ofPattern("HH:mm:ss")).format( DateTimeFormatter.ofPattern("HH:mm") ));  %>

								<%
												if(agendaList!=null && agendaList.size()>0) {
													LocalTime starttime = LocalTime.parse(ccmSchedule.getScheduleStartTime());
													int  count=0;
												  	for(Object[] level1: agendaList){
														if(level1[2].toString().equalsIgnoreCase("0")) {
															++count;
											%>
								<tr>
									<td class="center width-3"><span
										class="clickable" data-toggle="collapse" id="row<%=count %>"
										data-target=".row<%=count %>"><button type="button"
												class="btn btn-sm btn-success" id="btn<%=count %>"
												onclick="ChangeButton('<%=count %>')" data-toggle="tooltip"
												data-placement="top" title="Expand">
												<i class="fa fa-plus" id="fa<%=count%>"></i>
											</button></span></td>
									<td class="center width-5"><%=count %></td>

									<td class="width-35"><%=level1[4]!=null?StringEscapeUtils.escapeHtml4(level1[4].toString()): " - " %></td>

									<td class="width-25">
										<%if(level1[6]!=null && !level1[6].toString().equalsIgnoreCase("0")) {%>
										<%=level1[9]!=null?StringEscapeUtils.escapeHtml4(level1[9].toString()): " - " %>
										<%} else {%> - <%} %>
									</td>

									<td class="center width-10"><%=starttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) %>
										- <%=starttime.plusMinutes(Long.parseLong(level1[7].toString())).format( DateTimeFormatter.ofPattern("hh:mm a") )  %>
									</td>

									<td class="center">
										<%if(level1[8]!=null && !level1[8].toString().isEmpty()) {%> <a
										class="btn btn-sm"
										href="CCMScheduleAgendaFileDownload.htm?scheduleAgendaId=<%=level1[0] %>&count=<%=count %>&subCount=0"
										target="_blank"> Annex-<%=level1[3]!=null?StringEscapeUtils.escapeHtml4(level1[3].toString()): " - " %>
									</a> <%} else{%> - <%} %>
									</td>

								</tr>

								<%
												List<Object[]> agendaList2 = agendaList.stream().filter(e -> level1[0].toString().equalsIgnoreCase(e[2].toString())).collect(Collectors.toList());
												
												if(agendaList2.size()>0) {
													LocalTime substarttime = starttime ;
												%>

								<tr class="collapse row<%=count %>" id="rowcollapse<%=count%>">
									<td colspan="1"></td>
									<td colspan="8">
										<table class="table table-bordered table-hover table-condensed  subagendatable w-100"
											id="subagendatable">
											<tbody>
												<%	int countA=0;
																		for(Object[] level2: agendaList2){
																				++countA;
																	%>
												<tr>
													<%-- <td class="center"><%=level2[3] %></td> --%>
													<td class="center width-5"><%=count+"."+countA %></td>
													<td class="width-38"><%=level2[4]!=null?StringEscapeUtils.escapeHtml4(level2[4].toString()): " - " %></td>

													<td class="width-27">
														<%if(level2[6]!=null && !level2[6].toString().equalsIgnoreCase("0")) {%>
														<%=level2[9]!=null?StringEscapeUtils.escapeHtml4(level2[9].toString()): " - " %>
														<%} else {%> - <%} %>
													</td>

													<td class="center width-15point"><%=substarttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) %>
														- <%=substarttime.plusMinutes(Long.parseLong(level2[7].toString())).format( DateTimeFormatter.ofPattern("hh:mm a") )  %>
														<%substarttime = substarttime.plusMinutes(Long.parseLong(level2[7].toString())); %>
													</td>

													<td class="center width-14point">
														<%if(level2[8]!=null && !level2[8].toString().isEmpty()) {%>
														<a class="btn btn-sm"
														href="CCMScheduleAgendaFileDownload.htm?scheduleAgendaId=<%=level2[0] %>&count=<%=count %>&subCount=<%=countA %>"
														target="_blank"> Annex-<%=count %>-<%=countA %>
													</a> <%} else{%> - <%} %>
													</td>
												</tr>

												<%} %>
											</tbody>
										</table>
									</td>
								</tr>
								<%} %>
								<%starttime=starttime.plusMinutes(Long.parseLong(level1[7].toString())); %>
								<%} } }%>
							</tbody>
						</table>
						<%} %>


						<!-- Second Block -->

						<h5 class="agendah5Color">Decision</h5>
						<hr>
						<br>

						<form action="MeetingAgendaApprovalSubmit.htm" name="myfrm"
							id="myfrm" method="post">

							<div class="row">
								<div class="col-md-6">

									<textarea rows="2" type="text"
										class="form-control textareaDisplay" id="Remark" name="Remark"
										placeholder="Enter Remarks to Return ..!!"></textarea>


								</div>
								<div class="col-md-6" align="center">
									<br>
									<button type="submit" name="sub" value="approve"
										class="btn btn-success fw-weight-600"
										onclick="return confirm('Are You Sure To Approve ?')">
										<i class="fa fa-check" aria-hidden="true"></i> Approve
									</button>
									<button type="submit" name="sub" value="return"
										class="btn btn-danger fw-weight-600 returnBackPadding" onclick="remarks()">
										<i class="fa fa-repeat" aria-hidden="true"></i> Return
									</button>
									<button type="submit" name="sub" value="back"
										class="btn btn-primary back returnBackPadding">
										Back</button>
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" /> <input type="hidden"
										name="scheduleid" value="<%=scheduledata[6] %>" />

								</div>
							</div>


							<br>

						</form>
						<!-- Third Block -->

						<h4 class="agendah5Color">Committee Constitution</h4>
						<hr>
						<br>

						<div class="row">

							<div class="col-md-6">

								<div class="table-responsive tbl4OverFlow">

									<table
										class="table table-bordered table-hover table-striped table-condensed"
										id="myTable4">

										<tbody>
											<%	
											for(Object[] obj:invitedlist){ %>


											<tr>

												<td>
													<%  if(obj[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
													else if(obj[3].toString().equalsIgnoreCase("CS") ){	 %>
													Member Secretary<%}
													else if(obj[3].toString().equalsIgnoreCase("PS") ) { %>Member
													Secretary (Proxy) <%}
													else if(obj[3].toString().equalsIgnoreCase("CI")){   %>
													Internal<%}
													else if(obj[3].toString().equalsIgnoreCase("CW")){	 %>
													External(<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %>)<%}
													else if(obj[3].toString().equalsIgnoreCase("CO")){	 %>
													External(<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - "%>)<%}
													else if(obj[3].toString().equalsIgnoreCase("P") ){	 %>Presenter
													<%}
													else if(obj[3].toString().equalsIgnoreCase("I")){	 %> Addl.
													Internal<%}
													else if(obj[3].toString().equalsIgnoreCase("W") ){	 %>
													Addl. External(<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %>)<%}
													else if(obj[3].toString().equalsIgnoreCase("E") )    {%>
													Addl. External(<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %>)<%}
													else {%> <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%>
													(<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %>)
													<%}
												%>

												</td>
												<td><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %>
													(<%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - "%>)</td>
											</tr>
											<%}	%>


										</tbody>
									</table>

								</div>

							</div>
							<div class="col-md-6">

								<table
									class="table table-bordered table-hover table-striped table-condensed"
									id="myTable4">
									<thead>
										<tr>
											<th class="text-center" colspan="4">My Schedules
												on <%= sdf.format(sdf1.parse( scheduledata[2].toString()))%>
											</th>
										</tr>
										<tr>
											<th>SN</th>
											<th>Meeting Id</th>
											<th>Member Type</th>
											<th>Time</th>
										</tr>
									</thead>
									<tbody>
										<%long count=0;
										for(Object[] obj:empscheduledata){
											count++;%>
										<tr>
											<td><%=count %></td>
											<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></td>
											<td>
												<%  if(obj[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
													else if(obj[3].toString().equalsIgnoreCase("CS") ){	 %>
												Member Secretary<%}
													else if(obj[3].toString().equalsIgnoreCase("PS") ) { %>Member
												Secretary (Proxy) <%}
													else if(obj[3].toString().equalsIgnoreCase("CI")){   %>
												Internal<%}
													else if(obj[3].toString().equalsIgnoreCase("CW")){	 %>
												External(<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %>)<%}
													else if(obj[3].toString().equalsIgnoreCase("CO")){	 %>
												External(<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - "%>)<%}
													else if(obj[3].toString().equalsIgnoreCase("P") ){	 %>Presenter
												<%}
													else if(obj[3].toString().equalsIgnoreCase("I")){	 %> Addl.
												Internal<%}
													else if(obj[3].toString().equalsIgnoreCase("W") ){	 %>
												Addl. External(<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %>)<%}
													else if(obj[3].toString().equalsIgnoreCase("E") )    {%>
												Addl. External(<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - "%>)<%}
													else {%> <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%>
												(<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %>)
												<%}
												%>
											</td>
											<td><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></td>
										</tr>
										<%}	%>


									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>






	<script>



function remarks(){
	
	 event.preventDefault();
	
	 if($("#Remark").val()==""){
		 alert('Kindly fill Remarks to Return !')
	 }
	 if($("#Remark").val()!=""){
		 
		 var r=confirm("Are you sure, You want to Return ?");
	
		 if(r==true){
		 var input= $("<input>").attr("type","hidden").attr("name","sub").val("return");
		 
		 $("#myfrm").append(input);
		 $("#myfrm").submit(); 
		 }
		 
	 }
	 
	

}

$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
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
	            singleDatePicker:true,
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
 
	
function Add(myfrm){
	
	event.preventDefault();
	
	var date=$("#readonlystartdate").val();
	var time=$("#starttime").val();
	
	bootbox.confirm({ 
 		
	    size: "large",
		message: "<center></i>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>Are You Sure To Update Schedule to "+date+" &nbsp;("+ time +") ?</b></center>",
	    buttons: {
	        confirm: {
	            label: 'Yes',
	            className: 'btn-success'
	        },
	        cancel: {
	            label: 'No',
	            className: 'btn-danger'
	        }
	    },
	    callback: function(result){ 
	 
	    	if(result){
	    	
	    		$("sub").value;
	         $("#editform").submit(); 
	    	}
	    	else{
	    		event.preventDefault();
	    	}
	    } 
	}) 
	
	
}	


	
/* --------------------- Expand Button Handle for Agenda List--------------------------- */
function ChangeButton(id) {
	  
	if($("#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString()=='true'){
	$( "#btn"+id ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
	$( "#fa"+id ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
	$( ".row"+id).show();
    }else{
	$( "#btn"+id ).removeClass( "btn btn-sm btn-danger" ).addClass( "btn btn-sm btn-success" );
	$( "#fa"+id ).removeClass( "fa fa-minus" ).addClass( "fa fa-plus" );
	$( ".row"+id).hide();
    }
}	
/* --------------------- Expand Button Handle for Agenda List End --------------------------- */	
	

 
</script>


</body>
</html>