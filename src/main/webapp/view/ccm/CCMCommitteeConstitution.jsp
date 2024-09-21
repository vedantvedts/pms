<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">
.input-group-text {
	font-weight: bold;
}

label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

hr {
	margin-top: -2px;
	margin-bottom: 12px;
}

.card b {
	font-size: 20px;
}

.left {
	text-align: left !important;
}
.center{
	text-align: center !important;
}
.right{
	text-align: right !important;
}

.vertical-line {
	border-left: 2px solid black; /* The thickness and color of the line */
	height: 100px; /* The height of the line */
	margin: 0 20px; /* Optional: space around the line */
}		
</style>
	
</head>
<body>
<%

List<Object[]> allLabList = (List<Object[]>)request.getAttribute("allLabList");
List<Object[]> employeeList =(List<Object[]>)request.getAttribute("employeeList");
List<Object[]> employeeList1 =(List<Object[]>)request.getAttribute("employeeList1");
List<Object[]> expertList =(List<Object[]>)request.getAttribute("expertList");
List<Object[]> committeeMembersAll = (List<Object[]>)request.getAttribute("committeeMembersAll");

Object[] chairperson = committeeMembersAll!=null && committeeMembersAll.size()>0 ? committeeMembersAll.stream()
					   .filter(e -> e[8].toString().equalsIgnoreCase("CC")) 
					   .findFirst().orElse(null) : null;

Object[] co_chairperson = committeeMembersAll!=null && committeeMembersAll.size()>0 ? committeeMembersAll.stream()
					   .filter(e -> e[8].toString().equalsIgnoreCase("CH")) 
					   .findFirst().orElse(null) : null;

Object[] secretary = committeeMembersAll!=null && committeeMembersAll.size()>0 ? committeeMembersAll.stream()
					   .filter(e -> e[8].toString().equalsIgnoreCase("CS")) 
					   .findFirst().orElse(null) : null;

Object[] proxysecretary = committeeMembersAll!=null && committeeMembersAll.size()>0 ? committeeMembersAll.stream()
					   .filter(e -> e[8].toString().equalsIgnoreCase("PS")) 
					   .findFirst().orElse(null) : null;

String labCode = (String)session.getAttribute("labcode");
String committeeMainId = (String)request.getAttribute("committeeMainId");
String committeeId = (String)request.getAttribute("committeeId");

ObjectMapper objectMapper = new ObjectMapper();
String jsonemployeeList1 = objectMapper.writeValueAsString(employeeList1);
String jsonchairperson = objectMapper.writeValueAsString(chairperson);
String jsonco_chairperson = objectMapper.writeValueAsString(co_chairperson);
String jsonsecretary = objectMapper.writeValueAsString(secretary);
String jsonproxysecretary = objectMapper.writeValueAsString(proxysecretary);

jsonemployeeList1 = jsonemployeeList1.replace("\\", "\\\\").replace("\"", "\\\"")
					.replace("\b", "\\b").replace("\f", "\\f")
					.replace("\n", "\\n").replace("\r", "\\r")
					.replace("\t", "\\t");

