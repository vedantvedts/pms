<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>COMMITTEE ADD AGENDA FROM OLD MEETING</title>
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
</head>
 
<body>
  <%
  

  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");

  Object[] committeescheduleeditdata=(Object[])request.getAttribute("committeescheduleeditdata");
  Object[] committeescheduledata1=(Object[])request.getAttribute("committeescheduledata1");
  String scheduleidto=committeescheduleeditdata[6].toString();
  String meetingid=(String)request.getAttribute("meetingid");
  List<Object[]> fromagendalist=  (List<Object[]>)request.getAttribute("agendalist");
  List<Object[]> meetingsearch=(List<Object[]>)request.getAttribute("meetingsearch");
 %>



<%String ses=(String)request.getParameter("result"); 
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

    <br/>
    
    


<div class="container-fluid">
	<!-- <div class="container" style="margin-bottom:20px;">  -->
	<div style="margin-bottom:20px;"> 
  
		<div id="error"></div>
		
    		<div class="card" style=" ">
    	
    		<form action="CommitteeScheduleAgenda.htm" name="myfrm" id="myfrm" method="post">    	
	    		<div class="card-header" style="background-color: #055C9D;">
      				<h6 style="color: orange;font-weight: bold;font-size: 1.2rem !important " align="left"><%=committeescheduleeditdata[7] %> <span> (Meeting Date and Time :      				
	      				 &nbsp;<%=sdf.format(sdf1.parse(committeescheduleeditdata[2].toString()))%> - <%=committeescheduleeditdata[3] %>) </span> 					 
	      				<input type="submit" class="btn  btn-sm back" value="BACK" style="float:right;" />
	      				<span  style="float:right;margin: 5px 12px;" > (Meeting Id : <%=committeescheduleeditdata[11] %>) </span> 
	      				<input type="hidden" name="scheduleid" value="<%=committeescheduleeditdata[6] %>">
	      				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />      				
      				 </h6>  
      			</div>
      		</form>		
      		
	      		<div class="card-body">      		
	      			<div class="row">		
	      				<div class="col-md-4">
	      					<form action="AgendasFromPreviousMeetingsAdd.htm" method="post">
	      						<table>
	      							<tr>
	      								<td><input type="text" class="form-control item_name child" name="search" placeholder="Meeting Id" /></td>
	      								<td><button type="submit" class="btn btn-sm submit" style="margin-left: 1rem;">SEARCH</button></td>
	      							</tr>
	      						</table>
	      						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
	      						<input type="hidden" name="scheduleidto" value="<%=scheduleidto %>"  />			
	      					</form>	      				
	      				</div>
	      				<div class="col-md-5"><%if(committeescheduledata1!=null){ %> Agendas From Meeting Id : &nbsp;<%=committeescheduledata1[11] %> <%} %> </div>
	      				<div class="col-md-3"><%if(committeescheduledata1!=null){ %>Date : &nbsp;<%=sdf.format(sdf1.parse(committeescheduledata1[2].toString())) %> &nbsp;&nbsp;&nbsp; Time :&nbsp;<%=committeescheduledata1[3] %> <%} %></div>	      				
	      			</div>
