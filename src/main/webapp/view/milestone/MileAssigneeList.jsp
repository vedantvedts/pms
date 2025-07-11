<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Milestone Assignee List</title>
<style type="text/css">
label{
	font-weight: bold;
  font-size: 13px;
}
.table thead tr,tbody tr{
    font-size: 14px;
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

.hover:hover{
cursor: pointer;
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
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:210px !important;
}
.bootstrap-select {
	width: 400px !important;
}

.customTooltip {
  transition: opacity 0.2s ease;
  max-width: 450px;
  white-space: normal;
}
</style>
</head>
<body>
<%
  List<Object[]> MilestoneList=(List<Object[]>)request.getAttribute("MilestoneActivityList");
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  List<Object[]> totalAssignedMainList = (List<Object[]>)request.getAttribute("totalAssignedMainList");
  List<Object[]> totalAssignedSubList = (List<Object[]>)request.getAttribute("totalAssignedSubList");
  //Map<Long, Long> milestoneActivityIdsMap = (Map<Long, Long>)request.getAttribute("milestoneActivityIdsMap");
  Map<Long, Object[]> milestoneActivityLevelsMap = (Map<Long, Object[]>)request.getAttribute("milestoneActivityLevelsMap");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
 %>
 
 	<% String ses = (String) request.getParameter("result"); 
       String ses1 = (String) request.getParameter("resultfail");
       if (ses1 != null) { %>
        <div align="center">
            <div class="alert alert-danger" role="alert">
                <%= ses1 %>
            </div>
        </div>
    <% } if (ses != null) { %>
        <div align="center">
            <div class="alert alert-success" role="alert">
                <%= ses %>
            </div>
        </div>
    <% } %>
    
	<form class="form-inline"  method="POST" action="M-A-AssigneeList.htm">
  		<div class="row W-100" style="width: 100%;">

  			<div class="col-md-7">
   
	  			<p>
	  				<b style="color: #145374;"><span class="label label-primary"> &nbsp;&nbsp;&nbsp;&nbsp; Project &nbsp; </span> </b>
	  				<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
					<b style="color: #145374;"><span class="label label-warning">&nbsp;Accept&nbsp;</span></b>
					<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
					<b style="color: #145374;"><span class="label label-success">&nbsp;&nbsp;Update Progress&nbsp;&nbsp;</span></b>
      			</p>
	                     
  			</div>
			<div class="col-md-2" style="text-align: right;">
			   <label class="control-label" >Project Name :  </label>
			</div>
			<div class="col-md-2" style="margin-top: -5px;">
     			<select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId" onchange="this.form.submit()">
     				<option disabled="disabled"  selected value="">Choose...</option>
     				<% for (Object[] obj : ProjectList) {
    					String projectshortName=(obj[17]!=null)?" ("+obj[17].toString()+") ":""; %>
	 					<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>><%=obj[4]+projectshortName%>  </option>
	 				<%} %>
     			</select>
			</div>
 			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 		</div>
	</form>
	
	<br />
	
	<div class="container-fluid" >
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -20px;">
					<div class="row card-header">
			     		<div class="col-md-10">
							<h5 >
								<%if(ProjectId!=null){
									Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");
								%>
									<%=ProjectDetail[2] %> (<%=ProjectDetail[1]%>) 
								<%} %>
					 			Milestone List
					 		</h5>
						</div>
						<div class="col-md-2 justify-content-end" style="float: right;">
				
					 	</div>
					</div>
					<div class="card-body">
                    	<div class="table-responsive"> 
							<table class="table table-condensed table-striped table-hover table-bordered" id="myTable" style="width: 100%;">
								<thead class="center">
									<tr>
										<th width="3%">SN</th>
										<th width="2%">Main</th>
									    <th width="9%">Sub</th>
										<th width="22%">Milestone Activity</th>
										<th width="8%">Start Date</th>
										<th width="8%">End Date</th>	
										<th width="15%">First OIC</th>
										<th width="8%">Status</th>
										<th width="5%">Weightage</th>	
										<th width="10%">Progress</th>												
									 	<th width="10%">Action</th>
									</tr>
								</thead>
								<tbody>
									<%
									int slno = 0;
									if(totalAssignedMainList!=null && totalAssignedMainList.size()>0) {
										for(Object[] obj : totalAssignedMainList) {
									%>
										<tr>
											<td class="center">
												<%=++slno %>
											</td>
											<td class="center">M<%=obj[5]%></td>
											<td class="center"></td>
											<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;">
												<%=obj[4] %>
											</td>
											<td class="center"><%=sdf.format(obj[2])%></td>
											<td class="center"><%=sdf.format(obj[3])%></td>
											<td><%=obj[6]%></td>
											<td class="center">-</td>
											<td class="center"><%=obj[13]%></td>	
											<td>
												<%if(!obj[12].toString().equalsIgnoreCase("0")){ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
														<div class="progress-bar progress-bar-striped
															<%if(obj[14].toString().equalsIgnoreCase("2")){ %>
																bg-success
															<%} else if(obj[14].toString().equalsIgnoreCase("3")){ %>
																bg-info
															<%} else if(obj[14].toString().equalsIgnoreCase("4")){ %>
																bg-danger
															<%} else if(obj[14].toString().equalsIgnoreCase("5")){ %>
																bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=obj[12] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=obj[12] %>
														</div> 
													</div> 
												<%}else{ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
														</div>
													</div> 
												<%} %>
											</td>
											<td>		
												<%if(obj[8]!=null&&"Y".equalsIgnoreCase(obj[10].toString())){ %>
                        	                		<button type="button" class="btn edit" title="Update Remarks" onclick="getCommentBox('<%=obj[0] %>','<%=obj[5] %>','<%=obj[15]!=null? obj[15].toString().replaceAll("\n", " ").replaceAll("\r", " "):"" %>','<%=obj[16] %>')"  data-toggle="tooltip" data-placement="top" data-original-data="Remarks" title="Remarks">
                        	                		 <i class="fa fa-comment" aria-hidden="true" ></i>
                        	                		 </button>
												<%} %>
												<%if("A".equalsIgnoreCase(obj[10].toString())&&((Long) session.getAttribute("EmpId")).toString().equals(obj[11].toString())){ %> 
                                                	<form action="MilestoneActivityUpdate.htm" method="POST" name="myfrm"  style="display: inline">
                                                    	<button  class="editable-click" name="sub" value="Accept"  formaction="M-A-Assign-OIC.htm" onclick="return confirm('Are You Sure To Accept?')" >
															<div class="cc-rockmenu">
																<div class="rolling">	
											                    	<figure class="rolling_icon"><img src="view/images/accept.jpg" ></figure>
											                        <span>Accept</span>
											                    </div>
											   				</div>
											    		</button> 
											            <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														<input type="hidden" name="MilestoneActivityId" value="<%=obj[0]%>"/>
														<input type="hidden" name="RevId" value="<%=obj[8]%>"/>
														<input type="hidden" name="projectid" value="<%=ProjectId%>"/>
															
												    </form> 
												    
								                  	<form action="MilestoneActivityUpdate.htm" method="POST" name="myfrm"  style="display: inline">
								                    	<button type="button"  class="editable-click" name="sub" value="Back"   data-toggle="modal" data-target="#exampleModal<%=obj[0]%>" data-whatever="@mdo" >
															<div class="cc-rockmenu">
																<div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/sendback.jpg" ></figure>
											                        <span>Send Back</span>
											                	</div>
											           		</div>
											        	</button> 
											       		<input type="hidden" name="projectid" value="<%=ProjectId%>"/>
											            <div class="modal fade" id="exampleModal<%=obj[0]%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                              				<div class="modal-dialog">
                                          						<div class="modal-content">
                                             						<div class="modal-header">
                                            							<h5 class="modal-title" id="exampleModalLabel">Add Remarks</h5>
                                   										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    										<span aria-hidden="true">&times;</span>
                                      									</button>
                                        							</div>
                                         							<div class="modal-body">
          	                                  							<div class="row">
                       				 
										                                     <div class="col-md-12">
																				<div class="form-group">
																					<label class="control-label">Remark</label> 
																				    <textarea class="form-control" name="Remarks" style="height: 9rem;" maxlength="255" required="required" placeholder="Enter Send Back Remark here with max 255 characters"></textarea>
																				</div>
																			</div>       
                                         								</div>
                                       									<div class="modal-footer">
                                         									<button class="btn btn-sm btn-danger"   name="sub" value="Back"  formaction="M-A-Assign-OIC.htm" onclick="return confirm('Are You Sure To Send Back ?')">SendBack</button>
                                                						</div>
                                                 					</div>
                                                   				</div>
                                                  			</div>
											           	</div>       
											            <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														<input type="hidden" name="MilestoneActivityId" value="<%=obj[0]%>"/>
													</form> 
												<% } %>
																		
											</td>
		
										</tr>
									<%} }%>
									
									<%if(totalAssignedSubList!=null && totalAssignedSubList.size()>0) {
										for(Object[] obj : totalAssignedSubList) {
											Object[] levelsMapData = milestoneActivityLevelsMap.get(Long.parseLong(obj[0].toString()));
									%>
										<tr>
											<td class="center"><%=++slno %> </td>
											<td class="center"><%=levelsMapData[2] %></td>
											<td class="center"><%=levelsMapData[1] %> </td>
											<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;">
												<%=obj[4] %>
											</td>
															
											<td class="center"><%=sdf.format(obj[2])%></td>
											<td class="center"><%=sdf.format(obj[3])%></td>
											<td><%=obj[14] %></td>		      
											<td>
												<%if(obj[9].toString().equalsIgnoreCase("3")||obj[9].toString().equalsIgnoreCase("5")){ %>
													<%if(obj[7]!=null){ %>
														<%=sdf.format(obj[7]) %>
													<%}else{ %>
														<%=obj[8] %>
													<%} %>
												<%}else{ %>
													<%=obj[8] %>
												<%} %>
												
											</td>
											<td class="center"><%=obj[6] %></td>
											<td>
												<%if(!obj[5].toString().equalsIgnoreCase("0")){ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
														<div class="progress-bar progress-bar-striped
															<%if(obj[9].toString().equalsIgnoreCase("2")){ %>
																bg-success
															<%} else if(obj[9].toString().equalsIgnoreCase("3")){ %>
																bg-info
															<%} else if(obj[9].toString().equalsIgnoreCase("4")){ %>
																bg-danger
															<%} else if(obj[9].toString().equalsIgnoreCase("5")){ %>
																bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=obj[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=obj[5] %>
														</div> 
													</div> 
												<%}else{ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
														</div>
													</div> 
												<%} %>
											</td>
                                                      
											<td>
												<%if(obj[22]!=null && Integer.parseInt(obj[22].toString())==0){
													if(Integer.parseInt(obj[5].toString())<100) { 
														if(!obj[10].toString().equalsIgnoreCase("0")){ 
															if(Integer.parseInt(obj[6].toString())>0){
																String activityType = "";
																int activityLevelId = obj[23]!=null?Integer.parseInt(obj[23].toString()):0;
																if(activityLevelId==1) {
																	activityType = "A";
																}else if(activityLevelId==2) {
																	activityType = "B";
																}else if(activityLevelId==3) {
																	activityType = "C";
																}else if(activityLevelId==4) {
																	activityType = "D";
																}else if(activityLevelId==5) {
																	activityType = "E";
																}
																%>
																<%-- <%if(obj[24]!=null &&  !obj[24].toString().equalsIgnoreCase("0")  && !obj[25].toString().equalsIgnoreCase("Y")) {%>
                                                         		<span class="hover text-primary" style="color:blue ; font-weight: bold" onmouseover="showContent('<%=obj[24].toString() %>',this)">Linked Milestone </span>
                                                         			<div class="customTooltip" id="customTooltip<%=obj[24].toString() %>" style="position:absolute; display:none; z-index:9999; background:#fff; border:1px solid #ccc; padding:8px 10px; border-radius:6px; box-shadow: 0 2px 8px rgba(0,0,0,0.15); font-size:13px; color:#333; pointer-events:none;"></div>
                                                         	
                                                         		<%}else{ %> --%>
                                                         		<form class="form-inline"  method="POST" action="M-A-Update.htm">
                        	                                  		<button class="btn edit"  data-toggle="tooltip" data-placement="top"  title="UPDATE"> <i class="fa fa-wrench"  aria-hidden="true"></i> </button>
                                                                 	<input type="hidden" name="MilestoneActivityId"	value="<%=levelsMapData[0] %>" /> 
                                                                  	<input type="hidden" name="ActivityId" value="<%=obj[0] %>" /> 
                                                                  	<input type="hidden" name="startdate" value="<%=obj[2].toString() %>" >
                                                                  	<input type="hidden" name="ProjectId" value="<%=ProjectId %>" /> 
                                                                  	<input type="hidden" name="ActivityType" value="<%=activityType %>" /> 
                                                                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                                                        		</form>
                                                        	<%-- 	<%} %> --%>
                                           					<%}else{ %>
                                                            	Weightage Not Set 
                                                                   
                                                        <%}}else{ %>
                                                        	Base Line Not Set
                                                 	<%} }else{ %> 
                                                    	Completed 
                                                	<%} %>
                                            	<%} %>
                                        	</td>	
										</tr>
									<%} } %>
										
									<%if(slno==0) {%>
										<tr >
											<td colspan="9" style="text-align: center" class="center">No List Found</td>
										</tr>
									<%} %>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
		<div class="row m-1">
		<div class="col-md-12"
			style="text-align: center; width: 140px; height: 30px;color: green;">
			<b>Milestone Flow </b>
		</div>
	</div>
	
	<div class="row m-1"
		style="text-align: center; padding-top: 10px; padding-bottom: 15px;">

		<table align="center" style="border-spacing: 0 20px;">
		<tr>
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
				<b class="text-primary">Add Milestone Activity</b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Add Sub Milestone Activity </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Assign Weightage </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Assign Milestone Activity </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Set Baseline </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Assignee</b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary"> Acknowledge Milestone Activity </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Update progress</b>
				</td>
			</tr>
			
		</table>



	</div>
	<br> 
	<br>
	<br>
		
	
	
	<div class="modal fade my-modal" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
 	    	<div class="modal-content">
 	      		<div class="modal-header">
 	        		<h5 class="modal-title" id="exampleModalLongTitle"></h5>
		  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		  	          <span aria-hidden="true">&times;</span>
		  	        </button>
  	     	 	</div>
  	      		<div class="modal-body"> 
  	      
  	      			<form action="MileRemarkUpdate.htm" method="POST" autocomplete="off">
  	      				<div class="row">
  	      		    
							<div class="col-md-12" style="display: none;">Financial Outlay : <br>
								<input class="form-control" title="Enter Number" name="financialoutlay" id="financialoutlay" type="text"   maxlength="9" required="required" value="0">
							</div>
					 		<br>
							<div class="col-md-12"> Remarks :<br>
  	      		    			<textarea class="form-control" name="Remarks" id="remarks" required="required" maxlength="2000"> </textarea>
  	      		    		</div>
  	      				</div>
  	      				<br>
		  	      		<div align="center">
		  	      			<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
		  	      		</div>
		  	      		<br>

		                <input type="hidden" name="projectid" value="<%=ProjectId%>"/>
		  	      		<input type="hidden" name="MileId" value="" id="milId"/>
		  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		  	      	</form>
  	      		</div>
	  	      	<div class="modal-footer">
	 	      	</div>
  	    	</div>
		</div>
	</div>
			
						
</body>

<script>
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"minDate" : new Date(),
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

	$('#DateCompletion2').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : new Date(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	
	
	function getCommentBox(id,mile,remarks,financeoutlay){

		$('#exampleModalCenter').modal('toggle');
		$("#milId").val(id);
		$("#financialoutlay").val("");
		$("#remarks").val("");
		if(remarks!="null" && financeoutlay!="null"){
			$("#financialoutlay").val(financeoutlay);
			$("#remarks").val(remarks);
		}
		$("#exampleModalLongTitle").html('Milestone '+mile);
	}
	
	
	
	setPatternFilter($("#financialoutlay"), /^-?\d*$/);
	function setPatternFilter(obj, pattern) {
		  setInputFilter(obj, function(value) { return pattern.test(value); });
		}

	function setInputFilter(obj, inputFilter) {
		  obj.on("input keydown keyup mousedown mouseup select contextmenu drop", function() {
		    if (inputFilter(this.value)) {
		      this.oldValue = this.value;
		      this.oldSelectionStart = this.selectionStart;
		      this.oldSelectionEnd = this.selectionEnd;
		    } else if (this.hasOwnProperty("oldValue")) {
		      this.value = this.oldValue;
		      this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
		    }
		  });
		}
	
	$(document).ready(function() {

			$('[data-toggle="tooltip"]').tooltip()
		
        $('#myTable').DataTable({
            "lengthMenu": [ 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 100],
            "pagingType": "simple",
            "pageLength": 15
        });
    });
	
	
	function showContent(a,ele){
		$.ajax({
			type:'GET',
			url:'MilestoneLinked.htm',
			datatype:'json',
			data:{
				id:a,
			},
			success:function(result){
				
				var ajaxresult = JSON.parse(result);
			
				var val="";
					for (var key in ajaxresult) {
					  if (ajaxresult.hasOwnProperty(key)) {
						   
					    if(key===a){val = ajaxresult[key];}
					
					  }
					}
					
					
					var arr = val.split("/");
			
					// Tooltip handlers
					   ele.addEventListener("mousemove", function (e) {
					        var tooltip = document.getElementById("customTooltip"+a);
					        tooltip.style.display = "block";
					      /* tooltip.style.left = (e.pageX + 15) + "px";
					        tooltip.style.top = (e.pageY + 10) + "px"; */
					        tooltip.innerHTML =
					        	"<span style='font-weight:bold'>Project Code </span>: "+arr[2]+"<br> <span style='font-weight:bold'>Milestone Name: <br></span>"
					        	+arr[1] + "<br> ( " + arr[0] +" )";
					   }); 
					
					   ele.addEventListener("mouseleave", function () {
					        var tooltip = document.getElementById("customTooltip"+a);
					        tooltip.style.display = "none";
					    }); 
					; 
			}
		})
	}
	
	
	</script>  

</html>