%>
	<% String ses=(String)request.getParameter("result");
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
			<div class="alert alert-success" role="alert" >
		    	<%=ses %>
			</div>
		</div>
	<%} %>
	
	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
 			<div class="card-header" style="background-color: transparent;">
 				<div class="row">
 					<div class="col-md-3">
 						<h3 class="text-dark">Committee Constitution
 							<a class="btn btn-info btn-sm shadow-nohover back mb-2" href="CCMModules.htm">
	 							<i class="fa fa-home" aria-hidden="true" style="font-size: 1rem;"></i> 
	 							CCM
 							</a> 
 						</h3>
 					</div>
 					<div class="col-md-8"></div>
 					<div class="col-md-1">
 						<a class="btn btn-info btn-sm shadow-nohover back" id="schedule-btn" href="CCMSchedule.htm?committeeFlag=Y&committeeMainId=<%=committeeMainId%>&committeeId=<%=committeeId%>">
 							<i class="fa fa-clock-o" aria-hidden="true"></i>
 							Schedule
 						</a>
 					</div>
 				</div>
       		</div>
       		<div class="card-body">
       			<form action="CCMCommitteeSubmit.htm" method="post" id="committeeeditfrm">	
       				<div class="form-group">
						<div class="row">
							<div class="col-md-2"></div>
							<%-- <div class="col-md-1">
								<label class="control-label" style="">Lab Name<span class="mandatory" style="color: red;">*</span></label>
							</div>		
							<div class="col-md-2">
								<select class="form-control selectdee" name="CpLabCode" tabindex="-1" required="required" id="CpLabCode" onchange="chairpersonfetch('0')">
									<option disabled="disabled"  selected value="">Lab Name</option>
										<% for (Object[] obj : allLabList) {%>
											<option <%if(chairperson!=null && chairperson[9].toString().equals(obj[3].toString())){ %>selected <%} %>value="<%=obj[3]%>"><%=obj[3]%></option>
									    <%} %>
									<option <%if(chairperson!=null && chairperson[9].toString().equalsIgnoreCase("@EXP")){ %>selected <%} %>value="@EXP">Expert</option>
								</select>
							</div> --%>
							
							<div class="col-md-2">
								<label class="control-label" style="">Chairperson<span class="mandatory" style="color: red;">*</span></label>
							</div>	
							<div class="col-md-2">
								<select class="form-control dynamicdropdown" name="chairperson" id="chairperson" data-live-search="true" required="required"   data-placeholder="Select Chairperson" >
											             
								</select>	
								<%if(chairperson!=null) {%>
									<input type="hidden" name="cpmemberid"  value="<%=chairperson[0]%>" >
								<%} %> 
							</div>		
							
							<div class="col-md-2">
								<label class="control-label" style="">Co-Chairperson</label>
							</div>	
							<div class="col-md-2">
								<select class="form-control dynamicdropdown" id="co_chairperson" required="required" name="co_chairperson">
					    			
					  			</select>
					  			<%if(co_chairperson!=null){ %>
					  				<input type="hidden" name="comemberid"value="<%=co_chairperson[0]%>">
					  			<%} %>	
							</div>		
							
							<div class="col-md-2"></div>
						</div>	
					</div>
					<div class="form-group">
						<!-- <hr class="mt-3 mb-3"> -->
						
						<div class="row">
							<div class="col-md-2"></div>
							<%-- <div class="col-md-1">
								<label class="control-label" style="">Lab Name<span class="mandatory" style="color: red;">*</span></label>
							</div>		
							<div class="col-md-2">
								<select class="form-control selectdee" name="msLabCode" tabindex="-1" required="required" id="mSLabCode" onchange="msfetch('0')">
									<option disabled="disabled"  selected value="">Lab Name</option>
								    <% for (Object[] obj : allLabList) {%>
									    <option <%if(secretary!=null && secretary[9].toString().equals(obj[3].toString())){ %>selected <%} %>value="<%=obj[3]%>"><%=obj[3]%></option>
								    <%} %>
								    <option <%if(secretary!=null && secretary[9].toString().equalsIgnoreCase("@EXP")){ %>selected <%} %>value="@EXP">Expert</option>
								</select>
							</div> --%>
							
							<div class="col-md-2">
								<label class="control-label" style="">Member Secretary<span class="mandatory" style="color: red;">*</span></label>
							</div>	
							<div class="col-md-2">
								<select class="form-control dynamicdropdown" name="Secretary" id="secretary" data-live-search="true" required="required"   data-placeholder="Select Member secretary" >
													             
								</select>	
								<%if(secretary!=null){ %>
					  				<input type="hidden" name="msmemberid" value="<%=secretary[0]%>">
					  			<%} %>						
							</div>		
							
							<div class="col-md-2">
								<label class="control-label" style="">Member Secretary (Proxy)</label>
							</div>	
							<div class="col-md-2">
								<select class="form-control dynamicdropdown" id="proxysecretary" required="required" name="proxysecretary"style="margin-top: -5px">
		    						
					  			</select>
					  			<%if(proxysecretary!=null){ %>
					  				<input type="hidden" name="psmemberid" value="<%=proxysecretary[0]%>">
					  			<%}%> 
							</div>	
							
							<div class="col-md-2"></div>	
						</div>	
					</div>	
					<!-- <hr class="mt-3 mb-3"> -->
					
					<div class="row">			
						<div class="col-md-12" align="center">
					    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />                  	
							<input type="hidden" name="committeemainid" value="<%=committeeMainId%>"> 
							<input type="hidden" name="committeeId" value="<%=committeeId%>"> 
							<%if(chairperson!=null) {%>
								<button type="submit" class=" btn btn-sm edit" name="action" value="Edit" onclick="Add('committeeeditfrm')" >UPDATE</button>
							<%} else{%>
								<button type="submit" class=" btn btn-sm submit" name="action" value="Add" onclick="Add('committeeeditfrm')" >SUBMIT</button>
							<%} %>
				            
				        </div> 
					</div>
			              
				</form>
				
				<br>
				
				<!-- 	------------------------------------------------------------------------------- internal and Expert Members----------------------------------------------------------
 				-->			
 				<%
 				List<Object[]>tempcommitteemembersall=new ArrayList<>();
 				List<String>memberTypes=Arrays.asList("CC","CS","PS","CH");
 				if(committeeMembersAll.size()>0) 
 				{
 					tempcommitteemembersall = committeeMembersAll.stream().filter(i->!memberTypes.contains(i[8].toString())).collect(Collectors.toList());
 					tempcommitteemembersall = tempcommitteemembersall.stream().sorted(Comparator.comparingInt(e -> Integer.parseInt(e[11].toString()))).collect(Collectors.toList());
 				}
 				%>
 				
 				<%-- <%if(tempcommitteemembersall.size()>0 ){ %>
 					<hr  style="padding-top: 5px;padding-bottom: 5px;">
 				<%} %> --%>
 				
 				<%if(tempcommitteemembersall.size()>0 ){ %>
 					<hr  style="padding-top: 5px;padding-bottom: 5px;">
 				<%} %>
 				
 				<%if(tempcommitteemembersall.size()>0 ){ %>
 					<div class="row">
 						<div class="col-md-2"></div>
							<div class="col-md-7">
								<form action="MemberSerialNoUpdate.htm" method="POST">
									<table  class="table table-bordered table-hover table-striped table-condensed ">
					            	<thead>
					               		<tr>
					               			<th style="width:170px;text-align: center"> Sl No.</th>
					               			<th >Participants</th>			                    	
					                    	<th>Est</th>
					                    	<th>Action</th>
					                    </tr>
					              	</thead>
		              				<tbody>
		              					<%int count=0;
		              						for(Object[]obj:tempcommitteemembersall){%>
		              							<tr>
		              								<td style="display: flex;justify-content: center;align-items: center;">
		            									<input type="number" class="form-control" name="newslno" value="<%=obj[11] %>" min="1" max="<%=tempcommitteemembersall.size()%>" style="width:50%"> 
		              									<input type="hidden" name="memberId" value="<%=obj[0].toString() %>">
		              								</td>
									              	<td><%=obj[2].toString() %>, <%=obj[4].toString() %></td>
									              	<td> 
														<%  if(obj[9].toString().equalsIgnoreCase("@EXP")) 
																out.println(obj[12]);
															else
																out.println(obj[9]);
														%>
													</td>
													<td align="center">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
												        <input type="hidden" name="committeemainid" value="<%=committeeMainId%>">
												        <input type="hidden" name="committeeId" value="<%=committeeId%>">
												        <input type="hidden" name="ccmflag" value="Y">
														<button class="fa fa-trash btn btn-danger" type="submit" style="background-color: white;border-color: white;"
														formnovalidate="formnovalidate" formaction="CommitteeMemberDelete.htm" formmethod="POST" name="committeememberid" value="<%=obj[0] %>"
													  	onclick="return confirm('Are You Sure To Delete this Member?');" ></button>
								
													</td>
		              							</tr>
		              						<%}%>
		              					<tr>
		              						<td colspan=1 style="display: flex;justify-content: center;align-items: center">
			              						<input type="hidden" name="committeemainid" value="<%=committeeMainId%>">
			              						<input type="hidden" name="committeeId" value="<%=committeeId%>">
			              						<input type="hidden" name="ccmflag" value="Y">
			              						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
			              						<button class="btn btn-sm edit" onclick="return slnocheck('serialnoupdate');">UPDATE</button>
		              						</td>
		              						<td colspan=3></td>
		              					</tr>
		              				</tbody>
		              			</table>
		              		</form>
		              	</div>
 					</div>	
 				<%} %>
 				
 				<hr>
				<br>
				
	     		<%-- <div class="row" >	
					<table align="center">
						<tr>
							<td>				
								<button class="btn btn-primary btn-sm back" type="button"  onclick="submitForm('backfrm');">BACK</button> 						
							</td> 
 							<td>
								<form  method="post" action="CommitteeConstitutionLetter.htm" target="_blank" >
									<button  type="submit" class="btn btn-sm preview"  >LETTER</button>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
									<input type="hidden" name="committeemainid" value="<%=committeemainid%>">
									<input type="hidden" name="ccmflag" value="Y">
								</form>
							</td>
							<td>
								<form  method="post" action="CommitteeConstitutionLetterDownload.htm" target="_blank" >
									<button  type="submit"  class="btn btn-sm edit"  ><i class="fa fa-download" style="   font-size: 0.90rem; " ></i></button>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />    												
									<input type="hidden" name="committeemainid" value="<%=committeemainid%>">
								</form>
							</td>
							<td>
				               	<form  action="SendFormationLetter.htm" method="post" >  						             
				                	<button type="submit" onclick="inviteform()" class=" btn btn-sm prints"  ><i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbsp; EMAIL</button>
				              		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />  
				              		<input type="hidden" name="committeemainid" value="<%=committeemainid%>">
				              	 </form>
		             		</td>	
						</tr>
					</table>
				</div>	 --%>
	       		
	       		<br>
	       		<!-- ------------------------------------- add new members ---------------------------------------------------------------- -->
				<label  style="margin-bottom: 4px !important" for="repids"> Add More Members</label>
				<hr>
				<div class="row">
					<!-- -------------------------------------- Internal members -------------------------------------------- -->
					<div class="col-md-4" style="">
						<form action="CommitteeMainMembersSubmit.htm" method="post" name="editfrm" id="editfrm" >				
							<div class="row">				
								<div class="col-md-9">
									<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="" style="margin-top: 10px;width:100%">
										<thead>  
											<tr>
												<th> Internal Members</th>
											</tr>
										</thead>								
										<tbody>
											<tr class="tr_clone">
												<td>
													<div class="input select">
														<select class="form-control selectdee " name="InternalMemberIds" data-live-search="true" required  data-placeholder="Select Members" multiple style="width:400px">
										                <%for(Object[] obj:employeeList){ %>																							
															<option value="<%=obj[0]%>"><%=obj[1]%>, <%=obj[2]%></option>																				
														<%} %>
														</select>
													<input type="hidden" name="InternalLabCode" value="<%=labCode%>"> 	
													</div>
												</td>
											</tr>																
										</tbody>
									</table>
								</div>
											
								<div class="col-md-2 align-self-center">	
									<button class="btn btn-sm submit btn-members" name="submit" type="submit" onclick="return confirm('Are you Sure to Add this Member(s)');"  >ADD</button>
								</div>									
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="committeemainid" value="<%=committeeMainId%>">
								<input type="hidden" name="committeeId" value="<%=committeeId%>">
								<input type="hidden" name="ccmflag" value="Y"> 
							</div>
						</form>
					</div>
					<!-- --------------------------------------Internal members -------------------------------------------- -->
					
					<!-- --------------------------------------External MembersWithin DRDO -------------------------------------------- -->
					<div class="col-md-4" style="">
						<form action="CommitteeMainMembersSubmit.htm" method="post" name="editfrm" id="editfrm" >							
							<div class="row">				
								<div class="col-md-9">
									<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="" style="margin-top: 10px;width:100%">
										<thead>  
											<tr >
												<th colspan="2">External Members (Within DRDO)</th>
											</tr>
										</thead>								
										<tbody>
											<tr class="tr_clone1">
												<td style="width:30%">
													 <div class="input select">
														 <select class="form-control selectdee" name="Ext_LabCode" tabindex="-1" required style="" id="Ext_LabCode" onchange="employeename()">
															<option disabled="true"  selected value="">Lab Name</option>
															    <% for (Object[] obj : allLabList) {
															    if(!labCode.equals(obj[3].toString())){%>
															    <option value="<%=obj[3]%>"><%=obj[3]%></option>
															    <%}
															    }%>
														</select>
														
													</div>
												</td>										
												<td style="width:70%">
													<div class="input select">
														<select class="form-control selectdee" name="ExternalMemberIds" id="ExternalMember" data-live-search="true"   data-placeholder="Select Members" multiple>

														</select>															
													</div>														
												</td>						
											</tr>
										</tbody>
									</table>
								</div>
								<div class="col-md-2 align-self-center">					
									<button class="btn  btn-sm submit btn-members" name="submit" value="add" type="submit" onclick="return confirm('Are you Sure to Add this Member(s)');" >ADD</button>
								</div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="committeemainid" value="<%=committeeMainId%>"> 
								<input type="hidden" name="committeeId" value="<%=committeeId%>">
								<input type="hidden" name="ccmflag" value="Y">
							</div>
						</form>
					</div>
					<!-- --------------------------------------External Members Within DRDO -------------------------------------------- -->
					
					<!-- --------------------------------------External Members Outside DRDO -------------------------------------------- -->
					<div class="col-md-4" style="">
						<form action="CommitteeMainMembersSubmit.htm" method="post"  >				
							<div class="row">				
								<div class="col-md-9">
									<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="" style="margin-top: 10px;width:100%">
										<thead>  
											<tr>
												<th>Expert Member (Outside DRDO)</th>
											</tr>
										</thead>								
										<tbody>
											<tr class="tr_clone2">
												<td>
													<div class="input select ">
														<select class="selectdee" name="ExpertMemberIds"   data-live-search="true" style="width: 350px"  data-placeholder="Select Members" required multiple>
											            	<%for(Object[] obj:expertList){ %>																									
																<option value="<%=obj[0]%>"><%=obj[1]%>, <%=obj[2]%></option>	
															<%} %>
														</select>
													</div>
												</td>
											</tr>
										</tbody>	
									</table>
								</div>
								<div class="col-md-2 align-self-center">					
									<button class="btn  btn-sm submit btn-members" name="submit" value="add" type="submit" onclick="return confirm('Are you Sure to Add this Member(s)');" >ADD</button>
								</div>	
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />											
								<input type="hidden" name="committeemainid" value="<%=committeeMainId%>"> 
								<input type="hidden" name="committeeId" value="<%=committeeId%>">
								<input type="hidden" name="ccmflag" value="Y">
							</div>
						</form>
					</div>
					<!-- --------------------------------------External Members Outside DRDO -------------------------------------------- -->
				</div>
       		</div>
		</div>
	</div>
	

