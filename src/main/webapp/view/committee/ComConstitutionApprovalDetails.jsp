<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/committeeModule/ComConstitutionApprovalDetails.css" var="ComConstitutionApprovalDetails" />
<link href="${ComConstitutionApprovalDetails}" rel="stylesheet" />
<title>COMMITTEE MEMBERS</title>
</head>
<body>
<%
String seslabid = (String) session.getAttribute("labid");

Object[] projectdata = (Object[]) request.getAttribute("projectdata");
Object[] committeedata = (Object[]) request.getAttribute("committeedata");
Object[] divisiondata = (Object[]) request.getAttribute("divisiondata");
Object[] proposedcommitteemainid = (Object[]) request.getAttribute("proposedcommitteemainid");

List<Object[]> approvalstatuslist = (List<Object[]>) request.getAttribute("approvalstatuslist");

Object[] initiationdata = (Object[]) request.getAttribute("initiationdata");
Object[] approvaldata = (Object[]) request.getAttribute("committeeapprovaldata");

List<Object[]> committeemembersall = (List<Object[]>) request.getAttribute("committeemembersall");

List<Object[]> constitutionapprovalflow = (List<Object[]>) request.getAttribute("constitutionapprovalflow");
Object[] chairperson = null;
Object[] secretary = null;
Object[] proxysecretary = null;

String initiationid = committeedata[4].toString();
String divisionid = committeedata[3].toString();
String projectid = committeedata[2].toString();
String committeeid = committeedata[1].toString();
String committeemainid = committeedata[0].toString();
String status = committeedata[9].toString();

List<Object[]> committeeMemberreplist = (List<Object[]>) request.getAttribute("committeeMemberreplist");
%>


<%for(int i=0;i<committeemembersall.size();i++)
{	
	if(committeemembersall.get(i)[8].toString().equalsIgnoreCase("CC")){
		chairperson=committeemembersall.get(i);
		committeemembersall.remove(i);
	}
}
for(int i=0;i<committeemembersall.size();i++){
	if(committeemembersall.size()>0 && committeemembersall.get(i)[8].toString().equalsIgnoreCase("CS")){
		secretary=committeemembersall.get(i);
		committeemembersall.remove(i);
	}
}
for(int i=0;i<committeemembersall.size();i++){
	if(committeemembersall.size()>0 && committeemembersall.get(i)[8].toString().equalsIgnoreCase("PS")){
		proxysecretary=committeemembersall.get(i);
		committeemembersall.remove(i);
	}

}%>

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

    <br />
   
    
<div class="container-fluid mt-n2">
	<div class="row">
		<div class="col-md-12">	
			<div class="card shadow-nohover">	
						
					<div class="card-header">						
						<div class="row">										
							<div class="col-md-12">
							<h4 class="h4Color"><%=committeedata[8]!=null?StringEscapeUtils.escapeHtml4(committeedata[8].toString()): " - " %>
							
								<p class="float-right">
									
										<%if(Long.parseLong(projectid)>0){ %> Project : <%=projectdata[4]!=null?StringEscapeUtils.escapeHtml4(projectdata[4].toString()): " - " %><%}else if (Long.parseLong(divisionid)>0){ %>  Division : <%=divisiondata[1]!=null?StringEscapeUtils.escapeHtml4(divisiondata[1].toString()): " - " %> <%}else if(Long.parseLong(initiationid)>0){ %>Pre-Project : <%=initiationdata[1]!=null?StringEscapeUtils.escapeHtml4(initiationdata[1].toString()): " - "%> <%} %> (Approval Pending)
									
								</p>
							</h4>
							</div>				
						</div>
					</div>
<!-- ---------------------------------------------------------------------committee main members ---------------------------------------------- -->
					<div class="card-body">	
							 <div class="row">							
								<div class="col-md-4 mt-5px">									 
					                    	<label class="control-label chairPerson">Chairperson</label>
					                    	<table class="w-100">
					                        <tr >
												<td class="w-25 border-0">
													 <div class="input select">
														<%=chairperson[2]!=null?StringEscapeUtils.escapeHtml4(chairperson[2].toString()): " - " %>(<%=chairperson[4]!=null?StringEscapeUtils.escapeHtml4(chairperson[4].toString()): " - "%>)(<%=chairperson[9]!=null?StringEscapeUtils.escapeHtml4(chairperson[9].toString()): " - "%>)
													</div>
												</td>										
																		
											</tr>
											</table>
								</div>
							
							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Member Secretary</label>
										<table class="w-100">
					                        <tr >
												<td class="w-25 border-0">
													 <div class="input select">
														<%=secretary[2]!=null?StringEscapeUtils.escapeHtml4(secretary[2].toString()): " - " %>(<%=secretary[4]!=null?StringEscapeUtils.escapeHtml4(secretary[4].toString()): " - "%>)(<%=secretary[9]!=null?StringEscapeUtils.escapeHtml4(secretary[9].toString()): " - "%>)
													</div>
												</td>										
											</tr>
										</table>
				  						
									</div>
								</div>

							 
							<%if(proxysecretary!=null){ %>
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Member Secretary (Proxy)</label>
										<table class="w-100">
					                        <tr >
												<td class="w-25 border-0">
													 <div class="input select">
														<%=proxysecretary[2]!=null?StringEscapeUtils.escapeHtml4(proxysecretary[2].toString()): " - " %>(<%=proxysecretary[4]!=null?StringEscapeUtils.escapeHtml4(proxysecretary[4].toString()): " - "%>)(<%=proxysecretary[9]!=null?StringEscapeUtils.escapeHtml4(proxysecretary[9].toString()): " - "%>)
													</div>
												</td>										
											</tr>
										</table>
				  						
									</div>
								</div>	
							<%} %>				
							</div> 
							
				<br>
