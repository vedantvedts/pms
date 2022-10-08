<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Action Assignee</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x: hidden; 
}
h6{
	text-decoration: none !important;
}


</style>
</head>
 
<body>
  <%

  
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  Object[] Assignee=  (Object[]) request.getAttribute("Assignee");
  List<Object[]> SubList=(List<Object[]> ) request.getAttribute("SubList");
  String AssigneeName=(String) request.getAttribute("AssigneeName");
  String Assigner=(String) request.getAttribute("Assigner");
  List<Object[]> LinkList=(List<Object[]> ) request.getAttribute("LinkList");
  String actionno= (String) request.getAttribute("actionno");
  
  
 %>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center" >
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center" >
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></div>
                    <%} %>

    <br />
    
    


<div class="container-fluid">

	<div class="container" style="margin-bottom:20px;">

		
    		<div class="card" style=" ">
    	
    	
    	
	    		<div class="card-header" style="background-color: #055C9D;">
      				<h6 style="color: white;font-weight: bold;font-size: 1.2rem !important " align="left"> Action  Id : <%=actionno %>
					<span style="float: right;font-size: 17px;margin-top: 5px">Assignee : <%=Assignee[12] %> &nbsp;(<%=Assignee[18] %>)</span>
      				 </h6>
      			</div>
      		
      		
	      		<div class="card-body">
	      			
	        		<div class="row">
	      					<div class="col-md-12">
	      						<table style="width: 100%;">
	      							<tr>
	      								<td style="width: 15%;">
	      									<label style="font-size: medium; padding-top: 10px;  "> Action Item  :</label>
	      								</td>
	      								<td >&nbsp;&nbsp;&nbsp;&nbsp;
	      									 <%=Assignee[5] %>
	      								</td>							
	      							</tr>
	      						</table>
	      						<table>
	      							<tr>
	      								<td>
	      									<label style="font-size: medium; padding-top: 10px;  "> Assignee  :</label>
	      								</td>	      	
	      								<td>&nbsp;&nbsp;&nbsp;&nbsp;
	      									<%=Assignee[12] %>&nbsp;(<%=Assignee[18] %>)
	      								</td>
	      								<td style="padding-left: 50px;" >
	      									<label style="font-size: medium; padding-top: 10px;  "> Assigner :</label>
	      								</td>	      	
	      								<td>&nbsp;&nbsp;&nbsp;&nbsp;
	      									<%=Assignee[1]%> &nbsp;(<%=Assignee[17] %>)
	      								</td>	
	      								<td style="padding-left: 50px;" >
	      									<label style="font-size: medium; padding-top: 10px;  "> PDC (Current) :</label>
	      								</td>	      	
	      								<td>&nbsp;&nbsp;&nbsp;&nbsp;
	      									<%=sdf.format(Assignee[4])%>
	      								</td>	
	      							</tr>
	      							<tr>
	      								<td>
	      									<label style="font-size: medium; padding-top: 10px;  ">  Original PDC :</label>
	      								</td>	      	
	      								<td>&nbsp;&nbsp;&nbsp;&nbsp;
	      									<%=sdf.format(Assignee[14])%>
	      								</td>	
	      								     
	      							<% int revision=Integer.parseInt(Assignee[11].toString());
	      							for(int i=1;i<=revision;i++){ %>
	      							
	      								<td style="padding-left: 50px;" >
	      									<label style="font-size: medium; padding-top: 10px;  "> Revised - <%=i%> PDC:</label>
	      								</td>	      	
	      								<td>&nbsp;&nbsp;&nbsp;&nbsp;
	      									<%=sdf.format(Assignee[15+i-1])%>
	      								</td>	
	      							
	      							<%} %>
	      							</tr>	
	      						</table>      						      					
	      					</div>      				
	      				</div>
	      				<hr>
	      				<br>
						
	          		<div align="center">
	          			<form method="post" action="SendBackSubmit.htm" enctype="multipart/form-data">
	          			
							<input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
							
							<div class="row">
								
								<div class="col-md-1" align="right">
								
								<label>Remarks:</label></div>	
									
								<div class="col-md-7">
									
									<textarea rows="2" style="display:block; margin-top: -15px;" class="form-control"  id="Remarks" name="Remarks"  placeholder="Enter Remarks..!!"  ></textarea>
									
								</div>
								
								<div class="col-md-4">
									<button type="submit" class="btn btn-warning btn-sm edit"  onclick="back()" >Send Back</button>
									<button type="submit" class="btn btn-danger btn-sm revoke"   onclick="close5()" formaction="CloseSubmit.htm"> Close Action</button>
					        		<input type="submit" class="btn btn-primary btn-sm back" value="Back" onclick="close2()" formaction="ActionForwardList.htm"/>
					        		<input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" />	
								</div>
								
							</div>
							                                 
						</form>
						
						
						
				<%if(Integer.parseInt(Assignee[11].toString())<2){ %> 
		    		<br>
		    		<hr><br>
		    		<form method="post"  action="ExtendPdc.htm" >
		          			<div class="row" align="left"> 							
								<div class="col-sm-6" >
									<table>
										<tr>
											<td style="width: 10%">
				                            	<label>Extend PDC <span class="mandatory" style="color: red;">* </span>:</label>
				                            </td>
				                            <td style="width: 20%">
				                            	<input class="form-control " name="ExtendPdc" id="DateCompletion" required="required"  value="<%=sdf.format(Assignee[4])%>" style=" margin-top: -4px; ">
				                           	</td>
				                           	<td style="width: 20%">
												<button type="submit" class="btn btn-danger btn-sm submit"   onclick="return confirm('Are You Sure To Submit ?')" > UPDATE</button>
												<input type="hidden" name="ActionMainId" value="<%=Assignee[0] %>" />	
												<input type="hidden" name="froward" value="Y" />
												<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
											</td>
										</tr> 
									</table>
								</div>
							</div>
		      			</form>
		      			<br>
		      			<hr>
	      		<%} %>
						
	          		</div>		
			    
	      		
	    		</div>
    		</div>
   	</div>   
   </div>  
 <div class="row" style="margin-top: 20px;">
 
	<div class="col-md-12">
    	
    	<div class="card" style="">
      		
      		<div class="card-body" >
      		
      		
      		 <div class="row">
      		
