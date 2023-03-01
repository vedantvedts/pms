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
	    margin: -7px 0px;
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
			width : 180px;
			height: 180px;
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
			width : 135px;
			height: 135px;
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
</style>
</head>
<body>
<%
List<Object[]> actionassigneelist = (List<Object[]>)request.getAttribute("actionassigneelist"); 
List<Object[]> actionassignorlist = (List<Object[]>)request.getAttribute("actionassignorlist"); 
String empid = ((Long) session.getAttribute("EmpId")).toString();
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
%>

<div class="container-fluid">
			<div class="row">
				<div class="col-md-6">
					<div class="card shadow-nohover">
						<div class="row">
							<div class="col-md-4"> 
								 <div class="card-body">
								      <h6 class="card-title" align="center"><img src="view/images/action1.png" /> Today</h6>
								      <hr>
								      <div class="row">
								      	<div class="col-md-6 ">
								      		 <div class="counter blue" style="cursor: pointer;" onclick="ModelForList('Today')">
								      		  <%int todaytodo=0; for(Object[] obj: actionassigneelist){
												Date date1=sdf.parse(sdf.format(obj[4]));
												Date date2=sdf.parse(sdf.format(new Date()));
												if(date1.compareTo(date2) == 0){%> <% ++todaytodo;}}%>
					                				<span class="counter-value" style="text-align: center; " > <%=todaytodo%></span>
								           
								            </div>
									        <hr style="margin: 5px !important">
									       <h6><span class="blue">&#x220E;</span> To Do</h6>
								      	</div>
								      	<div class="col-md-6">
								      		 <div class="counter purple" style="cursor: pointer;" onclick="ModelForList('Today')">
								      		 <%int todayreview=0; for(Object[] obj: actionassignorlist){
												Date date1=sdf.parse(sdf.format(obj[4]));
												Date date2=sdf.parse(sdf.format(new Date()));
												if(date1.compareTo(date2) == 0){%><% ++todayreview;}}%>
					                				<span class="counter-value"  ><%=todayreview%> </span>
								            </div>
									        <hr style="margin: 5px !important">
									        <h6 style="margin-left: -28px;"><span class="purple">&#x220E;</span> To Review</h6>
								      	</div>
								      </div>
								    </div>
							</div>
								<div class="col-md-4"> 
									 <div class="card-body">
								      <h6 class="card-title" align="center"><img src="view/images/upcoming.png" style="width: 22px;"/> Upcoming</h6>
								      <hr>
								      <div class="row">
								      	<div class="col-md-6 ">
								      		 <div class="counter blue" style="cursor: pointer;" onclick="ModelForList('Upcoming')">
								      		 <%int todayupcoming=0; for(Object[] obj: actionassigneelist){
												Date date1=sdf.parse(sdf.format(obj[4]));
												Date date2=sdf.parse(sdf.format(new Date()));
												if(date1.compareTo(date2) > 0){%><% ++todayupcoming;}}%>
					                				<span class="counter-value"  ><%=todayupcoming %></span>
								            </div>
									        <hr style="margin: 5px !important">
									       <h6> <span class="blue">&#x220E;</span> To Do</h6>
								      	</div>
								      	<div class="col-md-6">
								      		 <div class="counter purple" style="cursor: pointer;" onclick="ModelForList('Upcoming')">
					                				 <%int upcomingreview=0; for(Object[] obj: actionassignorlist){
												Date date1=sdf.parse(sdf.format(obj[4]));
												Date date2=sdf.parse(sdf.format(new Date()));
												if(date1.compareTo(date2) > 0){%><% ++upcomingreview;}}%>
					                				<span class="counter-value"  ><%=upcomingreview%> </span>
								            </div>
									       
									        <hr style="margin: 5px !important">
									        <h6 style="margin-left: -28px;"><span class="purple">&#x220E;</span> To Review</h6>
								      	</div>
								      </div>
								    </div>
							</div>
							<div class="col-md-4"> 
								 <div class="card-body">
								      <h6 class="card-title" align="center"><img src="view/images/missed.png" style="width: 22px; background-color: fff;" /> Missed</h6>
								      <hr>
								      <div class="row">
								      	<div class="col-md-6" style="cursor: pointer;" onclick="ModelForList('Missed')">
								      	<%int missedtodo=0; for(Object[] obj: actionassigneelist){
											Date date1=sdf.parse(sdf.format(obj[4]));
											Date date2=sdf.parse(sdf.format(new Date()));
											if(date1.compareTo(date2) < 0){%><%++missedtodo;}}%>
								      		 <div class="counter blue" >
					                				<span class="counter-value"  ><%=missedtodo%></span>
								            </div>
									        <hr style="margin: 5px !important">
									       	 <h6> <span class="blue">&#x220E;</span> To Do</h6>
								      	</div>
								      	<div class="col-md-6">
								      		 <div class="counter purple" style="cursor: pointer;" onclick="ModelForList('Missed')">
					                		<%int missedreview=0; for(Object[] obj: actionassignorlist){
												Date date1=sdf.parse(sdf.format(obj[4]));
												Date date2=sdf.parse(sdf.format(new Date()));
												if(date1.compareTo(date2) < 0){%><% ++missedreview;}}%>
					                				<span class="counter-value"  ><%=missedreview%> </span>
								            </div>
									        <hr style="margin: 5px !important">
									        <h6 style="margin-left: -28px;"><span class="purple">&#x220E;</span> To Review</h6>
								      	</div>
								      </div>
								  </div>
							</div>
						</div>
					</div>
			<hr style="margin: 8px 70px !important; ">
				<div style="margin-top: 10px;">
					<div class="card shadow-nohover">
						<div class="card-body">
							<table class="table table-bordered table-hover table-striped table-condensed ">
										<thead>
											<tr>
												<th>SN</th> 
												<th>Action No</th>
												<th>Date</th> 
												<th>PDC</th>
												<th>Progress</th>
												<th>Action</th>
											</tr>
										</thead>
										<!----------------------- start Today Action List  --------------------------->
							<%int l1=0; 
							if(actionassigneelist!=null && actionassigneelist.size()>0){%>
							<tbody id="modal_Today_Action" style="display: none;">
								<tr><td colspan="6" style="text-align: center;padding: 0.1rem !important;"> <b>To Do - Today Action List</b> </td></tr>
							
							<%for(Object[] obj: actionassigneelist){
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) == 0){%>
								<tr>                            
									<td style="text-align: center;"> <%=++l1%></td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#424b50; font-weight: 600;"
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
									 >  &nbsp;<%=obj[9]%></button>
									</td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[3])%></td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[4])%></td>
									<td>
									<%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=obj[14]%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												Not Yet Started .
										</div>
										</div> <%}%>
									
									</td> <td></td>
								</tr>
							<%}}%></tbody><%}%>
						<!----------------------- close Today Action List  --------------------------->	
							
							<!----------------------- start Upcoming Action List  --------------------------->
							<%int m1=0; 
							if(actionassigneelist!=null && actionassigneelist.size()>0){%>
							<tbody id="modal_Upcoming_Action" style="display: none;">
								<tr><td colspan="6" style="text-align: center;padding: 0.1rem !important;"> <b>To Do - Upcoming Action List</b> </td></tr>
							
							<%for(Object[] obj: actionassigneelist){
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) > 0){%>
								<tr>
									<td style="text-align: center;"> <%=++m1%></td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#424b50; font-weight: 600;"
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
									 >  &nbsp;<%=obj[9]%></button>
									</td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[3])%></td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[4])%></td>
									<td>
									<%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=obj[14]%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												Not Yet Started .
										</div>
										</div> <%}%>
									
									</td> <td></td>
								</tr>
						<%}}%></tbody><%}%>
							<!----------------------- Close Upcoming Action List  --------------------------->
							
							<!----------------------- start Missed Action List  --------------------------->
							<%if(actionassigneelist!=null && actionassigneelist.size()>0){%>
							<tbody id="modal_Missed_Action" style="display: none;">
								<tr><td colspan="6" style="text-align: center;padding: 0.1rem !important;"> <b>To Do - Missed Action List</b> </td></tr>
							<%int n1=0;for(Object[] obj: actionassigneelist){
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) < 0){%>
								<tr>
									<td style="text-align: center;"> <%=++n1%></td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#424b50; font-weight: 600;"
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
									 >  &nbsp;<%=obj[9]%></button>
									</td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[3])%></td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[4])%></td>
									<td>
									<%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=obj[14]%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												Not Yet Started .
										</div>
										</div> <%}%>
									
									</td> <td></td>
								</tr>
							<%}}%></tbody><%}%>
							<!----------------------- start Missed Action List  --------------------------->
										
						<!----------------------- start Today Action List  --------------------------->
							<%int i1=0; 
							if(actionassignorlist!=null && actionassignorlist.size()>0){%>
								<tbody id="modal_Review_Today_Action" style="display: none;">
								<tr><td colspan="6" style="text-align: center;padding: 0.1rem !important;"> <b>To Review - Today Action List</b> </td></tr>
							
							<%for(Object[] obj: actionassignorlist){
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) == 0){%>
								<tr>
									<td style="text-align: center;"> <%=++i1%></td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#424b50; font-weight: 600;"
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
									 >  &nbsp;<%=obj[9]%></button>
									</td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[3])%></td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[4])%></td>
									<td>
									<%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=obj[14]%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												Not Yet Started .
										</div>
										</div> <%}%>
									
									</td> <td></td>
								</tr>
							<%}}%></tbody><%}%>
						<!----------------------- close Today Action List  --------------------------->	
							
							<!----------------------- start Upcoming Action List  --------------------------->
							<%int j1=0; 
							if(actionassignorlist!=null && actionassignorlist.size()>0){%>
								<tbody id="modal_Review_Upcoming_Action" style="display: none;">
								<tr><td colspan="6" style="text-align: center;padding: 0.1rem !important;"> <b>To Review - Upcoming Action List</b> </td></tr>
							
							<%for(Object[] obj: actionassignorlist){
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) > 0){%>
								<tr>
									<td style="text-align: center;"> <%=++j1%></td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#424b50; font-weight: 600;"
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
									 >  &nbsp;<%=obj[9]%></button>
									</td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[3])%></td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[4])%></td>
									<td>
									<%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=obj[14]%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												Not Yet Started .
										</div>
										</div> <%}%>
									
									</td> <td></td>
								</tr>
							
							<%}}%></tbody><%}%>
							<!----------------------- Close Upcoming Action List  --------------------------->
							
							<!----------------------- start Missed Action List  --------------------------->
							<%int k1=0; 
							if(actionassignorlist!=null && actionassignorlist.size()>0){%>
							<tbody id="modal_Review_Missed_Action" style="display: none;">	
								<tr><td colspan="6" style="text-align: center;padding: 0.1rem !important;"> <b>To Review - Missed Action List</b> </td></tr>
							<%for(Object[] obj: actionassignorlist){
								Date date1=sdf.parse(sdf.format(obj[4]));
								Date date2=sdf.parse(sdf.format(new Date()));
								if(date1.compareTo(date2) < 0){%>
								<tr>
									<td style="text-align: center;"> <%=++k1%></td>
									<td class="editable-click">
									 <button class="btn btn-sm btn-link w-100 "  formtarget="_blank" 
									 data-toggle="tooltip" data-placement="top" title="Action No" style="color:#424b50; font-weight: 600;"
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
									 >  &nbsp;<%=obj[9]%></button>
									</td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[3])%></td>
									<td style="text-align: center;font-size: 11px;font-weight: 600;"><%=sdf.format(obj[4])%></td>
									<td><%if(obj[14]!=null){%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
											<%=obj[14]%>
										</div> 
										</div> <%}else{%>
										<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
										<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;"  >
												Not Yet Started .
										</div>
										</div> <%}%>
									</td> <td></td>
								</tr>
							<%}}%></tbody><%}%>
							<!----------------------- start Missed Action List  --------------------------->
							</table>
					    </div>
					</div>
				</div> 
				</div>
				<div class="col-md-6" >
					<div class="card shadow-nohover">
						<h4 class="card-header">Favorite List</h4>
						<div class="card-body">
							<table >
					   					<tr>

					   						<td >
					   							<label class="control-label" style="font-size: 14px;font-weight:600; margin-bottom: .0rem;"> From Date : </label>
					   						</td>
					   						<td style="max-width: 160px; padding-right: 10px">
					   							<input  class="form-control"  data-date-format="dd/mm/yyyy" id="fdate" name="fdate"  required="required"  value="">
					   						</td>
					   						<td>
					   							<label class="control-label" style="font-size: 14px;font-weight:600; margin-bottom: .0rem;"> To Date : </label>
					   						</td>
					   						<td style="width: 160px; padding-right: 30px">
					   							<input  class="form-control "  data-date-format="dd/mm/yyyy" id="tdate" name="tdate"  required="required"  value="">
					   						</td>
					   						<td>
					   							<input type="submit" value="SUBMIT" class="btn  btn-sm submit	 "/>
					   						</td>			
					   					</tr>   					   				
					   				</table>
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
										<th style="text-align: center;width:10% !important;"> Date</th>
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
		document.getElementById("modal_Review_Today_Action").style.display = 'none';
		document.getElementById("modal_Today_Action").style.display = 'none';
		document.getElementById("modal_Review_Upcoming_Action").style.display = 'none';
		document.getElementById("modal_Upcoming_Action").style.display = 'none';
		document.getElementById("modal_Review_Missed_Action").style.display = 'none';
		document.getElementById("modal_Missed_Action").style.display = 'none';
		 if(value=='Today'){
			document.getElementById("modal_Review_Today_Action").style.display = '';
			document.getElementById("modal_Today_Action").style.display = '';
		}else if(value=='Upcoming'){
			document.getElementById("modal_Review_Upcoming_Action").style.display = '';
			document.getElementById("modal_Upcoming_Action").style.display = '';
		}else if(value=='Missed'){
			document.getElementById("modal_Review_Missed_Action").style.display = '';
			document.getElementById("modal_Missed_Action").style.display = '';
		}else{
			//$("#Actionvalue").val("");
		}
	}
	
	
	
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

</script>
</body>
</html>