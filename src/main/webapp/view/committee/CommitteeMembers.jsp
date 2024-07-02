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
Object[] projectdata=(Object[])request.getAttribute("projectdata"); 
Object[] committeedata=(Object[])request.getAttribute("committeedata");
Object[] divisiondata=(Object[])request.getAttribute("divisiondata"); 
Object[] proposedcommitteemainid=(Object[])request.getAttribute("proposedcommitteemainid"); 
List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("employeelist");
List<Object[]> EmployeeList1=(List<Object[]>)request.getAttribute("employeelist1");

List<Object[]> clusterlist=(List<Object[]>) request.getAttribute("clusterlist");
List<Object[]> AllLabList=(List<Object[]>) request.getAttribute("AllLabList");
List<Object[]> expertlist=(List<Object[]>) request.getAttribute("expertlist");

Object[] initiationdata=(Object[])request.getAttribute("initiationdata");
Object[] approvaldata=(Object[])request.getAttribute("committeeapprovaldata");

List<Object[]> committeemembersall=(List<Object[]>)request.getAttribute("committeemembersall");
Object[] chairperson=null;
Object[] co_chairperson=null;
Object[] secretary =null;
Object[] proxysecretary=null;

String initiationid=committeedata[4].toString();
String divisionid=committeedata[3].toString();
String projectid=committeedata[2].toString();
String committeeid=committeedata[1].toString();
String committeemainid=committeedata[0].toString();
String status=committeedata[9].toString();
String proposedmainid=null;
if(proposedcommitteemainid!=null)
{
	proposedmainid=proposedcommitteemainid[0].toString();
}
List<Object[]> committeerepnotaddedlist=(List<Object[]>)request.getAttribute("committeerepnotaddedlist");
List<Object[]> committeeMemberreplist=(List<Object[]>)request.getAttribute("committeeMemberreplist");

String LabCode = (String)request.getAttribute("LabCode");


Object[]CommitteMainEnoteList = (Object[])request.getAttribute("CommitteMainEnoteList");
%>



<%
for(int i=0;i<committeemembersall.size();i++)
{	
	if(committeemembersall.get(i)[8].toString().equalsIgnoreCase("CC")){
		chairperson = committeemembersall.get(i);
		committeemembersall.remove(i);
		break;
	}
}
for(int i=0;i<committeemembersall.size();i++)
{
	if(committeemembersall.size()>0 && committeemembersall.get(i)[8].toString().equalsIgnoreCase("CS")){
		secretary = committeemembersall.get(i);
		committeemembersall.remove(i);
		break;
	}
}
for(int i=0;i<committeemembersall.size();i++)
{
	if(committeemembersall.size()>0 && committeemembersall.get(i)[8].toString().equalsIgnoreCase("PS")){
		proxysecretary = committeemembersall.get(i);
		committeemembersall.remove(i);
		break;
	}
}
for(int i=0;i<committeemembersall.size();i++)
{
	if(committeemembersall.size()>0 && committeemembersall.get(i)[8].toString().equalsIgnoreCase("CH")){
		co_chairperson = committeemembersall.get(i);
		committeemembersall.remove(i);
		break;
	}
}
String CpLabCode = chairperson[9].toString();

//Prudhvi - 27/03/2024 
/* --------- start -------------- */
List<IndustryPartner> industryPartnerList = (List<IndustryPartner>)request.getAttribute("industryPartnerList");
/* --------- end -------------- */
List<Object[]> constitutionapprovalflow=(List<Object[]>)request.getAttribute("constitutionapprovalflow");

%>

<%
String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
	</div></div>
                    <%} %>

    <br />
   
<div class="container-fluid" style="margin-top: -2%;">
	<div class="row">
		<div class="col-md-12">	
		   
			<div class="card shadow-nohover">	
						
					<div class="card-header">						
						<div class="row">										
							<div class="col-md-12"><h3 style="color:  #055C9D" ><%=committeedata[8] %>
							
								<p style="float: right;">
									
									<%if(Long.parseLong(projectid)>0){ %> Project: <%=projectdata[4] %><%}else if (Long.parseLong(divisionid)>0){ %>  Division: <%=divisiondata[1] %> <%}else if(Long.parseLong(initiationid)>0){ %>Pre-Project: <%=initiationdata[1]%> <%}else{ %>Non-Project<%} %>
									
								</p>
							</h3>
							</div>	
																	
						
						</div>
					</div>
					
