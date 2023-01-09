<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT APPROVE AD  LIST</title>
<style>
h6{
	color:white;
	font-family: 'Lato',sans-serif;
	font-weight: 800;
}
.card-header{
background-color: #07689f;
color:white;
}
.card{
	border:1px solid black;
}

</style>



</head>
<body>
<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy - hh:mm:ss");
List<Object[]> ProjectActionList=(List<Object[]>) request.getAttribute("ProjectActionList");
List<Object[]> ProjectApproveADList=(List<Object[]>) request.getAttribute("ProjectApproveAdList");
DecimalFormat df=new DecimalFormat("0.00");
NFormatConvertion nfc=new NFormatConvertion();
%>

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	<center>
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </center>
	 <%} %>
	
<br>	
	
<div class="container-fluid">	


	
<div class="row">

	<div class="col-md-12">
		
		<h4 style="margin-top: -20px;color:#055C9D">Project Approvals</h4>
	
			<%if(ProjectApproveADList.size()>0){
				int count=1;
					for(Object[] obj:ProjectApproveADList){ %>
	
			<div class="card shadow-nohover"  style="">
		
				<div class="card-header">
					<div class="row" >
						<div class="col-md-11" style="margin-top: 4px">
							<h6 ><%=count%> . &nbsp;&nbsp;&nbsp;Project Title : <%=obj[2] %> (<%=obj[1] %>)</h6>
						</div>
						
						<form action="PreviewPage.htm" method="POST" name="myfrm" id="myfrm">
						
							<div class="col-md-1">
								<button  type="submit" class="btn btn-warning btn-sm editbasic" > Preview </button>
							</div>
							
							<input type="hidden" name="InitiationId"	value="<%=obj[5] %>" /> 
							
							<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
						
						</form>
						
					</div>
				</div>
		<form action="ProjectApprovalAdSubmit.htm" method="POST" name="myfrm1" id="myfrm<%=obj[5] %>" >	
		
				<div class="card-body"> 
					  <table class="table table-bordered table-hover table-striped table-condensed ">
					      <tbody>
						    
						    		<tr>
						    			<td style="width:20%"> <b>Project Category</b> </td>
						    			<td><%=obj[6] %></td>
						    			<td rowspan="5" style="width:40%">
						      				<textarea rows="6" type="text" class="form-control"   name="Remark" required="required"  placeholder="Enter Remarks here"></textarea>
						    			</td>
						    		</tr>
						    		
						    		<%-- <tr>
						    			<td ><b>Project Title :</b></td>
						    			<td><%=obj[2] %>(<%=obj[1] %>) </td>
						    		</tr> --%>
						    		
						    		<tr>
						    			<td> <b>Security Classification</b> </td>
						    			<td><%=obj[7] %></td>
						    		</tr>
						    		<tr>
						    			<td> <b>Deliverable</b> </td>
						    			<td><%if(obj[8]!=null && obj[8].toString().equalsIgnoreCase("")){ %><%=obj[8] %>
						    			<%}else{ %>
						    			<%="-" %>
						    			<%} %>
						    			<%-- <td><%=obj[8] %></td> --%>
						    		</tr>
						    		
						    		<tr>
						    			<td> <b>Fe Cost (Lakhs) :</b></td>
						    			<td><%=nfc.convert(Double.parseDouble(obj[9].toString())) %></td>
						    		</tr>
						    		
						    		<tr >
						    			<td> <b>Re Cost (Lakhs) :</b></td>
						    			<td><%=nfc.convert(Double.parseDouble(obj[10].toString())) %></td>
						    		</tr>
						    	
						    		<tr>
						    			<td> <b>Duration (Months) :</b> </td>
						    			<td><%=obj[4] %></td>
						    			<td >
						    			<label style="font-size: 17px;font-family: 'Lato',sans-serif;"> <b>&nbsp;Action :&nbsp;&nbsp;&nbsp;</b> </label>
						        			<select class="custom-select" id="Category" required="required" name="Status" onchange="myconfirm(this,'myfrm<%=obj[5] %>')" style="width:85%" >
					    						<option disabled="true"  selected value="">Choose...</option>
					    							<% for (Object[] obj1 : ProjectActionList) {%>
														<option value="<%=obj1[1]%>"><%=obj1[2]%></option>
													<%} %>
					  						</select>
						    			</td> 
						    		</tr>
						    		
						  			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
									<input type="hidden" name="IntiationId"	value="<%=obj[5] %>" />
									<input type="hidden" name="projectcode"	value="<%=obj[1] %>" />  
						 	
						 
						   
						</tbody>
				  </table>
	
				  <table class="table table-bordered table-hover table-striped table-condensed ">
					      <tbody>
					      		<tr>
						    		<td><b>Forwarded By :</b></td>
						    		<td><%=obj[11] %> (<%=obj[12] %>)</td>
						    		<td><b>Forwarded Date :</b></td>
						    		<td><%=sdf.format(obj[13]) %></td>
						    		<td><b>Division Name :</b></td>
						    		<td><%=obj[14] %></td>
						    	</tr>
					      </tbody>
					</table>
				
					
					
	        </div>
	        	</form>
	        	
	        	<form action="" method="POST" name="myfrm" id="myfrm" align="center" style="margin-bottom: 10px;margin-top: -25px">
				                
				     	<button type="submit" class="btn btn-warning btn-sm prints" formaction="PfmsPrint.htm" formtarget="_blank"   >Print Executive Summary</button>&nbsp;&nbsp;
							 
						<button type="submit" class="btn btn-warning btn-sm prints" formaction="PfmsPrint2.htm" formtarget="_blank"  >Print Project Proposal</button>&nbsp;&nbsp;

				        <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				        
				        <input type="hidden" name="IntiationId"	value="<%=obj[5] %>" /> 
				                	
				   </form>
        </div>
        
        <br>
		<%count++;%>
					 <%}} else{%>
					 
					 <div align="center">
					 	
					 	<br><br><br><br>
					
					 	<h2>No Pending Approvals ..!!! </h2>
					 	<br><br>
					 	<a class="btn btn-primary back" href="MainDashBoard.htm" role="button">Back</a>
					 
					 </div>
					 
					 <%} %>
	
	</div>

</div> 
	
</div>	
	
	
	
	
<script type="text/javascript">

function myconfirm(sel,id){


	var text=sel.options[sel.selectedIndex].text;
	
	var message='Are you sure to ' + text ;
	
	 bootbox.confirm({ 
	 		
		    size: "medium",
 			/* message: "<center>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>Are You Sure to  </b></center>"+ text, */
 			message: "<center>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>"+message+"</b></center>" ,
		    buttons: {
		        confirm: {
		            label: 'Yes',
		            className: 'btn-success'
		        },
		        cancel: {
		            label: 'No',
		            className: 'btn-danger'
		        }
		    },
		    callback: function(result){ 
		 
		    	if(result){
		    	
		         $("#"+id).submit(); 
		    	}
		    	else{
		    		event.preventDefault();
		    	}
		    } 
		}) 
	
	
}





</script>
</body>
</html>