<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Milestone Activity Update</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}

</style>
</head>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
Object[] getMA=(Object[])request.getAttribute("MilestoneActivity");
String projectid=(String)request.getAttribute("projectid");
	%>
<body>
  <nav class="navbar navbar-light bg-light" style="margin-top: -1%;">
  <a class="navbar-brand"></a>
  <form class="form-inline"  method="POST" action="MilestoneUpdate.htm">
   <input type="submit" class="btn btn-primary btn-sm back "  value="Back" style="margin-left: 10px;"> 	
      <input type="hidden" name="MilestoneActivityId"	value="<%=getMA!=null?getMA[0]:0 %>" /> 

<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
</form>
</nav>

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></center>
                    <%} %>

    <br />


<div class="container-fluid">
<div class="row" >
<div class="col-md-12">
<div  class="panel-group" style="  "><h5 class="text-white" style="font-weight: bold;font-size: large;background-color: #055C9D; text-align: center;"><%=getMA!=null?getMA[1]:"-" %> Milestone Activity Details</h5>  
<div class="row container-fluid" >
                           <div class="col-md-1 " ><br><label class="control-label">Type</label>  <br>  <b >Main</b>                    		
                        	</div>
                    		<div class="col-md-5 " ><br>
                    		<label class="control-label"> Activity Name:</label> <br>  <%=getMA!=null?getMA[4]:"-" %> 
                        	</div>
                        	<div class="col-md-1 " align="center" ><br>
                    		<label class="control-label">Progress <br> </label>
                    		<%if(getMA!=null && !getMA[11].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=getMA[11] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=getMA[11] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
                    		 
                        	</div>
                        	<div class="col-md-2 " align="center" ><br>
                        	<label class="control-label">PDC<br>From :  <%=getMA!=null?sdf.format(getMA[2]):"-" %> <br> To :  <%=getMA!=null?sdf.format(getMA[3]):"-" %> <br></label>
                        	</div>
                        	<div class="col-md-2 " align="center" style="margin-left: -10px;">
                        	<br><label class="control-label">Completed On<br>
                        	<%if(getMA!=null && getMA[14]!=null){ %>
                        	<%=sdf.format(getMA[14]) %>
                        	<%}else{ %>
                        	<%=getMA!=null?getMA[15]:"-" %>
                        	<%} %>
                        	</label>
                        	</div>
                        	<div class="col-md-1 " style="margin-left: -10px;"><br>
                        	<%

                            List<Object[]> MilestoneActivityA=(List<Object[]>)request.getAttribute("MilestoneActivityA");
                            if(MilestoneActivityA==null&&MilestoneActivityA.size()==0){%>
                        	<label class="control-label">Update<br></label>
                        	  <form class="form-inline"  method="POST" action="M-A-Update.htm">
                        	  <button class="btn btn-sm edit"> <i class="fa fa-wrench" aria-hidden="true"></i> </button>
                        	 
                        	  
                         	  <input type="hidden" name="ProjectId"	value="<%=projectid %>" />	
                              <input type="hidden" name="MilestoneActivityId"	value="<%=getMA!=null?getMA[0]:"0" %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=getMA!=null?getMA[0]:"0" %>" /> 
                              <input type="hidden" name="ActivityType"	value="M" /> 
                              <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                              </form>
                              <%} %>
                        	</div>
                       		</div>
                  	
</div>

</div>
<div class="col-md-12">
<%


if(MilestoneActivityA!=null&&MilestoneActivityA.size()>0){
	int countA=1;
	for(Object[] ActivityA:MilestoneActivityA){
		List<Object[]> MilestoneActivityB=(List<Object[]>)request.getAttribute("MilestoneActivityB"+countA);
%>


	
		


					
						<div class="row container-fluid" style="margin-left: 10px;">
						 <div  class="col-sm-12" align="left" >
						   <div class="row container-fluid" >
						    <div class="col-md-1 " ><label class="control-label">A-<%=countA %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-5" align="left" >
                    		<label class="control-label"> Activity   Name: <br>  <%=ActivityA[4] %> </label>
                    		<br>
                        	</div>
                        	<div class="col-md-1 " align="center" style="margin-left: -5px;"><br>
                    		 
                    		<%if(!ActivityA[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=ActivityA[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=ActivityA[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not  Started
															</div>
															</div> <%} %>
                    		 
                        	</div>
                        	 <div  class="col-sm-2" align="center" style="margin-left: 5px;"> <br> 
                    		<label class="control-label">From: <%=sdf.format(ActivityA[2]) %> <br>To: <%=sdf.format(ActivityA[3]) %></label>
                    		<br>
                        	</div>
                        	<div class="col-md-2 " align="center" style="margin-left: -0px;">
                        	<br><label class="control-label"> 
                        	<%if(ActivityA[8]!=null){ %>
                        	<%=sdf.format(ActivityA[8]) %>
                        	<%}else{ %>
                        	<%=ActivityA[9] %>
                        	<%} %>
                        	</label>
                        	</div>
                            <div class="col-md-1 " style="margin-left: -5px;"><br>
                            <%if(MilestoneActivityB==null||MilestoneActivityB.size()==0){ %>
                        	 <form class="form-inline"  method="POST" action="M-A-Update.htm">
                        	  <button class="btn btn-sm edit"> <i class="fa fa-wrench" aria-hidden="true"></i> </button>
                        	 
                        	  
                           		 <input type="hidden" name="ProjectId"	value="<%=projectid %>" />	
                              <input type="hidden" name="MilestoneActivityId"	value="<%=getMA!=null?getMA[0]:"0" %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=ActivityA[0] %>" /> 
                              <input type="hidden" name="ActivityType"	value="A" /> 
                              <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                              </form>
                           <%} %>
                        	</div>
                        	</div>
                        	</div>
		                   </div>
		                   
								
							<%


if(MilestoneActivityB!=null&&MilestoneActivityB.size()>0){
	int countB=1;
	for(Object[] ActivityB:MilestoneActivityB){
		
%>


	
		
                       <div class="row container-fluid">
					
						 <div  class="col-sm-12" align="left" style="margin-left: 35px;" >
						    <div class="row container-fluid" >
						     <div class="col-md-1 " ><label class="control-label">B-<%=countB %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-5" align="left" >
                    		<label class="control-label"> Activity   Name:  <br> <%=ActivityB[4] %> </label>
                    		<br>
                        	</div>
                        	<div class="col-md-1 " align="center" style="margin-left: -14px;"><br>
                    		 
                    		<%if(!ActivityB[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=ActivityB[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=ActivityB[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not  Started
															</div>
															</div> <%} %>
                    		 
                        	</div>
                        	 <div  class="col-sm-2" align="center"  style="margin-left: 0px;"> <br> 
                    		<label class="control-label">From: <%=sdf.format(ActivityB[2]) %>  <br> To: <%=sdf.format(ActivityB[3]) %></label>
                    		<br>
                       
                        	</div>
                        	<div class="col-md-2 " align="center" style="margin-left: -0px;">
                        	<br><label class="control-label"> 
                        	<%if(ActivityB[8]!=null){ %>
                        	<%=sdf.format(ActivityB[8]) %>
                        	<%}else{ %>
                        	<%=ActivityB[9] %>
                        	<%} %>
                        	</label>
                        	</div>
                        	<div class="col-md-1 "><br>
                        	<%

                                 List<Object[]> MilestoneActivityC=(List<Object[]>)request.getAttribute(countA+"MilestoneActivityC"+countB);
                                if(MilestoneActivityC==null||MilestoneActivityC.size()==0){%>
                              <form class="form-inline"  method="POST" action="M-A-Update.htm">
                        	  <button class="btn btn-sm edit"> <i class="fa fa-wrench" aria-hidden="true"></i> </button>
                        	 
                        	  
                               <input type="hidden" name="ProjectId"	value="<%=projectid %>" />	
                              <input type="hidden" name="MilestoneActivityId"	value="<%=getMA!=null?getMA[0]:"0" %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=ActivityB[0] %>" /> 
                              <input type="hidden" name="ActivityType"	value="B" /> 
                              <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                              </form>                        
                              <%} %>	</div>
							</div>	
							</div>
							</div>
						<!-- B end -->
						
							<%
if(MilestoneActivityC!=null&&MilestoneActivityC.size()>0){
	int countC=1;
	for(Object[] ActivityC:MilestoneActivityC){
		
%>


	
		

					
						<div class="row container-fluid">
						 <div  class="col-sm-12" align="left" style="margin-left: 55px;">
                            <div class="row container-fluid" >
                             <div class="col-md-1 " ><label class="control-label">C-<%=countC %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-5" align="left" >
                    		<label class="control-label">  Activity   Name: <br> <%=ActivityC[4] %> </label>
                    		<br>
                        	</div>
                        	<div class="col-md-1 " align="center" style="margin-left: -35px;" ><br>
                    		 
                    		<%if(!ActivityC[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=ActivityC[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=ActivityC[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not  Started
															</div>
															</div> <%} %>
                    		 
                        	</div>
                        	 <div  class="col-sm-2" align="center"   style="margin-left: 0px;"><br>
                    		<label class="control-label">From: <%=sdf.format(ActivityC[2]) %>  <br> To: <%=sdf.format(ActivityC[3]) %></label>
                    		<br>
                       
                        	</div>
                        	<div class="col-md-2 " align="center" style="margin-left: -0px;">
                        	<br><label class="control-label"> 
                        	<%if(ActivityC[8]!=null){ %>
                        	<%=sdf.format(ActivityC[8]) %>
                        	<%}else{ %>
                        	<%=ActivityC[9] %>
                        	<%} %>
                        	</label>
                        	</div>
                        	<div class="col-md-1 "><br>
                              <form class="form-inline"  method="POST" action="M-A-Update.htm">
                        	  <button class="btn btn-sm edit"> <i class="fa fa-wrench" aria-hidden="true"></i> </button>
                        	 
                        	  
                              <input type="hidden" name="ProjectId"	value="<%=projectid %>" />	
                              <input type="hidden" name="MilestoneActivityId"	value="<%=getMA!=null?getMA[0]:"0" %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=ActivityC[0] %>" /> 
                              <input type="hidden" name="ActivityType"	value="C" /> 
                              <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                              </form>                        	</div>
                        	</div>
	
						<!-- C end -->
									</div>
									</div>
									
	
		<%countC++;}}else{
	%>
				
	
<%} %>	
									
									
									
		
		<%countB++;}}else{
	%>
					
	
<%} %>	
			
						<!-- A end -->
						
		 
			
		
				
				
	               
<%countA++;}}else{
	%>
				
	
<%} %>
	</div>
</div>
	</div>								
<script type="text/javascript">

	    
	</script>  
</body>
</html>