<script type="text/javascript">

function employeename(){

	$('#ExternalMember').val("");
	
		var $CpLabCode  = $('#Ext_LabCode').val()
		
			if($CpLabCode !=""){
				$.ajax({

					type : "GET",
					url : "ExternalEmployeeListFormation.htm",
					data : {
						CpLabCode : $CpLabCode ,
						committeemainid : '<%=committeeMainId%>'
					   },
					datatype : 'json',
					success : function(result) {
						var result = JSON.parse(result);
						
						var values = Object.keys(result).map(function(e) {
		 					return result[e]
							  
						});
						var s = '';
						s += '<option value="">--Select--</option>';
						for (i = 0; i < values.length; i++) 
						{
							s += '<option value="'+values[i][0]+'">' +values[i][1].trim() + ", " +values[i][3]+""  + '</option>';
						} 
						 
						$('#ExternalMember').html(s);
						
					}
				});

			}
	}

</script>



<script type="text/javascript">
function submitForm1(myform)
{ 
 	myconfirm('Are You Sure To Add This members ?',myform);
 	event.preventDefault();
}
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
</script>



<script type="text/javascript">



function memberrepdelete(memrepid){			
	
	if(confirm('Are You Sure To Delete ?')){
				$.ajax({

						type : "GET",
						url : "CommitteeMemberRepDelete.htm",
						data : {
								memrepid : memrepid
								},
						datatype : 'json',
						success : function(result) {
						var result = JSON.parse(result);
						
							if(result===1)
							{
								$('#repmem'+memrepid).remove();
								replacerepdd();
							}else if(result===0)
							{
								alert('Delete Operation Failed, Try Again !');
							}
						}
					});
				}
			}