<!-- 	------------------------------------------------------------------------------- internal and external members----------------------------------------------------------
 -->			<%if(committeemembersall.size()>0 ){ %>
 					<hr class="hr-pt hr-pb">
 				<%} %>
				<div class="row">
								<div  class="col-md-4">
									<%if(committeemembersall.size()>0){ %>
										<h5 class="internalMembersColor"> Internal Members</h5> 
										<hr>									
										<table class="border-0">
											<tbody>
											<%
												int count = 1;
												for (int i=0;i<committeemembersall.size();i++) {
													Object[] obj=committeemembersall.get(i);
													if(obj[7].toString().equalsIgnoreCase(seslabid)){
											%>
											
											<tr>
												<td class="tdclass"><%=count%> )</td> <td> <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%> (<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>)</td>
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
						
							<h5 class="internalMembersColor">External Members (Within DRDO)</h5>
								<hr>
							
							 <table border='0'>
	
								<tbody>
									<%int count = 1;
										for (int i=0;i<committeemembersall.size();i++) {
											Object[] obj=committeemembersall.get(i);
											if(Long.parseLong(obj[7].toString())>0 && !obj[7].toString().equalsIgnoreCase(seslabid) ){
									%>
									
									<tr>
										<td class="tdclass"><%=count%> )</td> <td> <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%> (<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>) (<%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - " %>)</td>
										
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
						
						<h5 class="internalMembersColor">External Member (Outside DRDO)</h5>
							<hr>						
						 <table border='0'>

							<tbody>
								<%int count = 1;
										for (int i=0;i<committeemembersall.size();i++) {
											Object[] obj=committeemembersall.get(i);
											if(Long.parseLong(obj[7].toString())==0){
									%>
								<tr>
									<td class="tdclass"> <%=count%> )</td> <td> <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%> (<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>) (<%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - " %>)</td>
								</tr>
								<%	count++; 
										
										}
									} %>
							</tbody>
						</table>						
						<br>	
						
					</div>
					<%} %>
				</div>		
						<div class="row">	
							<div  class="col-md-6 mt-10">
								<h5 class="internalMembersColor">Representatives</h5>
								<hr>						
								<table border='0'>
									<tbody>
										<%if(committeeMemberreplist.size()>0){
											int count = 1;
											for (Object[] obj : committeeMemberreplist) {
										%>
											<tr id="repmem<%=obj[0] %>">
												<td><sp> <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%> </sp></td>
											</tr>
										<%	count++; 	
											}
										}else {%>
											<tr><td>No Representatives Found</td></tr>
										<%}%>
									</tbody>
								</table>						
							</div>
							<div  class="col-md-6">
								<br>
								<h4 align="center"><%=approvaldata[7]!=null?StringEscapeUtils.escapeHtml4(approvaldata[7].toString()): " - " %></h4>
								<%if(approvaldata[4]!=null){ %>  <!-- approvaldata[5].toString().equals("RTSC") || approvaldata[5].toString().equals("RTDG") ||approvaldata[5].toString().equals("RTDR") || approvaldata[5].toString().equals("RTR") || approvaldata[5].toString().equals("RTDO") || -->
								<div class="col-md-row"><h4><%=StringEscapeUtils.escapeHtml4(approvaldata[4].toString())%></h4></div>
								<%} %>
								<form  method="post" action="CommitteeMainApproval.htm" id="approveform">					
									<table border='0' class="w-100">									
										<tr>
											<td>
												<label class="control-label">Remarks</label>
												<span class="float-right"><label class="control-label">Constitution Letter</label>
												<button  type="submit"  class="btn btn-sm edit "  formaction="CommitteeConstitutionLetterDownload.htm" formmethod="post" formtarget="_blank"><i class="fa fa-download fs-90"></i></button>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />    												
											<input type="hidden" name="committeemainid" value="<%=committeemainid%>"></span>
											</td>
										</tr>
										<tr >
											<td  >
												<input class="form-control w-100" name="remarks"  id="remarks" maxlength="150">
											</td>
										</tr>
										
									<%if(approvaldata[5]!=null && approvaldata[5].toString().equals("RDO")){ %>
										<tr >
											<td  >
												<label class="control-label">Approval Authority</label>
											</td>
										</tr>
									
										<tr>
											<td class="hr-pt">
												<select class="form-control selectdee" name="approvalauthority" id="approvalauthority" required="required">
													<option value=" " >Choose...</option>
													<option value="ADR">Director</option>
													<option value="ADG">Director General</option>
													<option value="ASC">Secretary</option>
												</select>
											</td>
										</tr>
									<%}else{ %>
										<input type="hidden" name="approvalauthority" id="approvalauthority" value="0">
									<%} %>
																		
										<tr>
											<td class="hr-pt" align="center" >
												<button  type="button" class="btn btn-sm submit" onclick="return checkremarks('approve')">Approve</button>
											
												<%if(!approvaldata[5].toString().equals("RTDO") && !approvaldata[5].toString().equals("CRR")){ %>
												<button  type="button" class="btn btn-sm btn-danger font-weight-bold" onclick="return checkremarks('return')">Return</button> 
												<%} %>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
												<input type="hidden" name="committeemainid" value="<%=proposedcommitteemainid[0]%>">
											</td>
										</tr>	
									</table>						
								</form>
							</div>
						</div>		
						<br>
						<hr >

		     
					     <div class="row backDivStyle">	
							<table align="center">
								<tr>
									<td>				
						 				<a class="btn btn-primary btn-sm back" type="button" href="CommitteeMainApprovalList.htm" >BACK</a> 						
						 			</td>
								</tr>
							</table>									
				 		</div> 	
				 		<hr>
				 		
						 	<div class="row"  >
						 		<div class="col-md-12 text-center"><b>Approval Flow</b></div>
						 	</div>
						 	<div class="row text-center pt-10px">
				                <table  align="center" >
				                	<tr>
				                		<td class="trup constituteByBg">
				                			Constituted By
				                		</td>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td >
				                		
				                		<td class="trup groupHeadBg">
				                			Group Head
				                		</td>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td>
				                		
				                		<td class="trup p&cdoBg">
				                			P&C DO
				                		</td>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td>
				                		
				                		<td class="trup directorBg">
				                			Director
				                		</td>
				                			                		
				                	</tr>			   
				                	
				                	<tr>
				                		<td class="trdown constituteByBg">	
				                			<%if(constitutionapprovalflow.size()>0){ %>
								                     <%for(Object[] obj : constitutionapprovalflow){ %>
								                     	<%if(obj[3].toString().equals("Constituted By") ){ %>
								                     		<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>
								                     	<%} %>
								                     <%} %>
								               <%} %>
				                		</td>
				                		<td class="trdown groupHeadBg">	
				                			 <%if(constitutionapprovalflow.size()>0){ %>
								                     <%for(Object[] obj : constitutionapprovalflow){ %>
								                     	<%if(obj[3].toString().equals("Group Head") ){ %>
								                     		<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>
								                     	<%} %>
								                     <%} %>
								               <%} %>   
				                		</td>
				                		<td class="trdown p&cdoBg">	
				                			<%if(constitutionapprovalflow.size()>0){ %>
								                     <%for(Object[] obj : constitutionapprovalflow){ %>
								                     	<%if(obj[3].toString().equals("DO-RTMD") ){ %>
								                     		<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>
								                     	<%} %>
								                     <%} %>
								               <%} %>    
				                		</td>
				                		<td class="trdown directorBg">	
				                			 <%if(constitutionapprovalflow.size()>0){ %>
								                     <%for(Object[] obj : constitutionapprovalflow){ %>
								                     	<%if(obj[3].toString().equals("Director") ){ %>
								                     		<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>
								                     	<%} %>
								                     <%} %>
								               <%} %>
				                		</td>
				                	</tr>             	
				                </table>			             
						 	</div>
						 							 						 
				 		</div>
					</div>
				</div>
			</div>
		</div>
	
	<script type="text/javascript">
		function checkremarks(operation)
		{
			
		console.log(operation);
			var remarks=$('#remarks').val();
			var approvalauth=$('#approvalauthority').val();			
			var input2 = $("<input>")
            .attr("type", "hidden")
            .attr("name", "operation").val(operation);
			$('#approveform').append(input2);
			
			if(operation=='return'){
				if(remarks.trim().length==0){
					alert('Please Enter Remarks to Return');
				}
				
				
				else if(remarks.trim().length>0 ){
					
						if(confirm('Are You Sure To Return?')){
							$('#approveform').submit();
						
					}
					
				}
			}else if(operation=='approve'){
				if(approvalauth.trim().length==0){
					
					alert('Please Select Approval Authority');
				}else if(confirm('Are You Sure To Approve?')){
					$('#approveform').submit();
				}
			}
		}
	</script>
				
<!-- --------------------------------------External Members Outside DRDO -------------------------------------------- -->
				
				
<script type="text/javascript">

function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
</script>




	
</body>

</html>