<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Milestone Activity Compare</title>
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
String rev=(String)request.getAttribute("P");
int revno=(Integer)request.getAttribute("Count");
	%>
<body>
  <nav class="navbar navbar-light bg-light" style="margin-top: -1%;">
  <a class="navbar-brand"></a>
  <form class="form-inline"  method="POST" action="MilestoneActivityCompareSubmit.htm" >
    <label style="margin-left: 10px;margin-right: 10px;" >First  No : <span class="mandatory" style="color: red;">*</span></label>
  <select class="form-control selectdee"    name="FirstNo"  id="FirstNo"  required="required"   data-live-search="true" style="margin-left: 10px;margin-right: 10px;width: 150px;">
	<option value="" disabled="disabled" selected="selected"
					hidden="true">Select</option>
				 <%
					for (int i=0;i<revno;i++) {
				%>
				<option value="<%=i%>" ><%=i%></option>
				<%
					}
				%>

			</select>   
   <label style="margin-left: 10px;margin-right: 10px;" >Second  No : <span class="mandatory" style="color: red;">*</span></label>
  <select class="form-control selectdee"    name="SecondNo"  id="SecondNo" required="required"    data-live-search="true" style="margin-left: 10px;margin-right: 10px;width: 150px;">
	<option value="" disabled="disabled" selected="selected"
					hidden="true">Select</option>
				 <%
					for (int i=0;i<revno;i++) {
				%>
				<option value="<%=i%>" ><%=i%></option>
				<%
					}
				%>
            
			</select>  
      <input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0] %>" /> 
 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
</form>
  <form class="form-inline"  method="POST" action="MilestoneActivityDetails.htm" >
  <input type="submit" class="btn btn-primary btn-sm back "   value="Back" style="margin-left: 10px;" > 
			
		
      <input type="hidden" name="sub"	value="C" /> 
      <input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0] %>" /> 
<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
</form>
</nav>




