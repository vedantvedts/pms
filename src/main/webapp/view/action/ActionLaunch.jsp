<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<!DOCTYPE html>
	<html>
	<head>                   
		<meta charset="ISO-8859-1">
		<jsp:include page="../static/header.jsp"></jsp:include>
		<script src="./resources/js/multiselect.js"></script>
		<link href="./resources/css/multiselect.css" rel="stylesheet"/>
		
		<title>New Action</title>
		<style type="text/css">
			label{
				font-weight: bold;
				font-size: 13px;
			}
			body{
				background-color: #f2edfa;
				overflow-x:hidden !important; 
			}
			h6{
				text-decoration: none !important;
			}
			.multiselect-container>li>a>label {
				padding: 4px 20px 3px 20px;
			}
			.cc-rockmenu {
				color:fff;
				padding:0px 5px;
				font-family: 'Lato',sans-serif;
			}

			.cc-rockmenu .rolling {
				display: inline-block;
				cursor:pointer;
				width: 34px;
				height: 30px;
				text-align:left;
				overflow: hidden;
				transition: all 0.3s ease-out;
				white-space: nowrap;
				
			}
			.cc-rockmenu .rolling:hover {
				width: 120px;
			}
			.cc-rockmenu .rolling .rolling_icon {
				float:left;
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
				padding: 0px 0;
				font-size: 14px;
				font-family: 'Muli',sans-serif;
			}

			.cc-rockmenu .rolling p {
				margin:0;
			}

			.width{
				width:150px !important;
			}
			.talign{
				style="text-align: center;"
			}
		</style>
	</head>
	
	<body>
		<%
		
		Object[] ActionData = (Object[])request.getAttribute("actiondata");
		List<Object[]> AllLabList = (List<Object[]>)request.getAttribute("AllLabList");
		List<Object[]> AssignedList=(List<Object[]>)request.getAttribute("AssignedList");
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
		List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
		Object[] projectdata = (Object[])request.getAttribute("ProjectData"); 
		List<Object[]> EmpListmodal=(List<Object[]>)request.getAttribute("EmployeeListModal");		
		String LabCode =(String)request.getAttribute("LabCode"); 
		String clusterid = (String)session.getAttribute("clusterid");
	%>



	<%String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert" >
			<%=ses1 %>
		</div></div>
		<%}if(ses!=null){%>
		<div align="center">
			<div class="alert alert-success" role="alert"  >
				<%=ses %>
			</div></div>
			<%} %>

			<div class="container-fluid">

				<div class="container" style="margin-bottom:20px;">
					
					<div class="card" style=" ">

						<div class="card-header" style="background-color: #055C9D;">
							<div class="row"> 

								<div class="col-sm-7" align="left"  >
									<h3 style="color: white;font-weight: bold;font-size: 1.2rem !important " align="left">
									<%if(ActionData!=null &&ActionData[2]!=null){%>
									             <%=ActionData[2]%>
									<%}else{%>
										New Action 
									<%}%>  For  Assignee 
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<%if(ActionData!=null &&ActionData[6]!=null){%>
									           PDC :  <%=sdf.format(ActionData[6])%>
										<%}%>
									</h3>
								</div>     
								<div class="col-sm-5" align="left" >       
									<div class="input-group">
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
					
					
					<div class="card-body">
						<form method="post"  action="ActionSubmit.htm" >
							<div class="row"> 
								<div class="col-sm-6" align="left"  >
									<div class="form-group">
										<label  >Action Item: <span class="mandatory" style="color: red;" >*</span>
										</label><br>
										<input class="form-control " type="text"name="Item" id="Item"  style="width:100% " maxlength="1000" required="required">
									</div>
								</div>

								<div class="col-sm-2" align="left"  >
									<div class="form-group">
										<label  >PDC: <span class="mandatory" style="color: red;">* </span>
										</label>
										<input class="form-control " name="DateCompletion" id="DateCompletion" required="required" placeholder="" >
									</div>
								</div>

								<div class="col-sm-4" align="left"  >
									<label > Type : 
									</label><br>
									<select class="form-control selectdee "  name="Project"  id="Project" required="required"   data-live-search="true" id="projectid" <%if(ActionData!=null && ActionData[5]!=null){%>disabled <%}%>>                                                     
										<option value="0" <%if(ActionData!=null && ActionData[5]!=null && "0".equalsIgnoreCase(ActionData[5].toString())){%> selected="selected" <%}%>>General</option>	
										<%if(projectdata!=null){%>
										    <option value="<%=projectdata[0] %>" <%if(projectdata!=null && projectdata[0]!=null && projectdata[0].toString().equalsIgnoreCase(ActionData[5].toString())){%> selected="selected" <%}%>><%=projectdata[1]%></option>
										<%}else{%>
										<%for(Object[] obj:ProjectList){%>
											<option value="<%=obj[0] %>" ><%=obj[4]%></option>	
										<%}}%>
									</select>	
								</div>
							</div>
							
							<div class="row" align="center">
								<div class="col-sm-3" align="left">
									<label> Action Type : </label><br>
									
									<select class="form-control selectdee " name="Type" id="ActionType"  required="required"  data-live-search="true" >                                                     
										<option value="A" >Action</option>	
										<option value="I" >Issue</option>
										<option value="K" >Risk</option>
									</select>	
								</div>
								
								<div class="col-sm-3" align="left">
									<label> Priority : </label>
									<br>
									<select class="form-control selectdee " name="Priority"  id="Priority" required="required"  data-live-search="true" >                                                     
										<option value="H" >High</option>	
										<option value="L" >Low</option>
										<option value="M" >Medium</option>
										<option value="I" >Immediate</option>
									</select>	
								</div>
								
								<div class="col-sm-3" align="left">
									<label> Category : </label>
									<br>
									<select class="form-control selectdee " name="Category" id="Category"  required="required"  data-live-search="true" >                                                     
										<option value="T" >Technical</option>	
										<option value="F" >Finance</option>
										<option value="M" >Managerial</option>
										<option value="L" >Logistic</option>
										<option value="O" >Others</option>
									</select>	
								</div>
				
								 <div class="col-sm-3" align="left" >
									<div class="form-group" id="OldList">
										<label > Old Action Id : </label><br>
										<select class="form-control selectdee " name="OldActionNo" id="OldActionNoId" hidden="hidden" data-live-search="true"  style="width:100% " ></select>
									</div>
									<b id="Message" style="font-size:14px;color: maroon " ></b>
								</div> 
							</div>
							<div class="row" align="center">
								<div class="col-sm-4" align="left"  ></div>
								<div class="col-sm-4" align="center"  ><br>
								            <input type="hidden" id="ActionLevel" <%if(ActionData!=null && ActionData[4]!=null){ %> value="<%=ActionData[4]%>" <%}%>>
									        <input type="hidden"  id="ActionPraentId" <%if(ActionData!=null && ActionData[1]!=null){ %> value="<%=ActionData[1]%>" <%}%>>
									        <input type="hidden"  id="Actiontype" <%if(ActionData!=null && ActionData[8]!=null){ %> value="<%=ActionData[8]%>" <%}%>>
									        <input type="hidden" id="MainId" <%if(ActionData!=null && ActionData[7]!=null){ %> value="<%=ActionData[7]%>" <%}%>>
									        <input type="button" id="Actionsubmit" class="btn  btn-sm submit" style="margin-top: 10px;" value="SUBMIT"/>
									        <input type="hidden" id="Actionscheduleid" <%if(ActionData!=null && ActionData[9]!=null){ %> value="<%=ActionData[9]%>" <%}else{%> value="0" <%}%>>									
										    <button  class="btn  btn-sm back" style="margin-top: 10px;" onclick="resetSubmit()" >Reset</button>
									        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />         				
									
								</div>			  
							</div>			    
						</form>
					</div>
				</div>
			</div>   
		</div>
		
		
		
		
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12">
					<div class="card shadow-nohover">
						
						<h3 class="card-header">Action Assigned List</h3>
						
						<div class="card-body">

							<div class="data-table-area mg-b-15">
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
													<table id="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
													<thead>

														<tr>
															<th>SN</th>
															<th style="text-align: left;">Action Item</th>
															<th class="width-110px">PDC</th>
															<th class="width-110px">Assigned Date</th>									
														 	<th>Assignee</th>	
														 	<th class="width-125px" style="width: 155.547px;">Progress</th>
														 	<th >Is Seen</th>
														 	<th >Action</th>
														</tr>
													</thead>
													<tbody>
														<%int  count=1;
															
														 	if(AssignedList!=null&&AssignedList.size()>0){
															for(Object[] obj: AssignedList){ %>
														<tr>
															<td style="width:1% !important; " class="center"><%=count %></td>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=obj[5] %></td>
															<td class="width-30px"><%=sdf.format(obj[4])%></td>
															<td style="width:8% !important; "><%=sdf.format(obj[3])%></td>
															<td style="width:16% !important; "><%=obj[1]%>, <%=obj[2]%></td>
															<td style="width:10% !important; "><%if(obj[11]!=null){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[11]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=obj[11]%>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																Not Yet Started .
															</div>
															</div> <%} %></td>
															<td class="talign">
														
																	<%if(obj[14].toString().equals("1")){ %>
																		<p style="color: green;">Seen</p>																		
																	<%}else if(obj[14].toString().equals("0")){ %>
																		<p style="color: red; font-weight: bold;">UnSeen</p>
																	<%} %>
														</td>
															
														<td >		
														 <form action="CloseAction.htm" method="POST" name="myfrm"  style="display: inline">
															<button  class="editable-click" name="sub" value="C">  
																<div class="cc-rockmenu">
											                      <div class="rolling">
											                        <figure class="rolling_icon"><img src="view/images/preview3.png"  ></figure>
											                        <span>Actions</span>
											                      </div>
											                     </div> 
															</button>
															
															 <%-- <button type="submit"  class="editable-click" name="ActionAssignid" value="<%=obj[15]%>" formtarget="blank"  formaction="ActionTree.htm" formmethod="POST"  >
																<div class="cc-rockmenu">
																<div class="rolling">	
																 <figure class="rolling_icon">
																<i class="fa fa-solid fa-sitemap"></i>
															    </figure>
															    <span> Tree</span>
															    </div>
															     </div>
															  </button>  --%>
															                  
															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														    <input type="hidden" name="ActionMainId" value="<%=obj[0]%>"/>
														    <input type="hidden" name="ActionAssignId" value="<%=obj[15]%>"/>
														 
														
														<%if(obj[11]==null && "0".equals(obj[16].toString())){ %>	
															
																<button type="button" onclick="Actioneditmodal('<%=obj[0]%>' , '<%=obj[15]%>'); ">
																	<div class="cc-rockmenu">
											                    	  <div class="rolling">
																		<figure class="rolling_icon"><img src="view/images/edit.png"></figure>
																		 <span>Edit</span>
																	  </div>
																	</div>
																</button>  
												            
                                                        <%} %>
											         	
											         		</form> 
														</td>
													</tr>
												<% count++; } }else{%>
												<tr>
													<td colspan="6" style="text-align: center">No List Found</td>
												</tr>
												<%} %>
												</tbody>
												</table>
														
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />


													</div>
												</div>
											</div>
										</div>
									</div>
								</div>

							</div>
							
						</div>

						
					</div>

				</div>

			</div>
			
			<div class="modal fade  bd-example-modal-lg" tabindex="-1" role="dialog" id="newfilemodal">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Action Edit</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body" align="center">
							<form action="ActionEditSubmit.htm" method="post" autocomplete="off" id="editform" >
								<table style="width: 100% ; padding: 15px;">
									<tr >
										<th style="padding: 10px 0px; width: 20% ;"> Action Item </th>
										<td style="padding: 10px 0px; "> 
											<textarea name="actionitem" class="form-control" id="modalactionitem" maxlength="500" required="required" rows="4" cols="60"></textarea>
										</td>
									</tr>
									<tr>
										<th>Lab</th>
										<td>
										<select class="form-control selectdee" name="modelAssigneeLabCode" id="modelAssigneelabcode" style=" width: 100% !important ;" onchange="AssigneeEmpListForEdit(0);" >
											 <%if(AllLabList!=null && AllLabList.size()>0){
											    for(Object[] lab : AllLabList){
											    	if(clusterid!=null && clusterid.equalsIgnoreCase(lab[1].toString())){
											 %>
												<option value="<%=lab[3] %>" <%if(LabCode.equals(lab[3].toString())){ %>selected <%} %>><%=lab[3] %></option>
											<%}}}%> 
											<option value="@EXP">Expert</option>
										</select>
										</td>
									</tr>
									<tr>
										<th style="padding: 10px 0px; width: 20% ;" >Assignee</th>
										<td style="padding: 10px 0px; width: 50% !important ;" >
											<select class="form-control selectdee"  name="Assignee" style=" width: 100% !important ;" id="modalassignee" required="required"  data-live-search="true"   data-placeholder="Select Assignee" >
												<%-- <%for(Object[] obj:EmpListmodal){ %>	
												<option value="<%=obj[0]%>"><%=obj[1]%>, <%=obj[2]%></option>	
												<%} %> --%>
											</select>
										</td>
									</tr>
									<tr>
										<th style="padding: 10px 0px; width: 20% ;"> PDC </th>
										<td style="padding: 10px 0px;  width: 30% ; "  >
											<input type="text" name="newPDC" value="" class="form-control" id="modalipdc1"  readonly required >
											<input type="text" name="newPDC1" value="" class="form-control" id="modalipdc2"  readonly required onclick="alert('PDC Revision Limit Exceded !!');">
										</td>
									</tr>
								</table>
								<button type="submit" class="btn btn-sm submit" id="modalsubmitbtn"  >SUBMIT</button>
								
								<input type="hidden" name="actionmainid" id="modalactionmainid" value="">
								<input type="hidden" name="actionassigneid" id="modalactionassignid" value="">
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
							</form>
						</div>
						
					</div>
				</div>
			</div>

			<div class="modal fade  bd-example-modal-lg" tabindex="-1" role="dialog" id="ActionAssignfilemodal">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Action Item : <b id="MainActionitem" ></b></h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body" >
							<form name="specadd" id="specadd" action="ActionSubmit.htm" method="post">
  
				   			<div class="row" >
								
									  <div class="col-2" ></div>
				  				      
			                          <div class="col-3" >
				                             <div class="form-group">
				                                      <label > Lab : <span class="mandatory" style="color: red;">* </span></label>
				                                       <br>
				                                       <select class=" form-control selectdee" style="width: 100%;" name="AssigneeLabCode" id="AssigneeLabCode" required="required" style="margin-top: -5px" onchange="AssigneeEmpList()" >
															<option disabled="disabled"  selected value="" >Choose...</option>
															<%if(AllLabList!=null && AllLabList.size()>0){	
																for (Object[] obj  : AllLabList) {
															if(clusterid!=null && clusterid.equalsIgnoreCase(obj[1].toString())){
															%>
														     	<option value="<%=obj[3]%>" <%if(LabCode!=null && LabCode.equalsIgnoreCase(obj[3].toString())){ %>selected <%} %> ><%=obj[3] %> </option>
															<%}}}%>
															<option value="@EXP"> Expert</option>
														</select>	
				                              </div>
			                         </div>
			
			
			                         <div class="col-4"  >
			                               <div class="form-group">
											    <label > Assignee : </label><br>
												<select class="form-control selectdee" style="width: 100%;" name="Assignee" id="Assignee" required="required"  data-live-search="true"  data-placeholder="Select Assignee" multiple>
													
												</select>
											</div>
									</div>
			 				</div>  
			 				<div  align="center">
			 								<input type="hidden" name="Atype" id="Atype">
			 								<input type="hidden" name="scheduleminutesid" id="scheduleid">
			 								<input type="hidden" name="MainActionId" id="MainActionId">
			 								<input type="hidden" name="ActionLevel"   id="actionlevel" >
			 								<input type="hidden" name="ActionParentid"   id="actionparentid" >
			 								<input type="hidden" name="ActionItem"   id="ActionItem" >
			 								<input type="hidden" name="MainPDC"   id="MainPDC" >
			 								<input type="hidden" name="Type"  id="MainActionType"  >
			 								<input type="hidden" name="ProjectId"  id="ProjectId" >
			 							    <input type="hidden" name="MainPriority"  id="MainPriority" >
			 								<input type="hidden" name="MainCategory"  id="MainCategory"  > 
			 								<input type="hidden" name="OldActionNoId"  id="OldActionNoId" >
			 				 				<input type="submit" name="sub" class="btn  btn-sm submit" form="specadd"  id="adding" value="SUBMIT"  onclick="return confirm('Are you sure To Submit?')"/>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />         				
											
							</div>	
 	<!-- Form End -->			
							</form>
						</div>
					</div>
				</div>
			</div><!-- model end -->

 
			<script type="text/javascript">
				function Actioneditmodal($actionid , $assignid)
				{
					
					$.ajax({		
						type : "GET",
						url : "ActionDetailsAjax.htm",
						data : {
							actionid : $actionid,
							assignid : $assignid
						},
						datatype : 'json',
						success : function(result) {
							var result = JSON.parse(result);
							$('#modalactionitem').html(result[1]);
							$('#modalactionmainid').val(result[0]);
							$('#modalactionassignid').val(result[6]);
							$('#modelAssigneelabcode').val(result[5]).trigger('change');
							AssigneeEmpListForEdit(result[2]);
							$('#modalassignee').val(''+result[2]).trigger('change');
							
							if(result[4]<2){
								
								$('#modalipdc1').show();
								$('#modalipdc2').hide();
								
								$('#modalipdc1').daterangepicker({
									
									"singleDatePicker" : true,
									"linkedCalendars" : false,
									"showCustomRangeLabel" : true,
									"startDate" : result[3],
									"cancelClass" : "btn-default",
									showDropdowns : true,
									locale : {
										format : 'DD-MM-YYYY'
									},
								});
							}else{
								$('#modalipdc1').hide();
								$('#modalipdc2').show();	
								$('#modalipdc2').val(result[3]);
							}
							$('#newfilemodal').modal('toggle');
						}
					});
					
					
				}

				
			</script>


			<!-- <script type="text/javascript">


				function changeempdd()
				{
					if (document.getElementById('allempcheckbox').checked) 
					{
						employeefetch('A');
					} else {
						
						employeefetch($('#projectid').val());
					}
				}
				
				function employeefetch(ProID){
					
					
					$.ajax({		
						type : "GET",
						url : "ProjectEmpListFetchAction.htm",
						data : {
							projectid : ProID
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
				
			</script>-->
			



			<script>
				
				$(function() {
					$('#chkveg').multiselect({
						includeSelectAllOption: true
					});
				});
	
				function AssigneeEmpListForEdit(empid){

				 	var $AssigneeLabCode =  $('#modelAssigneelabcode').val(); 

				 	if($AssigneeLabCode!=""){
				 		
				 		$.ajax({
				 			
				 			type : "GET",
				 			url : "ActionAssigneeEmployeeList.htm",
				 			data : {
				 				LabCode : $AssigneeLabCode,	
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

				 					s += '<option value="'+values[i][0]+'">'+values[i][1] + '(' +values[i][3]+')' + '</option>';
				 				} 
				 				
				 				$('#modalassignee').html(s);
				 				$('#modalassignee').val(''+empid).trigger('change');
				 			}
				 		});
				 		
				 	}
				 }			

			</script>   

			<script>
			$("#OldList").hide();
			$("#ItemDescriptionSearchBtn").click(function(){
				$('#OldActionNoId').empty();
				var $ItemSearch = $("#ItemDescriptionSearch").val();
				$("#loader ").show(); 				
				if ($ItemSearch === ""){
					alert("Search Content Requried");
					$("#loader ").hide();
				}else{
					
					$.ajax({

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
							
							if(size==0){
								document.getElementById('Message').innerHTML = " * Old Action Number doesn't Exist. Please Reset "; 
							}
							if(size!=0){
								document.getElementById('Message').innerHTML = " "; 
							}
							
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
				document.getElementById('Message').innerHTML = " "; 

			}
				$('#DateCompletion').daterangepicker({
					"singleDatePicker" : true,
					"linkedCalendars" : false,
					"showCustomRangeLabel" : true,
					 "minDate" : new Date(),
					<%if(ActionData!=null && ActionData[6]!=null){%>
					 "maxDate" : new Date('<%=ActionData[6]%>'), 
					<%}%>
					"cancelClass" : "btn-default",
					showDropdowns : true,
					locale : {
						format : 'DD-MM-YYYY'
					}
				});
				
				
				$('#Actionsubmit').click(function(){
					var $actionitem = $("#Item").val().trim();

						if($actionitem=="" || $actionitem==null|| $actionitem=="null" ||$actionitem==" "){
							alert("Please Enter Action item!");
						}else{
							$('#ActionAssignfilemodal').modal('toggle');
							
							var $Mainid = $("#MainId").val();
							var $MainPdc = $("#DateCompletion").val();
							var $type= $("#ActionType").val();
							var $projectid = $("#Project").val();
							var $priority    = $("#Priority").val();
							var $Actionlevel = $("#ActionLevel").val();
							var $Actionparentid = $("#ActionPraentId").val(); 
							var $Atype = $("#Actiontype").val();
							var $actionscheduleid = $("#Actionscheduleid").val();
							$("#scheduleid").val($actionscheduleid);
							$("#Atype").val($Atype);
							$("#MainActionId").val($Mainid);
							$("#actionlevel").val($Actionlevel);
							$("#actionparentid").val($Actionparentid);
							$("#ActionItem").val($actionitem);
							$("#MainPDC").val($MainPdc);
							$("#ProjectId").val($projectid);
							$("#MainActionType").val($type);
							$("#MainPriority").val($priority);
							$("#MainCategory").val($("#Category").val());
							$("#OldActionNoId").val($("#OldActionNoId").val());
							document.getElementById('MainActionitem').innerHTML =$("#Item").val();
							$('#DateCompletion1').daterangepicker({
								"singleDatePicker" : true,
								"linkedCalendars" : false,
								"showCustomRangeLabel" : true,
								"minDate" : new Date(),
								"maxDate" : $("#DateCompletion").val(), 
								"cancelClass" : "btn-default",
								showDropdowns : true,
								locale : {
									format : 'DD-MM-YYYY'
								}
							});
							AssigneeEmpList();
						}
					});
				
				$(document).ready(function(){	
				 	
					 AssigneeEmpList();
				 }); 	
				 

				function AssigneeEmpList(){
				 	
				 	$('#Assignee').val("");
				 	
				 	var $AssigneeLabCode = $('#AssigneeLabCode').val();
				 	var $ActionMainId = $("#MainActionId").val();
				 	var $parentid = $("#actionparentid").val();
				 	var $MainId;
				 	if($ActionMainId==0){
				 		$MainId=$parentid;
				 	}else{
				 		$MainId=$ActionMainId;
				 	}
				 
				 	if($AssigneeLabCode!=""){
				 		
				 		$.ajax({
				 			
				 			type : "GET",
				 			url : "ActionAssigneeEmployeeList.htm",
				 			data : {
				 				LabCode : $AssigneeLabCode,
				 				MainId  : $MainId,
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
				 					s += '<option value="'+values[i][0]+'">'+values[i][1] + '(' +values[i][3]+')' + '</option>';
				 				} 
				 				
				 				$('#Assignee').html(s);	
				 			}
				 		});
				 		
				 	}
				 }
				
				</script>
		</body>
		</html>