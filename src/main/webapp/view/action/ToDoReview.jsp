	<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@page import="java.util.List , java.util.stream.Collectors,com.vts.pfms.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Insert title here</title>
<style type="text/css">
	.table thead th {
		color: white;
		background-color:#1249a1; 
		text-align:center;
		padding-bottom: 0.1rem !important;
	    padding-top: 0.1rem !important;
	}
	.table tbody td {
	    padding-bottom: 0.1rem !important;
	    padding-top: 0.1rem !important;
	}

	/* counter css */
	.counter{
    color: #628900;
    background: linear-gradient(to bottom, #628900 49%, transparent 50%);
    font-family: 'Poppins', sans-serif;
    text-align: center;
    padding: 19px 20px 18px;
    margin: 0 auto;
    border: 8px solid #628900;
    border-radius: 100% 100%;
    box-shadow: inset 0 8px 10px rgba(0, 0, 0, 0.3);
	}
	.counter .counter-value{
	    color: #fff;
	    font-size: 20px; 
	    font-weight: 700;
	    display: flex;
	}
	.counter.blue{
	    color: #36AE7C;
	    background: linear-gradient(to top, #045e39 -12%, transparent 173%);
	    border-color: #36AE7C;
	    margin: 10px 0px;
	}
	.counter.purple{
	    color: #6E3274;
	    background: linear-gradient(to top, #510b58 -12%, transparent 173%);
	    border-color: #6E3274;
	    margin: 10px 0px;
	}
	@media screen and (max-width:990px) {
	    .counter{ margin-bottom: 40px; }
	}

	@media screen and (min-width: 1151px) and (max-width : 1500px){
		.counter {
			width : 70px;
			height: 70px;
		}
	}
	
	@media screen and (min-width: 1501px) {
		.counter {
			width : 84px;
			height: 100px;
			padding: 49px 19px 19px;
		}
		.counter .counter-value {
		    font-size: 30px;
		    margin: -27px 0 21px;
		}
	}

	@media screen and (max-width : 1150px){
		.counter h3{
			font-size: 11px
		}
		.counter {
			width : 84px;
			height: 100px;
		}
		.counter .counter-value{
			font-size: 17px;
			 margin: 0 0 18px;
		}
	}

	.purple{
	color: #6E3274;
	}
	.blue{
	color: #36AE7C;
	}

	.modal-xl{
		max-width: 1100px;
	}
	


</style>
</head>
<body>
<%
List<Object[]> actionassigneelist = (List<Object[]>)request.getAttribute("actionassigneelist"); 
List<Object[]> actionassignorlist = (List<Object[]>)request.getAttribute("actionassignorlist"); 
List<Object[]> ProjectList = (List<Object[]>)request.getAttribute("ProjectList");
List<Object[]> favouritelist = (List<Object[]>)request.getAttribute("FavouriteList");
String empid = ((Long) session.getAttribute("EmpId")).toString();
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
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
	<div class="card shadow-nohover">
	<div class="card-header" style="height: 30px;"> <h5 style="margin-top: -8px;"> To-Do Review</h5> </div>
		<div class="card-body">
			<div class="row">
				<div class="col-md-6">
					<div class="card shadow-nohover">
						<div class="row">
							<div class="col-md-4"> 
								 <div class="card-body">
								      <h6 class="card-title" align="center" onclick="ModelForList('Today')" style="cursor: pointer;"><img src="view/images/action1.png" /> Today</h6>
								      <hr>
								      <div class="row">
								      	<div class="col-md-6 ">
								      		 <div class="counter blue" style="cursor: pointer;" onclick="ModelForList('Today')">
								      		  <%int todaytodo=0; for(Object[] obj: actionassigneelist){
												Date date1=sdf.parse(sdf.format(obj[4]));
												Date date2=sdf.parse(sdf.format(new Date()));
												if(date1.compareTo(date2) == 0){%> <% ++todaytodo;}}%>
					                				<span class="counter-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center" > <%=todaytodo%></span>
								           
								            </div>
									        <hr style="margin: 5px !important">
									       <h6 style="margin-left: -14px;"><span class="blue">&#x220E;</span> To Do</h6>
								      	</div>
								      	<div class="col-md-6">
								      		 <div class="counter purple" style="cursor: pointer;" onclick="ModelForList('Today')">
								      		 <%int todayreview=0; for(Object[] obj: actionassignorlist){
								      			if(!obj[11].toString().equalsIgnoreCase(empid)){
												Date date1=sdf.parse(sdf.format(obj[4]));
												Date date2=sdf.parse(sdf.format(new Date()));
												if(date1.compareTo(date2) == 0){%><% ++todayreview;}}}%>
					                				<span class="counter-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center"  ><%=todayreview%> </span>
								            </div>
									        <hr style="margin: 5px !important">
									        <h6 style="margin-left: -30px;"><span class="purple">&#x220E;</span> To Review</h6>
								      	</div>
								      </div>
								    </div>
							</div>
								<div class="col-md-4"> 
									 <div class="card-body">
								      <h6 class="card-title" align="center" onclick="ModelForList('Upcoming')" style="cursor: pointer;"><img src="view/images/upcoming.png" style="width: 22px;"/> Upcoming</h6>
								      <hr>
								      <div class="row">
								      	<div class="col-md-6 ">
								      		 <div class="counter blue" style="cursor: pointer;" onclick="ModelForList('Upcoming')">
								      		 <%int todayupcoming=0; for(Object[] obj: actionassigneelist){
												Date date1=sdf.parse(sdf.format(obj[4]));
												Date date2=sdf.parse(sdf.format(new Date()));
												if(date1.compareTo(date2) > 0){%><% ++todayupcoming;}}%>
					                				<span class="counter-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center"  ><%=todayupcoming %></span>
								            </div>
									        <hr style="margin: 5px !important">
									       <h6 style="margin-left: -14px;"> <span class="blue">&#x220E;</span> To Do</h6>
								      	</div>
								      	<div class="col-md-6">
								      		 <div class="counter purple" style="cursor: pointer;" onclick="ModelForList('Upcoming')">
					                				 <%int upcomingreview=0; for(Object[] obj: actionassignorlist){
					                					 if(!obj[11].toString().equalsIgnoreCase(empid)){
														Date date1=sdf.parse(sdf.format(obj[4]));
														Date date2=sdf.parse(sdf.format(new Date()));
														if(date1.compareTo(date2) > 0){%><% ++upcomingreview;}}}%>
					                				<span class="counter-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center"   ><%=upcomingreview%> </span>
								            </div>
									       
									        <hr style="margin: 5px !important">
									        <h6 style="margin-left: -30px;"><span class="purple">&#x220E;</span> To Review</h6>
								      	</div>
								      </div>
								    </div>
							</div>
							<div class="col-md-4"> 
								 <div class="card-body">
								      <h6 class="card-title" align="center" onclick="ModelForList('Missed')" style="cursor: pointer;"><img src="view/images/missed.png" style="width: 22px; background-color: fff;" /> Missed</h6>
								      <hr>
								      <div class="row">
								      	<div class="col-md-6" style="cursor: pointer;" onclick="ModelForList('Missed')">
								      	<%int missedtodo=0; for(Object[] obj: actionassigneelist){
											Date date1=sdf.parse(sdf.format(obj[4]));
											Date date2=sdf.parse(sdf.format(new Date()));
											if(date1.compareTo(date2) < 0){%><%++missedtodo;}}%>
								      		 <div class="counter blue" >
					                				<span class="counter-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center"  ><%=missedtodo%></span>
								            </div>
									        <hr style="margin: 5px !important">
									       	 <h6 style="margin-left: -14px;"> <span class="blue">&#x220E;</span> To Do</h6>
								      	</div>
								      	<div class="col-md-6">
								      		 <div class="counter purple" style="cursor: pointer;" onclick="ModelForList('Missed')" >
					                		<%int missedreview=0; for(Object[] obj: actionassignorlist){
					                			if(!obj[11].toString().equalsIgnoreCase(empid)){
												Date date1=sdf.parse(sdf.format(obj[4]));
												Date date2=sdf.parse(sdf.format(new Date()));
												if(date1.compareTo(date2) < 0){%><% ++missedreview;}}}%>
					                				<span class="counter-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center"  ><%=missedreview%> </span>
								            </div>
									        <hr style="margin: 5px !important">
									        <h6 style="margin-left: -30px;"><span class="purple">&#x220E;</span> To Review</h6>
								      	</div>
								      </div>
								  </div>
							</div>
						</div>
					</div>
			<hr style="margin: 4px 30px !important; ">
				<div >
					<div class="card shadow-nohover">
						<div class="card-body">
							
							<table class="table meeting" style="margin-top: -16px;">
										<thead style="height: 0px;">
											<tr>
												<th style="font-weight: 100;">SN</th> 
												<th style="font-weight: 100;">Action No</th>
												<th style="font-weight: 100;">Act with</th> 
												<th style="font-weight: 100;">PDC</th>
												<th style="font-weight: 100;">Prog</th>
												
											</tr>
										</thead>
										<!----------------------- start Today Action List  --------------------------->
							<%int l1=0; 
							if(actionassigneelist!=null && actionassigneelist.size()>0){%>
							<tbody id="modal_Today_Action" style="display: none;">
								
							<%for(Object[] obj: actionassigneelist){
								String[] input = obj[9].toString().split("/");
								String ActionNo = input[input.length-2]+"/"+input[input.length-1];
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) == 0){++l1;%>
								<tr>                            
									<td style="text-align: center;"> 
									<form name="myForm1" id="myForm1" action="ActionSubLaunch.htm" method="POST" style="display: inline">

																	<button class="btn btn-sm " name="sub" style="background-color: white;" title="To Do"><i class="fa fa-hand-o-right" aria-hidden="true" style="color: green;font-size: 1.3rem !important"></i></button>
												                    <input type="hidden" name="Assigner" value="<%=obj[12]%>,<%=obj[2]%>"/>	
																	<input type="hidden" name="ActionMainId" value="<%=obj[0]%>"/>
																	<input type="hidden" name="ActionNo" value="<%=obj[9]%>"/>
																	<input type="hidden" name="ActionAssignid" value="<%=obj[10]%>"/>
																	<input type="hidden" name="back" value="backTotodo"/>
 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>
									</td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#009bf1; font-weight: 600;"
									 onclick="ActionDetails('<%=obj[10] %>',   <!-- assignid -->
			                          									'<%=obj[5].toString().trim() %>',   <!-- action item -->
			                          									'<%=obj[9] %>',   <!-- action No -->
			                          									'<%if(obj[14]!=null){ %> <%=obj[14] %>% <%}else{ %>0<%} %>', <!-- progress -->
			                          									'<%=sdf.format(obj[3]) %>', <!-- action date -->
			                          									'<%=sdf.format(obj[4]) %>', <!-- enddate -->
			                          									'<%=sdf.format(obj[15]) %>', <!-- orgpdc -->
			                          									'<%=obj[1].toString().trim()%>', <!-- assignor -->
			                          									'<%=obj[16].toString().trim()%>', <!-- assignee -->
			                          									'<%=obj[17]%>' <!-- action type -->
			                          									);" 
									 >  &nbsp;<%=ActionNo!=null?StringEscapeUtils.escapeHtml4(ActionNo):" - " %></button>
									</td>
									<td style="text-align: left;font-size: 13px;font-weight: 600;"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):" - "%></td>
									<td style="text-align: center;font-size: 13px;font-weight: 600; width: 80px;"><%= obj[4]!=null?sdf.format(obj[4]):" - "%></td>
									<td style="width: 100px;">
									<%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=StringEscapeUtils.escapeHtml4(obj[4].toString())%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												N S
										</div>
										</div> <%}%>
									
									</td> 
									
								</tr>
							<%}}%></tbody><%}%>
						<!----------------------- close Today Action List  --------------------------->	
							
							<!----------------------- start Upcoming Action List  --------------------------->
							<%int m1=0; 
							if(actionassigneelist!=null && actionassigneelist.size()>0){%>
							<tbody id="modal_Upcoming_Action" style="display: none;">
								
							<%for(Object[] obj: actionassigneelist){
								String[] input = obj[9].toString().split("/");
								String ActionNo = input[input.length-2]+"/"+input[input.length-1];
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) > 0){ ++m1;%>
								<tr>
									
									<td style="text-align: center;"> 
									<form name="myForm1" id="myForm1" action="ActionSubLaunch.htm" method="POST" style="display: inline">

																	<button class="btn btn-sm " name="sub" style="background-color: white;" title="To Do"><i class="fa fa-hand-o-right" aria-hidden="true" style="color: green;font-size: 1.3rem !important"></i></button>
												                    <input type="hidden" name="Assigner" value="<%=obj[12]%>,<%=obj[2]%>"/>	
																	<input type="hidden" name="ActionMainId" value="<%=obj[0]%>"/>
																	<input type="hidden" name="ActionNo" value="<%=obj[9]%>"/>
																	<input type="hidden" name="ActionAssignid" value="<%=obj[10]%>"/>
																	<input type="hidden" name="back" value="backTotodo"/>
 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>
									</td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#dd2fd8; font-weight: 600;"
									 onclick="ActionDetails(			'<%=obj[10] %>',   <!-- assignid -->
			                          									'<%=obj[5].toString().trim() %>',   <!-- action item -->
			                          									'<%=obj[9] %>',   <!-- action No -->
			                          									'<%if(obj[14]!=null){ %> <%=obj[14] %>% <%}else{ %>0<%} %>', <!-- progress -->
			                          									'<%=sdf.format(obj[3]) %>', <!-- action date -->
			                          									'<%=sdf.format(obj[4]) %>', <!-- enddate -->
			                          									'<%=sdf.format(obj[15]) %>', <!-- orgpdc -->
			                          									'<%=obj[1].toString().trim()%>', <!-- assignor -->
			                          									'<%=obj[16].toString().trim()%>', <!-- assignee -->
			                          									'<%=obj[17]%>' <!-- action type -->
			                          									);" 
									 >  &nbsp;<%=ActionNo!=null?StringEscapeUtils.escapeHtml4(ActionNo):" - "%></button>
									</td>
									<td style="text-align: left;font-size: 13px;font-weight: 600;"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):" - "%></td>
									<td style="text-align: center;font-size: 13px;font-weight: 600;width: 80px;"><%=obj[4]!=null?sdf.format(obj[4]):" - "%></td>
									<td style="width: 100px;">
									<%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=StringEscapeUtils.escapeHtml4(obj[14].toString()) %>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												N S
										</div>
										</div> <%}%>
									
									</td> 
								</tr>
						<%}}%></tbody><%}%>
							<!----------------------- Close Upcoming Action List  --------------------------->
							
							<!----------------------- start Missed Action List  --------------------------->
							<%int n1=0;if(actionassigneelist!=null && actionassigneelist.size()>0){%>
							<tbody id="modal_Missed_Action" style="display: none;">
							<%for(Object[] obj: actionassigneelist){
								String[] input = obj[9].toString().split("/");
								String ActionNo = input[input.length-2]+"/"+input[input.length-1];
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) < 0){++n1;%>
								<tr>
									
									<td style="text-align: center;"> 
									<form name="myForm1" id="myForm1" action="ActionSubLaunch.htm" method="POST" style="display: inline">

																	<button class="btn btn-sm " name="sub"  title="To Do" style="background-color: white;"><i class="fa fa-hand-o-right" aria-hidden="true" style="color: green;font-size: 1.3rem !important"></i></button>
												                    <input type="hidden" name="Assigner" value="<%=obj[12]%>,<%=obj[2]%>"/>	
																	<input type="hidden" name="ActionMainId" value="<%=obj[0]%>"/>
																	<input type="hidden" name="ActionNo" value="<%=obj[9]%>"/>
																	<input type="hidden" name="ActionAssignid" value="<%=obj[10]%>"/>
																	<input type="hidden" name="back" value="backTotodo"/>
 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>
									</td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#f1931f; font-weight: 600;"
									 onclick="ActionDetails(	'<%=obj[10] %>',   <!-- assignid -->
			                          									'<%=obj[5].toString().trim() %>',   <!-- action item -->
			                          									'<%=obj[9] %>',   <!-- action No -->
			                          									'<%if(obj[14]!=null){ %> <%=obj[14] %>% <%}else{ %>0<%} %>', <!-- progress -->
			                          									'<%=sdf.format(obj[3]) %>', <!-- action date -->
			                          									'<%=sdf.format(obj[4]) %>', <!-- enddate -->
			                          									'<%=sdf.format(obj[15]) %>', <!-- orgpdc -->
			                          									'<%=obj[1].toString().trim()%>', <!-- assignor -->
			                          									'<%=obj[16].toString().trim()%>', <!-- assignee -->
			                          									'<%=obj[17]%>' <!-- action type -->
			                          									);" 
									 >  &nbsp;<%=ActionNo!=null?StringEscapeUtils.escapeHtml4(ActionNo):" - "%></button>
									</td>
									<td style="text-align: left;font-size: 13px;font-weight: 600;"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):" - "%></td>
									<td style="text-align: center;font-size: 13px;font-weight: 600;width: 80px;"><%=obj[4]!=null?sdf.format(obj[4]):" - " %></td>
									<td style="width: 100px;">
									<%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=StringEscapeUtils.escapeHtml4(obj[14].toString())%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												N S
										</div>
										</div> <%}%>
									
									</td> 
									
								</tr>
							<%}}%></tbody><%}%>
							<!----------------------- start Missed Action List  --------------------------->
										
						<!----------------------- start Today Action List  --------------------------->
							<%int i1=0; 
							if(actionassignorlist!=null && actionassignorlist.size()>0){%>
								<tbody id="modal_Review_Today_Action" style="display: none;">
							<%for(Object[] obj: actionassignorlist){
								if(!obj[11].toString().equalsIgnoreCase(empid)){
								String[] input = obj[9].toString().split("/");
								String ActionNo = input[input.length-2]+"/"+input[input.length-1];
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) == 0){ ++i1;%>
								<tr> 
									
									<td style="text-align: center;">
										<form action="CloseAction.htm" method="POST" name="myfrm"  style="display: inline">
											<button  class="btn btn-sm editable-click" name="sub" style="background-color: white;" title="To Review"> <i class="fa fa-hand-o-right" aria-hidden="true" style="color: purple;font-size: 1.3rem !important"></i></button>                 
											<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
											<input type="hidden" name="ActionMainId" value="<%=obj[0]%>"/>
											<input type="hidden" name="ActionAssignId" value="<%=obj[10]%>"/>	
											<input type="hidden" name="back" value="backTotodo"/>          	
									</form> 
									</td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#009bf1; font-weight: 600;"
									 onclick="ActionDetails(	'<%=obj[10] %>',   <!-- assignid -->
			                          									'<%=obj[5].toString().trim() %>',   <!-- action item -->
			                          									'<%=obj[9] %>',   <!-- action No -->
			                          									'<%if(obj[14]!=null){ %> <%=obj[14] %>% <%}else{ %>0<%} %>', <!-- progress -->
			                          									'<%=sdf.format(obj[3]) %>', <!-- action date -->
			                          									'<%=sdf.format(obj[4]) %>', <!-- enddate -->
			                          									'<%=sdf.format(obj[15]) %>', <!-- orgpdc -->
			                          									'<%=obj[1].toString().trim()%>', <!-- assignor -->
			                          									'<%=obj[16].toString().trim()%>', <!-- assignee -->
			                          									'<%=obj[17]%>' <!-- action type -->
			                          									);" 
									 >  &nbsp;<%=ActionNo!=null?StringEscapeUtils.escapeHtml4(ActionNo):" - "%></button>
									</td>
									<td style="text-align: left;font-size: 13px;font-weight: 600;"><%=obj[16]!=null?StringEscapeUtils.escapeHtml4(obj[16].toString()):" - "%></td>
									<td style="text-align: center;font-size: 13px;font-weight: 600;width: 80px;"><%=obj[4]!=null?sdf.format(obj[4]):" - "%></td>
									<td style="width: 100px;">
									<%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=StringEscapeUtils.escapeHtml4(obj[14].toString())%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												N S
										</div>
										</div> <%}%>
									
									</td> 
									
								</tr>
							<%}}}%></tbody><%}%>
						<!----------------------- close Today Action List  --------------------------->	
							
							<!----------------------- start Upcoming Action List  --------------------------->
							<%int j1=0; 
							if(actionassignorlist!=null && actionassignorlist.size()>0){%>
								<tbody id="modal_Review_Upcoming_Action" style="display: none;">
							<%for(Object[] obj: actionassignorlist){
								if(!obj[11].toString().equalsIgnoreCase(empid)){
								String[] input = obj[9].toString().split("/");
								String ActionNo = input[input.length-2]+"/"+input[input.length-1];
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) > 0){++j1;%>
								<tr>
									
									<td style="text-align: center;">
										<form action="CloseAction.htm" method="POST" name="myfrm"  style="display: inline">
											<button  class="btn btn-sm editable-click" name="sub" style="background-color: white;" title="To Review"> <i class="fa fa-hand-o-right" aria-hidden="true" style="color: purple;font-size: 1.3rem !important"></i></button>                 
											<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
											<input type="hidden" name="ActionMainId" value="<%=obj[0]%>"/>
											<input type="hidden" name="ActionAssignId" value="<%=obj[10]%>"/>	
											<input type="hidden" name="back" value="backTotodo"/>          	
									</form> 
									</td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#dd2fd8; font-weight: 600;"
									 onclick="ActionDetails(	'<%=obj[10] %>',   <!-- assignid -->
			                          									'<%=obj[5].toString().trim() %>',   <!-- action item -->
			                          									'<%=obj[9] %>',   <!-- action No -->
			                          									'<%if(obj[14]!=null){ %> <%=obj[14] %>% <%}else{ %>0<%} %>', <!-- progress -->
			                          									'<%=sdf.format(obj[3]) %>', <!-- action date -->
			                          									'<%=sdf.format(obj[4]) %>', <!-- enddate -->
			                          									'<%=sdf.format(obj[15]) %>', <!-- orgpdc -->
			                          									'<%=obj[1].toString().trim()%>', <!-- assignor -->
			                          									'<%=obj[16].toString().trim()%>', <!-- assignee -->
			                          									'<%=obj[17]%>' <!-- action type -->
			                          									);" 
									 >  &nbsp;<%=ActionNo!=null?StringEscapeUtils.escapeHtml4(ActionNo):" - "%></button>
									</td>
									<td style="text-align: left;font-size: 13px;font-weight: 600;"><%=obj[16]!=null?StringEscapeUtils.escapeHtml4(obj[16].toString()):" - "%></td>
									<td style="text-align: center;font-size: 13px;font-weight: 600; width: 80px;"><%=obj[4]!=null?sdf.format(obj[4]):" - "%></td>
									<td style="width: 100px;">
									<%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=StringEscapeUtils.escapeHtml4(obj[14].toString())%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												N S
										</div>
										</div> <%}%>
									
									</td> 
								</tr>
							
							<%}}}%></tbody><%}%>
							<!----------------------- Close Upcoming Action List  --------------------------->
							
							<!----------------------- start Missed Action List  --------------------------->
							<%int k1=0; 
							if(actionassignorlist!=null && actionassignorlist.size()>0){%>
							<tbody id="modal_Review_Missed_Action" style="display: none;">	
							<%for(Object[] obj: actionassignorlist){
								if(!obj[11].toString().equalsIgnoreCase(empid)){
								String[] input = obj[9].toString().split("/");
								String ActionNo = input[input.length-2]+"/"+input[input.length-1];
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) < 0){ ++k1;%>
								<tr>
									
									<td style="text-align: center;">
										<form action="CloseAction.htm" method="POST" name="myfrm"  style="display: inline">
											<button  class="btn btn-sm editable-click" name="sub" style="background-color: white;" title="To Review"> <i class="fa fa-hand-o-right" aria-hidden="true" style="color: purple;font-size: 1.3rem !important"></i></button>                 
											<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
											<input type="hidden" name="ActionMainId" value="<%=obj[0]%>"/>
											<input type="hidden" name="ActionAssignId" value="<%=obj[10]%>"/>	
											<input type="hidden" name="back" value="backTotodo"/>          	
									</form> 
									</td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#f1931f; font-weight: 600;"
									 onclick="ActionDetails(	'<%=obj[10] %>',   <!-- assignid -->
			                          									'<%=obj[5].toString().trim() %>',   <!-- action item -->
			                          									'<%=obj[9] %>',   <!-- action No -->
			                          									'<%if(obj[14]!=null){ %> <%=obj[14] %>% <%}else{ %>0<%} %>', <!-- progress -->
			                          									'<%=sdf.format(obj[3]) %>', <!-- action date -->
			                          									'<%=sdf.format(obj[4]) %>', <!-- enddate -->
			                          									'<%=sdf.format(obj[15]) %>', <!-- orgpdc -->
			                          									'<%=obj[1].toString().trim()%>', <!-- assignor -->
			                          									'<%=obj[16].toString().trim()%>', <!-- assignee -->
			                          									'<%=obj[17]%>' <!-- action type -->
			                          									);" 
									 >  &nbsp;<%=ActionNo!=null?StringEscapeUtils.escapeHtml4(ActionNo):" - "%></button>
									</td>
									<td style="text-align: left;font-size: 13px;font-weight: 600;"><%=obj[16]!=null?StringEscapeUtils.escapeHtml4(obj[16].toString()):" - "%></td>
									<td style="text-align: center;font-size: 13px;font-weight: 600;width: 80px;"><%=obj[4]!=null?sdf.format(obj[4]):" - "%></td>
									<td style="width: 100px; "><%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=StringEscapeUtils.escapeHtml4(obj[14].toString())%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												N S
										</div>
										</div> <%}%>
									</td> 
								</tr>
							<%}}}%></tbody><%}%>
							<!----------------------- start Missed Action List  --------------------------->
							</table>
						   
					    </div>
					</div>
				</div> 
			</div>
				<div class="col-md-6" >
					<div class="card shadow-nohover">
						<div class="card-header" style="height: 42px;"><h5 style="margin-top: -5px;">Favourite List <button type="button" class="btn btn-success btn-sm add" style="float: right;margin-top: -4px;" onclick="Modelfavourite()">Add Favourite</button></h5></div>
						<div class="card-body">
								<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" >
							<thead>
								<tr>
									  <th>SN</th>
									  <th>Action No</th>
									  <th style="width: 48.7969px;">PDC</th>
									  <th>Assignee</th>
									  <th>Prog</th>
								</tr>
							</thead>
							<tbody>
							<% int sn=0;if(favouritelist!=null &&favouritelist.size()>0){
								for(Object[] obj :favouritelist) {
									String[] input = obj[6].toString().split("/");
									String ActionNo = input[input.length-2]+"/"+input[input.length-1];
								%>
								<tr>
									<td style="text-align: center;font-size: 14px;font-weight: 600;"><%=++sn%></td>
									<td class="editable-click" style="text-align: center;font-size: 14px;font-weight: 600;">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#424b50; font-weight: 600;"
									 onclick="ActionDetails(	'<%=obj[10] %>',   <!-- assignid -->
			                          									'<%=obj[5].toString().trim() %>',   <!-- action item -->
			                          									'<%=obj[6] %>',   <!-- action No -->
			                          									'<%if(obj[11]!=null){ %> <%=obj[11] %>% <%}else{ %>0<%} %>', <!-- progress -->
			                          									'<%=sdf.format(obj[3]) %>', <!-- action date -->
			                          									'<%=sdf.format(obj[4]) %>', <!-- enddate -->
			                          									'<%=sdf.format(obj[12]) %>', <!-- orgpdc -->
			                          									'<%=obj[1].toString().trim()%>', <!-- assignor -->
			                          									'<%=obj[13].toString().trim()%>', <!-- assignee -->
			                          									'<%=obj[14]%>' <!-- action type -->
			                          									);" 
									 >  &nbsp;<%=ActionNo!=null?StringEscapeUtils.escapeHtml4(ActionNo):" - "%></button>
									</td>
									<td style="text-align: center;font-size: 14px;font-weight: 600;"><%=obj[4]!=null?sdf.format(obj[4]):" - "%></td>
									<td style="text-align: left;font-size: 14px;font-weight: 600;"><%=obj[13]!=null?StringEscapeUtils.escapeHtml4(obj[13].toString()):" - "%></td>
									<td style="text-align: center;font-size: 14px;font-weight: 600;"><%if(obj[11]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[11]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=StringEscapeUtils.escapeHtml4(obj[11].toString())%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;width:75px; height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												N S
										</div>
										</div> <%}%></td>
								</tr>
								<%}}%>
							</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<!---------------------------------------------------------------- action modal ------------------------------------------------------->
	<div class=" modal bd-example-modal-lg" tabindex="-1" role="dialog" id="action_modal">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #FFE0AD; ">
					<div class="row w-100"  >
						<div class="col-md-12" >
							<h5 class="modal-title" id="modal_action_no" style="font-weight:700; color: #A30808;"></h5>
						</div>
					</div>
					 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" align="center">
					<form action="#" method="post" autocomplete="off" >
						<table >
							<tr>
								<th style="width:17%;padding: 5px;"> Action Item :</th>
								<td class="tabledata" style="width:90%;padding: 5px;word-wrap:break-word;" colspan="3" id="modal_action_item"></td>
							</tr>
							<tr>
								<th style="padding: 5px;" >Assign Date :</th>
								<td style="padding: 5px;" id="modal_action_date"></td>
								<th style="padding: 5px;" >PDC :</th>
								<td style="padding: 5px;" id="modal_action_PDC"></td>
							</tr>
							<tr>
								<th style="padding: 5px;" >Assignor :</th>
								<td style="padding: 5px;" class="tabledata" id="modal_action_assignor"></td>
								<th style="padding: 5px;" >Assignee :</th>
								<td style="padding: 5px;" class="tabledata" id="modal_action_assignee"></td>
							</tr>
							<tr>
								<th style="padding: 5px;" >Final Progress :</th>
								<td style="padding: 5px;" id="modal_action_progress"></td>
								<th style="padding: 5px;" > Type :</th>
								<td style="padding: 5px;font-weight: bold;color:#A30808 " id="modal_action_type"></td>
							</tr>
							
						</table>
						</form>
						<hr>
						<form action="#" method="get">
							<table class="table table-bordered table-hover table-striped table-condensed " id="" style="width: 100%">
								<thead> 
									<tr style="background-color: #055C9D; color: white;">
										<th style="text-align: center;width:5% !important;">SN</th>
										<th style="text-align: center;width:14% !important;"> Date</th>
										<th style="text-align: center;width:15% !important;"> Progress</th>
										<th style="width:65% !important;">Remarks</th>
										<th style="text-align: center;width:5% !important;">Download</th>
									</tr>
								</thead>
								<tbody id="modal_progress_table_body"></tbody>
							</table>
						</form>
				</div>
			</div>
		</div>
	</div>