<div class="container-fluid">
<div class="row" >
<div class="col-md-6">
<div  class="panel-group" style="  "><h5 class="text-white" style="font-weight: bold;font-size: large;background-color: #055C9D; text-align: center;"><%=getMA[1] %> Milestone Activity Details ( Base Line <%=rev %> )</h5>  
<div class="row container-fluid" >
                             <div class="col-md-2 " ><br><label class="control-label"> Type</label><br>Main
                    		
                        	</div>
                    		<div class="col-md-5 " ><br>
                    		<label class="control-label" style="text-align: justify;"> Activity Name:   </label> <br><%=getMA[4] %>
                        	</div>
                        	<div class="col-md-2 " align="center" ><br>
                    		<label class="control-label">Progress  </label><br>
                    		<%if(!getMA[11].toString().equalsIgnoreCase("0")){ %>
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
                        	<div class="col-md-3 " align="center"><br>
                        	<label class="control-label">PDC</label><br>From :  <%=sdf.format(getMA[2]) %> <br>To :  <%=sdf.format(getMA[3]) %> <br>
                        	</div>
                          
                       		</div>
                  	
</div>

</div>
<%
Object[] getMA1=(Object[])request.getAttribute("MilestoneActivity1");
	%>
<div class="col-md-6">
<div  class="panel-group" style="  "><h5 class="text-white" style="font-weight: bold;font-size: large;background-color: #055C9D; text-align: center;"><%=getMA[1] %> Milestone Activity Details ( Base Line <%=getMA1[8] %> )</h5>  
<div class="row container-fluid" >
                             <div class="col-md-2 " ><br><label class="control-label">  Type</label><br>Main
                    		
                        	</div>
                    		<div class="col-md-4 " ><br>
                    		<label class="control-label" style="text-align: justify;"> Activity Name: </label><br> <%=getMA1[4] %> 
                        	</div>
                        	<div class="col-md-2 " align="center" ><br>
                    		<label class="control-label">Progress  </label><br>
                    		<%if(!getMA1[11].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=getMA1[11] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=getMA1[11] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
                    		 
                        	</div>
                        	<div class="col-md-3 " align="center" ><br>
                        	<label class="control-label">PDC</label>
                        	<br>From :  <%=sdf.format(getMA1[2]) %> <br>To :  <%=sdf.format(getMA1[3]) %> <br>
                        	</div>
                            <div class="col-md-1 " align="center"><br>
                        	<label class="control-label">Status </label>
                        	<br>  <%=Math.abs(Integer.parseInt(getMA1[13].toString())-Integer.parseInt(getMA1[12].toString())) %> Days <%if(Integer.parseInt(getMA1[13].toString())-Integer.parseInt(getMA1[12].toString())>0){ %> <br> Advance <%}else if(Integer.parseInt(getMA1[13].toString())-Integer.parseInt(getMA1[12].toString())<0){%>  <br> Delay <%} %>
                        	<br></div>	</div>
                  	
</div>

</div>
<div class="col-md-6">
<%

List<Object[]> MilestoneActivityA=(List<Object[]>)request.getAttribute("MilestoneActivityA");
if(MilestoneActivityA!=null&&MilestoneActivityA.size()>0){
	int countA=1;
	for(Object[] ActivityA:MilestoneActivityA){
		
%>


	
		


					
						
						   <div class="row container-fluid" >
						    <div class="col-md-2 " ><label class="control-label" style="margin-left: 5px;">A-<%=countA %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-5" align="left" >
                    		 <%=ActivityA[4] %> 
                    		<br>
                        	</div>
                        	<div class="col-md-2 " align="center">
                    		 
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
                        	 <div  class="col-sm-3" align="center" >
                    		From: <%=sdf.format(ActivityA[2]) %> <br>To: <%=sdf.format(ActivityA[3]) %>
                    		<br>
                        	</div>
                        	</div>
                        
		                   
								
							<%

List<Object[]> MilestoneActivityB=(List<Object[]>)request.getAttribute("MilestoneActivityB"+countA);
if(MilestoneActivityB!=null&&MilestoneActivityB.size()>0){
	int countB=1;
	for(Object[] ActivityB:MilestoneActivityB){
		
%>


	
		
                     
						    <div class="row container-fluid" >
						     <div class="col-md-2 " ><label class="control-label" style="margin-left: 5px;">B-<%=countB %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-5" align="left" >
                    	    <%=ActivityB[4] %> 
                    		<br>
                        	</div>
                        	<div class="col-md-2 " align="center" >
                    		 
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
                        	 <div  class="col-sm-3" align="center"  >  
                    		From: <%=sdf.format(ActivityB[2]) %> <br> To: <%=sdf.format(ActivityB[3]) %>
                    		<br>
                       
                        	</div>

							</div>	
							
						<!-- B end -->
						
							<%

List<Object[]> MilestoneActivityC=(List<Object[]>)request.getAttribute("MilestoneActivityC"+countA+countB);
if(MilestoneActivityC!=null&&MilestoneActivityC.size()>0){
	int countC=1;
	for(Object[] ActivityC:MilestoneActivityC){
		
%>


	
		

					
					
                            <div class="row container-fluid" >
                             <div class="col-md-2 " ><label class="control-label"  style="margin-left:5px;">C-<%=countC %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-5" align="left" >
                    		 <%=ActivityC[4] %> 
                    		<br>
                        	</div>
                        	<div class="col-md-2 " align="center"  >
                    		 
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
                        	 <div  class="col-sm-3" align="center"   >
                    		From: <%=sdf.format(ActivityC[2]) %> <br> To: <%=sdf.format(ActivityC[3]) %>
                    		<br>
                       
                        	</div>

                        	</div>
	
						<!-- C end -->
								
											<%

List<Object[]> MilestoneActivityD=(List<Object[]>)request.getAttribute("MilestoneActivityD"+countA+countB+countC);
if(MilestoneActivityD!=null&&MilestoneActivityD.size()>0){
	int countD=1;
	for(Object[] ActivityD:MilestoneActivityD){
		
%>


	
		
                     
						    <div class="row container-fluid" >
						     <div class="col-md-2 " ><label class="control-label" style="margin-left: 10px;">D-<%=countD %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-5" align="left" >
                    	    <%=ActivityD[4] %> 
                    		<br>
                        	</div>
                        	<div class="col-md-2 " align="center" >
                    		 
                    		<%if(!ActivityD[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=ActivityD[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=ActivityD[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not  Started
															</div>
															</div> <%} %>
                    		 
                        	</div>
                        	 <div  class="col-sm-3" align="center"  >  
                    		From: <%=sdf.format(ActivityD[2]) %> <br> To: <%=sdf.format(ActivityD[3]) %>
                    		<br>
                       
                        	</div>

							</div>	
							
						<!-- B end -->
						
							<%

List<Object[]> MilestoneActivityE=(List<Object[]>)request.getAttribute("MilestoneActivityE"+countA+countB+countC+countD);
if(MilestoneActivityE!=null&&MilestoneActivityE.size()>0){
	int countE=1;
	for(Object[] ActivityE:MilestoneActivityE){
		
%>


	
		

					
					
                            <div class="row container-fluid" >
                             <div class="col-md-2 " ><label class="control-label"  style="margin-left:15px;">E-<%=countE %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-5" align="left" >
                    		 <%=ActivityE[4] %> 
                    		<br>
                        	</div>
                        	<div class="col-md-2 " align="center"  >
                    		 
                    		<%if(!ActivityE[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=ActivityE[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=ActivityE[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not  Started
															</div>
															</div> <%} %>
                    		 
                        	</div>
                        	 <div  class="col-sm-3" align="center"   >
                    		From: <%=sdf.format(ActivityE[2]) %> <br> To: <%=sdf.format(ActivityE[3]) %>
                    		<br>
                       
                        	</div>

                        	</div>
	
						<!-- C end -->
								
									
	
		<%countE++;}}else{
	%>
				
	
<%} %>	
									
									
									
		
		<%countD++;}}else{
	%>
					
	
<%} %>						
	
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
	
	
	<div class="col-md-6">
<%

List<Object[]> MilestoneActivity1A=(List<Object[]>)request.getAttribute("MilestoneActivity1A");
if(MilestoneActivity1A!=null&&MilestoneActivity1A.size()>0){
	int countA=1;
	for(Object[] ActivityA:MilestoneActivity1A){
		
%>


	
		


					
						   <div class="row container-fluid" >
						    <div class="col-md-2 " ><label class="control-label" style="margin-left: 5px;">A-<%=countA %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-4" align="left" >
                    		  <%=ActivityA[4] %> 
                    		<br>
                        	</div>
                        	<div class="col-md-2 " align="center" >
                    		 
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
                        	 <div  class="col-sm-3" align="center"> 
                    		From: <%=sdf.format(ActivityA[2]) %> <br> To: <%=sdf.format(ActivityA[3]) %>
                    		<br>
                        	</div>
                            <div class="col-md-1 " align="center" >
                        	<%if(ActivityA[7]!=null){ %>  <%=Math.abs(Integer.parseInt(ActivityA[7].toString())-Integer.parseInt(ActivityA[6].toString())) %> Days <%if(Integer.parseInt(ActivityA[7].toString())-Integer.parseInt(ActivityA[6].toString())>0){ %>  <br> Advance <%}else if(Integer.parseInt(ActivityA[7].toString())-Integer.parseInt(ActivityA[6].toString())<0){ %>  <br> Delay <%} %> <%}else{ %> New <%} %>
                        	</div>
                        	</div>
                        	
		                   
								
							<%

List<Object[]> MilestoneActivityB=(List<Object[]>)request.getAttribute("MilestoneActivity1B"+countA);
if(MilestoneActivityB!=null&&MilestoneActivityB.size()>0){
	int countB=1;
	for(Object[] ActivityB:MilestoneActivityB){
		
%>


	
		
              
						    <div class="row container-fluid" >
						     <div class="col-md-2 " ><label class="control-label" style="margin-left: 10px;">B-<%=countB %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-4" align="left" >
                    		 <%=ActivityB[4] %> 
                    		<br>
                        	</div>
                        	<div class="col-md-2 " align="center" >
                    		 
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
                        	 <div  class="col-sm-3" align="center"  >  
                    		From: <%=sdf.format(ActivityB[2]) %>  <br>To: <%=sdf.format(ActivityB[3]) %>
                    		<br>
                       
                        	</div>
                        	 <div class="col-md-1 " align="center" >
                        	<%if(ActivityB[7]!=null){ %> <%=Math.abs(Integer.parseInt(ActivityB[7].toString())-Integer.parseInt(ActivityB[6].toString())) %> Days <%if(Integer.parseInt(ActivityB[7].toString())-Integer.parseInt(ActivityB[6].toString())>0){ %>  <br> Advance <%}else if(Integer.parseInt(ActivityB[7].toString())-Integer.parseInt(ActivityB[6].toString())<0){ %>  <br> Delay <%} %> <%}else{ %> New <%} %>
                        	</div>
							</div>	
							
						<!-- B end -->
						
							<% 
List<Object[]> MilestoneActivityC=(List<Object[]>)request.getAttribute("MilestoneActivity1C"+countA+countB);
if(MilestoneActivityC!=null&&MilestoneActivityC.size()>0){
	int countC=1;
	for(Object[] ActivityC:MilestoneActivityC){
		
%>


	
		

					
					
                            <div class="row container-fluid" >
                             <div class="col-md-2 " ><label class="control-label" style="margin-left: 10px;">C-<%=countC %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-4" align="left" >
                    		 <%=ActivityC[4] %> 
                    		<br>
                        	</div>
                        	<div class="col-md-2 " align="center" >
                    		 
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
                        	 <div  class="col-sm-3" align="center"   >
                    		From: <%=sdf.format(ActivityC[2]) %>  <br>To: <%=sdf.format(ActivityC[3]) %>
                        	</div>
                             <div class="col-md-1 " align="center">
                        	<%if(ActivityC[7]!=null){ %> <%=Math.abs(Integer.parseInt(ActivityC[7].toString())-Integer.parseInt(ActivityC[6].toString())) %> Days <%if(Integer.parseInt(ActivityC[7].toString())-Integer.parseInt(ActivityC[6].toString())>0){ %>  <br> Advance <%}else if(Integer.parseInt(ActivityC[7].toString())-Integer.parseInt(ActivityC[6].toString())<0){ %>  <br> Delay <%} %> <%}else{ %> New <%} %> 
                        	</div>
                        	</div>
	
						<!-- C end -->
						<%

List<Object[]> MilestoneActivityD=(List<Object[]>)request.getAttribute("MilestoneActivity1D"+countA+countB+countC);
if(MilestoneActivityD!=null&&MilestoneActivityD.size()>0){
	int countD=1;
	for(Object[] ActivityD:MilestoneActivityD){
		
%>


	
		
              
						    <div class="row container-fluid" >
						     <div class="col-md-2 " ><label class="control-label" style="margin-left: 15px;">D-<%=countD %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-4" align="left" >
                    		 <%=ActivityD[4] %> 
                    		<br>
                        	</div>
                        	<div class="col-md-2 " align="center" >
                    		 
                    		<%if(!ActivityD[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=ActivityD[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=ActivityD[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not  Started
															</div>
															</div> <%} %>
                    		 
                        	</div>
                        	 <div  class="col-sm-3" align="center"  >  
                    		From: <%=sdf.format(ActivityD[2]) %>  <br>To: <%=sdf.format(ActivityD[3]) %>
                    		<br>
                       
                        	</div>
                        	 <div class="col-md-1 " align="center" >
                        	<%if(ActivityD[7]!=null){ %> <%=Math.abs(Integer.parseInt(ActivityD[7].toString())-Integer.parseInt(ActivityD[6].toString())) %> Days <%if(Integer.parseInt(ActivityD[7].toString())-Integer.parseInt(ActivityD[6].toString())>0){ %>  <br> Advance <%}else if(Integer.parseInt(ActivityD[7].toString())-Integer.parseInt(ActivityD[6].toString())<0){ %>  <br> Delay <%} %> <%}else{ %> New <%} %>
                        	</div>
							</div>	
							
						<!-- B end -->
						
							<%

List<Object[]> MilestoneActivityE=(List<Object[]>)request.getAttribute("MilestoneActivity1E"+countA+countB+countC+countD);
if(MilestoneActivityE!=null&&MilestoneActivityE.size()>0){
	int countE=1;
	for(Object[] ActivityE:MilestoneActivityE){
		
%>


	
		

					
					
                            <div class="row container-fluid" >
                             <div class="col-md-2 " ><label class="control-label" style="margin-left: 15px;">E-<%=countE %><br></label>
                    		
                        	</div>
						   <div  class="col-sm-4" align="left" >
                    		 <%=ActivityE[4] %> 
                    		<br>
                        	</div>
                        	<div class="col-md-2 " align="center" >
                    		 
                    		<%if(!ActivityE[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=ActivityE[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=ActivityE[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not  Started
															</div>
															</div> <%} %>
                    		 
                        	</div>
                        	 <div  class="col-sm-3" align="center"   >
                    		From: <%=sdf.format(ActivityE[2]) %>  <br>To: <%=sdf.format(ActivityE[3]) %>
                        	</div>
                             <div class="col-md-1 " align="center">
                        	<%if(ActivityE[7]!=null){ %> <%=Math.abs(Integer.parseInt(ActivityE[7].toString())-Integer.parseInt(ActivityE[6].toString())) %> Days <%if(Integer.parseInt(ActivityE[7].toString())-Integer.parseInt(ActivityE[6].toString())>0){ %>  <br> Advance <%}else if(Integer.parseInt(ActivityE[7].toString())-Integer.parseInt(ActivityE[6].toString())<0){ %>  <br> Delay <%} %> <%}else{ %> New <%} %> 
                        	</div>
                        	</div>
	
						<!-- C end -->
									
									
	
		<%countE++;}}else{
	%>
				
	
<%} %>	
									
									
									
		
		<%countD++;}}else{
	%>
					
	
<%} %>					
									
	
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

$(document).ready(function() {
	   $('#SecondNo').on('change', function() {
			var from = $("#FirstNo").val();
			var Start = Number(from);
			var end = $("#SecondNo").val();
			var End =Number(end);
			if ( Start >= End){
		       
				  alert("Second No should greater than  First No");
			}else{
		     $('#submit').click();
			}
		   });
	}); 
	</script>  
</body>
</html>