<!-- ---------------------------------------------------------------------committee main members ---------------------------------------------- -->
					<div class="card-body">	
						  <form action="CommitteeMainEditSubmit.htm" method="post" id="committeeeditfrm">				
							 <div class="row">							
								<div class="col-md-8" style="margin-top:5px; ">									 
					                    	<label class="control-label" style="margin-bottom: 4px !important">Chairperson<span class="mandatory" style="color: red;">*</span></label>
					                    	<table style="width:100%">
					                        <tr >
												<td style="width:25%; border:0:">
													 <div class="input select" id="cplab-col">
														<select class="form-control selectdee" name="CpLabCode" tabindex="-1" required="required" style="width: 200px" id="CpLabCode" onchange="chairpersonfetch('1')">
															<option disabled="disabled"  selected value="">Lab Name</option>
														    <% for (Object[] obj : AllLabList) {%>
															    <option <%if(chairperson[9].toString().equals(obj[3].toString())){ %>selected <%} %>value="<%=obj[3]%>"><%=obj[3]%></option>
														    <%} %>
														    <option <%if(chairperson[9].toString().equalsIgnoreCase("@EXP")){ %>selected <%} %>value="@EXP">Expert</option>
														</select>
																
													</div>
												</td>										
												<td style="border:0;">
												<div class="input select">
														<select class="form-control selectdee" name="chairperson" id="chairperson" data-live-search="true" required="required"   data-placeholder="Select Chairperson" >
												             
														</select>	
														<input type="hidden" name="cpmemberid" value="<%=chairperson[0]%>"> 										
												</div>														
											</td>						
										</tr>
										</table>
								</div>
							
							
<%-- 								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Member Secretary<span class="mandatory" style="color: red;">*</span></label>
										<select class="form-control selectdee" id="secretary" required="required" name="Secretary"style="margin-top: -5px">
				    						<option disabled="true"  selected value="" >Choose...</option>
				    						<% for (Object[] obj : EmployeeList1) {%>
												<option value="<%=obj[0]%>" <%if(secretary!=null && secretary[5].toString().equals(obj[0].toString())){ %>selected<%} %> ><%=obj[1]%> (<%=obj[3] %>)</option>
											<%} %>
				  						</select>
				  						<%if(secretary!=null){ %>
				  						<input type="hidden" name="msmemberid" value="<%=secretary[0]%>">
				  						<%} %>	
									</div>
								</div> --%>
								<div class="col-md-3">
									<div class="form-group">
										<label class="control-label">Co-Chairperson</label>
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
														    <% for (Object[] obj : AllLabList) {%>
															    <option <%if(secretary[9].toString().equals(obj[3].toString())){ %>selected <%} %>value="<%=obj[3]%>"><%=obj[3]%></option>
														    <%} %>
														    <option <%if(secretary[9].toString().equalsIgnoreCase("@EXP")){ %>selected <%} %>value="@EXP">Expert</option>
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
				    						<% for (Object[] obj : EmployeeList1) {%>
												<option value="<%=obj[0]%>" <%if(proxysecretary!=null && proxysecretary[5].toString().equals(obj[0].toString())){ %>selected<%} %> ><%=obj[1]%>, <%=obj[3] %></option>
											<%} %>
				  						</select>
				  						<%if(proxysecretary!=null){ %>
				  						<input type="hidden" name="psmemberid" value="<%=proxysecretary[0]%>">
				  						<%}%> 
									</div>
								</div>	
							</div>
						
									<!-- prakarsh -->
							<div class="row">
							
							<div class="col-md-3">
							<div class="form-group">
							<label class="control-label">Reference No.</label>
							
												
							<input type="text" class="form-control"   name="Reference No." value="<%= committeedata[11] != null ? committeedata[11] : "--" %>" >
							
							</div>
							</div>
						
							<div class="col-md-4">
				         	<div class="form-group">
				            	<label class="control-label" >Formation Date</label>
				  				<input type="date" class="form-control"  data-date-format="dd/mm/yyyy" id="Formationdate" name="Formationdates"  value="<%= committeedata[12] != null ? committeedata[12] : '-' %>"  >
				        	</div>
				        </div>
							
							</div> 
							<div class="row">			
								<div class="col-md-12" align="center">
					              	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />                  	
									<input type="hidden" name="committeemainid" value="<%=committeemainid%>"> 
									<%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>
				                	<button class=" btn btn-primary btn-sm submit" type="submit"  onclick="Add('committeeeditfrm')" >SUBMIT</button>
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
 				if(committeemembersall.size()>0) 
 				{
 					tempcommitteemembersall=committeemembersall.stream()
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
									<td>

														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
												        <input type="hidden" name="committeemainid" value="<%=committeemainid%>">
												      <%--   <input type="hidden" name="committeememberid" value="<%=obj[0] %>" /> --%> 
												        <%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>
														<button class="fa fa-trash btn btn-danger " type="submit" style="background-color: white;border-color: white;"
															formaction="CommitteeMemberDelete.htm" formmethod="POST" name="committeememberid" value="<%=obj[0] %>"
														  onclick="return confirm('Are You Sure To Delete this Member?');" ></button>
														<%} %>
									
									
									</td>
			              	</tr>
			              	<%}%>
			              	<tr>
			              	<td colspan=1 style="display: flex;justify-content: center;align-items: center">
			              	<input type="hidden" name="committeemainid" value="<%=committeemainid%>">
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
 				
