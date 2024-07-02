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
<%-- <spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/content.css" var="contentCss" /> 
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" />
--%>

<title>COMMITTEE SCHEDULE ACTION</title>



<style>
.bs-example {
	margin: 20px;
}

.accordion .fa {
	margin-right: 0.5rem;
}
</style>

<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

.note-editable {
	line-height: 1.0;
}

.panel-info {
	border-color: #bce8f1;
}

.panel {
	margin-bottom: 10px;
	background-color: #fff;
	border: 1px solid transparent;
	border-radius: 4px;
	-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
	box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}

.panel-heading {
	background-color: #FFF !important;
	border-color: #bce8f1 !important;
	border-bottom: 2px solid #466BA2 !important;
	color: #1d5987;
}

.panel-title {
	margin-top: 0;
	margin-bottom: 0;
	font-size: 13px;
	color: inherit;
	font-weight: bold;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

div {
	display: block;
}

element.style {
	
}

.olre-body .panel-info .panel-heading {
	background-color: #FFF !important;
	border-color: #bce8f1 !important;
	border-bottom: 2px solid #466BA2 !important;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-heading {
	padding: 3px 10px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.panel-heading {
	padding: 3px 10px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.panel-heading {
	padding: 3px 10px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.panel-heading {
	padding: 3px 10px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.panel-heading {
	padding: 3px 10px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.p-5 {
	padding: 5px;
}

.panel-heading {
	padding: 10px 15px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

user agent stylesheet
div {
	display: block;
}

.panel-info {
	border-color: #bce8f1;
}

.form-check {
	margin: 0px 4%;
}
</style>
</head>


<body>

	<%


String specname=(String)request.getAttribute("specname");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
Object[] committeescheduleeditdata=(Object[])request.getAttribute("committeescheduleeditdata");
List<Object[]> committeescheduledata=(List<Object[]>)request.getAttribute("committeescheduledata");
List<Object[]> EmpList=(List<Object[]>)request.getAttribute("EmployeeList");
List<Object[]> EmpNameList=(List<Object[]>)request.getAttribute("EmpNameList");
String labcode = (String)request.getAttribute("labcode");
List<Object[]> Alllablist = (List<Object[]>)request.getAttribute("AllLabList");
String projectid=committeescheduleeditdata[9].toString();

String GenId="GenAdd";
String MinutesBack=null;
MinutesBack=(String)request.getAttribute("minutesback");
if(MinutesBack==null){
	MinutesBack="NO";
}
List<String>committees=Arrays.asList("PMRC","EB");

//Prudhvi - 13/03/2024
String rodflag=(String)request.getAttribute("rodflag");
%>


	<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><center>
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


	<nav class="navbar navbar-light bg-light" style="margin-top: -1%">
		<a class="navbar-brand"> <b
			style="color: #585858; font-size: 19px; font-weight: bold; text-align: left; float: left"><span
				style="color: #31708f"><%=committeescheduleeditdata[7] %> </span> <span
				style="color: #31708f; font-size: 15px"> (Meeting Date and
					Time : <%=sdf.format(sdf1.parse(committeescheduleeditdata[2].toString()))%>
					- <%=committeescheduleeditdata[3] %>)
			</span></b>

		</a>

		<%if(MinutesBack.equalsIgnoreCase("minutesback")){ %>
		<!-- Prudhvi - 13/03/2024 -->
		<a class="btn  btn-sm back"
		    <%if(rodflag!=null && rodflag.equalsIgnoreCase("Y")) {%>
		    	href="RODScheduleMinutes.htm?committeescheduleid=<%=committeescheduleeditdata[6] %>"
		    <%} else{%>
				href="CommitteeScheduleMinutes.htm?committeescheduleid=<%=committeescheduleeditdata[6] %>"
			<%} %>
			style="margin-left: 50px; font-size: 12px; font-weight: bold; width: 62px; margin-top: -2px;">BACK</a>

		<%} %>

		<%if(!MinutesBack.equalsIgnoreCase("minutesback")){ %>

		<a class="btn  btn-sm back" href="ActionList.htm"
			style="margin-left: 50px; font-size: 12px; font-weight: bold; width: 62px; margin-top: -2px;">BACK</a>

		<%} %>

	</nav>


	<div class="container-fluid">

		<div class="row">

			<div class="col-md-5">
				<div class="card" style="border-color: #00DADA; margin-top: 2%;">
					<div class="card-body" <%if(committeescheduledata.size()>5) {%>style="height: 70vh;overflow: auto;background-image: repeating-linear-gradient(45deg, #ffffff 40%, #C4DDFF) !important;"<%} else{%>style=" background-image: repeating-linear-gradient(45deg, #ffffff 40%, #C4DDFF) !important;"<%} %>>
				<div>
						<%
						String prev=""; // for holding the point number
						String next=""; // to store the prev point number
						int count=1;
						for(Object[] obj:committeescheduledata ){  
							prev=obj[7].toString();
							if(!prev.equalsIgnoreCase(next)){ // if prev and next is not equal make count 1
								count=1;
							}
							
							%>

						<div class="panel panel-info" style="margin-top: 10px;">

							<div class="panel-heading " id="div<%=obj[0].toString()%>">
								<h4 class="panel-title" id="<%=obj[0].toString()%>">
									<span style="font-size: 14px"><%=obj[7]+"."+(count++) +". "%> <%-- <%=obj[4] %> --%>  
									<input type="hidden" id="Data<%=obj[0].toString()%>" value="<%=obj[1].toString()%>">
									<%if(obj[1].toString().length()>50) {%>
									<%=obj[1].toString().substring(0,50) %><span style="font-size: 11px;color:crimson;cursor: pointer;" onclick='showModal("<%=obj[0].toString()%>")'>&nbsp;( view more)</span>
									<%}else {%>
									<%=obj[1].toString() %>
									<%} %>	
										<br>
										<%if("3".equalsIgnoreCase(obj[7].toString())){%><%-- / <%=obj[5] %> / --%>
									<%-- 	<%=obj[6] %> --%> <%} %> 
										 (<%if("K".equalsIgnoreCase(obj[2].toString())){%>Risk Task<%} %> 
										 <%if("I".equalsIgnoreCase(obj[2].toString())){%>Issue Task<%} %> 
										 <%if("A".equalsIgnoreCase(obj[2].toString())){%>Action Task<%} %>
										 <%if("R".equalsIgnoreCase(obj[2].toString())){%>Recommendation Task<%} %> )
									</span>
								</h4>
								<div style="float: right !important; margin-top: -25px;">
									<form name="myForm<%=obj[0] %>" id="myFormgen<%=obj[0] %>" action="ItemSpecAdd.htm" method="post">
										<input type="hidden" name="specname" value="myFormgen<%=obj[0] %>"> 
										<input type="hidden" name="ScheduleId" value="<%=obj[3] %>"> 
										<input type="hidden" name="ProjectId" value="<%=obj[10] %>">
										<input type="hidden" name="scheduleminutesid" value="<%=obj[0] %>" readonly="readonly"> 
										<input type="hidden" name="minutesid" value="<%=obj[6] %>" readonly="readonly"> 
										<input type="hidden" name="agendasubid" value="<%=obj[9] %>" readonly="readonly"> 
										<input type="hidden" name="scheduleagendaid" value="<%=obj[7] %>" readonly="readonly"> 
										<input type="hidden" name="unitid" value="<%=obj[8] %>" readonly="readonly">
										<input type="hidden" name="type" value="<%=obj[2] %>" readonly="readonly"> 
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
										<input type="submit" name="sub" <%if(!obj[11].toString().equalsIgnoreCase("0")){ %>
											class="btn btn-warning btn-sm" <%}else{ %>
											class="btn btn-info btn-sm"
											<%}if(specname!=null&&specname.equalsIgnoreCase("myFormgen"+obj[0])){ %>
											id="GenAdd" <%} %> <%if(specname==null){ %> id="GenAdd"
											<%} %> onclick="FormName('myFormgen<%=obj[0] %>')"
											value="Assign"
											style="width: 50px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify;" />

									</form>
								</div>
							</div>
						</div>
						<%next=prev;}  // assign the previous value to next one%> 
</div>
					</div>
					<!-- Big card-body end -->

				</div>
				<!-- Card End  -->

			</div>
			<!-- col-md-5 end -->
			<div class="col-md-7" style="">

				<div class="card" style="margin-top: 2%;">
					<div class="card-header" style="background-color: #055C9D;">
						<div class="row">

							<div class="col-sm-5" align="left">
								<h6 style="color: white; font-weight: bold; font-size: 1.2rem !important" align="left"></h6>
							</div>

							<div class="col-sm-7" align="left">
								<div class="input-group" style="margin-top: -8px;">
									<input type="text" class="form-control" placeholder="Search Action Id to Link Old Action" name="ItemDescription" id="ItemDescriptionSearch">
									<div class="input-group-append">
										<button class="btn btn-secondary" type="button" style="font-size: 10px;" id="ItemDescriptionSearchBtn">
											<i class="fa fa-search"></i>
										</button>
									</div>
								</div>
								</div>
						</div>
					</div>
					<div class="card-body" >
						<form name="specadd" id="specadd" action="CommitteeActionSubmit.htm" method="post" >
							<div class="row" style="margin-top: -35px">
								<div class="col-md-12" align="left">
									<label> <b id="iditemspec" style="font-size: 18px"></b>
										<b id="iditemsubspecofsub" style="font-size: 18px"></b> <b
										id="iditemsubspec" style="font-size: 18px"></b><b
										id="iditemsubspecofsubspec" style="font-size: 18px"></b> <b
										id="action" style="font-size: 18px"></b> <input type="hidden"
										name="scheduleminutesid" id="minutesidadd"> <input
										type="hidden" name="ScheduleId" id="ScheduleAdd"> <input
										type="hidden" name="ProjectId" id="ProjectAdd"> <input
										type="hidden" name="Type" id="TypeAdd"> <input
										type="hidden" name="ScheduleSpec" id="ScheduleSpec"> <input
										type="hidden" name="specname" id="specnameadd"> <input
										type="hidden" name="minutesback" value="<%=MinutesBack %>">
									</label>
								</div>

								<div class="col-sm-10" align="left">
									<div class="form-group" style="text-align: justify;">
										<label>Action Item: <span class="mandatory"
											style="color: red;">*</span>
										</label><br>
										<b id="iditem" style="font-size: 18px"></b> 
										<input type="hidden" name="Item" id="additem" style="width: 100%" maxlength="1000">
									</div>
								</div>
								<div class="col-md-1" align="left"></div>

								<div class="col-sm-3" align="left">
									<div class="form-group">
										<label>PDC: <span class="mandatory"
											style="color: red;">*</span></label> 
											<input class="form-control " name="DateCompletion" id="DateCompletion" required="required" placeholder=""> 
											<input type="hidden" name="meetingdate" value="<%=committeescheduleeditdata[2]%>">
									</div>
								</div>
								<div class="col-sm-4" align="left">
									<label> Priority : </label> <br> 
									<select class="form-control selectdee " name="Priority" id="Priority" required="required" data-live-search="true">
										<option value="H">High</option>
										<option value="L">Low</option>
										<option value="M">Medium</option>
										<option value="I">Immediate</option>
									</select>
								</div>

								<div class="col-sm-4" align="left">
									<label> Category : </label> <br> 
									<select class="form-control selectdee " name="Category" id="Category" required="required" data-live-search="true">
										<option value="T">Technical</option>
										<option value="F">Finance</option>
										<option value="M">Managerial</option>
										<option value="L">Logistic</option>
										<option value="O">Others</option>
									</select>
								</div>

								<div class="col-sm-3" align="left">
									<div class="form-group">
										<label>Lab: <span class="mandatory"
											style="color: red;">* </span></label> <select
											class="form-control selectdee" name="AssigneeLabCode"
											id="AssigneeLabCode" onchange="AssigneeEmpList();">
											<%for(Object[] lab : Alllablist){%>
											<option value="<%=lab[3] %>"
												<%if(labcode.equalsIgnoreCase(lab[3].toString())){%>
												selected="selected" <%}%>><%=lab[3] %></option>
											<%}%>
											<option value="@EXP"
												<%if("@EXP".equalsIgnoreCase(labcode)){%>
												selected="selected" <%}%>>Expert</option>
										</select>
									</div>
								</div>

								<div class="col-sm-4" align="left">
									<div class="form-group">
										<label> Assignee : </label>
										<%-- <%if(Long.parseLong(projectid)>0){ %>
												<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
													<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox" onchange="changeempdd()" >
												</div>
											<%} %> --%>
										<br> <select class="form-control selectdee"
											name="Assignee" id="Assignee"<%if(committees.contains(committeescheduleeditdata[8].toString())) {%> required="required" <%} %>
									onchange="removeAttri()"		data-live-search="true" data-placeholder="Select Assignee"
											multiple>


											<%--  <%for(Object[] obj:EmpList){ %>	
																								
																						<option value="<%=obj[0]%>"><%=obj[1]%>, <%=obj[2]%></option>	
																								
																						<%} %> --%>
										</select>
									</div>
								</div>

						<!-- 		<div class="col-sm-4" align="left">
									<div class="form-group" id="OldList">
										<label> Old Action No : </label><br> <select
											class="form-control selectdee " name="OldActionNo"
											id="OldActionNoId" hidden="hidden" data-live-search="true"
											style="width: 100%"></select>
									</div>
								</div> -->
								<!-- Prudhvi - 13/03/2024 -->
								<%if(!committees.contains(committeescheduleeditdata[8].toString()) && rodflag==null) {%>
								<div class="col-sm-4" align="left" id="main">
									<div class="form-group" >
										<label>Multiple Assignee : </label><br> 
										<select class="form-control"    onchange="showEmployee()" id="multipleAssignee" name="multipleAssignee" required="required">
										<option value="" selected="selected"> Select </option> 
										<option value="T">ALL TD</option>
										<option value="G">ALL GH</option>
										<option value="D">ALL DH</option>
										<option value="P">ALL PD</option>
										</select>
									</div>
								</div>
								<%} %>

							</div>
							<div class="row" align="center">
								<div class="col-sm-4" align="left"></div>
								<div class="col-sm-6" align="left">
									<br> <input type="submit" name="sub"
										style="margin-top: 10px;" class="btn  btn-sm submit"
										form="specadd" id="adding" value="SUBMIT"
										onclick="return confirm('Are you sure To Submit?')" />
									<button class="btn  btn-sm back" style="margin-top: 10px;"
										onclick="resetSubmit()">Reset</button>
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />
									<!-- Prudhvi - 13/03/2024 -->
									<%if(rodflag!=null) {%>
										<input type="hidden" name="rodflag" value="Y">	
									<%} %>
								</div>
							</div>
							<!-- Form End -->

							<div class="table-responsive">
								<table class="table table-bordered table-hover table-striped table-condensed"
									id="myTabl" style="margin-top: 20px; width: 98%;">
									<thead>
										<tr>
											<th style="text-align: left;">Action Item</th>
											<th style="">PDC</th>
											<th style="">Assigned On</th>
											<th style="">Assignee</th>
											<th style="">Action</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>

						</form>
					</div>

				</div>

			</div>
			<!-- col-md-7 end -->


		</div>
		<!-- main row end -->

	</div>
	
	<!--Modal for employees  -->
<div class="modal fade bd-example-modal-lg" id="employeeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content" >
      <div class="modal-header" style="background-color:#C4DDFF;">
        <h5 class="modal-title" id="modalHeader" >Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" >
      <div style="display:flex;justify-content: center;height: 58vh; overflow-y: auto;">
        <table class="table table-bordered" style="width: 80%;" >
  		<thead class="bg-light">
    	<tr>
   		<th style="width:12%;">SL No.</th>
   		<th style="text-align: center;">Employee</th>
    	</tr>
  		</thead>
  		<tbody id="modalTable">
   
    	</tbody>
        </table>
     </div>
      </div>
    
    </div>
  </div>
</div>


<!-- modal for action item -->

<div class="modal fade" id="actionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Action Item</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalbody" style="font-size: 1.15rem;">
      
      </div>

    </div>
  </div>
</div>

<!-- modal for action edit start -->

	<div class="modal fade" id="exampleModalAction" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalCenterTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content" style="margin-left: -13%; width: 37rem;">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="CommitteActionEdit.htm" method="post">
						<div class="row">
							<div class="col-md-3">
								<label
									style="font-family: 'Lato', sans-serif; font-weight: 700; font-size: 16px">PDC
									:</label>
							</div>
							<div class="col-md-4" style="margin-left: -6%;">
								<input class="form-control " name="PDCDate" id="PDCDate"
									style="width: 261%;">
							</div>
						</div>

						<div class="row">
							<div class="col-md-3 mt-3">
								<div class="form-group">
									<label
										style="font-family: 'Lato', sans-serif; font-weight: 700; font-size: 16px">Lab
										:</label>
								</div>
								</div>
								<div class="col-md-8 mt-3" style="margin-left: -6%;">
									<select class="form-control selectdee" name="AssigneeLab" onchange="labChange()"
										id="AssigneeLabName" style="width: 118%;">
										
									</select>
								</div>
							</div>

						<div class="row mt-2">
							<div class="col-md-3">
								<label
									style="font-family: 'Lato', sans-serif; font-weight: 700; font-size: 16px">
									Assignee : </label>
							</div>
							<div class="col-md-8" style="margin-left: -6%;">
								<select class="form-control selectdee " name="AssigneeId"
									id="AssigneeUpdate" data-live-search="true"
									style="width: 118%;">

								</select>
							</div>
						</div>
						<br>
						<div align="center">
							<button type="submit" class="btn btn-sm submit"
								onclick="return confirm('Are you sure To Submit?')">Submit</button>
							<input type="hidden" name="ActionAssignId" id="ActionAssignId"
								value=""> <input type="hidden" name="ActionMainId"
								id="ActionMainId" value="" /> <input type="hidden"
								name="AssigneeId" id="AssigneeId" value="" /> <input
								type="hidden" name="CommitteeScheduleId"
								id="CommitteeScheduleId" value="" /> <input type="hidden"
								name="minutesback" value="<%=MinutesBack%>" /> 
								<input type="hidden" name="specnamevalue" id="specValue" value="">
								<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
<!-- modal for action edit start -->

	<script type="text/javascript">
		function changeempdd() {
			var $labcode = $('#AssigneeLabCode').val();

			if (document.getElementById('allempcheckbox').checked) {
				employeefetch(0, $labcode);
			} else {
				employeefetch(
	<%=committeescheduleeditdata[9]%> , $labcode);
  }
}

	
	function employeefetch(ProID,labcode){
			
				
						$.ajax({		
							type : "GET",
							url : "ProjectEmpListFetch.htm",
							data : {
								projectid : ProID,
								labCode   : labcode
								   },
							datatype : 'json',
							success : function(result) {
		
							var result = JSON.parse(result);
								
							var values = Object.keys(result).map(function(e) {
										 return result[e]
									  
							});
								
					var s = '';
						s += '<option value="">'+"--Select--"+ '</option>';
								 for (i = 0; i < values.length; i++) {									
									s += '<option value="'+values[i][0]+'">'
											+values[i][1] + " (" +values[i][2]+")" 
											+ '</option>';
								} 
								 
								$('#Assignee').html(s);
								
							}
						});
		
		
	}
		
</script>


	<script>
  
    $(document).ready(function(){
        // Add minus icon for collapse element which is open by default
        $(".collapse.show").each(function(){
        	$(this).prev(".panel-heading").find(".fa").addClass("fa-minus").removeClass("fa-plus");
        });
        
        // Toggle plus minus icon on show hide of collapse element
        $(".collapse").on('show.bs.collapse', function(){
        	$(this).prev(".panel-heading").find(".fa").removeClass("fa-plus").addClass("fa-minus");
        }).on('hide.bs.collapse', function(){
        	$(this).prev(".panel-heading").find(".fa").removeClass("fa-minus").addClass("fa-plus");
        });
    });
    
    $(document).ready(function(){
        // Add minus icon for collapse element which is open by default
        $(".collapse.show").each(function(){
        	$(this).prev(".panel-heading").find(".btn").addClass("btn-danger btn-sm").removeClass("btn-info btn-sm");
        });
        
        // Toggle plus minus icon on show hide of collapse element
        $(".collapse").on('show.bs.collapse', function(){
        	$(this).prev(".panel-heading").find(".btn").removeClass("btn-info btn-sm").addClass("btn-danger btn-sm");
        }).on('hide.bs.collapse', function(){
        	$(this).prev(".panel-heading").find(".btn").removeClass("btn-danger btn-sm").addClass("btn-info btn-sm");
        });
    });
   
    

</script>


	<script type="text/javascript">
	 
	
	$("#OldList").hide();

	
	$("#ItemDescriptionSearchBtn").click(function(){
		   $('#OldActionNoId').empty();
		var $ItemSearch = $("#ItemDescriptionSearch").val();
		  $("#loader ").show(); 
		
		
		
		  if ($ItemSearch === ""){
			 alert("Search Content Requried");
			 $("#loader ").hide();
		  }else{
					  
			  $
				.ajax({

					type : "GET",
					url : "ActionNoSearch.htm",
					data : {
						ActionSearch : $ItemSearch
					},
					datatype : 'json',
					success : function(result) {

						var result = JSON.parse(result);
						var values = Object.values(result).map(function(key, value) {
							  return result[key,value]
							});
						var size = Object.keys(values).length;
						var s = '';
						 $("#OldList").show(); 
					     $("#OldActionNoId").prop("disable",false);
					    $("#OldActionNoId").empty();
					     $.each(values, function(key, value) {   
					         $('#OldActionNoId')   
					             .append($("<option></option>")
					                        .attr("value", value[0])
					                        .text(value[1]+", "+value[2])); 
					    });
					    
						$("#loader ").hide(); 
					}
				}); 
			  
			  
			  
		  }
		}); 
	
	
	function resetSubmit(){
		event.preventDefault();
		 $("#OldList").hide(); 
	     $("#OldActionNoId").prop("disable",true);

	}
	


    function FormName(formId) {
    	var data = formId.substring(9);
    	$("."+"panel-title").css('color', '#31708f');
    	$("."+"panel-title").css('text-decoration', 'none');
    	
    	$('#'+data).css('color', 'green');
    	$('#'+data).css('text-decoration', 'underline');
    
    	console.log("data "+data)
    	
    	  $("#"+formId).submit(function(event){
    		    event.preventDefault();
    		    $('#adding').show();
    		   
    		    var minutesidadd = $("input[name='minutesid']",this).val();
    		    var specnameadd= $("input[name='specname']",this).val();
    		    var agendasubidadd= $("input[name='agendasubid']",this).val();
    		    var scheduleagendaidadd= $("input[name='scheduleagendaid']",this).val();
    		    var scheduleminutesidadd = $("input[name='scheduleminutesid']",this).val();
    		    var scheduleid= $("input[name='ScheduleId']",this).val();
    		    var projectid= $("input[name='ProjectId']",this).val();
    		    var unitidadd= $("input[name='unitid']",this).val();
    		    var typeadd= $("input[name='type']",this).val();
    		    $("#minutesidadd").val(scheduleminutesidadd);
    		    $("#specnameadd").val(specnameadd);
    		    $("#ScheduleAdd").val(scheduleid);
    		    $("#ProjectAdd").val(projectid);
    		    $("#TypeAdd").val(typeadd);
    		    var specall;
    		    var type;
    		    if(typeadd=='A'){
    		    	type="(Action Task)";
    		    }else if(typeadd=='I'){
    		    	type="(Issue Task)";
    		    }else{
    		    	type="(Risk Task)";
    		    }
    		    
    		    $.ajax({

    		    	type : "GET",
    		    	url : "ScheduleActionItem.htm",
    		    	data : {
    		    		ScheduleMinutesId : scheduleminutesidadd
    		    		
    		    	},
    		    	datatype : 'json',
    		    	success : function(result) {

    		    		var result = JSON.parse(result);
    		    		var values = Object.keys(result).map(function(e) {
    		    			  return result[e]
    		    			});
    		    	
    		    		
    		    		$("#iditem").html(result);
						$("#additem").val(result);
						$("#ScheduleSpec").val(result);
    		    	}
    		    });
    		    
    		    $.ajax({

    		    	type : "GET",
    		    	url : "ScheduleActionList.htm",
    		    	data : {
    		    		ScheduleMinutesId : scheduleminutesidadd
    		    		
    		    	},
    		    	datatype : 'json',
    		    	success : function(result) {

    		    		var result = JSON.parse(result);
    		    		var values = Object.keys(result).map(function(e) {
    		    			  return result[e]
    		    			});
    		    		
    		    		
    		    		var s = '';
    		    		
    		    		$("#myTabl tbody tr").hide();
    		    		$("#myTabl thead tr").show(); 
    		    		
    		    		$("#myTabl").DataTable().destroy(); 
    		    		$("#myTabl tbody").html('');  
    		    		var markup = '';
    		    		if(values.length!=0)
    		    		{
    		    			
	    		    		for (i = 0; i < values.length; i++) 
	    		    		{
	    		    			var tempday = moment(JSON.stringify(values[i][3]), "MMM-DD-YYYY");
	    		    			var formatday= moment(tempday).format("DD-MM-YYYY");
	    		    			var tempday1 = moment(JSON.stringify(values[i][4]), "MMM-DD-YYYY");
	    		    			var formatday1= moment(tempday1).format("DD-MM-YYYY");
	    		    		    var tempday2 = moment(JSON.stringify(values[i][10]), "MMM-DD-YYYY");
	    		    			var pdcday= moment(tempday2).format("DD-MM-YYYY");
	    		    			   
	    		    			markup += "<tr><td  style='overflow-wrap: break-word; word-break: break-all; white-space: normal;max-width:20%;min-width:20%;'> "+  values[i][5]+"<br>"+"<b>(" + values[i][9] + ")</b>"  + "</td><td style='width:15%;'> "+  formatday1  + "</td><td style='width:15%;'> "+  formatday  + "</td><td style='width:20%;'> "+  values[i][1] +', '+values[i][2] +'('+values[i][8] +')' + "</td>";
	    		    		    markup += "<td style='width:13%;text-align:center;'>";
	    		    			if (values[i][6]==="A") {
	    		    			    markup += "<button class='btn btn-sm' type='button' onclick=\"actionEditform('" + values[i][9] + "','" + pdcday + "','" + values[i][0] + "','" + values[i][11] + "','" + values[i][12] + "','" + values[i][13] + "','" + values[i][8] + "','" + values[i][14] + "')\"><i class='fa fa-pencil-square-o' aria-hidden='true' style='color:red;font-size: 18px;'></i></button>";
	    		    			} else {
	    		    				 markup += "--";
                                }
	    		    			markup += "</td></tr>";
	    		    		}
	    		    		
    		    		}
    		    		
    		    		$("#myTabl tbody").html(markup); 
    		    		$("#myTabl").DataTable({
    		    			"lengthMenu": [  5,10,25, 50, 75, 100 ],
    		    			"pagingType": "simple"
    		    		});
    		    	}
    		    });
    		    
    		  }); 
    	 

    }  
    
	$('#DateCompletion').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		/* "minDate" : new Date(), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	
</script>

<script>

 var genid="<%=GenId%>";
	$(document).ready(function(){
	$("#"+genid).click();

	});   

$(document).ready(function(){
	 AssigneeEmpList();
}); 	


function AssigneeEmpList(){
	
	$('#Assignee').val("");
	
	var $AssigneeLabCode = $('#AssigneeLabCode').val();
	var mainlabcode = "<%=labcode.toString()%>" ;
	
	let projectid = <%=committeescheduleeditdata[9]%> ;
	
	var div = document.getElementById("main");
	
	if(mainlabcode===$AssigneeLabCode){
		if(div!=null){
		div.style.display = "block";
		}
		}else{
		if(div!=null){
		div.style.display = "none";
		}
	}

	if($AssigneeLabCode!=""){
		
		$.ajax({
			
			type : "GET",
			url : "ActionAssigneeEmployeeList.htm",
			data : {
				LabCode : $AssigneeLabCode,
				proid    : projectid
			},
			datatype : 'json',
			success : function(result) {
				var result = JSON.parse(result);
				var values = Object.keys(result).map(function(e) {
					return result[e]
				});
				
				var s = '';
				s += '<option value="">Choose ...</option>';
				if($AssigneeLabCode == '@EXP'){
					
				}
				for (i = 0; i < values.length; i++) 
				{
					
					s += '<option value="'+values[i][0]+'">'+values[i][1] + ',' +' '+values[i][3] + '</option>';
				} 
				
				$('#Assignee').html(s);

			}
		});
	}
	
	
	
}  
function showEmployee(){
	   var value=$('#multipleAssignee').val();
	  $.ajax({
		  type:'GET',
		  url:'getEmployees.htm',
		  datatype:'json',
		  data:{
			  flag:value,
		  },
		  success:function(result){
			  var ajaxresult=JSON.parse(result);
			  console.log(ajaxresult);
			  if(value==="P"){
				  $('#modalHeader').text(" PROJECT DIRECTORS");
				  $('#employeeModal').modal('show');
				  var html="";
				  for(var i=0;i<ajaxresult.length;i++){
					 html=html+"<tr><td style='text-align:center'>"+(i+1)+"</td><td>"+ajaxresult[i][1]+"</td></tr>"; 
				  }
				  $('#modalTable').html(html);
			  }
 			if(value==="D"){
 				$('#modalHeader').text(" DIVISION HEADS"); 
 				$('#employeeModal').modal('show');
 				  var html="";
				  for(var i=0;i<ajaxresult.length;i++){
					 html=html+"<tr><td style='text-align:center'>"+(i+1)+"</td><td>"+ajaxresult[i][1]+"</td></tr>"; 
				  }
				  $('#modalTable').html(html);
			  }
 			 if(value==="T"){
 				$('#modalHeader').text(" TECHNICAL DIRECTORS");
 				$('#employeeModal').modal('show');
 				  var html="";
				  for(var i=0;i<ajaxresult.length;i++){
					 html=html+"<tr><td style='text-align:center'>"+(i+1)+"</td><td>"+ajaxresult[i][1]+"</td></tr>"; 
				  }
				  $('#modalTable').html(html);
			  }
 			 if(value==="G"){
 				$('#modalHeader').text(" GROUP HEADS");
 				$('#employeeModal').modal('show');
 				  var html="";
				  for(var i=0;i<ajaxresult.length;i++){
					 html=html+"<tr><td style='text-align:center'>"+(i+1)+"</td><td>"+ajaxresult[i][1]+"</td></tr>"; 
				  }
				  $('#modalTable').html(html);
			  }
		  }
	  })
   }
   
   function removeAttri(){
	    var selectElement = document.getElementById("multipleAssignee");
	    selectElement.removeAttribute("required");
	    var selectElements = document.getElementById("Assignee");
	    /* console.log(selectElements.value); */
	    if(selectElements.value.length==0){
	    	selectElement.setAttribute('required', 'required');
	    }
   }
 function showModal(a){
	 var value= document.getElementById("Data"+a).value;
	 console.log(a);
	 $('#actionModal').modal('show');
	 document.getElementById('modalbody').innerHTML=value;
 }
 
 function actionEditform(actionno,pdc,mainid,assigneeId,actionAssignId,scheduleId,assigneeLab,projectid){
	 
		$('#exampleModalAction').modal('show');   
		$('#exampleModalAction .modal-title').html('<span style="color: #C2185B;">Action No : '+ actionno);
	    $('#PDCDate').val(pdc);
	    $('#ActionMainId').val(mainid);
	    $('#ActionAssignId').val(actionAssignId);
	    $('#CommitteeScheduleId').val(scheduleId);
	    
	    var specNameAdd= $('#specnameadd').val();
	    $('#specValue').val(specNameAdd);
	    
	    //all lab list
	    $('#AssigneeLabName').empty();
	    <%for(Object[] obj2:Alllablist){%>
        var optionValue = '<%=obj2[3]%>';
	    var optionText = '<%=obj2[3]%>';
        var option = $("<option></option>").attr("value", optionValue).text(optionText);
        if (assigneeLab == optionValue) {
            option.prop('selected', true);
        }
      $('#AssigneeLabName').append(option);
      <% }%>
      
      var expertOptionValue = "@EXP";
      var expertOptionText = "Expert";
      var expertOption = $("<option></option>").attr("value", expertOptionValue).text(expertOptionText);
      if (assigneeLab == 'Expert') {
          expertOption.prop('selected', true);
      }
      $('#AssigneeLabName').append(expertOption);
      
      //pdc date 
      $('#PDCDate').daterangepicker({
  		"singleDatePicker" : true,
  		"linkedCalendars" : false,
  		"showCustomRangeLabel" : true,
  		/* "minDate" : new Date(), */
  		"startDate":pdc, 
  		"cancelClass" : "btn-default",
  		showDropdowns : true,
  		locale : {
  			format : 'DD-MM-YYYY'
  		}
  	});
      
      //exsiting employee name to be selected
      $.ajax({
          type: "GET",
          url: "ActionAssigneeEmployeeList.htm",
          data: {
          	LabCode: assigneeLab,  
              proid: projectid
          },
          dataType: 'json',
          success: function(result) {
          	 var values = Object.values(result);
               var options = '';
               for (var i = 0; i < values.length; i++) {
                   var optionValue = values[i][0];
                   var optionText = values[i][1] + ', ' + values[i][3];
                   var isSelected = (assigneeId == optionValue) ? 'selected' : '';
                   options += '<option value="' + optionValue + '" ' + isSelected + '>' + optionText + '</option>';
               }

               $('#AssigneeUpdate').html(options);
               
           },
          error: function(xhr, status, error) {
              console.error("Error:", error);
          }
      });
 }    
 
 // labcode change then their lab employyee will show
 function labChange(){
	 var labCode=$('#AssigneeLabName').val();
	 var projectid=0;
	 $('#AssigneeUpdate').empty();

     $.ajax({
         type: "GET",
         url: "ActionAssigneeEmployeeList.htm",
         data: {
         	LabCode: labCode,  
             proid: projectid
         },
         dataType: 'json',
         success: function(result) {
         	 var values = Object.values(result);
              var options = '';
              for (var i = 0; i < values.length; i++) {
                  var optionValue = values[i][0];
                  var optionText = values[i][1] + ', ' + values[i][3];
                  options += '<option value="' + optionValue + '">' + optionText + '</option>';
              }

              $('#AssigneeUpdate').html(options);
              
          },
         error: function(xhr, status, error) {
             console.error("Error:", error);
         }
     });
 }
	</script>
</body>
</html>