function replacerepdd(){
				
			$.ajax({		
				type : "GET",
				url : "CommitteeRepNotAddedList.htm",
				data : {
						committeemainid : '<%=committeeMainId%>'
					   },
				datatype : 'json',
				success : function(result) {

					var result = JSON.parse(result);
			
					var values = Object.keys(result).map(function(e) {
	 				return result[e]
							  
				});
						
				var s = '';
				s += '<option value="">'
					+"--Select--"+ '</option>';
				for (i = 0; i < values.length; i++) {
						
					s += '<option value="'+values[i][0]+'">'
						+values[i][2] + " (" +values[i][1]+")" 
						+ '</option>';
				} 
					 
				$('#repids').html(s);
						
		}
	});
}

</script>


<script type="text/javascript">

 $(document).ready(function(){	
	 
	/* chairpersonfetch('0');
	msfetch('0'); */
	
	 const committeeMainId = '<%=committeeMainId%>';
	 
	 if(committeeMainId=="0"){
		 $('.btn-members').prop('disabled', true);
	 }
	 
	 $('#schedule-btn').on('click', function(){
		 if(committeeMainId=="0"){
			 alert('CCM Committee not constituted yet');
			 event.preventDefault();
		 }
	 });
}); 

		<%-- function chairpersonfetch(hint){
			$('#chairperson').val("");
				var $CpLabCode = $('#CpLabCode').val();
						if($CpLabCode !=""){
				
						$.ajax({		
							type : "GET",
							url : "ChairpersonEmployeeListFormation.htm",
							data : {
								CpLabCode : $CpLabCode,
								committeemainid : '<%= committeemainid %>',
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
											+values[i][1] + ", " +values[i][3]
											+ '</option>';
								} 
								 
								$('#chairperson').html(s);
								if(hint=='0' && $CpLabCode =='<%=chairperson!=null?chairperson[9]:""%>'){
									$('#chairperson').val('<%=chairperson!=null?chairperson[5]:""%>');
								}
															
							}
						});
		
		}
	} --%>
		
		<%-- function msfetch(hint){
			$('#secretary').val("");
			var $CpLabCode = $('#mSLabCode').val();
					if($CpLabCode !=""){
			
					$.ajax({		
						type : "GET",
						url : "ChairpersonEmployeeListFormation.htm",
						data : {
							CpLabCode : $CpLabCode,
							committeemainid : '<%= committeemainid %>',
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
										+values[i][1]+", " +  values[i][3]
										+ '</option>';
							} 
							 
							$('#secretary').html(s);
							if(hint=='0' && $CpLabCode =='<%=secretary!=null?secretary[9]:""%>'){
								$('#secretary').val('<%=secretary!=null?secretary[5]:""%>');
							}
														
						}
					});
	
	}
		} --%>
		
