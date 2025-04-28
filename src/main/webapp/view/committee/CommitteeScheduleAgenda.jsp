<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
<link href="${sweetalertCss}" rel="stylesheet" />
<script src="${sweetalertJs}"></script>
<title>COMMITTEE AGENDA </title>
<style type="text/css">
label{  
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
}
h6{
	text-decoration: none;
}

h6 span{
	font-size: 16px;
	color:white;
}

</style>



<style>

.control-label{
	font-weight: bold !important;
}


.table thead th{
	
	vertical-align: middle !important;
}

.header{
        position:sticky;
        top: 0 ;
        background-color: #346691;
    }
    
    .table button{
    	
    	font-size: 12px;
    }
    
 label{
 	font-size: 15px !important;
 }
 
.attachlist
{
	width: 100%;
}
 
</style>
<!-- --------------  tree   ------------------- -->
<style>
ul, #myUL {
  list-style-type: none;
}

#myUL {
  margin: 0;
  padding: 0;
}

.caret {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret::before {
  content: "  \25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down::before {
  content: "\25B6  ";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.caret-last {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last::before {
  content: "\25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}


.nested {
  display: none;
}

.active {
  display: block;
}
</style>

<!-- ---------------- tree ----------------- -->
<!-- -------------- model  tree   ------------------- -->
<style>

.caret-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret-last-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last-1::before {
  content: "\25B7" ;
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-1::before {
  content: "\25B7" ;
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down-1::before {
  content: "\25B6";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.nested-1 {
  display: none;
}

.active-1 {
  display: block;
}

</style>

</head>
 
<body>
  <%
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  
  Object[] labdata=(Object[])request.getAttribute("labdata");
  String filesize=  (String)request.getAttribute("filesize");
  
  List<Object[]> AllLabList=(List<Object[]>) request.getAttribute("AllLabList");
  Object[] scheduledata=(Object[])request.getAttribute("scheduledata");
  List<Object[]> projectlist=  (List<Object[]> ) request.getAttribute("projectlist");
  List<Object[]> committeeagendalist =  (List<Object[]>)request.getAttribute("committeeagendalist");
  List<Object[]> filerepmasterlistall=(List<Object[]>) request.getAttribute("filerepmasterlistall");
  List<Object[]> AgendaDocList=(List<Object[]>) request.getAttribute("AgendaDocList");
  List<Object[]> LabEmpList=(List<Object[]>)request.getAttribute("LabEmpList");
  String LabCode =  (String)request.getAttribute("LabCode");
  
  String scheduleid=scheduledata[6].toString();
  String projectid=scheduledata[9].toString();
  String divisionid=scheduledata[16].toString();
  String initiationid=scheduledata[17].toString();
  

 %>
 
 
 
 
<% 
	String ses=(String)request.getParameter("result"); 
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null)
	{ %>
		<div align="center">	
			<div class="alert alert-danger" role="alert" >  <%=ses1 %>  </div>
		</div>
	<%} if(ses!=null){ %>
		<div align="center">
			<div class="alert alert-success" role="alert"  >  <%=ses %> </div>
	     </div>
   <%} %>


<div class="container-fluid">
	<div style="margin-bottom:20px;"> 
    		<div class="card">
    	
	    	<form action="CommitteeScheduleView.htm" name="myfrm" id="myfrm" method="post">
	    		<div class="card-header" style="background-color: #055C9D;">
      				<h6 style="color: orange;font-weight: bold;font-size: 1.2rem !important " align="left"><%=scheduledata[7] %> <span> (Meeting Date and Time :      				
	      				 &nbsp;<%=sdf.format(sdf1.parse(scheduledata[2].toString()))%> - <%=scheduledata[3] %>) </span>      				
						<input type="hidden" name="projectid" value="<%=projectid%>"/>
	      				<input type="submit" class="btn  btn-sm view" value="VIEW" style="float:right;" />
	      				<span  style="float:right;margin: 5px 12px;" > (Meeting Id : <%=scheduledata[11] %>) </span> 
	      				<input type="hidden" name="scheduleid" value="<%=scheduledata[6] %>">
	      				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />      				
      				 </h6>
      			</div>
	      	</form>		
      		
	      		<div class="card-body">
	      			<form method="post" action="CommitteeAgendaSubmit.htm"  id="addagendafrm" name="addagendafrm">	        
	        			<div >
	        			
	          				<div style="float: right;"><span style="font-size: 15px ;color: blue ; font-weight: ">Duration in Minutes</span></div>
	          				<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" style="margin-top: 30px;">
								<thead>  
									<tr id="">
										<th>Agenda Item</th>
										<th>Reference</th>
										<th>Remarks</th>
										<th>Lab</th>
										<th>Presenter</th>
										<th>Duration </th>
										<th>Attach File </th> 
										<th> <button type="button" class="tr_clone_addbtn btn " name="add"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  ;"></i></button></th>	
									</tr>
										
									<tr class="tr_clone">
									
										<td width="20%"><input type="text" name="agendaitem" class="form-control item_name child" maxlength="500" required="required" /></td>
										
										<td width="15%">
											<%if(Long.parseLong(projectid) > 0) { %>
												<select class="form-control child  items" name="projectid"  required="required" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
												
											    <% for (Object[] obj : projectlist) {
											    	if(obj[0].toString().equals(projectid)){%>						    				 	
									     				<option value="<%=obj[0]%>"><%=obj[3]%> (<%=obj[2] %>)</option>
									    			<%} 
									    		}%>					
												</select>
											<%}else if(Long.parseLong(initiationid) > 0) {%>
												<select class="form-control child  items" name="projectid"  required="required" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
											    	<option value="0"><%=labdata[1] %>(GEN)</option>		
												</select>
											<%}else{ %>									
												<select class="form-control items" name="projectid" required="required" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
																							
									        		<option disabled  selected value="">Choose...</option>
									        		<option value="0"><%=labdata[1] %>(GEN)</option>
											  		<% for (Object[] obj : projectlist) {%>						    				 	
								     					<option value="<%=obj[0]%>"><%=obj[3]%> (<%=obj[2] %>)</option>
								    				<%} %>					
												</select>
											<%} %>
										</td>		
						         		<td  width="20%"><input type="text" name="remarks" class="form-control item_name child" maxlength="255" required="required" /></td>      
						         		 
						         		 <td>
						         		 	<select class="form-control items PresLabCode" name="PresLabCode" id="PresLabCode_0"  required="required" style="width: 200px" onchange="AgendaPresentors('0')"  data-live-search="true" data-container="body">
												<option disabled="disabled"  selected value="">Lab Name</option>
											    <% for (Object[] obj : AllLabList) {%>
												    <option value="<%=obj[3]%>" <%if(LabCode.equalsIgnoreCase(obj[3].toString())){ %>selected <%} %>  ><%=obj[3]%></option>
											    <%} %>
											    <option value="@EXP">Expert</option>
											</select>
						         		 
						         		 </td>
						         		         	                             
						         		<td width="15%">						         		
											<select class="form-control items presenterid" name="presenterid" id="presenterid_0"  required="required" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
								        		<option disabled="disabled" selected value="">Choose...</option>
										        <% for(Object[] emp : LabEmpList){ %>
										        	<option value="<%=emp[0] %>"><%=emp[1] %>(<%=emp[3] %>)</option>
										        <%} %>
											</select>
										</td>		
										<td  width="10%">
										 	<input type="number" name="duration" class="form-control item_name child" min="1"   placeholder="Minutes" required/>
										</td>						         		                                      
																	
										<td style="text-align: left; width: 15%;">
										
											<button type="button" class=" btn btn-sm btnfileattachment" name="add" onclick="openMainModal('0','0',' ','<%=projectid %>','0','add')" > <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button> 
											<br>
											<table class="attachlist" id="attachlistdiv_0">
												
											</table>										
										</td>							
										<td>
											<button type="button" class="tr_clone_sub btn  " name="sub" > <i class="btn btn-sm fa fa-minus" style="color: red;padding: 0px  ;"> </i></button>
										</td>								
									</tr>
								</thead>
							</table>

	          				<div align="center">
				            	<input type="submit"  class="btn  btn-sm submit" value="SUBMIT" onclick="return allfilessizecheck('addagendafrm'); "/> <!-- return confirm('Are You Sure To Add This Agenda(s) ?') -->
				            	<button type="reset" class="btn btn-sm reset" style="color: white" onclick="$('.hidden').val(''); $('.attachname').html('');" > RESET</button>
				            	<input type="button"  class="btn  btn-sm edit" value="Copy Agenda from old Meetings" onclick="submitForm('agendasprevious'); "/>
	          				</div>
	        			</div>
	        		
			        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
			        	<input type="hidden" name="scheduleid" value="<%=scheduledata[6] %>">
			     		<input type="hidden" name="schedulesub" value="<%=scheduledata[5]%>"/>
			         	<input type="hidden" name="projectid" value="<%=projectid%>"/>
			    
	      			</form>
	    		</div>
    		</div>
	   	</div>   
	   	
	   	<form action="AgendasFromPreviousMeetingsAdd.htm"  method="post" id="agendasprevious">
	   		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
	   		<input type="hidden" name="scheduleidto" value="<%=scheduledata[6]%>"/>	   
		</form>


<% if(committeeagendalist.size()>0){ %> 
<div class="row">

	<div class="col-md-12">
    	<div class="card" style="">
      		<div class="card-body" >
      			<div class="row">

		   			<div class="col-md-12" style="padding-left: 0px">
		   
		   				<div class="table-responsive">
		   				
		    				<table class="table table-bordered table-hover  table-condensed" id="myTable3" style="margin-top: 20px;">
								<thead>
									<tr>
										<th colspan="10" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;" >Agenda Details</th>									
									</tr>	
									<tr>			
										<th style="padding-top: 50px;">Priority</th>		
										<th style="text-align: left;">Agenda Item</th>
										<th>Reference</th>
										<th>Remarks</th>	
										<th>Presenter Lab</th>							
									 	<th>Presenter</th>
									 	<th>Duration </th>
									 	<th>Attachment</th>
									 	<th>Upload</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>					
							 		<%int  count=1;
									for(Object[] obj: committeeagendalist){ %>
									<form name="myForm1" id="myForm1<%=count%>" action="CommitteeScheduleAgendaEdit.htm" method="POST"  > <!-- enctype="multipart/form-data" -->
										<tr>
											<td width="5%" >
												<input type="number" class="form-control" style="line-height: 1.6 !important" name="priority" value="<%=obj[8]%>" onkeypress="return isNumber(event)" min="1" max="<%=committeeagendalist.size()%>" form="priority_form">
												<input type="hidden" name="agendaid"  value="<%=obj[0]%>" form="priority_form">
											</td>
											<td width="12%">
												<input type="text" class="form-control form-control" name="agendaitem" value="<%=obj[3].toString()%>"  maxlength="255" >	 
											</td>
											<td width="4%">
												<%if(Long.parseLong(projectid) > 0) { %>
													<select class="form-control" name="projectid"  required="required" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
														<% for (Object[] obj1 : projectlist) {
															if(obj1[0].toString().equals(projectid)){%>						    				 	
											     				<option value="<%=obj1[0]%>"><%=obj1[3]%> (<%=obj1[2] %>)</option>
											    			<%} 
											    		}%>					
													</select>
												<%}else{ %>
													<select class="form-control items" name="projectid"  required="required" style=" font-weight: bold; text-align-last: left; width: 220px;" data-live-search="true" data-container="body">
										          		<option value="0" ><%=labdata[1] %></option>
												    	<% for (Object[] obj1 : projectlist) {%>
									     					<option value="<%=obj1[0]%>" <%if(obj[5].toString().equals(obj1[0].toString()))  {%> selected <%} %>><%=obj1[3]%> (<%=obj1[2] %>)</option>
									    				<%} %>					
													</select>
												<%} %>
											</td>
											<td style="text-align: left; width: 10%;"> 
												<input type="text" class="form-control form-control" name="remarks" value="<%=obj[6].toString()%>"  maxlength="255" >
											</td>
											<td>
							         		 	<select class="form-control items " name="PresLabCode" id="PresLabCode_Edit_<%=obj[0] %>"  required="required" style="width: 200px" onchange="AgendaPresentors('Edit_<%=obj[0] %>')"  data-live-search="true" data-container="body">
													<option disabled="disabled"  selected value="">Lab Name</option>
												    <% for (Object[] lab : AllLabList) {%>
													    <option value="<%=lab[3]%>" <%if(obj[14].toString().equalsIgnoreCase(lab[3].toString())){ %>selected <%} %>><%=lab[3]%></option>
												    <%} %>
												    <option value="@EXP" <%if(obj[14].toString().equalsIgnoreCase("@EXP")) {%>selected<%} %>>Expert</option>
												</select>
							         		</td>
											<td style="width:1%">
												<select class="form-control edititemsdd" name="presenterid" id="presenterid_Edit_<%=obj[0] %>" required="required" style=" font-weight: bold; text-align-last: left; width: 220px;" data-live-search="true" data-container="body">
													<option disabled="true"  selected value="">Choose...</option>
										        					
												</select>
											</td>	
											<td  width="10%">
												<input type="number" name="duration" class="form-control item_name numeric-only" min="1"  placeholder="Minutes " value="<%=obj[12] %>" required />
											</td>
											<td style="text-align: left; width: 3%;">
												<table>
												<%for(Object[] doc : AgendaDocList) { 
													if(obj[0].toString().equalsIgnoreCase(doc[1].toString())){%>
													<tr>
														<td><%=doc[3] %></td>
														<td style="width:1% ;white-space: nowrap;" ><a href="AgendaDocLinkDownload.htm?filerepid=<%=doc[2]%>" target="blank"><i class="fa fa-download" style="color: green;" aria-hidden="true"></i></a></td>
														<td style="width:1% ;white-space: nowrap;" ><a type="button" onclick="removeDocRow(this,<%=doc[0] %>);" > <i class=" fa fa-minus" style="color: red;"   ></i> </a></td>
													<tr>													
												<%} }%>
												</table>
									
											</td>
										
											<td style="text-align: left; width: 15%;"> 
												<span id="editattachname_<%=obj[0] %>" class="attachname"></span>
												<button type="button" class=" btn btn-sm" name="add" id="attacheditbtn_<%=obj[0] %>" onclick="openMainModal('<%=obj[0] %>','<%=obj[1] %>','<%=obj[3] %>','<%=obj[5] %>','0','edit')" > <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
												<input type="hidden" name="attachid" id="editattachid_<%=obj[0] %>" value="">												
											</td>																	
											<td style="text-align: left; width: 6%;">
				                                <input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
												<input type="hidden"  name="AgendaPriority" value="<%= obj[8]%>"/>
												<input type="hidden" name="committeescheduleagendaid" id="committeescheduleagendaid" value="<%=obj[0]%>"/>
												<input type="hidden" name="scheduleid" value="<%=scheduleid%>"/>
												<button type="submit" class="btn  btn-sm" name="action" value="edit" onclick="return confirm('Are you sure To Edit this Agenda?')"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
												<button type="submit" class="btn  btn-sm" name="action" value="delete" onclick="return confirm('Are you sure To Delete this Agenda?')" formaction="CommitteeAgendaDelete.htm"> <i class="fa fa-trash" aria-hidden="true" ></i></button>
											</td>
										 
										</tr>
									</form> 								
										<% count++; } %>
										<%if( committeeagendalist.size()!=1 ){ %>
										<tr>
											<td ><input type="submit" value="Update" class="btn  btn-sm submit" onclick="return confirm('Are You Sure to Update the Priorities ?');" form="priority_form"></td>
											<td colspan="9"></td>
										</tr>
										<%} %>
								</tbody>
							</table>
						
						</div> 
					</div>
 <!-- ----------------------------- -->		 	
  				</div>
			</div>
			</div>
		</div>
	</div>
</div>  

 <form method="get" action="CommitteeAgendaPriorityUpdate.htm" id="priority_form">
	<input type="hidden" name="scheduleid" value="<%=committeeagendalist.get(0)[1]%>"/>
</form>
<%} %>  

<!--  -----------------------------------------------agenda attachment ---------------------------------------------- -->

<%-- 		<div class="modal" tabindex="-1" role="dialog" id="attachmentmodal" aria-labelledby="myLargeModalLabel" aria-hidden="true">
 				 <div class="modal-dialog modal-dialog-centered " style="max-width: 75% !important; ">
   					 <div class="modal-content">
   						 <div class="modal-header">
					        <h4 class="modal-title"></h4>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
						 </div>
						<div class="modal-body">   
		<!-- --------------------------------------------left page ----------------------------------------------------->
							<div class="col-md-12" >		
		<!-- -------------------------------- tree ----------------------------- -->
								<div class="row" style="height: 28rem; overflow-y:auto;verflow-x:auto; ">		
									<ul>	
									<%for(Object[] obj :filerepmasterlistall)
									{ 
										if(Long.parseLong(obj[1].toString())==0)
										{%>  
										<li>
											<span class="caret" id="system<%=obj[0]%>"  onclick="onclickchangeMain(this);" >
							             		<%=obj[3] %>
							             	</span>
							             	<span>
									           
							             	</span>
											<ul  class="nested">
												<li>
								<!-- ----------------------------------------level 1------------------------------------- -->	
													<%for(Object[] obj1 :filerepmasterlistall)
													{ 
														if(Long.parseLong(obj1[1].toString())==Long.parseLong(obj[0].toString()))
														{%>  
														<li>
															<span class="caret" id="system<%=obj1[0]%>" onclick="onclickchangeMain(this);" >
							             						<%=obj1[3] %>
							             					</span>
															<span>
																<button type="button" id="upbutton<%=obj1[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','-','','-','','-','',1)">
									             					<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>
									             				</button>
									             			
							             					</span>
															<ul  class="nested">
																<li>
												<!-- ----------------------------------------level 2------------------------------------- -->	
																		<%for(Object[] obj2 :filerepmasterlistall)
																		{ 
																			if(Long.parseLong(obj2[1].toString())==Long.parseLong(obj1[0].toString()))
																			{ %>  
																			<li>
																				<span class="caret" id="system<%=obj2[0]%>" onclick="onclickchangeMain(this);" >
																					<%=obj2[3] %>
																				</span>
																				<span>
																					<button type="button" id="upbutton<%=obj2[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','-','','-','',2)">
													             						<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>
													             					</button>
													             					
													             					
											             						</span>
																				<ul  class="nested">
																					<li>
																	<!-- ----------------------------------------level 3------------------------------------- -->	
																							<%for(Object[] obj3 :filerepmasterlistall)
																							{ 
																								if(Long.parseLong(obj3[1].toString())==Long.parseLong(obj2[0].toString()))
																								{%>  
																								<li>
																									<span class="caret" id="system<%=obj3[0]%>"  onclick="onclickchangeMain(this);" >
																										<%=obj3[3] %>
																									</span>
																									<span>
																										<button type="button" id="upbutton<%=obj3[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','-','',3)">
																		             						<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>
																		             					</button>
																		             					
																             						</span>
																									<ul  class="nested">
																										<li>
																						<!-- ----------------------------------------level 4------------------------------------- -->	
																											<%for(Object[] obj4 :filerepmasterlistall)
																											{ 
																												if(Long.parseLong(obj4[1].toString())==Long.parseLong(obj3[0].toString()))
																												{%>  
																												<li>
																													
																														<span class="caret-last"  id="system<%=obj4[0]%>" onclick="onclickchangeMain(this);" >
																															<%=obj4[3] %>
																														</span>
																														<span> 
																															<button type="button" id="upbutton<%=obj4[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','<%=obj4[0]%>','<%=obj4[3] %>',4)">
																							             						<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i>
																							             					</button>
																							             					
																							             					
																							             					
																					             						</span>
																													
																												</li>	
																											<% }
																											} %>			
																									
																						<!-- ----------------------------------------level 4------------------------------------- -->
																										</li>
																									</ul>
																								</li>	
																							<%}
																							} %>	
																				
																	<!-- ----------------------------------------level 3------------------------------------- -->
																					</li>
																				</ul>
																			</li>	
																		<%}
																		} %>		
															
												<!-- ----------------------------------------level 2------------------------------------- -->
																</li>
															</ul>
														</li>	
													<%}
													} %>
											
								<!-- ----------------------------------------level 1------------------------------------- -->
												</li>
											</ul>
										</li>	
									<%}
									} %>
									</ul>							
								</div>
			
							</div>
	
						</div>	
					</div> 
				</div> 
			</div> --%>
<!--  -----------------------------------------------agenda attachment ---------------------------------------------- -->


<!-- --------------------------------------------  model start  -------------------------------------------------------- -->

		<div class="modal fade" id="exampleModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered "  style="max-width: 60% !important;">
		
				<div class="modal-content" >
					   
				    <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374"></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
				          <span aria-hidden="true">&times;</span>
				        </button>
				    </div>
					<div class="modal-body"  style="padding: 0.5rem !important;">
							
						<div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
							<div class="row">
								<div class="col-md-12">
									<div style="margin-top: -15px;" id="fileuploadlist">
						
									</div>
								</div>
									
			           		</div>					
						</div>
					</div>
				<div class="modal-footer">
					<div style="color: red;font-weight: 500;">Note - Please upload PDF files only and PDF size should be smaller than 10mb.</div>
				</div>
			</div>
			</div> 
		</div>
		
		<input type="hidden" name="projectid" id="ProjectId" value="<%=projectid %>" />
<!-- --------------------------------------------  model end  -------------------------------------------------------- -->

<form method="POST" action="FileUnpack.htm"  id="downloadform" target="_blank"> 
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<input type="hidden" name="FileUploadId" id="FileUploadId" value="" />
</form>


<script type="text/javascript">

$('.edititemsdd').select2();
$('.items').select2();

var count=1;
$("table").on('click','.tr_clone_addbtn' ,function() {
   $('.items').select2("destroy");        
   var $tr = $('.tr_clone').last('.tr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
  
  count++;
  
  $clone.find(".btnfileattachment").attr("onclick", 'openMainModal(\'0\',\'0\',\' \',\''+'<%=projectid %>'+'\',\''+count+'\',\'add\')').val("").end();
  $clone.find(".hidden").prop("id", 'attachid_'+count).prop("name", 'attachid_'+count).val("").end();
  $clone.find(".attachlist").prop("id","attachlistdiv_"+count).html("").end();
  $clone.find(".attachname").prop("id", 'attachname_'+count).html("").end();
  $clone.find('.items presenterid' ).attr('id', 'select'+count);
  $clone.find(".PresLabCode").prop("id", 'PresLabCode_'+count).attr("onchange", 'AgendaPresentors(\''+count+'\')').end();
  $clone.find(".presenterid").prop("id", 'presenterid_'+count).end();
  
  $('.items').select2();
  $clone.find('.items' ).select2('val', ''); 
  $clone.find("input").val("").end();
  
  AgendaPresentors(count+'');
  
});

$("table").on('click','.tr_clone_sub' ,function() {
	
var cl=$('.tr_clone').length;
	
if(cl>1){
	
   $('.items').select2("destroy");        
   var $tr = $(this).closest('.tr_clone');
   var $clone = $tr.remove();
   $tr.after($clone);
   $('.items').select2();
   
}
   
});
</script>


<script>
function editsubmit(agendaid) {
	var attacharr = [];
	$('input[name="editattachid_'+agendaid+'"').each(function() {
		attacharr.push($(this).val());
	});
	return false;
} 
</script>



<script type="text/javascript">
function removeDocRow(elem,attachid)
{
	if(confirm('Are You Sure To unlink this Document ?')){
	
		$.ajax({
			type : "GET",
			url : "AgendaUnlinkDoc.htm",
			data : {
				AttachDocid : attachid
			},
			datatype: 'json',
			success : function(result)
				{
					var result= JSON.parse(result);
					if(result==1){
						alert('Document Removed Successfully');
						$(elem).parent('td').parent('tr').remove();
					}else
					{
						alert('Document Removal Unsuccessful \n Internal Error occured !!');
					}
				}
		});
	}
}
</script>


<script type='text/javascript'> 
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 

function submitForm1(msg,frmid)
{ 
	myconfirm(msg,frmid);
	event.preventDefault(); 
}
</script>

<script type="text/javascript">
  function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
  </script>

<input type="hidden" id="addoredit" value="" />
<input type="hidden" id="agendano" value="" />
<!--  -----------------------------------------------agenda attachment js ---------------------------------------------- -->

<script type="text/javascript">

function setagendaattachval(attachid, attchName)
{
	$addedit=$('#addoredit').val();
	$agendaelem=$('#agendano').val();
	if($addedit==='add'  )
	{
		let agendano=$('#agendano').val();
		let html= $("#attachlistdiv_"+agendano).html();
		let attname ;
		if(attchName.length>5){
			attname = attchName.substring(0, 5).concat("...");
		}else{
			attname=attchName;
		}
		html += '<tr id="a_'+agendano+'"><td title='+attchName+'> '+attname+'</td><td style="width:1% ;white-space: nowrap;">';
		html += '<button type="button"  onclick="$(this).parent(\'td\').parent(\'tr\').remove();"  > <i class="btn btn-sm fa fa-minus" style="color: red;"   ></i> </button>';  /* onclick="$(\'#a_'+agendano+'\').remove();" */
		html += '<input type="hidden" name="attachid_'+agendano+'" value="'+attachid+'" /></td>';
		html += '</tr>';
		$("#attachlistdiv_"+agendano).html(html);
	}
	/* else if($addedit==='edit'){		
		$('#editattachid_'+$agendaelem).val(attachid);
		$('#editattachname_'+$agendaelem).html(attchName+'&nbsp;&nbsp; <i class="btn btn-sm fa fa-minus" style="color: red;" onclick="editattachremove('+$agendaelem+');"  ></i>');
		$('#attacheditbtn_'+$agendaelem).hide();
	} */
	$('#exampleModalCenter1').modal('hide');
	$('#attachmentmodal').modal('hide');
}
 

function editattachremove(agendaid)
{
	$('#editattachid_'+$agendaelem).val(0);
	$('#editattachname_'+$agendaelem).html('');
	$('#attacheditbtn_'+$agendaelem).show();
}
</script>
<script type="text/javascript">
function FileDownload(fileid1)
{
	$('#FileUploadId').val(fileid1);
	$('#downloadform').submit();
}

$(document).ready(function(){
	<%for( Object[] agenda : committeeagendalist){ %>
		EditAgendaPresentors('<%=agenda[0]%>','<%=agenda[9]%>');
	<%}%>
	
});
</script>

<%-- <script type="text/javascript">
function onclickchange(ele)
{
	elements = document.getElementsByClassName('caret-1');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
    elements = document.getElementsByClassName('caret-last-1');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
$(ele).css("color", "green");
$(ele).css("font-weight", "700");

}
function onclickchangeMain(ele)
{
	elements = document.getElementsByClassName('caret');
	for (var i1 = 0; i1 < elements.length; i1++) {
		$(elements[i1]).css("color", "black");
		$(elements[i1]).css("font-weight", "");
	}
	elements = document.getElementsByClassName('caret-last');
	for (var i1 = 0; i1 < elements.length; i1++) {
		$(elements[i1]).css("color", "black");
		$(elements[i1]).css("font-weight", "");
	}
	$(ele).css("color", "green");
	$(ele).css("font-weight", "700");
}
$(document).ready(function(){
	var toggler = document.getElementsByClassName("caret");
	var i;
	for (i = 0; i <toggler.length; i++) {
	  toggler[i].addEventListener("click", function() {	
		this.parentElement.querySelector(".nested").classList.toggle("active");   
	    this.classList.toggle("caret-down");
	  });
	}
	
	<%for( Object[] agenda : committeeagendalist){ %>
		EditAgendaPresentors('<%=agenda[0]%>','<%=agenda[9]%>');
	<%}%>
	
});
function setmodelheader(m,l1,l2,l3,l4,lev,project,divid){
	/* var modelhead=project+'  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+m; */
	var modelhead=m;
	if(lev>=1)
	{
		 modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l1; 
	}
	if(lev>=2)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l2;
	}
	if(lev>=3)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l3;
	}
	if(lev>=4)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l4;
	}
	$('#'+divid).html(modelhead);
}

function modalbox(mid,mname,l1,lname1,l2,lname2,l3,lname3,l4,lname4,lev)
{
		var $projectid=$('#ProjectId').val();		
		setmodelheader(mname,lname1,lname2,lname3,lname4,lev,$('#projectname').val(),'model-card-header');		
		$('#amendmentbox').css('display','none');
		$('#submitversion').val('');
		$('#prevversion').text('');
		$('#downloadbtn').remove();
		$('#FileName').prop('readonly',false);
		$('#FileName').val('');
		$('#modeldescshow').text('');
		$('#uploadbox').css('display','none');
		$('#ammendmentbox').css('display','none');
		
		$.ajax({
				type : "GET",
				url : "FileHistoryListAjax.htm",
				data : {
					projectid : $projectid,
					mainsystemval : mid,
					sublevel : lev ,
					s1:l1,
					s2:l2,
					s3:l3,
					s4:l4,				
				},
				datatype: 'json',
				success : function(result)
					{
						var result= JSON.parse(result);
						var values= Object.keys(result).map(function(e){
						return result[e];
					})			
						/* --------------------------------------------ajax nested--------------------------------------- */		
							 $.ajax({
									type : "GET",
									url : "FileDocMasterListAll.htm",
									data : {
										projectid : $projectid,		
									},
									datatype: 'json',
									success : function(result1)
											{
												var result1= JSON.parse(result1);
												var values1= Object.keys(result1).map(function(e){
													return result1[e];
												})
														
												var values2=values1;
												/* --------------------------------------------------tree making--------------------------------------------------------- */			
													var str='<ul>';
													for(var v1=0;v1<values1.length;v1++)
													{ 
														if(values1[v1][2]===1)
														{  
															str +='<li> <span class="caret-1" id="docsysl1'+values1[v1][0]+'" onclick="onclickchange(this);" >'+values1[v1][3] +'</span> <ul  class="nested-1"> <li>'; 
													 /* ----------------------------------------level 1------------------------------------- */	
																for(var v2=0;v2<values2.length;v2++)
																{ 
																	if(values1[v2][2]===2 && values2[v2][1]==values1[v1][0] )
																	{  
																		str += '<li> <span class="caret-1" id="docsysl2'+values2[v2][0]+'" onclick="onclickchange(this);" >' +values2[v2][3]+'</span> <ul  class="nested-1"> <li>'; 
																/* ----------------------------------------level 2------------------------------------- */
																			for(var v3=0;v3<values.length;v3++)
																			{ 
																				if(  values[v3][1]==values2[v2][0])
																				{
																					str += '<li>';
																					
																					if(values[v3][4]!=0)
																					{
																						str += '<input type="radio" class="DocModalcheckbox" onchange="setagendaattachval(\''+ values[v3][4] +'\', \''+values[v3][3] +'\');" ></button>' ;
																					}
																					else
																					{
																						str += '<input type="radio" class="DocModalcheckbox" disabled onclick="alert(\'Document Not Uploaded\');" ></button>' ;
																					}
																					
																					str +=' <span class="caret-last-1" id="docsysl3'+values[v3][0]+'" onclick="onclickchange(this);">'+values[v3][3]+'('+values[v3][9]+')</span>';
																					if(values[v3][4]!=0)
																					{ 
																						str +=' <span class="version">Ver '+values[v3][8]+'.'+values[v3][6];
																						str +=		' <button type="radio" name="selectattach" class="btn"  style="background-color: transparent;margin: -5px 0px;" onclick="FileDownload(\''+values[v3][4]+'\')">';                                     
																						str += 			'<i class="fa fa-download" aria-hidden="true"></i>';
																						str +=		'</button> ';
																						str += '</span>';
																					} 
 																					str +='	</span> </li>';
																				}
																			}			
																/* ----------------------------------------level 2------------------------------------- */			
																		str +=	'</li> </ul> </li>';
																	}
																} 
												 	/* ----------------------------------------level 1------------------------------------- */
															str +='</li> 	</ul> 	</li>';	
														} 
													} 
												/* --------------------------------------------------tree making--------------------------------------------------------- */
													str += '</ul>';
													$('#fileuploadlist').html(str);
													var toggler = document.getElementsByClassName("caret-1");
													$('#s1').val(l1);
													$('#s2').val(l2);
													$('#s3').val(l3);
													$('#s4').val(l4);
													$('#mainsystemval').val(mid);
													$('#sublevel').val(lev);
													$('#Path').val(mname+'/'+lname1);
													
													var i;
													for (i = 0; i <toggler.length; i++) {
													  toggler[i].addEventListener("click", function() {	
														this.parentElement.querySelector(".nested-1").classList.toggle("active-1");   
													    this.classList.toggle("caret-down-1");
													  });
													}
													$('#exampleModalCenter1').modal('show');
											},
											error: function(XMLHttpRequest, textStatus, errorThrown) {
												alert("Internal Error Occured !!");
									            alert("Status: " + textStatus);
									            alert("Error: " + errorThrown); 
									        }  
							 		})
						/* --------------------------------------------ajax nested--------------------------------------- */
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					alert("Internal Error Occured !!");
		            alert("Status: " + textStatus);
		            alert("Error: " + errorThrown); 
		        }  
		 })
				
}
</script> --%>
<!--  -----------------------------------------------agenda attachment js ---------------------------------------------- -->
<script type="text/javascript">
function editcheck(editfileid)
{
	const fi = $('#'+editfileid )[0].files[0].size;							 	
    const file = Math.round((fi / 1024/1024));
    if (document.getElementById(editfileid).files.length !=0 && file >= <%=filesize%> ) 
    {
    	event.preventDefault();
     	alert("File too Big, please select a file less than <%=filesize%> mb");
    } else
    {
    	 return confirm('Are You Sure To Edit This Agenda?');
    }
}
</script>
<script type="text/javascript">
var filexcount=0;
	function allfilessizecheck(frmid)
	{	
		filexcount=0;
		var fileidarr=[];
		$(".filex").each(function() {			
            if (this.id) {            	
            	fileidarr.push(this.id);
            }
        });
		for(var z=0; z<fileidarr.length;z++)
		{
			if(document.getElementById(fileidarr[z]).files.length !=0 ){
				const fi = $('#'+fileidarr[z] )[0].files[0].size;							 	
		        const file = Math.round((fi / 1024/1024));
		       
		        if (file >= <%=filesize%>) 
		        {
		        	filexcount++;
		        }	        
			}
		}
		if(filexcount>0)
		{
			event.preventDefault();
			alert('File too Big, please select a file less than <%=filesize%> mb');
		}else
		{
			return confirm('Are You Sure to Submit These Agenda (s)?')
		}
	}					
</script>
	
<script type="text/javascript">
		function AgendaPresentors($AddrowId){
			$('#presenterid_'+$AddrowId).val("");
				var $PresLabCode = $('#PresLabCode_'+$AddrowId).val();
						if($PresLabCode !=""){
						$.ajax({		
							type : "GET",
							url : "CommitteeAgendaPresenterList.htm",
							data : {
								PresLabCode : $PresLabCode,
								   },
							datatype : 'json',
							success : function(result) {
		
							var result = JSON.parse(result);	
							var values = Object.keys(result).map(function(e) {
										 return result[e]
							});
								
					var s = '';
						s += '<option value="" selected disabled>Choose...</option>';
								 for (i = 0; i < values.length; i++) {									
									s += '<option value="'+values[i][0]+'">'
											+values[i][1] + " (" +values[i][3]+")" 
											+ '</option>';
								} 
								$('#presenterid_'+$AddrowId).html(s);
							}
						});
		}
	}
		function EditAgendaPresentors($AddrowId,PresentorID){
			$('#presenterid_Edit_'+$AddrowId).val("");
				var $PresLabCode = $('#PresLabCode_Edit_'+$AddrowId).val();
						if($PresLabCode !=""){
						$.ajax({		
							type : "GET",
							url : "CommitteeAgendaPresenterList.htm",
							data : {
								PresLabCode : $PresLabCode,
								   },
							datatype : 'json',
							success : function(result) {
		
							var result = JSON.parse(result);	
							var values = Object.keys(result).map(function(e) {
										 return result[e]
							});
								
					var s = '';
						s += '<option value="" selected disabled>Choose...</option>';
								 for (i = 0; i < values.length; i++) {									
									s += '<option value="'+values[i][0]+'">'
											+values[i][1] + " (" +values[i][3]+")" 
											+ '</option>';
								} 
								$('#presenterid_Edit_'+$AddrowId).html(s);
								$('#presenterid_Edit_'+$AddrowId).val(PresentorID).trigger('change');
							}
						});
		}
	}
var mainAgendaId="";
function openMainModal(agendaid,scheduleid,agendaname,projectid,cloneId,agendatype){
	var attachRepIds = [];
	var agendadocId=[];
	mainAgendaId="";
	$('#addoredit').val(agendatype);
	$('#agendano').val(cloneId);
	mainAgendaId=agendaid;
	if(agendaid!=0){
		 $.ajax({
             url: 'getAgendaAttachId.htm',
             type: 'GET',
             data: {agendaid: agendaid},
             success: function(response) {
            	 try {
                     var parsedResponse = JSON.parse(response);
                     if (Array.isArray(parsedResponse)) {
                       parsedResponse.forEach(item => {
                         attachRepIds.push(item[1]);
                         agendadocId.push(item[0]);
                       });
                     } else {
                       console.error('Response is not an array:', parsedResponse);
                     }
                   } catch (e) {
                     console.error('Error parsing JSON response:', e);
                   }
             },
          }); 
	}
	
	$.ajax({
		type : "GET",
		url : "FileRepMasterListAllAjax.htm",
		data : {
			projectid : projectid,
		},
		datatype: 'json',
		success : function(result)
			{
				var result= JSON.parse(result);
				var values= Object.keys(result).map(function(e){
					return result[e];
				})	
                if (values.length > 0) {
                     projectName = values[0][4];
                     subId = values[0][2];
                }
				
				var values1=values;
				var values2=values;
				
			/* --------------------------------------------------tree making--------------------------------------------------------- */			
				var str='<ul>';
				var itemCounter = 0;
				var subCounter= 0;
				var main="";
				var sub="";
				var mainLevelId="";
				var subLevelId="";
				for(var v1=0;v1<values1.length;v1++){ 
					mainLevelId=values1[v1][0];
					main=values1[v1][3];
				  for(var v2=0;v2<values2.length;v2++){ 
					  if( values2[v2][1]==values1[v1][0] )
						{
						  subLevelId=values2[v2][0];
						  sub=values2[v2][3];
						  levelId = values2[v2][0];
						   var itemId = 'item-' + (++itemCounter);
							str += '<li id="' + itemId + '"> <span style="color:#006400;font-weight:600;font-size:20px;">'+values1[v1][3]+' <i class="fa fa-arrow-right" aria-hidden="true"></i> '+values2[v2][3]+'</span> ';
							
							 (function(projectid,itemId,mainIndex,main,sub,mainLevelId,subLevelId,attachRepIds) {
								 $.ajax({
					                    type: "GET",
					                    url: "ProjectDocsList.htm",
					                    data: { projectid: projectid}, 
					                    datatype: 'json',
					                    success: function(result) {
					                    	var result= JSON.parse(result);
					        				var mainvalues= Object.keys(result).map(function(e){
					        					return result[e];
					        				})
					        				var values3=mainvalues;
					        				var values4=mainvalues;
					                        var mainStr = '<ul>';
					                        for(var v3=0;v3<values3.length;v3++){
					                        	for(var v4=0;v4<values4.length;v4++){
					                        		var masterid=values4[v4][0];
					                        		var mianItemId = 'main-sub-item-'+ (++subCounter);
					                        		 if( values4[v4][1]==values3[v3][0] ){
					                        			 mainStr +='<li id="' + mianItemId + '"> <span style="color:#FF6700;font-weight:600;font-size:19px;">'+values3[v3][3]+' <i class="fa fa-arrow-right" aria-hidden="true"></i> '+values4[v4][3]+'</span></li>';
					                        		 
					                      			 (function(mianItemId,subIndex,subLevelId,attachRepIds,masterid) {
					            							 $.ajax({
					            				                    type: "GET",
					            				                    url: "AllFilesList.htm",
					            				                    data: { projectid: projectid, subid:subLevelId }, 
					            				                    datatype: 'json',
					            				                    success: function(additionalResult) {
					            				                        var additionalResult = JSON.parse(additionalResult);
					            				                        var additionalValues = Object.keys(additionalResult).map(function(e) {
					            				                            return additionalResult[e];
					            				                        });
					            				                        var additionalStr = '<ul>';
					            				                        for (var j = 0; j < additionalValues.length; j++) {
					            				                        	if(masterid==additionalValues[j][1]){
					            				                        	var subItemId = 'sub-item-' + subIndex + '-' + j;
					            				                            additionalStr +='<li id="' + subItemId + '" style="color:black;font-weight:600;font-size:18px;">'
					            				                            additionalStr += '<input class="form-check-input " type="checkbox" style=" width: 18px; height: 18px;margin-top:9px;" value="' + additionalValues[j][4] + '" id="checkbox' + j + '"';
					            				                            if(additionalValues[j][7]!=0){
					            				                            	if(attachRepIds.length>0 && attachRepIds.includes(additionalValues[j][4])){
					            					                            	   additionalStr += ' checked disabled>';
					            					                              }
					            				                            }else{
					            				                                additionalStr += ' disabled>';
					            				                            }
					            				                            additionalStr +='&nbsp;<span >' + additionalValues[j][3] + '</span>';
					            				                        	if(additionalValues[j][4]!=0){
					            				                        		 additionalStr +='&nbsp;&nbsp;<span class="version" style="color:grey">Ver '+additionalValues[j][8]+'.'+additionalValues[j][6];
					            				                        		 additionalStr +='<button type="radio" name="selectattach" class="btn"  style="background-color: transparent;margin: -5px 0px;"  onclick="FileDownload(\''+additionalValues[j][4]+'\')">';                                     
					            				                        		 additionalStr +='<i class="fa fa-download" aria-hidden="true" style="font-size:20px;"></i>';
					            				                        		 additionalStr +='</button> ';
					            				                        		 additionalStr += '</span>';
					            											}
					            			                        		 additionalStr += '<span><button type="button" class="btn" style="background-color: transparent;" title="Upload" onclick="fileUpload(\''+subItemId+'\')"><i class="fa fa-upload" aria-hidden="true" style="color: #0a5dff;font-size:20px;"></i></button>';
					            			                        		 additionalStr += '<label for="fileInput" id="uploadlabel'+subItemId+'" style="margin-left: 20px; display: none;">'
					            			                        		 additionalStr += '<input type="file" name="docFileInput" id="fileInput'+subItemId+'" required="required"  accept="application/pdf"/> '
					            			                        		 additionalStr += '<button type="submit" class="btn btn-sm back" onclick="fileSubmit(\''+subItemId+'\',\''+main+'\',\''+sub+'\',\''+mainLevelId+'\',\''+subLevelId+'\',\''+additionalValues[j][0]+'\',\''+additionalValues[j][7]+'\',\''+additionalValues[j][5]+'\',\''+additionalValues[j][6]+'\',\''+additionalValues[j][8]+'\',\''+ additionalValues[j][4] +'\', \''+additionalValues[j][3] +'\',\''+mainAgendaId+'\')">Upload</button>'
					            			                        		 additionalStr += '</label>'
					            			                        		 additionalStr += '</span>';
					            				                             additionalStr +='</li>'
					            				                        }
					            				                    }
					            				                        additionalStr += '</ul>';
					            				                        $('#' + mianItemId).append(additionalStr);
					            				                    }
					            				               });
					            						 })(mianItemId,subCounter,subLevelId,attachRepIds,masterid); 
					                        			 
					                        		 }
					                        	}
					                        }
					                        mainStr += '</ul>';
					                        $('#' + itemId).append(mainStr);
					                    }
					               });
								  })(projectid,itemId,itemCounter,main,sub,mainLevelId,subLevelId,attachRepIds);
					}
			     }
		      } 
		/* --------------------------------------------------tree making--------------------------------------------------------- */
				str += '</ul>';
				 if (projectid != null && projectid !== undefined && projectid.trim() !== '') {
			         $('#exampleModalCenter1 .modal-title').html('<span style="color: #F50057;font-weight:600;">Document Linking - ' + agendaname + '</span>');
			     } else {
			         $('#exampleModalCenter1 .modal-title').html('<span style="color: #F50057;font-weight:600;">Document Linking </span>');
			     }
			$('#fileuploadlist').html(str);
		}
    });
	$('#exampleModalCenter1').modal('show');
}

// Event delegation for dynamically added checkboxes
$(document).on('change', '.form-check-input', function() {
  // Send AJAX request with the selected checkbox value
  var selectedValue = $(this).val();
  var isChecked = $(this).prop('checked');
  var agendtype=$('#addoredit').val();
  
  if(isChecked){
	  if (agendtype==='add') {
      	setagendaattachval(selectedValue,'File');
      }else{
    	  $.ajax({
  	        url: 'addAgendaLinkFile.htm', 
  	        type: 'GET',
  	        data: { attachId: selectedValue,agendaId: mainAgendaId},
  	        success: function(response) {
  	        	 Swal.fire({
  	    	            icon: 'success',
  	    	            title: 'Success',
  	    	            text: 'Document linked successfully!',
  	    	            allowOutsideClick :false
  	    	          });
  	        	 $('#exampleModalCenter1').hide();
  	        	$('.swal2-confirm').click(function() {
  	                location.reload();
  	            });
  	        },
  	        error: function() {
  	          Swal.fire({
  	            icon: 'error',
  	            title: 'Error',
  	            text: 'An error occurred while submitting the checkbox selection.',
  	          });
  	        }
  	    });
      }
    }
});

function fileUpload(Id){
	 var label = document.getElementById("uploadlabel"+Id);
   if (label.style.display === "none") {
       label.style.display = "inline-block";
   } else {
       label.style.display = "none";
   }
}

function fileSubmit(value,main,sub,mainLevelId,subLevelId,docId,repid,filename,releaseDoc,version,attachid,attchName,agendaid) {
	
    var fileInput =  $("#fileInput"+value)[0].files[0];
    var modalHeaderContent = main+','+sub;
    var agendtype=$('#addoredit').val();
    
	 if (fileInput === undefined) {
	       Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: 'Please select a file to upload!',
	            allowOutsideClick :false
	       });
	       return;
	  }
	// Check if the file is a PDF
	   var fileType = fileInput.type;
	   if (fileType !== 'application/pdf') {
	       Swal.fire({
	           icon: 'error',
	           title: 'Invalid File Type',
	           text: 'Please select a PDF file!',
	           allowOutsideClick: false
	       });
	       return;
	   }
	   // Check if the file size is less than 10MB (10 * 1024 * 1024 bytes)
	   var fileSize = fileInput.size;
	   if (fileSize > 10 * 1024 * 1024) {
	       Swal.fire({
	           icon: 'error',
	           title: 'File Too Large',
	           text: 'Please select a file smaller than 10MB!',
	           allowOutsideClick: false
	       });
	       return;
	   }
    if (confirm("Are you sure to submit this?")) {
        event.preventDefault();
        var projectid = <%= projectid %>;
        var formData = new FormData();
        formData.append("file", $("#fileInput"+value)[0].files[0]);
        formData.append("FileRepId", repid);
        formData.append("projectid", projectid);
        formData.append("mainLevelId", mainLevelId);
        formData.append("subLevelId", subLevelId);
        formData.append("docId", docId);
        formData.append("FileNameUI", attchName);
        formData.append("FileVersion", version);
        formData.append("FileRelease", releaseDoc);
        formData.append("HeaderValue", modalHeaderContent);
        formData.append("agendaid", agendaid);
        formData.append("${_csrf.parameterName}", "${_csrf.token}");
        // Use AJAX to submit the form data
        $.ajax({
            url: 'DocFileUpload.htm',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
            	attachid=response;
            	 if (agendtype==='add') {
     	        	setagendaattachval(attachid,attchName);
     	        }else{
            	  Swal.fire({
		    	       	title: "Success",
		                text: "File Uploaded Successfully",
		                icon: "success",
		                allowOutsideClick :false
		         		});
            	  $('#exampleModalCenter1').hide();
            	  $('.swal2-confirm').click(function() {
  	                location.reload();
  	               });
            	}
            },
            error: function(xhr, status, error) {
            	  Swal.fire({
                      icon: 'error',
                      title: 'Error',
                      text: 'An error occurred while uploading the file'
                  });
                  console.log(xhr.responseText);
               }
          });
        
    } else {
        event.preventDefault();
        return false;
    }
}
</script>

</body>
</html>