<!--   --------------------------------------------------------------------------------------------------- -->	
				<% if(meetingsearch!=null&&meetingsearch.size()>0)	{      			%>
					<div align="center">
				  		<h5>Select Meeting</h5>
					</div>
				
	      			<form action="AgendasFromPreviousMeetingsAdd.htm" method="post">  
			      			<table id="mydatatable" data-toggle="table" data-pagination="true" data-search="true">							
								<thead>
									<tr>
										<th>Select</th>
										<th>Meeting Id</th>
										<th>Date </th>
										<th> Time</th>
										<th>Committee</th>																							
										<th >Venue</th>					 	
										<!-- <th >Role</th> -->
									</tr>
								</thead>
							<tbody>
								<% 	for (Object[] obj :meetingsearch) { %>
										<tr>
											<td align="center"><input type="radio" name="scheduleidfrom" value="<%=obj[2] %>" / ></td>
											<td><%=obj[7] %></td>
											<td><%=sdf.format(obj[3])%> </td>
											<td> <%=obj[4] %></td>
											<td> <%=obj[9]%></td>
											<td><%if(obj[10]!=null){%> <%=obj[10]%> <%}else{ %> &nbsp;&nbsp;&nbsp;&nbsp;- <%} %></td>																	
										</tr>
							   <% }%>
	 					</tbody>
					</table>	
					
					<div align="center">
				           	<input type="submit"  class="btn  btn-sm submit" value="SUBMIT" />				            	
					</div>
				<%-- 	<input type="hidden" name="meetingid" value="<%=obj[7] %>"  />	 --%>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />						
					<input type="hidden" name="scheduleidto" value="<%=scheduleidto %>"  />
				</form>
				<%} %>
	    <!--  --------------------------------------------------------------------------------------------- -->   
			<%if(committeescheduledata1!=null && (fromagendalist==null || fromagendalist.size()==0 ) ){ %>
				 <div align="center" style="margin-top: 25px;"> <h6>No Agenda is Defined For This Meeting !</h6> </div>
			<%} %>	    
	    <!--  --------------------------------------------------------------------------------------------- -->
	    
	      <%if(fromagendalist!=null && fromagendalist.size()>0 ){ %>
	      		<div align="center">
				  	<h5>Select Agendas</h5>
				</div>
	      			<form method="post" action="CommitteePreviousAgendaAddSubmit.htm" enctype="multipart/form-data" id="addagendafrm" name="addagendafrm">	        
	        			<div >	<span style="font-size: 15px ;color: blue ; float: right; ">Duration in Minutes</span></div>
	          				<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" style="margin-top: 30px;">
								<thead>  
									<tr id="">
										<th align="center" width="25px">Select</th>
										<th align="center">Agenda Item</th>
										<th align="center">Reference</th>
										<th align="center">Remarks</th>
										<th align="center">Lab</th>
										<th align="center">Presenter</th>
										<th align="center">Duration </th>
										<!-- <th>Attachment</th>	 -->								
									</tr>								
									<%for(Object[] agenda : fromagendalist){ %>
									<tr>								
										<td align="center" >
										<input type="checkbox" name="fromagendaid" id="fromagendaid" value="<%=agenda[0] %>" / >
										
										 </td>
										<td ><%=agenda[3] %> </td>														
						         		<td ><%=agenda[4] %> </td>						         		                                      
						         		<td ><%=agenda[6] %> </td>
						         		<td ><%=agenda[14] %> </td>		
										<td ><%=agenda[10] %> (<%=agenda[11] %> )</td>						         		                                      
										<td ><%=agenda[12] %> </td>
																	
									</tr>
									<%} %>
								</thead>
							</table>

	          				<div align="center">
				            	<button type="submit"  class="btn  btn-sm submit" onclick="return checkagendaselect();">SUBMIT</button>				            	
	          				</div>
			        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
			        	<input type="hidden" name="scheduleidfrom" value="<%=fromagendalist.get(0)[1] %>"  />
			     		<input type="hidden" name="scheduleidto" value="<%=scheduleidto %>"  />
			         	
			    
	      			</form>
	      			
	      		<%} %>
	    		</div>
    		</div>
    		
    		<div>
    			    			
    		
    		</div>   		
    		
   	</div>   
   	
 
</div>

<script type='text/javascript'> 
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 


$(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 10
	})
})

/* 'Are You Sure To Add This Agenda(s) ?' */
function checkagendaselect()
{
	if(document.querySelector('#fromagendaid:checked') !== null  )
	{
		return confirm('Are You Sure To Add This Agenda(s) ?');
	}else
	{
		alert('Please Select Agenda');
		return false;
	}
}





</script>



 
 
</body>
</html>