</script>

<script>

function Add(myfrm){

    
    var fieldvalues = $("select[name='Member']").map(function(){return $(this).val();}).get();
    
    var $chairperson = $("#chairperson").val();
    var $cplabCode = $('#CpLabCode').val();
    var $LabCode = '<%=labCode%>';
    var $mSLabCode=$('#mSLabCode').val();
    
    var $cochairperson = $("#co_chairperson").val();
    var $secretary = $("#secretary").val();
    var $proxysecretary=$("#proxysecretary").val();
    
    if($mSLabCode===$cplabCode){
		if($chairperson==$secretary){
			 alert("Chairperson and Member Secretary Should Not Be The Same Person ");	   
			 event.preventDefault();
				return false;
		}
    }
    
    if( $LabCode === $cplabCode){
		if($chairperson==$secretary){
			 alert("Chairperson and Member Secretary Should Not Be The Same Person ");	   
			 event.preventDefault();
				return false;
		}
		
		if($cochairperson == $chairperson)
		{
			alert("Chairperson and Co-Chairperson Should Not Be The Same Person ");	   
			 event.preventDefault();
				return false;
		}
		
		if($proxysecretary==$chairperson)
		{
			alert("Chairperson and Proxy Member Secretary Should Not Be The Same Person ");	   
			 event.preventDefault();
				return false;
		}
	}
    
    if($cochairperson==$secretary)
	{
		alert("Member Secretary and Co-Chairperson Should Not Be The Same Person ");	   
		 event.preventDefault();
			return false;
	}
    if($proxysecretary==$secretary)
	{
		alert("Member Secretary and Proxy Member Secretary Should Not Be The Same Person ");	   
		 event.preventDefault();
			return false;
	}
	
	if($cochairperson!=='0' &&  $proxysecretary!=='0' && $cochairperson==$proxysecretary )
	{
		alert("Co-Chairperson and Proxy Member Secretary Should Not Be The Same Person ");	   
		 event.preventDefault();
			return false;
	}
    
	
	
	
    
    for (var i = 0; i < fieldvalues.length; i++) {
    	
    	if($chairperson==fieldvalues[i]){
    		 alert("Chairperson Should Not Be A Member ");	   
    		 event.preventDefault();
    			return false;
    	}
    	
    	if($secretary==fieldvalues[i]){
   		 alert("Member Secretary Should Not Be A Member ");	   
   		 event.preventDefault();
   			return false;
 	  	}
    	
    	if($proxysecretary==fieldvalues[i]){
      		 alert("Proxy Member Secretary Should Not Be A Member ");	   
      		 event.preventDefault();
      			return false;
    	  	}
    	
   } 
    
	if(confirm('Are you Sure to Update this Committee?')){
		return true;
	}else{
		event.preventDefault();
	}

  return true;
}

 