<!---------------------------------------------------------------- action modal ----------------------------------------------------- -->

	<!---------------------------------------------------------------- Favorite modal ------------------------------------------------------->
	<div class=" modal bd-example-modal-lg" tabindex="-1" role="dialog" id="Favorite_modal">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #FFE0AD; height: 50px;">
					<div class="row w-100"  style="margin-top: -10px;">
					<div class="col-md-3"> <h4>Favourite List</h4></div>
						<div class="col-md-9" >
							<table>
					   				<tr>
					   					<td>
					   						<label class="control-label" style="font-size: 14px;font-weight:600;">Project : </label>
					   					</td>
					   					<td >
					   						<select class="form-control selectdee "  style="width: 113px;" name="Project"  id="Project" required="required"   data-live-search="true" id="projectid" >                                                     
												<option value="0" >General</option>	
												<%for(Object[] obj:ProjectList){%>
													<option value="<%=obj[0] %>" ><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - "%></option>	
												<%}%>
											</select>	
					   					</td>
					   					<td style="margin-left: 30px;">
					   						<label class="control-label" style="font-size: 14px;font-weight:600; margin-bottom: .0rem;"> From Date : </label>
					   					</td>
					   					<td style="max-width: 160px; padding-right: 50px">
					   						<input  class="form-control"  data-date-format="dd/mm/yyyy" id="fdate" name="fdate"  required="required"  value="">
					   					</td>
					   					<td>
					   						<label class="control-label" style="font-size: 14px;font-weight:600; margin-bottom: .0rem;"> To Date : </label>
					   					</td>
					   					<td style="width: 160px; padding-right: 50px">
					   						<input  class="form-control "  data-date-format="dd/mm/yyyy" id="tdate" name="tdate"  required="required"  value="">
					   					</td>
					   					<td>
					   						<button type="button"  onclick="GetActionList()" class="btn  btn-sm submit">Submit</button>
					   					</td>		
					   				</tr>   					   				
					   		</table>
					   		 
						</div>
					</div>
				</div>
				 <form action="AddFavouriteList.htm" method="POST" id="frm1">
				<div class="modal-body" align="center" style="max-height: 30rem; overflow-y:auto;">	
					
							<table class="table meeting"  >
									<thead style = "height: 0px;">
										<tr>
											<th style="text-align: center;font-size: 14px;font-weight: 100;">SN</th>
											<th style="text-align: center;font-size: 14px;font-weight: 100;width: 450px;">Action Item</th>
											<th style="text-align: center;font-size: 14px;font-weight: 100;">PDC</th>
											<th style="text-align: center;font-size: 14px;font-weight: 100;">Assignee</th>
											<th style="text-align: center;font-size: 14px;font-weight: 100;">Assigner</th>
											<th style="text-align: center;font-size: 14px;font-weight: 100;">Prog</th>
											<th style="text-align: center;font-size: 14px;font-weight: 100;">Action</th>
										</tr>
									</thead>
									<tbody id="favourite_list" style="max-height: 25rem; overflow-y:auto;"> 
										<tr>
										    <td colspan="7" style="text-align: center;font-size: 14px;font-weight: 600; ">data not available!</td>
										</tr>	
									</tbody>
							</table>
							<hr> 
				</div>
				<div class="model-footer" style="height: 50px;">
						<div align="center">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<button type="button" id="favId" style="display: none; " class="btn btn-primary btn-sm submit" onclick="AddFavourite()"> SUBMIT</button>
						</div>	
				</div>
				</form>	
			</div>
		</div>
	</div>
