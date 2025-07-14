<%@page import="com.vts.pfms.committee.model.ProgrammeMaster"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.master.model.IndustryPartner"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title> COMMITTEE MEMBERS </title>
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

.tdclass {
	padding-top:7px;
	padding-bottom: 7px;
}

tr_clone .select2{
	width:600px !important;
}

tr_clone1 .select2{
	width:350px !important;
}
tr_clone2 select .select2{
	width:350px !important;
}
sp::before {
	content: "\2022";
  	color: red;
  	font-weight: bold;
  	display: inline-block; 
  	width: 1em;
  	margin-left: 1em;
}		
</style>
</head>

<body>

	<%
		Object[] committeedata=(Object[])request.getAttribute("committeedata");
		List<Object[]> employeeList=(List<Object[]>)request.getAttribute("employeeList");
		List<Object[]> employeeList1=(List<Object[]>)request.getAttribute("employeeList1");
		
		List<Object[]> clusterlist=(List<Object[]>) request.getAttribute("clusterlist");
		List<Object[]> allLabList=(List<Object[]>) request.getAttribute("allLabList");
		List<Object[]> expertList=(List<Object[]>) request.getAttribute("expertList");
		List<ProgrammeMaster> programmeList=(List<ProgrammeMaster>) request.getAttribute("programmeList");
		
		
		List<Object[]> committeeMembersAll=(List<Object[]>)request.getAttribute("committeeMembersAll");
		Object[] chairperson=null;
		Object[] co_chairperson=null;
		Object[] secretary =null;
		Object[] proxysecretary=null;
		
		String committeeId=(String)request.getAttribute("committeeId");
		String committeemainid=(String)request.getAttribute("committeeMainId");
		String programmeId = (String)request.getAttribute("programmeId");
		List<Object[]> committeerepnotaddedlist=(List<Object[]>)request.getAttribute("committeerepnotaddedlist");
		List<Object[]> committeeMemberreplist=(List<Object[]>)request.getAttribute("committeeMemberreplist");
		
		for(int i=0;i<committeeMembersAll.size();i++)
		{	
			if(committeeMembersAll.get(i)[8].toString().equalsIgnoreCase("CC")){
				chairperson = committeeMembersAll.get(i);
				committeeMembersAll.remove(i);
				break;
			}
		}
		for(int i=0;i<committeeMembersAll.size();i++)
		{
			if(committeeMembersAll.size()>0 && committeeMembersAll.get(i)[8].toString().equalsIgnoreCase("CS")){
				secretary = committeeMembersAll.get(i);
				committeeMembersAll.remove(i);
				break;
			}
		}
		for(int i=0;i<committeeMembersAll.size();i++)
		{
			if(committeeMembersAll.size()>0 && committeeMembersAll.get(i)[8].toString().equalsIgnoreCase("PS")){
				proxysecretary = committeeMembersAll.get(i);
				committeeMembersAll.remove(i);
				break;
			}
		}
		for(int i=0;i<committeeMembersAll.size();i++)
		{
			if(committeeMembersAll.size()>0 && committeeMembersAll.get(i)[8].toString().equalsIgnoreCase("CH")){
				co_chairperson = committeeMembersAll.get(i);
				committeeMembersAll.remove(i);
				break;
			}
		}
		String CpLabCode = chairperson!=null?chairperson[9].toString():"-";
		
		
		//Prudhvi - 27/03/2024 
		/* --------- start -------------- */
		List<IndustryPartner> industryPartnerList = (List<IndustryPartner>)request.getAttribute("industryPartnerList");
		/* --------- end -------------- */
		List<String> loginTypes = Arrays.asList("A","P");
		
		String logintype = (String)session.getAttribute("LoginType");
		String labcode = (String)session.getAttribute("labcode");
		Long EmpId = (Long) session.getAttribute("EmpId");
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
   
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">	
				<div class="card shadow-nohover">	
					<div class="card-header">						
						<div class="row">										
							<div class="col-md-8">
								<h3 style="color: #055C9D;">Programme Management Council (PMC)</h3>
							</div>	
							<div class="col-md-1 right">
								<label class="form-label">Programme:</label>
							</div>
							<div class="col-md-2 " style="margin-top: -0.4rem;">
								<form action="PrgmCommitteeConstitution.htm" method="post">
									<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
									<input type="hidden" name="committeeId" value="<%=committeeId%>">
									<select class="form-control selectdee" name="programmeId" id="programmeId" onchange="this.form.submit()">
										<option value="0" disabled>--Select--</option>
										<%if(programmeList!=null && programmeList.size()>0) {
											if(!Arrays.asList("A","Z").contains(logintype)) {
												programmeList = programmeList.stream().filter(e -> e.getProgrammeId().equals(EmpId)).collect(Collectors.toList());
											}
											for(ProgrammeMaster prgm : programmeList) {
										%>
											<option value="<%=prgm.getProgrammeId()%>" <%if(prgm.getProgrammeId()==Long.parseLong(programmeId)) {%>selected<%} %> ><%=prgm.getPrgmName() %> (<%=prgm.getPrgmCode() %>)</option>
										<%} } %>
									</select>
								</form>
							</div>	
							<div class="col-md-1 right">
								<%if(chairperson!=null) {%>
									<form action="PrgmSchedule.htm" method="post">
										<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
										<input type="hidden" name="committeeMainId" value="<%=committeemainid%>">
										<input type="hidden" name="committeeId" value="<%=committeeId%>">
										<input type="hidden" name="programmeId" value="<%=programmeId%>">
										<button type="submit" class="btn btn-info btn-sm shadow-nohover back">
				 							<i class="fa fa-clock-o" aria-hidden="true"></i>
				 							Schedule
				 						</button>
									</form>
								<%} %>	
							</div>	
						</div>
					</div>
					
					<!-- ---------------------------------------------------------------------committee main members ---------------------------------------------- -->
					<div class="card-body">	
						<form action="PrgmCommitteeSubmit.htm" method="post" id="committeeesubfrm">				
							<div class="row">							
								<div class="col-md-8" style="margin-top:5px; ">									 
					            	<label class="control-label" style="margin-bottom: 4px !important">Chairperson<span class="mandatory" style="color: red;">*</span></label>
					            	<table style="width:100%">
					                	<tr >
											<td style="width:25%; border:0:">
												<div class="input select" id="cplab-col">
													<select class="form-control selectdee" name="CpLabCode" tabindex="-1" required="required" style="width: 200px" id="CpLabCode" onchange="chairpersonfetch('1')">
														<option disabled="disabled"  selected value="">Lab Name</option>
													    <% for (Object[] obj : allLabList) {%>
														    <option <%if(chairperson!=null && chairperson[9].toString().equals(obj[3].toString())){ %>selected <%} %>value="<%=obj[3]%>"><%=obj[3]%></option>
													    <%} %>
													    <option <%if(chairperson!=null && chairperson[9].toString().equalsIgnoreCase("@EXP")){ %>selected <%} %>value="@EXP">Expert</option>
													</select>
												</div>
											</td>										
											<td style="border:0;">
												<div class="input select">
													<select class="form-control selectdee" name="chairperson" id="chairperson" data-live-search="true" required="required"   data-placeholder="Select Chairperson" >
													</select>	
													<input type="hidden" name="cpmemberid" value="<%=chairperson!=null?chairperson[0]:"0"%>"> 										
												</div>														
											</td>						
										</tr>
									</table>
								</div>
							</div> 
							
							<div class="row">
								<div class="col-md-8" style="margin-top:5px; ">									 
					            	<label class="control-label" style="margin-bottom: 4px !important">Member Secretary<span class="mandatory" style="color: red;">*</span></label>
					           		<table style="width:100%">
					                	<tr >
											<td style="width:25%; border:0:">
												<div class="input select" id="cplab-col">
													<select class="form-control selectdee" name="msLabCode" tabindex="-1" required="required" style="width: 200px" id="mSLabCode" onchange="msfetch('1')">
														<option disabled="disabled"  selected value="">Lab Name</option>
													    <% for (Object[] obj : allLabList) {%>
														    <option <%if(secretary!=null&& secretary[9].toString().equals(obj[3].toString())){ %>selected <%} %>value="<%=obj[3]%>"><%=obj[3]%></option>
													    <%} %>
													    <option <%if(secretary!=null && secretary[9].toString().equalsIgnoreCase("@EXP")){ %>selected <%} %>value="@EXP">Expert</option>
													</select>
												</div>
											</td>										
											<td style="border:0;">
												<div class="input select">
													<select class="form-control selectdee" name="Secretary" id="secretary" data-live-search="true" required="required"   data-placeholder="Select Member secretary" >
													</select>	
													<%if(secretary!=null){ %>
				  										<input type="hidden" name="msmemberid" value="<%=secretary[0]%>">
				  									<%} %>										
												</div>														
											</td>						
										</tr>
									</table>
								</div>
			
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Member Secretary (Proxy)</label>
										<select class="form-control selectdee" id="proxysecretary" required="required" name="proxysecretary"style="margin-top: -5px">
				    						<option value="0"  selected >None</option>
				    						<% for (Object[] obj : employeeList1) {%>
												<option value="<%=obj[0]%>" <%if(proxysecretary!=null && proxysecretary[5].toString().equals(obj[0].toString())){ %>selected<%} %> ><%=obj[1]%>, <%=obj[3] %></option>
											<%} %>
				  						</select>
				  						<%if(proxysecretary!=null){ %>
				  						<input type="hidden" name="psmemberid" value="<%=proxysecretary[0]%>">
				  						<%}%> 
									</div>
								</div>
								
								<%-- <div class="col-md-8" style="margin-top:5px; ">									 
					            	<label class="control-label"> Co-Chairperson </label>
					            	<table style="width:100%">
					                	<tr >
											<td style="width:25%; border:0:">
												 <div class="input select" id="cplab-col">
													<select class="form-control selectdee" name="ccplabocode" tabindex="-1"  style="width: 200px" id="ccplabocode" onchange="ccchairpersonfetch('1')">
														<option disabled="disabled"  selected value="">SELECT</option>
													    <% for (Object[] obj : allLabList) {%>
														    <option <%if(co_chairperson!=null &&   co_chairperson[9].toString().equals(obj[3].toString())){ %>selected <%} %>value="<%=obj[3]%>"><%=obj[3]%></option>
													    <%} %>
													    <option <%if(co_chairperson!=null && co_chairperson[9].toString().equalsIgnoreCase("@EXP")){ %>selected <%} %>value="@EXP">Expert</option>
													</select>
															
												</div>
											</td>										
											<td style="border:0;">
												<div class="input select">
													<select class="form-control selectdee" name="co_chairperson" id="co_chairperson" data-live-search="true"    data-placeholder="Select co-chairPerson" >
												             
													</select>	
													<%if(co_chairperson!=null){ %>
								  						<input type="hidden" name="comemberid" value="<%=co_chairperson[0]%>">
								  						<%} %>									
												</div>														
											</td>						
										</tr>
									</table>
								</div> --%>
							<%-- 	<div class="col-md-7">
									<div class="form-group">
										
										<select class="form-control selectdee" id="co_chairperson" required="required" name="co_chairperson"style="margin-top: -5px">
				    						<option selected value="0" >None</option>
				    						<% for (Object[] obj : EmployeeList1) {%>
												<option value="<%=obj[0]%>" <%if(co_chairperson !=null && co_chairperson[5].toString().equals(obj[0].toString())){ %>selected<%} %> ><%=obj[1]%>, <%=obj[3] %></option>
											<%} %>
				  						</select>
				  						<%if(co_chairperson!=null){ %>
				  						<input type="hidden" name="comemberid" value="<%=co_chairperson[0]%>">
				  						<%} %>	
									</div>
								</div> --%>
							</div>
						
							<%-- <div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Reference No.</label>
										<input type="text" class="form-control"   name="ReferenceNo" value="<%= committeedata!=null && committeedata[11] != null ? committeedata[11] : "--" %>" >
									</div>
								</div>
						
								<div class="col-md-4">
						         	<div class="form-group">
						            	<label class="control-label" >Formation Date</label>
						  				<input type="date" class="form-control"  data-date-format="dd/mm/yyyy" id="Formationdate" name="Formationdates" <%if(committeedata!=null && committeedata[12] != null) { %> value="<%=committeedata[12]%>" <%} %>  >
						        	</div>
					        	</div>
							</div>  --%>
							<div class="row">			
								<div class="col-md-12" align="center">
					              	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />                  	
									<input type="hidden" name="committeemainid" value="<%=committeemainid%>"> 
									<input type="hidden" name="committeeId" value="<%=committeeId%>"> 
									<input type="hidden" name="programmeId" value="<%=programmeId%>">
				                	<%if(chairperson!=null) {%>
										<button type="submit" class=" btn btn-sm edit" name="action" value="Edit" onclick="Add('committeeeditfrm')" >UPDATE</button>
									<%} else{%>
										<button type="submit" class=" btn btn-sm submit" name="action" value="Add" onclick="Add('committeeeditfrm')" >SUBMIT</button>
									<%} %>
								</div> 
			              	</div>
						</form>
						
						<br>
						<!-- 	--------------------------------------------- internal and Expert Members------------------------------------ -->			
 						<%
			 				List<Object[]>tempcommitteemembersall=new ArrayList<>();
			 				List<String>memberTypes=Arrays.asList("CC","CS","PS","CH");
			 				if(committeeMembersAll.size()>0) 
			 				{
			 					tempcommitteemembersall=committeeMembersAll.stream()
			 												.filter(i->!memberTypes.contains(i[8].toString())).collect(Collectors.toList());
			 					tempcommitteemembersall=tempcommitteemembersall.stream()
			 													.sorted(Comparator.comparingInt(e -> Integer.parseInt(e[11].toString()))).collect(Collectors.toList());
			 				}
			 			%>
 
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
							                    	<th>Member Type</th>
							                   		<%if(loginTypes.contains(logintype)) {%>
							                   			<th>Action</th>  
							                   		<%} %>
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
			              									<td><%=obj[2].toString() %>,<%=obj[4].toString() %></td>
			              									<td> 
																<%  if(obj[8].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
																	else if(obj[8].toString().equalsIgnoreCase("CS") ){	 %> Member Secretary<%}
																	else if(obj[8].toString().equalsIgnoreCase("CH") ){	 %> Co-Chairperson<%}
																	else if(obj[8].toString().equalsIgnoreCase("PS") ) { %>Member Secretary (Proxy) <%}
																	else if(obj[8].toString().equalsIgnoreCase("CI")){   %> Internal<%}
																	else if(obj[8].toString().equalsIgnoreCase("CW")){	 %> External(<%=obj[12] %>)<%}
																	else if(obj[8].toString().equalsIgnoreCase("CO")){	 %> External(<%=obj[12]%>)<%}
																	else if(obj[8].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
																	else if(obj[8].toString().equalsIgnoreCase("I")){	 %> Addl. Internal<%}
																	else if(obj[8].toString().equalsIgnoreCase("W") ){	 %> Addl. External(<%=obj[12] %>)<%}
																	else if(obj[8].toString().equalsIgnoreCase("E") )    {%> Addl. External(<%=obj[12] %>)<%}
																    // Prudhvi - 27/03/2024 start
																	else if(obj[8].toString().equalsIgnoreCase("CIP") )    {%> Industry Partner(<%=obj[12] %>)<%}
																	else if(obj[8].toString().equalsIgnoreCase("IP") )    {%> Addl. Industry Partner(<%=obj[12] %>)<%}
																%>
										
															</td>
												            <%if(loginTypes.contains(logintype)) {%> 
																<td class="center">
																	<button class="btn btn-danger " type="submit" name="committeememberid" value="<%=obj[0] %>" style="background-color: white;border-color: white;"
																		formaction="CommitteeMemberDelete.htm" formmethod="POST" formnovalidate="formnovalidate"
																	  onclick="return confirm('Are You Sure To Delete this Member?');" >
																	  	<i class="fa fa-trash fa-lg" aria-hidden="true"></i>
																	  </button>
																</td>
															<%} %>
			              								</tr>
		              								<%}%>
		              							<tr>
			              							<td colspan=1 style="display: flex;justify-content: center;align-items: center">
										              	<input type="hidden" name="committeemainid" value="<%=committeemainid%>">
										              	<input type="hidden" name="committeeId" value="<%=committeeId%>">
										              	<input type="hidden" name="programmeId" value="<%=programmeId%>">
										              	<input type="hidden" name="prgmflag" value="Y">
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
						
						<!-- ---------------------------------------------------------------------committee main members ---------------------------------------------- -->

				       <hr>
				       <br>
						
						<%if(chairperson!=null) {%>
		      			<div class="row" >	
		     	  		
							<table align="center">
								<tr>
 									<!-- <td>				
 										<button class="btn btn-primary btn-sm back" type="button"  onclick="submitForm('backfrm');">BACK</button> 						
 									</td> -->
		 							<%-- <td>
										<form  method="post" action="CommitteeConstitutionLetter.htm" target="_blank" >
											<button  type="submit" class="btn btn-sm preview"  >LETTER</button>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
											<input type="hidden" name="committeemainid" value="<%=committeemainid%>">
										</form>
									</td> --%>
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
										
								 	<%-- <td>
										<form  method="post" action="ProjectCommitteeDescriptionTOREdit.htm">
											<button  type="submit" class="btn btn-sm edit">DESCRIPTION</button>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
											<input type="hidden" name="committeemainid" value="<%=committeemainid%>">		
											<input type="hidden" name="operation" value="approve">								
										</form>
									</td> --%>								
								</tr>
							</table>
						</div>	
						<%} %>
						<!-- ------------------------------------- add new members ---------------------------------------------------------------- -->
	
						<div class="row">
							<div class="col-md-6" style="margin-left: 15px;">
								<label  style="margin-bottom: 4px !important" for="repids"> Add More Members</label>
								<hr>
								<!-- -------------------------------------- Internal members -------------------------------------------- -->
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
															<input type="hidden" name="InternalLabCode" value="<%=labcode%>"> 	
															</div>
														</td>
													</tr>																
												</tbody>
											</table>
										</div>
													
										<div class="col-md-2 align-self-center">	
											<button class="btn  btn-sm submit" name="submit" type="submit" onclick="return confirm('Are you Sure to Add this Member(s)');"  >SUBMIT</button>
										</div>									
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" name="committeemainid" value="<%=committeemainid%>"> 
										<input type="hidden" name="committeeId" value="<%=committeeId%>">
										<input type="hidden" name="programmeId" value="<%=programmeId%>">
										<input type="hidden" name="prgmflag" value="Y">
									</div>
								</form>
								<!-- --------------------------------------Internal members -------------------------------------------- -->
								
								
								<!-- --------------------------------------External MembersWithin DRDO -------------------------------------------- -->
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
																	    if(!labcode.equals(obj[3].toString())){%>
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
											<button class="btn  btn-sm submit" name="submit" value="add" type="submit" onclick="return confirm('Are you Sure to Add this Member(s)');" >SUBMIT</button>
										</div>
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" name="committeemainid" value="<%=committeemainid%>"> 
										<input type="hidden" name="committeeId" value="<%=committeeId%>">
										<input type="hidden" name="programmeId" value="<%=programmeId%>">
										<input type="hidden" name="prgmflag" value="Y">
									</div>
								</form>
								<!-- --------------------------------------External Members Within DRDO -------------------------------------------- -->
								<!-- --------------------------------------External Members Outside DRDO -------------------------------------------- -->
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
														<td >
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
											<button class="btn  btn-sm submit" name="submit" value="add" type="submit" onclick="return confirm('Are you Sure to Add this Member(s)');" >SUBMIT</button>
										</div>	
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />											
										<input type="hidden" name="committeemainid" value="<%=committeemainid%>">
										<input type="hidden" name="committeeId" value="<%=committeeId%>"> 
										<input type="hidden" name="programmeId" value="<%=programmeId%>">
										<input type="hidden" name="prgmflag" value="Y">
									</div>
								</form>
								<!-- --------------------------------------External Members Outside DRDO -------------------------------------------- -->
								<!-- Prudhvi - 27/03/2024 start -->
								<!-- -------------------------------------- Industry Partner -------------------------------------------- -->
								<form action="CommitteeMainMembersSubmit.htm" method="post"  >				
									<div class="row">				
										<div class="col-md-9">
											<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="table1" style="margin-top: 10px;">
												<thead>  
													<tr id="">
														<th colspan="2"> Industry Partner</th>
													</tr>
												</thead>
												<tr class="tr_clone1">
													<td style="width:30%">							
														<div class="input select">
															<select class="form-control selectdee" name="industryPartnerId" tabindex="-1"  style="" id="industryPartnerId" onchange="industrypartnerrepname()" required>
																<option disabled="true"  selected value="">Industry Partner</option>
																	<% for (IndustryPartner partner : industryPartnerList) {
																	%>
																		<option value="<%=partner.getIndustryPartnerId()%>"
																		data-subtext="(<%=partner.getIndustryCity()+" - "+partner.getIndustryPinCode() %>)"
																		><%=partner.getIndustryName()%> (<%=partner.getIndustryCity()+" - "+partner.getIndustryPinCode() %>)</option>
																		
																	<%}%>
															</select>
															<input type="hidden" name="industrypartnerlabid" value="@IP" />
														</div>
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
						 								<input type="hidden" name="rep" id="rep4" value="0" />
													</td>
													<td style="width:70%">
														<div class="input select ">
															<select class="form-control selectdee" name="industryPartnerRep" id="industryPartnerRep" data-live-search="true"   data-placeholder="Select Members" multiple>
															</select>
														</div>
													</td>						
												</tr>
											</table>
										</div>
										<div class="col-md-2 align-self-center">					
											<button class="btn  btn-sm submit" name="submit" value="add" type="submit" onclick="return confirm('Are you Sure to Add this Member(s)');" >SUBMIT</button>
										</div>	
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />											
										<input type="hidden" name="committeemainid" value="<%=committeemainid%>">
										<input type="hidden" name="committeeId" value="<%=committeeId%>">
										<input type="hidden" name="programmeId" value="<%=programmeId%>">
										<input type="hidden" name="prgmflag" value="Y"> 
									</div>
								</form>
								<!-- -------------------------------------- Industry Partner -------------------------------------------- -->
								<!-- Prudhvi - 27/03/2024 end -->
							</div>
				
							<div class="col-md-5">
								<div class="row">	
									<div  class="col-md-12" style="margin-top: 20px; margin-left: 20px;">
										<form action="CommitteeRepMemberAdd.htm" method="post">
											<table style="width: 100%;">	
												<tr>
													<td colspan="2">
										           		<label  style="margin-bottom: 4px !important" for="repids"> Add Representatives </label>
										           	</td>
										        </tr>   	
										        <tr>
											    	<td style="width: 60%;">
											  			<select class="form-control selectdee" id="repids" name="repids" style="" data-placeholder="Select Rep Types" multiple="multiple" >
															<option  disabled="disabled" value="0">Choose...</option>
															<%	for (Object[] obj  : committeerepnotaddedlist) {%>
														     	<option value="<%=obj[0]%>" ><%=obj[2]%>  </option>
															<% } %>
														</select>
													</td>
													<td style="width: 20%;"> 		  					
											     	  	<button class="btn  btn-sm submit" type="submit"  onclick="return confirm('Are you Sure to Add this Representatives(s)');" >SUBMIT</button>
											     	</td>
										     	</tr>							
											</table>
											
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />											
											<input type="hidden" name="committeemainid" value="<%=committeemainid%>"> 
											<input type="hidden" name="committeeId" value="<%=committeeId%>">
											<input type="hidden" name="programmeId" value="<%=programmeId%>">
											<input type="hidden" name="prgmflag" value="Y">
										</form>						
									</div>
								</div>
								<div class="row">	
									<div  class="col-md-12" style="margin-top: 20px; margin-left: 20px;">
										<h5 style="color: #FF5733">Representatives</h5>
										<hr>						
										<table border='0'>
											<tbody>
												<%if(committeeMemberreplist.size()>0){
													int count = 1;
													for (Object[] obj : committeeMemberreplist) { %>
														<tr id="repmem<%=obj[0] %>">
															<td><sp> <%=obj[3]%> </sp></td>
															<td>
																<button class="fa fa-trash btn btn-danger " type="button"  style="background-color: white;border-color: white;" onclick="memberrepdelete('<%=obj[0] %>');" ></button>
															</td>
														</tr>
											 	<%	count++; 	} } %>
											</tbody>
										</table>						
									</div>
								</div>	
							</div>
								
						</div>
					</div>
				</div>
			</div>
		</div>					
				
		<!-- --------------------------------------External Members Outside DRDO -------------------------------------------- -->
				
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
						committeemainid : '<%=committeemainid%>'
					   },
					datatype : 'json',
					success : function(result) {
						var result = JSON.parse(result);
						
						var values = Object.keys(result).map(function(e) {
		 					return result[e]
							  
						});
						console.log(values.length);
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
						committeemainid : '<%=committeemainid%>'
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
	 
	chairpersonfetch('0');
	msfetch('0');
	/* ccchairpersonfetch('0') */
}); 

	
		function chairpersonfetch(hint){
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
								if(hint=='0' && $CpLabCode =='<%=chairperson!=null?chairperson[9]:"-"%>'){
									$('#chairperson').val('<%=chairperson!=null?chairperson[5]:"-"%>');
								}
															
							}
						});
		
		}
	}
		
		function msfetch(hint){
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
							 <%if(secretary!=null){ %>
							if(hint=='0' && $CpLabCode =='<%=secretary[9]%>'){
								$('#secretary').val('<%=secretary[5]%>');
							}
								<%}%>						
						}
					});
	
	}
		}
		<%-- function ccchairpersonfetch(hint){
			$('#co_chairperson').val("");
			var $CpLabCode = $('#ccplabocode').val();
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
							 
							$('#co_chairperson').html(s);
							<%if(co_chairperson!=null){%>
							if(hint=='0' && $CpLabCode =='<%=co_chairperson[9]%>'){
								$('#co_chairperson').val('<%=co_chairperson[5]%>');
							}
							<%}%>							
						}
					});
	
	}
		}	 --%>
</script>

<script>

function Add(myfrm){

    
    var fieldvalues = $("select[name='Member']").map(function(){return $(this).val();}).get();
    
    var $chairperson = $("#chairperson").val();
    var $cplabCode = $('#CpLabCode').val();
    var $LabCode = '<%=labcode%>';
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
function industrypartnerrepname(){

	$('#industryPartnerRep').val("");
	
		var $industryPartnerId = $('#industryPartnerId').val();
	
		
				if($industryPartnerId!=""){
		
							$
								.ajax({

								type : "GET",
								url : "IndustryPartnerRepListInvitationsMainMembers.htm",
								data : {
									industryPartnerId : $industryPartnerId,
									committeemainid : '<%=committeemainid %>' 	
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
									+values[i][1] + " (" +values[i][3]+")" 
									+ '</option>';
						} 
						 
						$('#industryPartnerRep').html(s);
						
				
						
					}
				});

}
	}
	
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
</body>

</html>