<%-- 				<div class="row">
								<div  class="col-md-4">
									<%if(committeemembersall.size()>0){ %>
										<h5 style="color: #FF5733"> Internal Members</h5> 
										<hr>									
										<table border="0">
											<tbody>
											<%
												int count = 1;
												for (int i=0;i<committeemembersall.size();i++) {
													Object[] obj=committeemembersall.get(i);
													if(obj[9].toString().equalsIgnoreCase(LabCode)){
											%>
											
											<tr>
												<td class="tdclass"><%=count%> )</td> <td> <%=obj[2]%>, <%=obj[4]%></td>
												<td>
													<form action="CommitteeMemberDelete.htm" method="POST" id="commemdel">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
												        <input type="hidden" name="committeemainid" value="<%=committeemainid%>">
												        <input type="hidden" name="committeememberid" value="<%=obj[0] %>" /> 
												        <%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>
														<button class="fa fa-trash btn btn-danger " type="submit" style="background-color: white;border-color: white;"  onclick="return confirm('Are You Sure To Delete this Member?');" ></button>
														<%} %>
													</form>	
												</td>																							
											</tr>
											<%	count++;
												
												}
											}%>
										</tbody>
									</table>						
									<br>	
									<%} %>
								</div>		 		 	
					<%if(committeemembersall.size()>0){ %>
					
				 		<div  class="col-md-4">
						
							<h5 style="color: #FF5733">External Members (Within DRDO)</h5>
								<hr>
							
							 <table border="0">
	
								<tbody>
									<%int count = 1;
										for (int i=0;i<committeemembersall.size();i++) {
											Object[] obj=committeemembersall.get(i);
											if(Long.parseLong(obj[7].toString())>0 && !obj[9].toString().equalsIgnoreCase(LabCode) ){
									%>
									
									<tr>
										<td class="tdclass"><%=count%> )</td><td><%=obj[2]%>, <%=obj[4]%> (<%=obj[9] %>)</td>
										<td>
										<form action="CommitteeMemberDelete.htm" method="POST" id="commemdel">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
										        <input type="hidden" name="committeemainid" value="<%=committeemainid%>">	
										        <input type="hidden" name="committeememberid" value="<%=obj[0] %>" />
										        <%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>
												<button class="fa fa-trash btn btn-danger " type="submit" style="background-color: white;border-color: white;"  onclick="return confirm('Are You Sure To Delete this Member?');" ></button>
												<%} %>
											</form>	
										</td>
									</tr>
									<%	count++; 
										
										}
									} %>
								</tbody>
							</table>						
							<br>	
							
					</div> 
					<%} %>
					
					<%if(committeemembersall.size()>0){ %>
					
					<div  class="col-md-4">
						
						<h5 style="color: #FF5733">Expert Members (Outside DRDO)</h5>
							<hr>						
						 <table border='0'>

							<tbody>
								<%int count = 1;
										for (int i=0;i<committeemembersall.size();i++) {
											Object[] obj=committeemembersall.get(i);
											if(Long.parseLong(obj[7].toString())==0){
									%>
								<tr>
									<td class="tdclass"> <%=count%> )</td> <td> <%=obj[2]%>, <%=obj[4]%></td>
									<td>
										<form action="CommitteeMemberDelete.htm" method="POST" id="commemdel">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									        <input type="hidden" name="committeememberid" value="<%=obj[0] %>" />
									        <input type="hidden" name="committeemainid" value="<%=committeemainid%>">	
									        <%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>
											<button class="fa fa-trash btn btn-danger " type="submit"  style="background-color: white;border-color: white;" onclick="return confirm('Are You Sure To Delete this Member?');" ></button>
											<%} %>
										</form>	
									</td>
								</tr>
								<%	count++; 
										
										}
									} %>
							</tbody>
						</table>						
						<br>	
						
					</div>
					<%} %>
					<!-- Prudhvi - 27/03/2024 start-->
					<%if(committeemembersall.size()>0){ %>
					
					<div  class="col-md-4">
						
						<h5 style="color: #FF5733">Industry Partner</h5>
							<hr>						
						 <table border='0'>

							<tbody>
								<%int count = 1;
										for (int i=0;i<committeemembersall.size();i++) {
											Object[] obj=committeemembersall.get(i);
											if(obj[9].toString().equalsIgnoreCase("@IP")){
									%>
								<tr>
									<td class="tdclass"> <%=count%> )</td> <td> <%=obj[2]%>, <%=obj[4]%></td>
									<td>
										<form action="CommitteeMemberDelete.htm" method="POST" id="commemdel">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									        <input type="hidden" name="committeememberid" value="<%=obj[0] %>" />
									        <input type="hidden" name="committeemainid" value="<%=committeemainid%>">	
									        <%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>
											<button class="fa fa-trash btn btn-danger " type="submit"  style="background-color: white;border-color: white;" onclick="return confirm('Are You Sure To Delete this Member?');" ></button>
											<%} %>
										</form>	
									</td>
								</tr>
								<%	count++; 
										
										}
									} %>
							</tbody>
						</table>						
						<br>	
						
					</div>
					<%} %>
					<!-- end -->
				</div>	 --%>	
						
			
						
	<!-- ---------------------------------------------------------------------committee main members ---------------------------------------------- -->

		       <hr>
		       <br>
		       <%if(status.equals("A")){ %>
		     	  <div class="row" >	
		     	  		
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
				             		<td>
				             		<%if( proposedmainid==null){ %>             		
										<form  method="post" action="CommitteeDetails.htm">
											<button  type="submit" class="btn btn-sm add">CONSTITUTE NEW COMMITTEE</button>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
											<input type="hidden" name="committeeid" value="<%=committeeid%>">
											<input type="hidden" name="projectid" value="<%=projectid %>" >	
											<input type="hidden" name="divisionid" value="<%=divisionid%>"> 		
											<input type="hidden" name="initiationid" value="<%=initiationid%>"> 											
										</form>
											
											
									<%}else if(!proposedmainid.equals(committeemainid)  ){ %>
										<form  method="post" action="CommitteeMainMembers.htm">
											<button  type="submit" class="btn btn-sm add">PROPOSED COMMITTEE</button>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
											<input type="hidden" name="committeemainid" value="<%=proposedcommitteemainid[0]%>"> 											
										</form>
					             		
				             		<%} %>
				             		</td>
			             		
										
								<%if( (Long.parseLong(divisionid)>0 || Long.parseLong(projectid)>0 ||Long.parseLong(initiationid)>0)){ %>
								 	<td>
										<form  method="post" action="ProjectCommitteeDescriptionTOREdit.htm">
											<button  type="submit" class="btn btn-sm edit">DESCRIPTION</button>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
											<input type="hidden" name="committeemainid" value="<%=committeemainid%>">		
											<input type="hidden" name="operation" value="approve">								
										</form>
									</td>								
								<%} %>
								<%if(CommitteMainEnoteList!=null ) {%>
								<td>
									<form  method="post" action="CommitteeFlow.htm">
												<button  type="submit" class="btn btn-sm submit" style="background: #E76F51;border-color: #E76F51"> Approval History </button>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
												<input type="hidden" name="committeemainid" value="<%=committeemainid%>">
												<input type="hidden" name="projectid" value="<%=projectid %>" >	
												<input type="hidden" name="divisionid" value="<%=divisionid%>"> 		
												<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
								</form>	
								</td>
								<%} %>
								</tr>
							</table>
						</div>	
					<%} %>
						
								
							
					<% if(status.equals("P") ){ %>
							<%if(Long.parseLong(approvaldata[8].toString())>0){ %>
								<h4 align="center"><%=approvaldata[7] %></h4>
							<%} %>
						<div class="row" >	
						
							<table align="center">
							
								<tr>
									
			 						<td>				
			 							<button class="btn btn-primary btn-sm back" type="button"  onclick="submitForm('backfrm');">BACK</button> 						
			 						</td>
			 						<!-- Hidden for new Flow  -->
			 					<%-- 	<%if(!approvaldata[5].toString().equals("CCR") ){%>
			 						<td>
			 							<form action="ComConstitutionApprovalHistory.htm" method="POST" id="commemdel" target="_blank">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
										    <input type="hidden" name="committeemainid" value="<%=committeemainid%>">
											<button class="btn  btn-sm "  style="background-color: #ff8400;color:white;font-weight:800 !important;font-family: 'Montserrat', sans-serif;"  type="submit"  >History</button>
										</form>	
									</td>
									<%} %> --%>
									
			 						<td>
									<%-- 	<%if(status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) { %>
											<form  method="post" action="CommitteeMainApproval.htm">
												<button  type="submit" class="btn btn-sm submit">Preview</button>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
												<input type="hidden" name="committeemainid" value="<%=proposedcommitteemainid[0]%>">
												<input type="hidden" name="operation" value="approve">
												<input type="hidden" name="approvalauthority" value="0"> 
												<input type="hidden" name="redirect" value="1">
											</form>		
										<%} %>	 --%>
										
									<%
									
									if(status.equals("P") ) { %>
									<form  method="post" action="CommitteeFlow.htm">
												<button  type="submit" class="btn btn-sm submit">Preview</button>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
												<input type="hidden" name="committeemainid" value="<%=proposedcommitteemainid[0]%>">
												<input type="hidden" name="projectid" value="<%=projectid %>" >	
												<input type="hidden" name="divisionid" value="<%=divisionid%>"> 		
												<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
										</form>		
										<%} %>	
										
									</td>	
								</tr>
							</table>	
							
								</div> 
							 	<div class="row mt-3"  style="text-align: center; padding-top: 10px;" >
				                <table  align="center" >
				                	<tr>
				                		<td class="trup" style="background: #B5EAEA;">
				                			Constituted By
				                		</td>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td >
				                		
				                		<td class="trup" style="background: #C6B4CE;">
				                			Group Head
				                		</td>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td>
				                		
				                		<td class="trup" style="background: #E8E46E;">
				                			P&C DO
				                		</td>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td>
				                		
				                		<td class="trup" style="background: #FBC7F7;" >
				                			Director
				                		</td>
				                			                		
				                	</tr>			   
				                	
				                	<tr>
				                		<td class="trdown" style=" background:#B5EAEA; " >	
				                			<%if(constitutionapprovalflow.size()>0){ %>
								                     <%for(Object[] obj : constitutionapprovalflow){ %>
								                     	<%if(obj[3].toString().equals("Constituted By") ){ %>
								                     		<%=obj[1] %>,<%=obj[2] %>
								                     	<%} %>
								                     <%} %>
								               <%} %>
				                		</td>
				                		<td class="trdown"  style="background: #C6B4CE;" >	
				                			 <%if(constitutionapprovalflow.size()>0){ %>
								                     <%for(Object[] obj : constitutionapprovalflow){ %>
								                     	<%if(obj[3].toString().equals("Group Head") ){ %>
								                     		<%=obj[1] %>,<%=obj[2] %>
								                     	<%} %>
								                     <%} %>
								               <%} %>   
				                		</td>
				                		<td class="trdown" style="background: #E8E46E;" >	
				                			<%if(constitutionapprovalflow.size()>0){ %>
								                     <%for(Object[] obj : constitutionapprovalflow){ %>
								                     	<%if(obj[3].toString().equals("DO-RTMD") ){ %>
								                     		<%=obj[1] %>,<%=obj[2] %>
								                     	<%} %>
								                     <%} %>
								               <%} %>    
				                		</td>
				                		<td class="trdown" style="background: #FBC7F7;" >	
				                			 <%if(constitutionapprovalflow.size()>0){ %>
								                     <%for(Object[] obj : constitutionapprovalflow){ %>
								                     	<%if(obj[3].toString().equals("Director") ){ %>
								                     		<%=obj[1] %>,<%=obj[2] %>
								                     	<%} %>
								                     <%} %>
								               <%} %>
				                		</td>
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
													                <%for(Object[] obj:EmployeeList){ %>																							
																		<option value="<%=obj[0]%>"><%=obj[1]%>, <%=obj[2]%></option>																				
																	<%} %>
																	</select>
																<input type="hidden" name="InternalLabCode" value="<%=LabCode%>"> 	
																</div>
															</td>
														</tr>																
													</tbody>
												</table>
											</div>
											
										<div class="col-md-2 align-self-center">	
										<%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>				
											<button class="btn  btn-sm submit" name="submit" type="submit" onclick="return confirm('Are you Sure to Add this Member(s)');"  >SUBMIT</button>
											<%} %>							
										</div>									
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" name="committeemainid" value="<%=committeemainid%>"> 
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
																    <% for (Object[] obj : AllLabList) {
																    if(!LabCode.equals(obj[3].toString())){%>
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
										<%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>
										<button class="btn  btn-sm submit" name="submit" value="add" type="submit" onclick="return confirm('Are you Sure to Add this Member(s)');" >SUBMIT</button>
										<%} %>							
									</div>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" name="committeemainid" value="<%=committeemainid%>"> 
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
												            	<%for(Object[] obj:expertlist){ %>																									
																	<option value="<%=obj[0]%>"><%=obj[1]%>, <%=obj[2]%></option>	
																													
																<%} %>
																					
															</select>
														
														</div>
													</tr>
												</table>
									</div>
									<div class="col-md-2 align-self-center">					
										<%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>
										<button class="btn  btn-sm submit" name="submit" value="add" type="submit" onclick="return confirm('Are you Sure to Add this Member(s)');" >SUBMIT</button>
										<%} %>							
									</div>	
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />											
									<input type="hidden" name="committeemainid" value="<%=committeemainid%>"> 
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
										<%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>
										<button class="btn  btn-sm submit" name="submit" value="add" type="submit" onclick="return confirm('Are you Sure to Add this Member(s)');" >SUBMIT</button>
										<%} %>							
									</div>	
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />											
									<input type="hidden" name="committeemainid" value="<%=committeemainid%>"> 
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
														<%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>
										     	  		<button class="btn  btn-sm submit" type="submit"  onclick="return confirm('Are you Sure to Add this Representatives(s)');" >SUBMIT</button>
										     	  		<%} %>
										     	   </td>
									     	   </tr>							
											</table>
										
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />											
											<input type="hidden" name="committeemainid" value="<%=committeemainid%>"> 
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
														for (Object[] obj : committeeMemberreplist) {
													%>
													<tr id="repmem<%=obj[0] %>">
														<td><sp> <%=obj[3]%> </sp></td>
														<td>
															<%if(status.equals("A") || (status.equals("P") && (approvaldata[5].toString().equals("RTDO") || approvaldata[5].toString().equals("CCR"))) ){ %>
															<button class="fa fa-trash btn btn-danger " type="button"  style="background-color: white;border-color: white;" onclick="memberrepdelete('<%=obj[0] %>');" ></button>
															<%} %>
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
				
					<%if(Long.parseLong(projectid)>0){ %>
						<form method="post" action="ProjectMaster.htm" name="backfrm" id="backfrm">
							<input type="hidden" name="projectid" value="<%=projectid%>"/>							
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					<%}else if(Long.parseLong(divisionid)==0 && Long.parseLong(projectid)==0 && Long.parseLong(initiationid)==0){ %>
						<form method="post" action="CommitteeList.htm" name="backfrm" id="backfrm">
							<input type="hidden" name="projectid" value="<%=projectid%>"/> 							
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />								
							<input type="hidden" name="projectappliacble" value="N">		
						</form>
					<%}else if(Long.parseLong(divisionid)>0 ){ %>
	       				<form method="post" action="DivisionCommitteeMaster.htm" name="backfrm" id="backfrm">
							<input type="hidden" name="divisionid" value="<%=divisionid %>">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />									
						</form>		
		      		<%}else if(Long.parseLong(initiationid)>0 ){ %>
		      			<form method="post" action="InitiationCommitteeMaster.htm" name="backfrm" id="backfrm">
							<input type="hidden" name="initiationid" value="<%=initiationid %>">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />									
						</form>	      		
		      		<% } %>
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
								if(hint=='0' && $CpLabCode =='<%=chairperson[9]%>'){
									$('#chairperson').val('<%=chairperson[5]%>');
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
							if(hint=='0' && $CpLabCode =='<%=secretary[9]%>'){
								$('#secretary').val('<%=secretary[5]%>');
							}
														
						}
					});
	
	}
		}
		
</script>

<script>

function Add(myfrm){

    
    var fieldvalues = $("select[name='Member']").map(function(){return $(this).val();}).get();
    
    var $chairperson = $("#chairperson").val();
    var $cplabCode = $('#CpLabCode').val();
    var $LabCode = '<%=LabCode%>';
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
$( document ).ready(function() {
	var formationDate=new Date(<%=committeedata[12]%>)
	console.log("formationDate --- "+formationDate)
	console.log("hiii")
});

</script>
<!-- Prudhvi 27/03/2024 end -->	
</body>

</html>