<!---------------------------------------------------------------- Favorite modal ----------------------------------------------------- -->

<script type="text/javascript">

function ActionDetails(InAssignId,InActionItem,InActionNo,InProgress,InActionDate,InEndDate,InPDCOrg, InAssignor,InAssignee, InActionType )
{
		$("#modal_progress_table").DataTable().destroy();
		$.ajax({		
			type : "GET",
			url : "ActionSubListAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success : function(result) {
				var result = JSON.parse(result);
				
				$('#modal_action_no').html(InActionNo);
				$('#modal_action_item').html(InActionItem);
				$('#modal_action_date').html(InActionDate);
				$('#modal_action_PDC').html(InEndDate);
				$('#modal_action_assignor').html(InAssignor);
				$('#modal_action_assignee').html(InAssignee);
				
				var ActionType = 'Action';
				
				if(InActionType==='A')
				{
					ActionType = 'Action';
				}
				else if(InActionType==='I')
				{
					ActionType = 'Issue';
				}
				else if(InActionType==='D')
				{
					ActionType = 'Decision';
				}
				else if(InActionType==='R')
				{
					ActionType = 'Recommendation';
				}
				else if(InActionType==='C')
				{
					ActionType = 'Comment';
				}
				else if(InActionType==='K')
				{
					ActionType = 'Risk';
				}
				
				$('#modal_action_type').html(ActionType);
				
				if(InProgress.trim() === '0')
				{
					var progressBar ='<div class="progress" style="background-color:#cdd0cb !important;height: 1.5rem !important;">'; 
					progressBar += 		'<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >';
					progressBar +=		'Not Started'
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				else
				{
					var progressBar ='<div class="progress" style="background-color:#cdd0cb !important;height:1.5rem !important; ">'; 
					progressBar += 		'<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: '+InProgress+';  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >';
					progressBar +=		InProgress
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				$('#modal_action_progress').html(progressBar);
				
				var htmlStr='';
				if(result.length> 0){
					for(var v=0;v<result.length;v++)
					{	
						htmlStr += '<tr>';
						
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ (v+1) + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ moment(new Date(result[v][3]) ).format('DD-MM-YYYY') + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ result[v][2] + ' %</td>';
						htmlStr += '<td class="tabledata" >'+ result[v][4] + '</td>';
						
						if(result[v][5]=== null)
						{
							htmlStr += '<td class="tabledata" style="text-align: center;">-</td>';
						}
						else
						{
							htmlStr += '<td class="tabledata" style="text-align: center;"><button type="submit" class="btn btn-sm" name="ActionSubId" value="'+ result[v][5] + '" target="blank" formaction="ActionDataAttachDownload.htm" ><i class="fa fa-download"></i></button></td>';
						}
						htmlStr += '</tr>';
					}
				}
				else
				{
					htmlStr += '<tr>';
					
					htmlStr += '<td colspan="5" style="text-align: center;"> Progress Not Updated </td>';
					
					htmlStr += '</tr>';
				}
				setModalDataTable();
				$('#modal_progress_table_body').html(htmlStr);
				$('#action_modal').modal('toggle');
			}
		});
	}
	setModalDataTable();
	function setModalDataTable()
	{
		$("#modal_progress_table").DataTable({
			"lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			"pagingType": "simple",
			"pageLength": 5
		});
	}
	ModelForList("Today");
	function ModelForList(value) {
		console.log(value);
		document.getElementById("modal_Review_Today_Action").style.display = 'none';
		document.getElementById("modal_Today_Action").style.display = 'none';
		document.getElementById("modal_Review_Upcoming_Action").style.display = 'none';
		document.getElementById("modal_Upcoming_Action").style.display = 'none';
		document.getElementById("modal_Review_Missed_Action").style.display = 'none';
		document.getElementById("modal_Missed_Action").style.display = 'none';
		
		 if(value=='Today'){
			document.getElementById("modal_Review_Today_Action").style.display = '';
			document.getElementById("modal_Today_Action").style.display = '';
			var val = <%=i1+l1%>;
			console.log(<%=i1%> +": jk :"+<%=l1%>);
			if(val==0){
				$("#modal_Review_Today_Action").html('<tr><td colspan="6" style="text-align: center;padding: 0.1rem !important;"> <b>No Record Found</b> </td></tr>');
			}
		}else if(value=='Upcoming'){
			document.getElementById("modal_Review_Upcoming_Action").style.display = '';
			document.getElementById("modal_Upcoming_Action").style.display = '';
			var val1 = <%=j1+m1%>;
			if(val1==0){
				$("#modal_Review_Upcoming_Action").html('<tr><td colspan="6" style="text-align: center;padding: 0.1rem !important;"> <b>No Record Found</b> </td></tr>');
			}
		}else if(value=='Missed'){
			document.getElementById("modal_Review_Missed_Action").style.display = '';
			document.getElementById("modal_Missed_Action").style.display = '';
			var val2 = <%=k1+n1%>;
			if(val2==0){
				$("#modal_Review_Missed_Action").html('<tr><td colspan="6" style="text-align: center;padding: 0.1rem !important;"> <b>No Record Found</b> </td></tr>');
			}
		}
	}

	$('#fdate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"cancelClass" : "btn-default",
		"startDate": moment().subtract(30, 'days'),
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

	function Modelfavourite()
	{
		GetActionList();
		$('#Favorite_modal').modal('toggle');
	}
	
	function GetActionList() {
		
		var Infromdate= $("#fdate").val();
		var Intodate= $("#tdate").val();
		var Inprojectid= $("#Project").val();
		
		$.ajax({		
			type : "GET",
			url : "GetActionListForFavourite.htm",
			data : {
				Fromdate : Infromdate,
				Todate:Intodate,
				Projectid:Inprojectid
			},
			datatype : 'json',
			success : function(results) {
				var result = JSON.parse(results);
				var htmlStr='';
				if(result!=null && result.length>0){
					document.getElementById("favId").style.display = '';
					for(var v=0;v<result.length;v++)
					{	
						htmlStr += '<tr>';
							htmlStr += '<td class="tabledata" style="text-align: center;font-size: 14px;font-weight: 600;" >'+ (v+1) + '</td>';
							htmlStr += '<td class="tabledata" style="text-left: center;font-size: 15px;font-weight: 600;" >'+ result[v][5] + ' </td>';
							htmlStr += '<td class="tabledata" style="text-align: center;font-size: 14px;font-weight: 600;" >'+ moment(new Date(result[v][4]) ).format('DD-MM-YYYY') + '</td>';
							htmlStr += '<td class="tabledata" style="text-align: left;font-size: 14px;font-weight: 600;">'+ result[v][16] + '</td>';
							htmlStr += '<td class="tabledata" style="text-align: left;font-size: 14px;font-weight: 600;">'+ result[v][1] +'</td>';
							htmlStr += '<td class="tabledata" style="text-align: center;font-size: 14px;font-weight: 600;">';
							if(result[v][14]!=null){
								htmlStr += '<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">';
								htmlStr += '<div class="progress-bar progress-bar-striped" role="progressbar" style=" width:' + result[v][14] +'%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >'+result[v][14] +'</div> </div>'; 
							}else{
								htmlStr += '<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">';
								htmlStr += '<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;">N S</div></div> ';
							}
							htmlStr += '</td>';
							htmlStr += '<td align="center"><input type="checkbox" class="form-group1" name="favourite"  value="'+result[v][10]+'"></td>';
						htmlStr += '</tr>';
					}
				}else{
					htmlStr += '<tr> <td colspan="7" style="text-align: center;font-size: 18px;font-weight: 600;color: #1e73cf;">No Record Found !</td></tr>';	
				}
				$('#favourite_list').html(htmlStr);
			}
		});
	}
	
	function AddFavourite(myfrm){
		var fields = $("input[name='favourite']").serializeArray();

		if (fields.length === 0){
			alert("Please Select A Record");
			 event.preventDefault();	
			return false;
		}else{
			if(confirm("Are you sure to Submit?")){
				document.getElementById("frm1").submit();
			}	
		}
	}
	
	 $(document).ready(function(){
	 	  $("#myTable").DataTable({
	 	 "lengthMenu": [10,25, 50, 75, 100 ],
	 	 "pagingType": "simple",
	 	 "pageLength": 10
	 });
	 });	
</script>
</body>
</html>