</script>	
<!-- Prudhvi 27/03/2024 start -->
<script type="text/javascript">
	
function slnocheck(formid) {
	
	 var arr = document.getElementsByName("newslno");

	var arr1 = [];
	for (var i=0;i<arr.length;i++){
		arr1.push(arr[i].value);
	}		 
	 
    let result = false;
  
    const s = new Set(arr1);
    
    if(arr.length !== s.size){
       result = true;
    }
    if(result) {
   	event.preventDefault();
       alert('Serial No contains duplicate Values');
       return false;
    } else {
   	 return confirm('Are You Sure to Update?');
    }
  }


</script>
<!-- Prudhvi 27/03/2024 end -->	

<script type="text/javascript">

    const employeeList = JSON.parse('<%= jsonemployeeList1 %>');
    const chairperson = JSON.parse('<%= jsonchairperson %>');
    const co_chairperson = JSON.parse('<%= jsonco_chairperson %>');
    const secretary = JSON.parse('<%= jsonsecretary %>');
    const proxysecretary = JSON.parse('<%= jsonproxysecretary %>');

    function populateSelects() {
        const selects = $(".dynamicdropdown");
        selects.each(function() {
            const select = $(this);
            select.empty();

            const id = select.attr('id');
            if (id !== 'chairperson' && id !== 'secretary') {
                select.append('<option value="0">None</option>');
            }else if(id == 'secretary'){
            	select.append('<option value="" disabled="disabled" selected>--select--</option>');
            }

            employeeList.forEach(employee => {
                select.append(new Option(employee[1] + ", " + employee[3], employee[0]));
            });
        });

        if(chairperson!=null){
        	selectOptionForEdit();
        }	
        
        selects.select2();  // Apply Select2
        refreshOptions();
        
        
    }

    function refreshOptions() {
        const selectedIds = $(".dynamicdropdown").map(function() {
            return $(this).val();
        }).get();

        $(".dynamicdropdown").each(function() {
            const select = $(this);
            const currentSelectedId = select.val();
            select.find("option").each(function() {
                const option = $(this);
                if (option.val() !== "0" && selectedIds.includes(option.val()) && option.val() !== currentSelectedId) {
                    option.prop('disabled', true).hide();
                } else {
                    option.prop('disabled', false).show();
                }
            });
        });
    }

    
    function selectOptionForEdit(){
    	
    	/* ------------- chairperson -------------------  */
    	const selectchairperson = $("#chairperson");
    	selectchairperson.empty();

        employeeList.forEach(employee => {
            const option = new Option(employee[1] + ", " + employee[3], employee[0]);
            if (chairperson != null && chairperson.length > 5 && chairperson[5].toString() === employee[0].toString()) {
                option.setAttribute('selected', true);
            }
            selectchairperson.append(option);
        });

        selectchairperson.select2();
        
    	/* ------------- co_chairperson -------------------  */
    	const selectco_chairperson = $("#co_chairperson");
    	selectco_chairperson.empty();
	
    	selectco_chairperson.append('<option selected value="0">None</option>');
    	
        employeeList.forEach(employee => {
            const option = new Option(employee[1] + ", " + employee[3], employee[0]);
            if (co_chairperson != null && co_chairperson.length > 5 && co_chairperson[5].toString() === employee[0].toString()) {
                option.setAttribute('selected', true);
            }
            selectco_chairperson.append(option);
        });

        selectco_chairperson.select2();
        
    	/* ------------- secretary -------------------  */
    	const selectsecretary = $("#secretary");
    	selectsecretary.empty();

        employeeList.forEach(employee => {
            const option = new Option(employee[1] + ", " + employee[3], employee[0]);
            if (secretary != null && secretary.length > 5 && secretary[5].toString() === employee[0].toString()) {
                option.setAttribute('selected', true);
            }
            selectsecretary.append(option);
        });

        selectsecretary.select2();
        
    	/* ------------- secretary -------------------  */
    	const selectproxysecretary = $("#proxysecretary");
    	selectproxysecretary.empty();

    	selectproxysecretary.append('<option selected value="0">None</option>');
    	
        employeeList.forEach(employee => {
            const option = new Option(employee[1] + ", " + employee[3], employee[0]);
            if (proxysecretary != null && proxysecretary.length > 5 && proxysecretary[5].toString() === employee[0].toString()) {
                option.setAttribute('selected', true);
            }
            selectproxysecretary.append(option);
        });

        selectproxysecretary.select2();
        
    }
    
    
    $(document).ready(function() {
		populateSelects();
        $(".dynamicdropdown").change(refreshOptions);	
    });
</script>
</body>
</html>