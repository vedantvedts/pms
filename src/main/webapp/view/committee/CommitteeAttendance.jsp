	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>COMMMITTEE ATTENDANCE</title>
<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}
b{
	font-family: 'Lato',sans-serif;
}

.toggle.btn{
	min-height: 2.0rem !important;
	font-size: 0.95rem !important;
	padding: 0.35rem 0.75rem !important;
}

.fa{
	font-size: 1rem;
}


.card-header{
	background-color: #07689f;
	color:white;
}

.card{
	border-color: #07689f;
}

</style>
</head>
<body>
<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> committeeinvitedlist=(List<Object[]>)request.getAttribute("committeeinvitedlist");
List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("EmployeeList");
List<Object[]> ExpertList=(List<Object[]>) request.getAttribute("ExpertList");
String committeescheduleid=(String)request.getAttribute("committeescheduleid");
Object[] committeescheduledata=(Object[])request.getAttribute("committeescheduledata");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
List<Object[]> clusterlablist=(List<Object[]>) request.getAttribute("clusterlablist");

List<Object[]> committeereplist=(List<Object[]>) request.getAttribute("committeereplist");

String LabCode=(String) request.getAttribute("LabCode");
%>

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></div>
                    <%} %>



<div class="container">
	<div class="row" style="">
		<div class="col-md-12">
		
		 <div class="card shadow-nohover" >
			 <div class="card-header">
				 <div class="row">
							<div class="col-md-3" >
					  			<h4><%=committeescheduledata[8] %> Invitations </h4>
							 </div>
							 <div class="col-md-9" align="right" style="margin-top: 3px;" >
					 			<h5 style="color: white"  > (Meeting Date & Time : <%= sdf.format(sdf1.parse( committeescheduledata[2].toString()))%>  &  <%=committeescheduledata[3] %>)</h5>
							 </div>
					 	</div>
			  </div>
			  
		      <div class="card-body" >
		   
              		
			<div class="row" style="">
			<div class="col-md-1"></div>
				<div class="col-md-10">

				<div align="center">
					<h5 style="color:#145374" >(Meeting Id : <%=committeescheduledata[12] %>) </h5>
				</div>

				<%
					if(!committeeinvitedlist.isEmpty()){%>
					<form action="InvitationSerialNoUpdate.htm" method="Post"  id="serialnoupdate">
			         	<table  class="table table-bordered table-hover table-striped table-condensed ">
			            	<thead>
			               		<tr>
			               			<th>Sl.No</th>			                    	
			                    	<th>Member Type</th>
			                    	<th >Participants</th>
			                       	<th >Attendance</th> 
			                    </tr>
			              	</thead>                        
				    		<tbody>
								<%
								int count=1;
								
									
									for(Object[] obj:committeeinvitedlist){ %>
										
								<tr>
									<td>
										<input type="number" class="form-control" name="newslno" value="<%=obj[12] %>" min="1" max="<%=committeeinvitedlist.size()%>"> 
										<input type="hidden" name="invitationid" value="<%=obj[1] %>">
									</td>	
									<td> 
										<%  if(obj[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
											else if(obj[3].toString().equalsIgnoreCase("CS") ){	 %> Member Secretary<%}
											else if(obj[3].toString().equalsIgnoreCase("CH") ){	 %> Co-Chairperson<%}
											else if(obj[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary (Proxy) <%}
											else if(obj[3].toString().equalsIgnoreCase("CI")){   %> Internal<%}
											else if(obj[3].toString().equalsIgnoreCase("CW")){	 %> External(<%=obj[11] %>)<%}
											else if(obj[3].toString().equalsIgnoreCase("CO")){	 %> External(<%=obj[11]%>)<%}
											else if(obj[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
											else if(obj[3].toString().equalsIgnoreCase("I")){	 %> Addl. Internal<%}
											else if(obj[3].toString().equalsIgnoreCase("W") ){	 %> Addl. External(<%=obj[11] %>)<%}
											else if(obj[3].toString().equalsIgnoreCase("E") )    {%> Addl. External(<%=obj[11] %>)<%}
											else {%> REP_<%=obj[3].toString()%> (<%=obj[11] %>)  <%}
										%>
										
									</td>
									<td><%=obj[6] %> (<%=obj[7]%>)(<%=obj[11]%>)</td>        
									
									<td>
											<input name="attendance"  onchange="FormNameEdit(<%=obj[1]%>)"  type="checkbox" <%if((obj[4]).toString().equalsIgnoreCase("P")){ %>checked<%}%> data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="112" data-height="15" data-on="<i class='fa fa-user' aria-hidden='true'></i> Present" data-off="<i class='fa fa-user-times' aria-hidden='true'></i> Absent" >
											<input 	type="hidden" name="sample" value="attendance<%=count %>" >	
											<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
											<input type="hidden" name="scheduleid" value="<%=committeescheduleid %>">
									</td>
										
								</tr>
							
									<% count++;}%>
								<%if(committeeinvitedlist.size()>1	){ %>
									<tr>
										<td> <button type="submit" class="btn btn-sm edit" onclick="return slnocheck('serialnoupdate');" >Update</button></td>
									</tr>
								<%} %>
							</tbody>
				    
			             </table>	
			           </form>								

					 </div> 
		    	</div> 
		       
				<div align="center">
			      	<form method="post" action="CommitteeScheduleView.htm">
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
						<input type="hidden" name="scheduleid" value="<%=committeescheduleid %>">
						<!-- <button type="button" class="btn btn-sm add" id="addrep" onclick="showaddladd();">Add Additional Members</button>
						<button type="button" class="btn btn-sm add" id="addrep" onclick="showrepadd();">Add Representative</button> -->
						<button class="btn btn-info btn-sm  shadow-nohover back" >Back</button>
					</form>									
				 </div>
			
<!------------------------------------------------------------------------------------------------------------------------------------------------ -->	
			
				<div class=row>
		       		<div class="col-md-12" id="addmemtitleid" style="display: none;">
		       			<h5 style="color:#145374">Add Additional Members</h5>
		       			<hr> 
		          	</div>
		          	<div class="col-md-12" id="reptitleid" style="display: none;">
		       			<h5 style="color:#145374">Add Representative Members</h5>
		       			<hr> 
		          	</div>
		          	
		     	</div>			
					
<!-- --------------------------------internal add ----------------------------------------------- -->
			<div id="additionalmemadd" style="visibility: collapse;"> 
				<div class="row" id="repselect" style="visibility :collapse ;" >						
					<div class="col-md-6">	 
						
						<table  style="margin-top: 10px;width:100%">
							<tr >			
									
								<td style="width: 100%;">	
									<label>Representative Type</label>										
									<select class="form-control selectdee " name="reptype" id="reptype"  data-live-search="true" onchange="setreptype();" >
											<option selected value="0"  > Choose... </option>
										<% for (Object[] obj : committeereplist) {%>					
											<option value="<%=obj[2]%>"> <%=obj[3]%> </option>
										<%} %>
									</select>
								</td>
							</tr>
						</table>	
					</div>		
				</div>
				
				
				
				<form  action="CommitteeAttendanceSubmit.htm" method="POST" name="myfrm1" id="myfrm1">					
				<div class="row">						
					<div class="col-md-6">
						<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="" style="margin-top: 10px;width:100%">
							<thead>  
								<tr id="" >
									<th> Internal Members</th>
								</tr>
							</thead>				
							<tr class="tr_clone">
								<td >								
									 <div class="input select external">
										 <select class="form-control selectdee " name="internalmember" id="internalmember"  data-live-search="true"   data-placeholder="Select Members" multiple required>
							                 <% for (Object[] obj : EmployeeList) {%>
									       		<option value="<%=obj[0]%>,I,<%=obj[3]%>"><%=obj[1]%> ( <%=obj[2] %> ) </option>
									    	<%} %>
										</select>
										<input type="hidden" name="InternalLabId" value="<%=LabCode %>" />
									</div>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
 								<input type="hidden" name="committeescheduleid" value="<%=committeescheduleid %>">
								<input type="hidden" name="rep" id="rep1" value="0" />
								</td>
							</tr>
						</table>
					</div>
					
					<div class="col-md-6 align-self-center">
					
						<button class="btn btn-primary btn-sm submit" name="submit" value="submit" type="submit"  onclick="return confirm('Are you Sure to Add these Members ?');">SUBMIT</button>
							
					</div>
				
			</div>
			</form>
	<!-- --------------------------------internal add ----------------------------------------------- -->
	
	<!-- --------------------------------External Members (Within DRDO)----------------------------------------------- -->
			<form  action="CommitteeAttendanceSubmit.htm" method="POST" name="myfrm1" id="myfrm1">
			<div class="row">	
				
				<div class="col-md-6">
					
					<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="table1" style="margin-top: 10px;">
						<thead>  
							<tr id="">
								<th colspan="2"> External Members (Within DRDO)</th>
							</tr>
						</thead>
						<tr>
							<td style="width:30%">							
								<div class="input select">
									<select class="form-control selectdee" name="LabId" tabindex="-1"   id="LabCode" onchange="employeename()" required>
										<option disabled="true"  selected value="">Lab Name</option>
											<% for (Object[] obj : clusterlablist) {
											if(!LabCode.equals(obj[3].toString())){%>
												<option value="<%=obj[3]%>"><%=obj[3]%></option>
											<%} 
											}%>
									</select>
								</div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
 								<input type="hidden" name="committeescheduleid" value="<%=committeescheduleid %>">
								<input type="hidden" name="rep" id="rep2" value="0" />
							</td>
							<td>
								<div class="input select ">
									<select class="form-control selectdee" name="ExternalMemberLab" id="ExternalMemberLab" data-live-search="true"   data-placeholder="Select Members" multiple>
									</select>
								</div>
							</td>						
						</tr>
					</table>
				
				</div>
				
				<div class="col-md-6 align-self-center">
					
						<button class="btn btn-primary btn-sm submit" name="submit" value="submit" type="submit"  onclick="return confirm('Are you Sure to Add these Members ?');">SUBMIT</button>
							
				</div>
				
			</div>
			</form>
	<!-- --------------------------------External Members (Within DRDO)----------------------------------------------- -->
	<!-- --------------------------------External Members (Outside DRDO)----------------------------------------------- -->

			
			<form  action="CommitteeAttendanceSubmit.htm" method="POST" name="myfrm1" id="myfrm1">
			<div class="row">					
				
				<div class="col-md-6">
					
						<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="" style="margin-top: 10px;width:100%">
						<thead>  
							<tr id="">
								<th> External Members (Outside DRDO)</th>
							</tr>
						</thead>
						<tr class="tr_clone2">
							<td >
							
								<div class="input select external">
									<select  class= "form-control selectdee" name="externalmember" id="expertmember"   data-live-search="true"   data-placeholder="Select Members" multiple required>
										<% for (Object[] obj : ExpertList) {%>
									       	<option value="<%=obj[0]%>,E,<%=obj[3]%>"><%=obj[1]%> ( <%=obj[2] %> ) </option>
									    <%} %>
									</select>
									<input type="hidden" name="LabId1" value="@EXP" />
									<input type="hidden" name="rep" id="rep3" value="0" />
								</div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
 								<input type="hidden" name="committeescheduleid" value="<%=committeescheduleid %>">
						</tr>
					</table>					
				</div>
				
				<div class="col-md-6 align-self-center">
						
					<button class="btn btn-primary btn-sm submit" name="submit" value="submit" type="submit"  onclick="return confirm('Are you Sure to Add these Members ?');">SUBMIT</button>
								
				</div>
				
			</div>	
			</form>
	<!-- --------------------------------External Members (Outside DRDO)----------------------------------------------- -->
	</div>	       
	
<!------------------------------------------------------------------------------------------------------------------------------------------------ -->	
		        		
		    <% }else {%>
		       					
				<div align="center">
					<h5>Not Invited Yet ...!!</h5><br>									
				</div>
			<%} %> 
				 </div>
				 	 
		    </div> <!-- card end -->
		    
		</div>
	</div>
</div>




	 
				 <script type="text/javascript">
					function showrepadd()
					{
						document.getElementById('addmemtitleid').style.display = 'none';
						document.getElementById('reptitleid').style.display = 'block';	
						
						$('#internalmember').val('').trigger("change");
						$('#ExternalMemberLab').val('').trigger("change");
						$('#expertmember').val('').trigger("change");
						$('#LabCode').val('').trigger("change");
						
						document.getElementById('additionalmemadd').style.visibility = 'visible';
						document.getElementById('repselect').style.visibility = 'visible';
					}
					
					function showaddladd()
					{
						document.getElementById('reptitleid').style.display = 'none';
						document.getElementById('addmemtitleid').style.display = 'block';
						
						$('#internalmember').val('').trigger("change");
						$('#ExternalMemberLab').val('').trigger("change");
						$('#expertmember').val('').trigger("change");
						$('#LabCode').val('').trigger("change");
						
						document.getElementById('additionalmemadd').style.visibility = 'visible';
						$("#reptype").val("0").change();						
						if($('#repselect').css('visibility')==='visible')
						{
							document.getElementById('repselect').style.visibility = 'collapse';
						} 
						 
					}
				</script>
		       
		       
		       
<script type="text/javascript">
					
		function setreptype()
		{
			reptype=$('#reptype').val();
			$('#rep1').val(reptype);
			$('#rep2').val(reptype);
			$('#rep3').val(reptype);
		}
			
					
</script>
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
  

	
<script type="text/javascript">


function FormNameEdit(id){
   		 $.ajax({

				type : "GET",
				url : "CommitteeAttendanceToggle.htm",
				data : {
							invitationid : id
					   },
				datatype : 'json',
				success : function(result) {

				var result = JSON.parse(result);
		
				var values = Object.keys(result).map(function(e) {
			 				 return result[e]
			  
								});
					}
					   
				});
   	 
}

function employeename(){

	$('#ExternalMemberLab').val("");
	
		var $LabCode = $('#LabCode').val();
	
		
				if($LabCode!=""){
		
							$
								.ajax({

								type : "GET",
								url : "ExternalEmployeeListInvitations.htm",
								data : {
											LabCode : $LabCode,
											scheduleid : '<%=committeescheduleid %>' 	
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
							
							s += '<option value="'+values[i][0]+",W,"+values[i][4]+'">'
									+values[i][1] + " (" +values[i][3]+")" 
									+ '</option>';
						} 
						 
						$('#ExternalMemberLab').html(s);
											
					}
				});

		}
	}

</script>


</body>
</html>