<div class="col-md-1"></div>
   
   <div class="col-md-10" style="padding-left: 0px">
    <% if(LinkList.size()>0){ %>  
   				<div class="table-responsive">
    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" style="margin-top: 20px;">
						<thead>
							<tr>
								<th colspan="7" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;text-transform: capitalize;" >Old Action  Details </th>									
							</tr>	
							<tr>					
								<th style="text-align: left;">As On Date</th>
								<th style="">Progress %</th>
								<th style="">Remarks</th>								
							 	<th style="">Attachment</th>
							 	<!-- <th style="">Upload</th> -->
								<th style="">Action</th>
							</tr>
						</thead>
						<tbody>					
						<%
						for(Object[] obj: LinkList){ %>
														
							<tr>
								<td width="12%">
									<%=sdf.format(obj[3])%>
								</td>
								
								<td width="6%">
									
									<div class="progress" style="background-color:#cdd0cb !important">
  										<div class="progress-bar progress-bar-striped" role="progressbar" style="width: <%=obj[2]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><%=obj[2]%></div>
									</div>
				
										</td>
								
								<td style="text-align: left; width: 10%;"> 
									<%=obj[4]%>
								</td>
								
								<td style="text-align: left; width: 3%;">
								
							 <% 
						        if(obj[5].toString().length()!=0 && obj[5]!=null){
						        %>
						        <div  align="center">
										<a  
										 href="ActionAttachDownload.htm?ActionSubId=<%=obj[7]%>" 
										 target="_blank"><i class="fa fa-download"></i></a>
									</div>
								
									
								<%}else{ %>
								
								<div  align="center">-</div>
								 <%} %>
									
						
								</td>
								
														
								<td style="text-align: left; width: 6%;">
							     Old Action
								</td>
						
						</tr>
														
							<%  } %>	
									</tbody>
					</table>
				</div> 
				<%} %>
   						<div class="table-responsive">
    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" style="margin-top: 20px;">
						<thead>
						<tr>
								<th colspan="4" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;text-transform: capitalize;" >Action Updated Details </th>									
							</tr>	
							<tr>					
								<th style="text-align: left;">As On Date</th>
								<th style="">Progress %</th>
								<th style="">Remarks</th>								
							 	<th style="">Attachment</th>
							
							</tr>
						</thead>
						<tbody>					
											
					 	<%int  count=1;
						for(Object[] obj: SubList){ %>
														
						<tr >
						
							 
							
		
								<td width="12%">
									<%=sdf.format(obj[3])%>
								</td>
								
								<td width="6%">
								
									<div class="progress" style="background-color:#cdd0cb !important">
  										<div class="progress-bar progress-bar-striped" role="progressbar" style="width: <%=obj[2]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><%=obj[2]%></div>
									</div>
				
										</td>
								
								<td style="text-align: left; width: 10%;"> 
									<%=obj[4]%>
								</td>
								
								<td style="text-align: left; width: 3%;">
								
							 <% 
						        if(obj[5].toString().length()!=0 && obj[5]!=null){
						        %>
						        <div  align="center">
										<a  
										 href="ActionAttachDownload.htm?ActionSubId=<%=obj[7]%>" 
										 target="_blank"><i class="fa fa-download"></i></a>
									</div>
								
									
								<%}else{ %>
								
								<div  align="center">-</div>
								
								 <%} %>
									
						
															
							
						
						</tr>
														
							<% count++; } %>
							
							
						</tbody>
					</table>
				</div> 
	
				</div>
			 	
  			</div>

</div>

			</div>
		</div>
	</div>

<script>

function back(){
	
	event.preventDefault;
	$("#Remarks").prop('required',true);
	
	confirm('Are You Sure to Send Back To Assignee ?');
	
}

function close5(){
	
	event.preventDefault;
	$("#Remarks").prop('required',true);
	
	confirm('Are You Sure to Close This Action ?');
	
}

function close2(){
	
	event.preventDefault;
	$("#Remarks").prop('required',false);

	
}
</script>

    <script>
var from ="<%=sdf.format(Assignee[4])%>".split("-");
var dt = new Date(from[2], from[1] - 1, from[0]);
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"minDate" : dt,
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
</script>  




</body>
</html>