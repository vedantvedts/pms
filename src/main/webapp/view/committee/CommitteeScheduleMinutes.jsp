<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />

<title>COMMITTEE SCHEDULE MINUTES</title>

 <script src="${ckeditor}"></script>
 <link href="${contentCss}" rel="stylesheet" />

  <style>
    .bs-example{
        margin: 20px;
    }
    .accordion .fa{
        margin-right: 0.5rem;
    }
</style>

  	<style type="text/css">
		

label{
  font-weight: bold;
  font-size: 13px;
}
 
.note-editable {
  line-height: 1.0;
}
.panel-info {
    border-color: #bce8f1;
}
.panel {
    margin-bottom: 10px;
    background-color: #fff;
    border: 1px solid transparent;
    border-radius: 4px;
    -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
    box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}
 .panel-heading {
    background-color: #FFF !important;
    border-color: #bce8f1 !important;
    border-bottom: 2px solid #466BA2 !important;
    color: #1d5987;
}
.panel-title {
    margin-top: 0;
    margin-bottom: 0;
    font-size: 13px;
    color: inherit;
    font-weight: bold;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
div {
    display: block;
}

element.style {
}
.olre-body .panel-info .panel-heading {
    background-color: #FFF !important;
    border-color: #bce8f1 !important;
    border-bottom: 2px solid #466BA2 !important;
   
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info>.panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.p-5 {
    padding: 5px;
}
.panel-heading {
    padding: 10px 15px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
user agent stylesheet
div {
    display: block;
}

.panel-info {
    border-color: #bce8f1;
}

.form-check{
	margin:0px 2%;
}

.fa-thumbs-up {
  font-family: FontAwesome, 'Quicksand', Quicksand, sans-serif;
}

.form-inline{

display: inline-block;
}


.form-check-input:checked ~ .form-check-label::before {
    color: #fff;
    border-color: #7B1FA2;
    background-color: red;
}

	</style>
</head>
<body>

<%

String unit3=null;
unit3=(String)request.getAttribute("unit1");
if(unit3==null){
	  unit3="NO";
}
String unit21=null;
unit21=(String)request.getAttribute("unit2");
if(unit21==null){
	  unit21="NO";
}
 
String specname=(String)request.getAttribute("specname");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

Object[] committeescheduleeditdata=(Object[])request.getAttribute("committeescheduleeditdata");
List<Object[]> committeeagendalist=(List<Object[]>)request.getAttribute("committeeagendalist");
List<Object[]> dis=(List<Object[]>)request.getAttribute("minutesspeclist");
List<Object[]> minutesoutcomelist=(List<Object[]>)request.getAttribute("minutesoutcomelist");
String committscheduleid=(String) request.getAttribute("committscheduleid");
String membertype=(String) request.getAttribute("membertype");
String filesize=(String) request.getAttribute("filesize");
String committeeid=committeescheduleeditdata[0].toString();
String projectid=committeescheduleeditdata[9].toString();
String GenId="GenAdd";
List<Object[]> minutesattachmentlist=(List<Object[]>)request.getAttribute("minutesattachmentlist");

List<Object[]> committeescheduledata=(List<Object[]>)request.getAttribute("committeescheduledata");
List<String> AgendaCommitteeIds=(List<String>)request.getAttribute("AgendaCommitteeIds");

String formname=(String)request.getAttribute("formname");
if(formname!=null){
	GenId=formname;
}
/* if(formname==null){
	GenId="GenAdd";
}  */

%>




<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
 String errorMsg=(String)request.getParameter("errorMsg");
 
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
                    <%}if(errorMsg!=null){ %>
                    	<div align="center">
	<div class="alert alert-danger" role="alert" >
                     <%=errorMsg %>
                   </div></div>
           <%} %>         
                    
  
<nav class="navbar navbar-light bg-light justify-content-between"  style="margin-top: -1%">
	<a class="navbar-brand">
		
		<b style="color: #585858; font-size:19px;font-weight: bold;text-align: left; float:left" ><span style="color:#31708f"><%=committeescheduleeditdata[7] %> </span> <span style="color:#31708f;font-size: 15px"> (Meeting Date and Time : <%=sdf.format(sdf1.parse(committeescheduleeditdata[2].toString()))%> - <%=committeescheduleeditdata[3] %>)</span></b>

	</a>
	
	<form class="form-inline" method="POST" action="CommitteeMinutesViewAllDownload.htm"  name="myfrm" id="myfrm"> 
	
			<%if(AgendaCommitteeIds.contains(committeeid) && Long.parseLong(projectid)>0){ %>
				<input type="submit" class="btn  btn-sm view" value="DPFM 2021" formaction="CommitteeMinutesNewDownload.htm" formtarget="_blank" style="background-color:#0e49b5 ;color:white ;font-size:12px;" />
				<button type="submit" class="btn btn-sm prints my-2 my-sm-0" formaction="getMinutesFrozen.htm" onclick="return confirm('Are You Sure to Freeze Minutes 2021 ?')" style="font-size:12px;" <%if(committeescheduleeditdata[22].toString().equals("Y")){%> disabled="disabled" >FROZEN <%}else{ %> >FREEZE <%} %></button>
				
			<%} %>
			
			<button type="submit" class="btn btn-sm prints my-2 my-sm-0" formtarget="_blank"  style="font-size:12px;" >MINUTES</button>

			<input type="submit" class="btn  btn-sm view" value="TABULAR MINUTES" formaction="MeetingTabularMinutesDownload.htm" formtarget="_blank" style="background-color:#0e49b5 ;color:white ;font-size:12px;" />
			 	
			<input type="hidden" name="isFrozen" value="<%=committeescheduleeditdata[22]%>">
			<input type="hidden" name="committeescheduleid" value="<%=committeescheduleeditdata[6]%>">
			<input type="hidden" name="committeescheduleid" value="<%=committeescheduleeditdata[6] %>">
			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
			<a  class="btn  btn-sm back" href="CommitteeScheduleView.htm?scheduleid=<%=committeescheduleeditdata[6] %>&membertype=<%=membertype%>"   style=" font-size:12px;" >BACK</a>			
	</form>
</nav>    
<div class="container-fluid">          
<div class="row"> 
<div class="col-md-5" >
	<div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
    	<div class="card-body" style="margin-top: -8px" >
        	
        	<%--  <form method="POST" action="CommitteeMinutesViewAll.htm" name="myfrm" id="myfrm"> 
        	
				<b style="color: #346691; font-size: 20px;font-family: 'Lato',sans-serif; ">MINUTES</b> 
				<!-- <button type="submit" class="btn btn-sm prints" formtarget="_blank"  style="margin-left: 10px; font-size:11px;font-weight: bold;width:110px; margin-top: -2px; float:right" >VIEW MINUTES</button>	
				<i class="fa fa-download" style=" float:right" onclick="submitForm('download');"></i> -->																		
				<hr><br>
				
				<input type="hidden" name="committeescheduleid" value="<%=committeescheduleeditdata[6] %>">
				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
					
			</form>  --%>
			
			
					
         <div class="panel panel-info" style="margin-top: 10px;" >
         
      		<div class="panel-heading ">
        		<h4 class="panel-title">
          			<span  style="font-size:14px">1. Introduction </span>  
        		</h4>
         	<div   style="float: right !important; margin-top:-23px; ">
		 		
		 		<table style="text-align: right;" >
     				
     				<thead>
	             		<tr>
	                 		<th ></th>
	             		</tr>
	         		</thead>
	         		
	         		<tbody>
	         		
				       <%
				      if(!dis.isEmpty()){
				    	  for(Object[] hlo:dis){
				      if("1".equalsIgnoreCase(hlo[0].toString())){
				    	   /* GenId="GenEdit";  */ 
				       %>   
      	
	      				<tr>
	
				      		<td style="max-width:120px;  font-size:small; font-weight:bold; overflow: hidden; word-break: break-word !important; white-space: normal !important;"> 
				      			<form  id="myForm500" action="CommitteeMinutesSpecEdit.htm" method="post">
				      			
				      				<input type="hidden" name="specname" value="Introduction">
				                    <input type="hidden" name="scheduleid"	value="<%=hlo[7] %>" />
									<input type="hidden" name="minutesid"	value="<%=hlo[0] %>" />
									<input type="hidden" name="scheduleminutesid" 	value="<%=hlo[1] %>" /> 
				                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				                     <input type="hidden" name="formname" value="myForm6542" />

				         			<input class="btn btn-warning btn-sm" type="submit" 
				         			  
				         			<%
				      					if(formname!=null && formname.equalsIgnoreCase("myForm6542")){
				     				 %> 
				     				 id="myForm6542"
				         			
				         			<%}else {%>
				         			id="GenAdd"
				         			<%} %>
				         			
				         			onclick="FormNameEdit('myForm500')" value="EDIT"  style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;"   />
 				       			
 				       				
 				       			
 							</form>
				       		</td>
				       		
	      				</tr>
      	
       					<%}}}%>   
       			
      				 </tbody>
      			</table>
      			<br>
       	</div>
      
      
		<div   style="float: right !important; margin-top:-25px; ">  
		
			 <form name="myForm" id="myFormgen" action="ItemSpecAdd.htm" method="post" 

				<% if(!dis.isEmpty()){
					    	  for(Object[] hlo:dis){
					      if("1".equalsIgnoreCase(hlo[0].toString())){
					    
					       %>hidden="hidden" 
					        <%}}}%>   
				> 
			
			<input type="hidden" name="specname" value="Introduction">
			
			<input class="form-control" type="hidden" name="minutesid" value="1" readonly="readonly">
			<input class="form-control" type="hidden" name="agendasubid" value="0" readonly="readonly">
			<input class="form-control" type="hidden" name="scheduleagendaid" value="0" readonly="readonly">
			<input class="form-control" type="hidden" name="minutesunitid" value="0" readonly="readonly">
			<input type="hidden" name="formname" value="myForm6542" /> 
			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			<input type="submit" name="sub"  class="btn btn-info btn-sm"  id="GenAdd" onclick="FormName('myFormgen')" value="ADD"  style="width:40px; height: 24px; font-size:10px; font-weight: bold; text-align: justify; "/>
			
		
			</form>
   		</div>
     </div>
     <!-- panel-heading end -->
  	
	  	<div id="collapse1" class="panel-collapse collapse in">
	
	     </div>      
	       
   </div>
   <!-- panel end -->   
   
   
   
  <!--  2nd row -->
  
  

  	<div class="panel panel-info">
    	<div class="panel-heading">
        	<h4 class="panel-title">
         		<span  style="font-size:14px">2. Opening Remarks </span>
        	</h4>
       	<div   style="float: right !important; margin-top:-23px; ">
		 	<table style="text-align: center;" >
     			<thead>
	             	<tr>
	                 	<th ></th>       
	             	</tr>
	         	</thead>
	         	<tbody>
	         	
	         	
			       <%
			      if(!dis.isEmpty()){
			    	  for(Object[] hlo:dis){
			      if("2".equalsIgnoreCase(hlo[0].toString())){
			       %> 
      	
      				<tr>

			      		<td style="max-width:120px;  font-size:small; font-weight:bold; overflow: hidden; word-break: break-word !important; white-space: normal !important;"> 
			      			<form  id="myForm1" action="MinutesSpecEdit.htm" method="post">
			                	
			                		<input type="hidden" name="specname" value="OpeningRemarks">
			                		<input type="hidden" name="scheduleid"	value="<%=hlo[7] %>" />
									<input type="hidden" name="minutesid"	value="<%=hlo[0] %>" />
									<input type="hidden" name="scheduleminutesid" 	value="<%=hlo[1] %>" /> 
				                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
			                    	<input type="hidden" name="formname" value="rmmyForm2" /> 

			          			<input type="submit" class="btn btn-warning btn-sm"  id="rmmyForm2" onclick="FormNameEdit('myForm1')" value="EDIT"  style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;"   />
			          			
			       			</form>
			      		</td>
			      		
      				</tr>
      	
       				 <%}}}%> 
       				 
       			</tbody>
      	
      		</table>
      		<br>
      		
       </div>
       
       
       <div style="float: right !important; margin-top:-25px; " >
			
			<form name="myForm" id="myForm2" action="ItemSpecAdd.htm" method="post" 

				<% if(!dis.isEmpty()){
				    	  for(Object[] hlo:dis){
				      if("2".equalsIgnoreCase(hlo[0].toString())){
				       %>hidden="hiddden" 
				        <%}}}%> 
				> 

				<input type="hidden" name="specname" value="OpeningRemarks">
				<input class="form-control" type="hidden" name="minutesid" value="2" readonly="readonly">
				<input class="form-control" type="hidden" name="agendasubid" value="0" readonly="readonly">
				<input class="form-control" type="hidden" name="scheduleagendaid" value="0" readonly="readonly">
				<input class="form-control" type="hidden" name="minutesunitid" value="0" readonly="readonly">
				<input type="hidden" name="formname" value="rmmyForm2" /> 
	
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
				<input type="submit" class="btn btn-info btn-sm" id="rmmyForm2" name="sub" onclick="FormName('myForm2')" value="ADD"  style="width:42px height: 24px; font-size:10px; font-weight: bold; text-align: justify; "/>
			
			</form>
			
   		</div>
   		
     </div><!-- panel- heading end -->
	  
	  <div id="collapse2" class="panel-collapse collapse in">
	  
	   
	   </div>    
	       
   </div>   

   
    
  <!-- 3rd Row New-->
 
 <div class="panel panel-info">
	<div class="panel-heading">
	
    	<h4 class="panel-title">
           <span  style="font-size:14px">3. Agenda</span>
        </h4>
        
       	<div style="float: right !important; margin-top:-20px; " > 
       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse5" > <i class="fa fa-plus" id="agendaclick"></i></a></div>
      	</div>
      
  		<div id="collapse5" class="panel-collapse collapse in">
   			<%int unitcount=1;  long unit=1; String Unit=null; int countloop=100; int form=145;int collapse=140;String temp=null;int form6=565;int form7=123;
   
   
    if(!committeeagendalist.isEmpty()){
    	
 	  for(Object[] hlo1:committeeagendalist){
 	
 		 Unit=hlo1[3].toString();
 		 String scheduleagendaid=hlo1[0].toString();
 		 temp=hlo1[0].toString();
 			  
   			%>
   			
   			
<div class="row">  
	<div class="col-md-11"  align="left"  style="margin-left: 10px;">
     	
     	<div class="panel panel-info">
      		<div class="panel-heading">
        		
        		<h4 class="panel-title">
                	<span  style="font-size:14px">3.<%=unitcount %> <%=Unit %></span> 
                </h4>
       
       			<div style="float: right !important; margin-top:-20px; " >
        			<a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=countloop %>" > <i class="fa fa-plus 5Pre<%=scheduleagendaid %> 5Dis<%=scheduleagendaid %> 5Out<%=scheduleagendaid %>" style="color:orange" id="5Out<%=scheduleagendaid %>" ></i></a></div>
           		</div>
           		
  				<div id="collapse<%=countloop %>" class="panel-collapse in collapse ">
   					
   					<!-- Sub row of Agendas -->

	<!--  New code inside agenda start-->
	
	
	<!-- ******** sub row 1 start *****  -->
	

<!-- --------------------------------------------------  Dinesh  Start  --------------------------------------------------------------------------------------- -->
	
	
	
	<div class="row">  
   			<div class="col-md-11"  align="left"  style="margin-left: 10px;">
		
		<div class="panel panel-info">
		
		<div class="panel-heading">
	    	
	    	<h4 class="panel-title">
	           <span  style="font-size:14px">3.<%=unitcount %>.1. Presentation </span>
	        </h4>
	        
	       	<div style="float: right !important; margin-top:-20px; " > 
	       		<%int collapseP=481; %>
	       		<a data-toggle="collapse" data-parent="#accordion" href="#<%=collapseP%><%=collapse%>" > <i class="fa fa-plus" style="color:green" id="5Pre<%=scheduleagendaid %>5"></i></a>
	       	</div>
	       	
	    </div>
	      
	  	<div id="<%=collapseP%><%= collapse %>" class="panel-collapse collapse in">
	  
	  <% int unitcount11=1; 	long unit11=1; String Unit11=null; int countloop11=100; int form11=1458;int collapse11=140;String temp11=null;int form20=5000; int Presentationcount=0; 
	  
	  /* int unitcount13=1;  long unit13=1; String Unit13=null; int countloop13=100; int form13=4455;int collapse13=140;String temp13=null;int form18=700; */
	  
	   if(!dis.isEmpty()){
			for(Object[] hlod:dis){
				 if("3".equalsIgnoreCase(hlod[0].toString()) &&  temp.equalsIgnoreCase(hlod[3].toString()) && "7".equalsIgnoreCase(hlod[4].toString()))
				 {
		
	   %>
	   
	  			<div class="row">  
	   				<div class="col-md-11"  align="left"  style="margin-left: 10px;">
	     				<div class="panel panel-info">
	      					<div class="panel-heading">
	        					<h4 class="panel-title">
	          						<span  style="font-size:14px">3.<%=unitcount %>.1.<%=unit11 %>. <%=hlod[9] %></span>  </h4>
	          				
		       						<div   style="float: right !important; margin-top:-23px; ">
									 	<table style="text-align: center;" >
							     			<thead>
								             	<tr>
								                 	<th ></th>       
								             	</tr>
								         	 </thead>
								         	<tbody>
							      				<tr>
										      		<td style="max-width:120px;  font-size:small; font-weight:bold; overflow: hidden; word-break: break-word !important; white-space: normal !important;"> 
										      			<form  id="myForm<%=temp %>P<%=form11 %>" action="MinutesSpecEdit.htm" method="post">
										                	
										                		<input type="hidden" name="specname" value="Agenda-Recommendation">
										                		<input type="hidden" name="scheduleid"	value="<%=hlod[6] %>" />
																<input type="hidden" name="minutesid"	value="<%=hlod[0] %>" />
																<input type="hidden" name="scheduleminutesid" 	value="<%=hlod[1] %>" /> 
											                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />  
										                    	<input type="hidden" name="formname" value="rm<%=form7 %><%=temp %>P<%=form20 %>" />
																<input class="form-control" type="hidden" name="unit1" value="#5Pre<%=scheduleagendaid %>" readonly="readonly">
										          			<input type="submit" class="btn btn-warning btn-sm"  id="rm<%=form7 %><%=temp %>P<%=form20 %>" onclick="FormNameEditB('myForm<%=temp %>P<%=form11 %>' , '<%=hlod[9] %>')" value="EDIT"  style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;"   />
										          			
										       			</form>
										      		</td>
										      		
							      				</tr>
							      	
							       				
							       				
							       			</tbody>
							      	
							      		</table>
		      							<br>
		      		
		       						</div>
	           				</div>
	  					</div>
					</div>
				</div>
				
	<%unitcount11++;countloop++;form11++;form20++;unit11++;  Presentationcount++;}}}%>
	   <div class="row">  
	   				<div class="col-md-11"  align="left"  style="margin-left: 10px;">
	     				<div class="panel panel-info">
	      					<div class="panel-heading">
	       						<form action="ScheduleMinutesUnitEdit.htm" method="post"  id="myForm<%=form6 %><%=temp %>P<%=form20 %>">
	        					<h4 class="panel-title">
	          						<span  style="font-size:14px">3.<%=unitcount %>.2.<%=unit11 %>.</span>  </h4>
	          						<div style="margin-top:-22px; margin-left: 55px;">
	          						
	          						<input type="text" class=""  name="OutComesId" id="OutComesId" maxlength="100" value="<%= "Presentation "+ (++Presentationcount) %>">
	          						
	          						</div>
	          						<div style="margin-top:-26px; float: right;">
	          						<input type="submit" class="btn btn-info btn-sm" name="sub"  id="rm<%=form7 %><%=temp %>D<%=form20 %>" value="ADD" onclick="FormNameB('myForm<%=form6 %><%=temp %>P<%=form20 %>')" style="width:42px ;height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
	          						

	        					    </div>
	        					    <input type="hidden" name="specname" value="Agenda-<%=Unit %>-Outcomes">
	        					    <input class="form-control" type="hidden" name="agendasubid" value="7" readonly="readonly">
									<input class="form-control" type="hidden" name="minutesid" value="3" readonly="readonly">
									<input class="form-control" type="hidden" name="scheduleagendaid" value="<%=scheduleagendaid %>" readonly="readonly">
	        					    <input class="form-control" type="hidden" name="committeescheduleid" value="<%=committscheduleid %>" readonly="readonly">
								    <input type="hidden" name="formname" value="rm<%=form7 %><%=temp %>P<%=form20 %>" />
								    <input type="hidden" name="unitid" value="<%=temp %>" />
								    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />  
								    <input class="form-control" type="hidden" name="membertype" value="<%=membertype %>" readonly="readonly">
								    <input class="form-control" type="hidden" name="unit1" value="#5Pre<%=scheduleagendaid %>" readonly="readonly">
									
	       						</form>
	       					    
	           				</div>
	  					</div>
					</div>
				</div>
	    
			
	  			
	
	     </div>   <!-- Agenda collapse end -->     
	 </div><!-- Agenda Panel end -->  
	
	</div>
	
	</div><!-- row end -->
	
	
	
	 <div class="row">  
   			<div class="col-md-11"  align="left"  style="margin-left: 10px;">
		
		<div class="panel panel-info">
			
		<div class="panel-heading">
	    	
	    	<h4 class="panel-title">
	           <span  style="font-size:14px">3.<%=unitcount %>.2. Discussions </span>
	        </h4>
	        
	       	<div style="float: right !important; margin-top:-20px; " > 
	       		<%int collapseD=483; %>
	       		<a data-toggle="collapse" data-parent="#accordion" href="#<%=collapseD%><%=collapse%>" > <i class="fa fa-plus" style="color:green" id="5Dis<%=scheduleagendaid %>5"></i></a>
	       	</div>
	       	
	    </div>
	      
	  	<div id="<%=collapseD%><%= collapse %>" class="panel-collapse collapse in">
	  
	  <%int unitcount12=1; long unit12=1; String Unit12=null; int countloop12=100; int form12=3455;int collapse12=140;String temp12=null;int form19=650; int discussionscount=0; 
	  
	  /* int unitcount13=1;  long unit13=1; String Unit13=null; int countloop13=100; int form13=4455;int collapse13=140;String temp13=null;int form18=700; */
	  
	   if(!dis.isEmpty()){
			for(Object[] hlod:dis){
				 if("3".equalsIgnoreCase(hlod[0].toString()) &&  temp.equalsIgnoreCase(hlod[3].toString()) && "8".equalsIgnoreCase(hlod[4].toString()))
				 {
		
	   %>
	   
	  			<div class="row">  
	   				<div class="col-md-11"  align="left"  style="margin-left: 10px;">
	     				<div class="panel panel-info">
	      					<div class="panel-heading">
	        					<h4 class="panel-title">
	          						<span  style="font-size:14px">3.<%=unitcount %>.2.<%=unit12 %>. <%=hlod[9] %></span>  </h4>
	          				
		       						<div   style="float: right !important; margin-top:-23px; ">
									 	<table style="text-align: center;" >
							     			<thead>
								             	<tr>
								                 	<th ></th>       
								             	</tr>
								         	 </thead>
								         	<tbody>
							      				<tr>
										      		<td style="max-width:120px;  font-size:small; font-weight:bold; overflow: hidden; word-break: break-word !important; white-space: normal !important;"> 
										      			<form  id="myForm<%=temp %>D<%=form12 %>" action="MinutesSpecEdit.htm" method="post">
										                	
										                		<input type="hidden" name="specname" value="Agenda-Recommendation">
										                		<input type="hidden" name="scheduleid"	value="<%=hlod[6] %>" />
																<input type="hidden" name="minutesid"	value="<%=hlod[0] %>" />
																<input type="hidden" name="scheduleminutesid" 	value="<%=hlod[1] %>" /> 
											                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />  
										                    	<input type="hidden" name="formname" value="rm<%=form7 %><%=temp %>D<%=form19 %>" />
																<input class="form-control" type="hidden" name="unit1" value="#5Dis<%=scheduleagendaid %>" readonly="readonly">
										          			<input type="submit" class="btn btn-warning btn-sm"  id="rm<%=form7 %><%=temp %>D<%=form19 %>" onclick="FormNameEditB('myForm<%=temp %>D<%=form12 %>' , '<%=hlod[9] %>')" value="EDIT"  style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;"   />
										          			
										       			</form>
										      		</td>
										      		
							      				</tr>
							      	
							       				
							       				
							       			</tbody>
							      	
							      		</table>
		      							<br>
		      		
		       						</div>
	           				</div>
	  					</div>
					</div>
				</div>
				
	<%unitcount12++;countloop++;form12++;form19++;unit12++;  discussionscount++;}}}%>
	   <div class="row">  
	   				<div class="col-md-11"  align="left"  style="margin-left: 10px;">
	     				<div class="panel panel-info">
	      					<div class="panel-heading">
	       						<form action="ScheduleMinutesUnitEdit.htm" method="post"  id="myForm<%=form6 %><%=temp %>D<%=form19 %>">
	        					<h4 class="panel-title">
	          						<span  style="font-size:14px">3.<%=unitcount %>.2.<%=unit12 %>.</span>  </h4>
	          						<div style="margin-top:-22px; margin-left: 55px;">
	          						
	          						<input type="text" class=""  name="OutComesId" id="OutComesId" maxlength="100" value="<%= "Discussion "+ (++discussionscount) %>">
	          						
	          						</div>
	          						<div style="margin-top:-26px; float: right;">
	          						<input type="submit" class="btn btn-info btn-sm" name="sub"  id="rm<%=form7 %><%=temp %>D<%=form19 %>" value="ADD" onclick="FormNameB('myForm<%=form6 %><%=temp %>D<%=form19 %>')" style="width:42px ;height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
	          						

	        					    </div>
	        					    <input type="hidden" name="specname" value="Agenda-<%=Unit %>-Outcomes">
	        					    <input class="form-control" type="hidden" name="agendasubid" value="8" readonly="readonly">
									<input class="form-control" type="hidden" name="minutesid" value="3" readonly="readonly">
									<input class="form-control" type="hidden" name="scheduleagendaid" value="<%=scheduleagendaid %>" readonly="readonly">
	        					    <input class="form-control" type="hidden" name="committeescheduleid" value="<%=committscheduleid %>" readonly="readonly">
								    <input type="hidden" name="formname" value="rm<%=form7 %><%=temp %>D<%=form19 %>" />
								    <input type="hidden" name="unitid" value="<%=temp %>" />
								    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />  
								    <input class="form-control" type="hidden" name="membertype" value="<%=membertype %>" readonly="readonly">
								    <input class="form-control" type="hidden" name="unit1" value="#5Dis<%=scheduleagendaid %>" readonly="readonly">
									
	       						</form>
	       					    
	           				</div>
	  					</div>
					</div>
				</div>
	    
			
	  			
	
	     </div>   <!-- Agenda collapse end -->     
	 </div><!-- Agenda Panel end -->  
	
	</div>
	
	</div><!-- row end -->
	
<!-- --------------------------------------------------  Dinesh  End  --------------------------------------------------------------------------------------- -->	
	
	<!-- ********* sub row 2 end ********* -->
	
	
	
	<!-- ******** sub row 3 start *****  -->
	
	 <div class="row">  
   				<div class="col-md-11"  align="left"  style="margin-left: 10px;">
		
		<div class="panel panel-info">
		
		<div class="panel-heading">
	    	
	    	<h4 class="panel-title">
	           <span  style="font-size:14px">3.<%=unitcount %>.3. Outcomes </span>
	        </h4>
	        
	       	<div style="float: right !important; margin-top:-20px; " > 
	       		<%int collapse3=484; %>
	       		<a data-toggle="collapse" data-parent="#accordion" href="#<%=collapse3%><%=collapse%>" > <i class="fa fa-plus" style="color:green" id="5Out<%=scheduleagendaid %>5"></i></a>
	       	</div>
	       	
	    </div>
	      
	  	<div id="<%=collapse3%><%=collapse%>" class="panel-collapse collapse in">
	  	
	   <%int unitcount13=1;  long unit13=1; String Unit13=null; int countloop13=100; int form13=4455;int collapse13=140;String temp13=null;int form18=700;
	   if(!dis.isEmpty()){
			for(Object[] hlod:dis){
				 if("3".equalsIgnoreCase(hlod[0].toString())&&temp.equalsIgnoreCase(hlod[3].toString())&&"9".equalsIgnoreCase(hlod[4].toString())){
		
	   %>
	   
	  			<div class="row">  
	   				<div class="col-md-11"  align="left"  style="margin-left: 10px;">
	     				<div class="panel panel-info">
	      					<div class="panel-heading">
	        					<h4 class="panel-title">
	          						<span  style="font-size:14px">3.<%=unitcount %>.3.<%=unit13 %>. <%=hlod[8] %></span>  </h4>
	          				
	       						<div   style="float: right !important; margin-top:-23px; ">
								 	<table style="text-align: center;" >
						     			<thead>
							             	<tr>
							                 	<th ></th>       
							             	</tr>
							         	 </thead>
							         	<tbody>
							         	
							         	
						
						      	
						      				<tr>
						
									      		<td style="max-width:120px;  font-size:small; font-weight:bold; overflow: hidden; word-break: break-word !important; white-space: normal !important;"> 
									      			<form  id="myForm<%=temp %>R<%=form13 %>" action="MinutesSpecEdit.htm" method="post">
									                	
									                		<input type="hidden" name="specname" value="Agenda-Recommendation">
									                		<input type="hidden" name="scheduleid"	value="<%=hlod[6] %>" />
															<input type="hidden" name="minutesid"	value="<%=hlod[0] %>" />
															<input type="hidden" name="scheduleminutesid" 	value="<%=hlod[1] %>" /> 
										                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />  
									                    	<input type="hidden" name="formname" value="rm<%=form7 %><%=temp %>R<%=form18 %>" />
															<input class="form-control" type="hidden" name="unit1" value="#5Out<%=scheduleagendaid %>" readonly="readonly">				
									          			<input type="submit" class="btn btn-warning btn-sm"  id="rm<%=form7 %><%=temp %>R<%=form18 %>" onclick="FormNameEditA('myForm<%=temp %>R<%=form13 %>')" value="EDIT"  style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;"   />
									          			
									       			</form>
									      		</td>
									      		
						      				</tr>
						       			</tbody>
						      	
						      		</table>
	      							<br>
	      		
	       						</div>
	       			
	       		
	           				</div>
	  					</div>
					</div>
				</div>
				
	<%unitcount13++;countloop++;form13++;form18++;unit13++;}}}%>
	   			<div class="row">  
	   				<div class="col-md-11"  align="left"  style="margin-left: 10px;">
	     				<div class="panel panel-info">
	      					<div class="panel-heading">
	       						<form action="ScheduleMinutesUnitEdit.htm" method="post"  id="myForm<%=form6 %><%=temp %>R<%=form18 %>">
	        					<h4 class="panel-title">
	          						<span  style="font-size:14px">3.<%=unitcount %>.3.<%=unit13 %>.</span>  </h4>
	          						<div style="margin-top:-22px; margin-left: 55px;">
	          							<select  name="OutComesId" id="OutComesId" required="required"  data-live-search="true"  style="width: 165px;"  >
	                                        <%for(Object[] obj:minutesoutcomelist){ %>	
												<option value="<%=obj[0]%>"><%=obj[1]%></option>	
											<%} %>
										</select>
	          						
	          						
	          						
	          						
	          						</div>
	          						<div style="margin-top:-26px; margin-left: 240px;">
	          						<input type="submit" class="btn btn-info btn-sm" name="sub"  id="rm<%=form7 %><%=temp %>R<%=form18 %>" value="ADD" onclick="FormNameA('myForm<%=form6 %><%=temp %>D<%=form18 %>')" style="width:42px ;height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
	          						

	        					    </div>
	        					    <input type="hidden" name="specname" value="Agenda-<%=Unit %>-Outcomes">
	        					    <input class="form-control" type="hidden" name="agendasubid" value="9" readonly="readonly">
									<input class="form-control" type="hidden" name="minutesid" value="3" readonly="readonly">
									<input class="form-control" type="hidden" name="scheduleagendaid" value="<%=scheduleagendaid %>" readonly="readonly">
	        					    <input class="form-control" type="hidden" name="committeescheduleid" value="<%=committscheduleid %>" readonly="readonly">
								    <input type="hidden" name="formname" value="rm<%=form7 %><%=temp %>R<%=form18 %>" />
								     <input type="hidden" name="unitid" value="<%=temp %>" />
								    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />  
								    <input class="form-control" type="hidden" name="membertype" value="<%=membertype %>" readonly="readonly">
								    <input class="form-control" type="hidden" name="unit1" value="#5Out<%=scheduleagendaid %>" readonly="readonly">
									
	       						</form>
	       					    
	           				</div>
	  					</div>
					</div>
				</div>
	    
			
	  			
	
	     </div>   <!-- Agenda collapse end -->     
	 </div><!-- Agenda Panel end -->  
	
	</div>
	
	</div><!-- row end -->
	
	
	<!-- ********* sub row 3 end ********* -->
	

	
	<!-- New code inside agenda end -->
	


	</div><!-- main sub collapse end  -->
	
</div><!-- Agenda panel end -->

</div>
</div>


 <%unitcount++;countloop++;form6++;form7++;collapse++; }}else{
 	  
    %> 
    
  <div class="panel panel-info">
      <div class="panel-heading">
      		
      	<p>No Agenda Defined ..!!</p>
      		
      </div>
  </div>
      		
<%} %>

     </div>   <!-- Agenda collapse end -->     
 </div><!-- Agenda Panel end -->
    
 
 <!-- End of 3 new-->    
     

  
  
  <!-- New Code  -->
  
  <!-- 4th row Discussion -->
  
  
  <div class="panel panel-info">
	
	<div class="panel-heading">
    	
    	<h4 class="panel-title">
           <span  style="font-size:14px">4. Other Discussion</span>
        </h4>
        
   
   <%int unitcount0=1;  long unit0=1; String Unit0=null; int countloop0=100; int form46=4646;int collapse0=140;String temp0=null;

	
	   		
	   %>
   

       						<div   style="float: right !important; margin-top:-23px; ">
							 	<table style="text-align: center;" >
					     			<thead>
						             	<tr>
						                 	<th ></th>       
						             	</tr>
						         	 </thead>
						         	<tbody>
						         	
						         	
							 <%
							 	if(!dis.isEmpty()){
									for(Object[] hlo:dis){
										 if("4".equalsIgnoreCase(hlo[0].toString())){
										       %>
					      	
					      				<tr>
					
								      		<td style="max-width:120px;  font-size:small; font-weight:bold; overflow: hidden; word-break: break-word !important; white-space: normal !important;"> 
								      			<form  id="myForm<%=form46 %>" action="MinutesSpecEdit.htm" method="post">
								                	
								                		<input type="hidden" name="specname" value="Other Discussion">
								                		<input type="hidden" name="scheduleid"	value="<%=hlo[6] %>" />
														<input type="hidden" name="minutesid"	value="<%=hlo[0] %>" />
														<input type="hidden" name="scheduleminutesid" 	value="<%=hlo[1] %>" /> 
									                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />  
								                    	<input type="hidden" name="formname" value="rm<%=form46 %>" />
					
								          			<input type="submit" class="btn btn-warning btn-sm"  id="rm<%=form46 %>" onclick="FormNameEdit('myForm<%=form46 %>')" value="EDIT"  style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;"   />
								          			
								       			</form>
								      		</td>
								      		
					      				</tr>
					      	
					       				 <%}}}%> 
					       				
					       			</tbody>
					      	
					      		</table>
      							<br>
      		
       						</div>
       			
       						
       					    <div style="float: right !important; margin-top:-25px; " >
			
								<form name="myForm" id="myForm<%=form46 %>" action="ItemSpecAdd.htm" method="post" 
		
									<%
							 	if(!dis.isEmpty()){
									for(Object[] hlo:dis){
										 if("4".equalsIgnoreCase(hlo[0].toString())){
										       %>hidden="hidden" 
												        <%}}}%>  
												        >
					
									<input type="hidden" name="specname" value="Other Discussion">
									<input class="form-control" type="hidden" name="agendasubid" value="0" readonly="readonly">
									<input class="form-control" type="hidden" name="minutesid" value="4" readonly="readonly">
									<input class="form-control" type="hidden" name="scheduleagendaid" value="0" readonly="readonly">
									
									<input class="form-control" type="hidden" name="unit1id" value="#unitdiscussion" readonly="readonly">
									<input type="hidden" name="formname" value="rm<%=form46 %>" />
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									<input type="submit" class="btn btn-info btn-sm" name="sub" id="rm<%=form46 %><%=temp %>OD" onclick="FormName('myForm<%=form46 %>')" value="ADD"  style="width:42px ;height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>

								
								</form>
			
   							</div>
       					    
   
			
<%unitcount0++;countloop++;form46++;%>
   
    
	
  			

     </div>   <!-- Agenda collapse end -->     
 </div><!-- Agenda Panel end -->   

<!--  4th row end-->



<!-- 5th row Recommendation -->


<div class="panel panel-info">
	
	<div class="panel-heading">
    	
    	<h4 class="panel-title">
           <span  style="font-size:14px">5. Other Outcomes</span>
        </h4>
        
       	<div style="float: right !important; margin-top:-20px; " > 
       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse58" > <i class="fa fa-plus" id="OutCome5"></i></a>
       	</div>
       	
    </div>
      
  	<div id="collapse58" class="panel-collapse collapse in">
  	
   <% int unitcount1=1;  long unit1=1; String Unit1=null; int countloop1=100; int form1=545;int collapse1=140;String temp1=null; %>
	  
	   
   	 <%
							 	if(!dis.isEmpty()){
									for(Object[] hlo:dis){
										 if("5".equalsIgnoreCase(hlo[0].toString())){
										       %>
  			<div class="row">  
   				<div class="col-md-11"  align="left"  style="margin-left: 10px;">
     				<div class="panel panel-info">
      					<div class="panel-heading">
       						
	        					<h4 class="panel-title">
	          						<span  style="font-size:14px">5.<%=unitcount1 %> <%=hlo[8] %> </span>  </h4>
	          				
       						<div   style="float: right !important; margin-top:-23px; ">
							 	<table style="text-align: center;" >
					     			<thead>
						             	<tr>
						                 	<th ></th>       
						             	</tr>
						         	 </thead>
						         	<tbody>
					      				<tr>
								      		<td style="max-width:120px;  font-size:small; font-weight:bold; overflow: hidden; word-break: break-word !important; white-space: normal !important;"> 
								      			<form  id="myForm<%=form1 %>" action="MinutesSpecEdit.htm" method="post">
								                	 	
								                		<input type="hidden" name="specname" value="Recommendation">
								                		<input type="hidden" name="scheduleid"	value="<%=hlo[6] %>" />
														<input type="hidden" name="minutesid"	value="<%=hlo[0] %>" />
														<input type="hidden" name="scheduleminutesid" 	value="<%=hlo[1] %>" /> 
									                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />  
								                        <input type="hidden" name="formname" value="rm<%=form1 %>" /> 
														<input class="form-control" type="hidden" name="unit1" value="5" readonly="readonly">
								          			<input type="submit" class="btn btn-warning btn-sm" id="rm<%=form1 %>"   onclick="FormNameEditA('myForm<%=form1 %>')" value="EDIT"  style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;"   />
								          			
								       			</form>
								      		</td>
					      				</tr>
					       			</tbody>
					      		</table>
      							<br>
      		
       						</div>
       			
       						
       				
       					    
           				</div>
  					</div>
				</div>
			</div>
		 <%unitcount1++;form1++;}}}%> 	
<%countloop++;%>
   
    
		  <div class="row">  
	   				<div class="col-md-11"  align="left"  style="margin-left: 10px;">
	     				<div class="panel panel-info">
	      					<div class="panel-heading">
	       						<form action="ScheduleMinutesUnitEdit.htm" method="post" id="myForm<%=form1 %>">
	        					<h4 class="panel-title">
	          						<span  style="font-size:14px">5.<%=unitcount1 %>.</span>  </h4>
	          						<div style="margin-top:-22px; margin-left: 25px;">
		          						<select  name="OutComesId" id="Assignee" required="required"  data-live-search="true"  style="width: 165px;"  >
		                                    <%for(Object[] obj:minutesoutcomelist){ %>	
												<option value="<%=obj[0]%>"><%=obj[1]%></option>	
											<%} %>
										</select>
	          						</div>
	          						<div style="margin-top:-26px; margin-left: 200px;">
	          						<input type="submit" class="btn btn-info btn-sm" name="sub"  id="rm<%=form1 %>" value="ADD" onclick="FormNameA('myForm<%=form1 %>')" style="width:42px ;height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
	        					    </div>
	        					       <input class="form-control" type="hidden" name="agendasubid" value="0" readonly="readonly">
									    <input class="form-control" type="hidden" name="minutesid" value="5" readonly="readonly">
									   <input class="form-control" type="hidden" name="scheduleagendaid" value="0" readonly="readonly">
	        		                   <input type="hidden" name="specname" value="Other OutComes">
	        					    <input class="form-control" type="hidden" name="committeescheduleid" value="<%=committscheduleid %>" readonly="readonly">
								    
								     <input type="hidden" name="unitid" value="<%=temp %>" />
								    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />  
								    <input class="form-control" type="hidden" name="membertype" value="<%=membertype %>" readonly="readonly">
								    <input class="form-control" type="hidden" name="unit1" value="5" readonly="readonly">
									<input type="hidden" name="formname" value="rm<%=form1 %>" />
	       						</form>
	       					    
	           				</div>
	  					</div>
					</div>
				</div>
  			

     </div>   <!-- Agenda collapse end -->     
 </div><!-- Agenda Panel end --> 


<!-- 6th row Conclusion -->


<div class="panel panel-info">
	
	<div class="panel-heading">
    	
    	<h4 class="panel-title">
           <span  style="font-size:14px">6. Conclusion</span>
        </h4>
        
     
  	
   <%int unitcount2=1;  long unit2=1; String Unit2=null; int countloop2=100; int form2=5456;int collapse2=140;String temp2=null;
   

	   		
	   %>

       						<div   style="float: right !important; margin-top:-23px; ">
							 	<table style="text-align: center;" >
					     			<thead>
						             	<tr>
						                 	<th ></th>       
						             	</tr>
						         	 </thead>
						         	<tbody>
						         	
						         	
							 <%
							 	if(!dis.isEmpty()){
									for(Object[] hlo:dis){
										 if("6".equalsIgnoreCase(hlo[0].toString())){
										       %>
					      	
					      				<tr>
					
								      		<td style="max-width:120px;  font-size:small; font-weight:bold; overflow: hidden; word-break: break-word !important; white-space: normal !important;"> 
								      			<form  id="myForm<%=form2 %>" action="MinutesSpecEdit.htm" method="post">
								                	
								                		<input type="hidden" name="specname" value="Conclusion">
								                		<input type="hidden" name="scheduleid"	value="<%=hlo[6] %>" />
														<input type="hidden" name="minutesid"	value="<%=hlo[0] %>" />
														<input type="hidden" name="scheduleminutesid" 	value="<%=hlo[1] %>" /> 
									                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />  
								                    	<input type="hidden" name="formname" value="rm<%=form2 %>" />
														<input class="form-control" type="hidden" name="unit1id" value="#unitconclusion" readonly="readonly">
							
								          			<input type="submit" class="btn btn-warning btn-sm"  id="rm<%=form2 %>" onclick="FormNameEdit('myForm<%=form2 %>')" value="EDIT"  style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;"   />
								          			
								       			</form>
								      		</td>
								      		
					      				</tr>
					      	
					       				 <%}}}%> 
					       				
					       			</tbody>
					      	
					      		</table>
      							<br>
      		
       						</div>
       			
       						
       					    <div style="float: right !important; margin-top:-25px; " >
			
								<form name="myForm" id="myForm<%=form2 %>" action="ItemSpecAdd.htm" method="post" 
		
									<%
							 	if(!dis.isEmpty()){
									for(Object[] hlo:dis){
										 if("6".equalsIgnoreCase(hlo[0].toString())){
										       %>hidden="hidden" 
												        <%}}}%>  
												        >
					
									<input type="hidden" name="specname" value="Conclusion">
									<input class="form-control" type="hidden" name="agendasubid" value="0" readonly="readonly">
									<input class="form-control" type="hidden" name="minutesid" value="6" readonly="readonly">
									<input class="form-control" type="hidden" name="scheduleagendaid" value="0" readonly="readonly">
									
									<input class="form-control" type="hidden" name="unit1id" value="#unitconclusion" readonly="readonly">
									<input type="hidden" name="formname" value="rm<%=form2 %>" />
									
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	
									<input type="submit" class="btn btn-info btn-sm" name="sub"  id="rm<%=form2 %><%=temp %>CO" onclick="FormName('myForm<%=form2%>')" value="ADD"  style="width:42px ;height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
								
									
								
								</form>
			
   							</div>
       					    
  
			
<%unitcount2++;countloop++;form2++;%>
  

     </div>   <!-- Agenda collapse end -->     
 </div><!-- Agenda Panel end --> 


<!--  New code end-->




		</div><!-- Big card-body end -->
	
	</div><!-- Card End  -->
	
	
	<br>
	
	
	<%if(!committeescheduledata.isEmpty()){ %>
	
	<div class="row">
	
		<div class="col-md-3" >
		
			<form class="" name="assignaction" id="assignaction" action="CommitteeAction.htm" method="post">
	
				<input type="submit" name="sub" class="btn btn-sm add fa-thumbs-up" style="background-color:#0e49b5 !important; " form="assignaction"  value="ASSIGN ACTION &nbsp;&nbsp;&#xf164;"  onclick=""/>
				<input type="hidden" name="ScheduleId" value="<%=committeescheduleeditdata[6] %>">	
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="minutesback" value="minutesback"/>
				
			</form>
		
		
		</div>
	</div>
	
	<%} %>
	
<div class="row">
	<div class="col-md-12" >
		<div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
    		<div class="card-body" style="margin-top: -8px" >       	
				<b style="color: #346691; font-size: 20px;font-family: 'Lato',sans-serif; ">Additional File</b> 
				<hr><br>				
					<%if(minutesattachmentlist.size()>0){ %>
						<div class="card-body" style="margin-top: -8px" >       	
							<table class="table table-bordered table-hover table-striped table-condensed" >					
									<tr>
										<td><%=minutesattachmentlist.get(0)[2] %></td>
										<td>
											<div  align="center">
												<a  href="MinutesAttachDownload.htm?attachmentid=<%=minutesattachmentlist.get(0)[0]%>" 
												  target="_blank"><i class="fa fa-download"></i></a>
											</div>						
										</td>
										<td>
											<form method="post" action="MinutesAttachmentDelete.htm">
												<button class="fa fa-trash btn  " type="submit" onclick="return confirm('Are You Sure To Delete this File?');" style="margin-right: -30px"></button>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="ScheduleId" value="<%=committeescheduleeditdata[6] %>">
												<input type="hidden" name="attachmentid" value="<%=minutesattachmentlist.get(0)[0] %>">
											</form>									
										</td>
									</tr>
								
							</table>
						</div>
					<%} %>
				<form method="post" action="MinutesAttachment.htm" enctype="multipart/form-data" id="attachmentfrm" name="attachmentfrm" >					
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="hidden" name="ScheduleId" value="<%=committeescheduleeditdata[6] %>">
					<table>
						<tr>
							<td>
								<input type="file" name="FileAttach" id="FileAttach" required  class="form-control" aria-describedby="inputGroup-sizing-sm" maxlength="255" form="attachmentfrm"  onchange="Filevalidation('FileAttach');" />
							</td>
							<td>&nbsp;</td>
							<td>		
								<%if( minutesattachmentlist.size()==0){ %>						
									<input type="submit" name="sub" class="btn  btn-sm submit"  value="SUBMIT" onclick="return editcheck('FileAttach');" />
								<%}else if(minutesattachmentlist.size()>0){ %>
									<input type="hidden" name="attachmentid" value="<%=minutesattachmentlist.get(0)[0]%>"/>
									<input type="submit" name="sub" class="btn  btn-sm edit"  value="EDIT" onclick="return editcheck1('FileAttach');" />
								<%} %>
							</td>
						</tr>
					</table>
				</form>				
			</div>			
		</div>
	</div>
</div>
				
		
		
	

	
	
	
	
	
</div> <!-- col-md-5 end -->





<div class="col-md-7">
	
	<div class="card" style="margin-top: 2%;">
    	<div class="card-body">
            <form name="specadd" id="specadd" action="CommitteeMinutesSubmit.htm" method="post">
  
   				<div class="row"  style="margin-bottom: 10px;">
   					
   					<div class="col-md-12"  align="left">
						<label>
						<b id="iditemspec" style="font-size:18px " ></b>
						<b id="iditemsubspecofsub" style="font-size:18px " ></b>
						<b id="iditemsubspec" style="font-size:18px " ></b>
						<b id="iditemunit" style="font-size:18px " ></b>

							<input class="form-control" type="hidden" name="minutesid" id="minutesidadd" >
							<input class="form-control" type="hidden" name="agendasubid" id="agendasubidadd" >
							<input class="form-control" type="hidden" name="scheduleagendaid" id="scheduleagendaidadd" >
							<input class="form-control" type="hidden" name="specname" id="specnameadd" >
							<input class="form-control" type="hidden" name="minutesunitid" id="minutesunitidadd" >
							<input class="form-control" type="hidden" name="statusflag" value="D" readonly="readonly">
							<!--  for redirecting-->
							<input class="form-control" type="hidden" name="unit1" id="unit1idadd" readonly="readonly">
							<input class="form-control" type="hidden" name="formname" id="formnameadd" >
							
							<input class="form-control" type="hidden" name="scheduleidedit" id="scheduleidedit" >
							<input class="form-control" type="hidden" name="minutesidedits" id="minutesidedit" >
							<input class="form-control" type="hidden" name="schedulminutesid" id="scheduleminutesidedit" >
							
						</label>
					</div>
   					
   					<div class="col-md-12"  align="left" style="margin-left: 0px;width:100%;margin-top: -25px ">
						<label style="margin-left: 50px;"></label>
						<div   id="summernote" class="center">
						 
						</div>
						 <textarea  name="NoteText" id="editor1" style="display:none;"></textarea>
					</div>

  					
  
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					
		 			<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% ">
    					
    					<div class="card"  style="margin-top: 15px;">
            				<div class="card-body" style="background-color: #f7f7f7;">
  								
  								
  								<div align="center" id="drcdiv"  style="margin-top: 10px;">
  								
  									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="darc" id="decision" value="D">
									  <label class="form-check-label" for="decision">Decision</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="darc" id="recommendation" value="R">
									  <label class="form-check-label" for="recommendation">Recommendation</label>
									</div>
									
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="darc" id="comments" value="C">
									  <label class="form-check-label" for="comments">Comments</label>
									</div>
  								
  								</div>
 
  								<div class="form-group">
  									<label class="">Remarks : </label>
  									<input  class="form-control"  type="text" maxlength="255"  placeholder="Nil" name="remarks" id="remarks" style="width:80%">
  								
                        		</div>
  
								<div align="center" style="margin-top: -25px;">
									<br>
									
									<br>
																	
 										<input type="submit" name="sub" class="btn  btn-sm submit" form="specadd"  id="adding" value="SUBMIT"  />
								  		<input type="submit" name="sub" class="btn  btn-sm submit" form="specadd" id="editing"  value="SUBMIT" formaction="CommitteeMinutesEditSubmit.htm" onclick="return confirm('Are you sure To Submit?')"/>
										<input type="submit" name="sub" hidden="hidden" form="specadd" id="hiddensubmit">
										<input type="hidden" name="scheduleid" value="<%=committeescheduleeditdata[6] %>">	
										<input type="hidden" name="schedulesubid" value="1" readonly="readonly">
										<input type="hidden" name="membertype" value="<%=membertype %>" readonly="readonly">
										<input type="hidden" name="committeename" value="<%=committeescheduleeditdata[8]%>">
								</div>
  							</div>
  						</div>
					</div>
  
 				</div>  

	 		</form>
	 		
	 		<!-- AIR -->
	 		<form name="specadd" id="specair" action="CommitteeMinutesSubmit.htm" method="post">
  
   				<div class="row"  style="margin-bottom: 10px;">
   					
   					<div class="col-md-12"  align="left">
						<label>
						<b id="iditemspecair" style="font-size:18px " ></b>
						<b id="iditemsubspecofsubair" style="font-size:18px " ></b>
						<b id="iditemsubspecair" style="font-size:18px " ></b>
						<b id="iditemair" style="font-size:18px " ></b>
						<b id="outcomeair" style="font-size:18px " ></b>

							<input class="form-control" type="hidden" name="minutesid" id="minutesidair" >
							<input class="form-control" type="hidden" name="agendasubid" id="agendasubidair" >
							<input class="form-control" type="hidden" name="scheduleagendaid" id="scheduleagendaidair" >
							<input class="form-control" type="hidden" name="specname" id="specnameair" >

							<!--  for redirecting-->
							<input class="form-control" type="hidden" name="formname" id="formnameair" >
							<input class="form-control" type="hidden" name="unit1" id="unit1idair" readonly="readonly">
				
							
							<input class="form-control" type="hidden" name="scheduleidedit" id="scheduleideditair" >
							<input class="form-control" type="hidden" name="minutesidedits" id="minutesideditair" >
							<input class="form-control" type="hidden" name="schedulminutesid" id="scheduleminutesideditair" >
							
						</label>
					</div>
   					
   					<div class="col-md-12"  align="left" style="margin-left: 0px;width:100%;">
						<label >Action Name</label>

						 <textarea class="form-control" required="required"  name="NoteText" id="editorair" style="width:100%;" maxlength="1000"></textarea>
					</div>

  					
  
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					
		 			<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% ">
    					
    					<div class="card"  style="margin-top: 15px;">
            				<div class="card-body" style="background-color: #f7f7f7;">
                             <div class="row" >
                             <div class="col-md-8">
  								<div class="form-group">
  									<label class="">Remarks : </label>
  									<input  class="form-control"  type="text" maxlength="255"  placeholder="Nil" name="remarks" id="remarksair" style="width:100%">
                        		</div>
                        		</div>
                        		  <div class="col-md-4" id="OutComeDiv">
                        		<div class="form-group">
                        		<label class="">Outcome Type </label>
  	                               <select  class="form-control" name="darc" id="OutComeAir" required="required"  data-live-search="true"  >
                                        <%for(Object[] obj:minutesoutcomelist){ %>	
																	
											<option value="<%=obj[0]%>"><%=obj[1]%></option>	
															
										<%} %>
									</select>
								</div>
								</div>
								
								  <div class="col-md-4" id="PresDiscHeader">
                        		<div class="form-group">
                        		<label class="">Header </label>
  	                               <input type="text" class="form-control" name="PresDiscHeaderVal" value="" id="PresDiscHeaderVal" maxlength="100">
								</div>
								</div>
								
								</div>							
								<div align="center" style="margin-top: -25px;">
									<br>
									<br>
 										<input type="submit" name="sub" class="btn  btn-sm submit" form="specair"  id="addingair" value="SUBMIT"  />
								  		<input type="submit" name="sub" class="btn  btn-sm submit" form="specair" id="editingair"  value="SUBMIT" formaction="CommitteeMinutesEditSubmit.htm" onclick="return confirm('Are you sure To Submit?')"/>
								  		<input type="submit" name="sub" class="btn  btn-sm submit" style="background-color: #dc3545; border-color: #dc3545;" form="specair" id="deletingair"  value="DELETE" formaction="CommitteeMinutesDeleteSubmit.htm" onclick="return confirm('Are you sure To Submit?')"/>
										<input type="submit" name="sub" hidden="hidden" form="specadd" id="hiddensubmit">
										<input type="hidden" name="scheduleid" value="<%=committeescheduleeditdata[6] %>">	
										<input type="hidden" name="schedulesubid" value="1" readonly="readonly">
										<input type="hidden" name="membertype" value="<%=membertype %>" readonly="readonly">
										<input type="hidden" name="committeename" value="<%=committeescheduleeditdata[8]%>">
										<input type="hidden" name="OutComeAirHead"  id="OutComeAirHead" value="">
								</div>
  							</div>
  						</div>
					</div>  
 				</div>  
	 		</form>	 		
  		</div> 
	</div>	
</div>
<!-- col-md-7 end -->


</div> <!-- main row end -->

</div>

<script type="text/javascript">

function editcheck(editfileid)
{
	const fi = $('#'+editfileid )[0].files[0].size;							 	
    const file = Math.round((fi / 1024/1024));
    if (document.getElementById(editfileid).files.length !=0 && file >= <%=filesize%> ) 
    {
    	event.preventDefault();
     	alert("File too Big, please select a file less than <%=filesize%> mb");
    } else
    {
    	 return confirm('Are You Sure To Upload Minutes File ?');
    }
}


</script>

<script type="text/javascript">
function editcheck1(editfileid)
{
	const fi = $('#'+editfileid )[0].files[0].size;							 	
    const file = Math.round((fi / 1024/1024));
    if (document.getElementById(editfileid).files.length !=0 && file >= <%=filesize%> ) 
    {
    	event.preventDefault();
     	alert("File too Big, please select a file less than <%=filesize%> mb");
    } else
    {
    	return confirm('Are You Sure To Edit Minutes File ?');
    }
}



</script>




		<script type="text/javascript">
						
			    function Filevalidation (fileid)  
			    {
			        const fi = $('#'+fileid )[0].files[0].size;							 	
			        const file = Math.round((fi / 1024/1024));
			        if (file >= <%=filesize%>) 
			        {
			        	alert("File too Big, please select a file less than <%=filesize%> mb");
			        } 
			    }
						
		</script>
						



<script>
  
    $(document).ready(function(){
        // Add minus icon for collapse element which is open by default
        $(".collapse.show").each(function(){
        	$(this).prev(".panel-heading").find(".fa").addClass("fa-minus").removeClass("fa-plus");
        });
        
        // Toggle plus minus icon on show hide of collapse element
        $(".collapse").on('show.bs.collapse', function(){
        	$(this).prev(".panel-heading").find(".fa").removeClass("fa-plus").addClass("fa-minus");
        }).on('hide.bs.collapse', function(){
        	$(this).prev(".panel-heading").find(".fa").removeClass("fa-minus").addClass("fa-plus");
        });
    });
    
    $(document).ready(function(){
        // Add minus icon for collapse element which is open by default
        $(".collapse.show").each(function(){
        	$(this).prev(".panel-heading").find(".btn").addClass("btn-danger btn-sm").removeClass("btn-info btn-sm");
        });
        
        // Toggle plus minus icon on show hide of collapse element
        $(".collapse").on('show.bs.collapse', function(){
        	$(this).prev(".panel-heading").find(".btn").removeClass("btn-info btn-sm").addClass("btn-danger btn-sm");
        }).on('hide.bs.collapse', function(){
        	$(this).prev(".panel-heading").find(".btn").removeClass("btn-danger btn-sm").addClass("btn-info btn-sm");
        });
    });
   
    unitt="<%=unit3 %>";
    unitnew="<%=unit21%>";
    

    var regex = /\d+/g;
    var matches = unitt.match(regex);
    
	if(matches!=null){
		if("5"==matches){
			$("#OutCome5").click();	
		}else{
			
			$("#agendaclick").click();	
			unitt=unitt.slice(1);
			$("."+unitt).click();
			$("#"+unitt+'5').click();
		}
	}   
    
	
	function checklength(id){
		
		$('#'+id).on('change', function() { 
	        if($(this).is(':checked')) 
	        {
	        	var data =CKEDITOR.instances['summernote'].getData();
	        	if(data.length>1024){
	        		alert('Maximum number of characters for Action, Issue and Risk is 1024 . Characters entered by you is ' + data.length + '.');
					$(this).prop("checked", false);
				}
	        	
	        }
	    });
	}
	

 
</script>
	

 <script type="text/javascript">
	 
	
	  $('#specadd').submit(function() {
		  
		  var data =CKEDITOR.instances['summernote'].getData();
		  $('textarea[name=NoteText]').val(data);

		  if($('#issue').is(':checked')) 
		    {
				var data =CKEDITOR.instances['summernote'].getData();
				if(data.length>1024){
					alert('Maximum number of characters for Action, Issue and Risk is 1024 . Characters entered by you is ' + data.length+ '.');
					event.preventDefault();
				}
				
			}
			if($('#risk').is(':checked')) 
		    {
				var data =CKEDITOR.instances['summernote'].getData();
				if(data.length>1024){
					alert('Maximum number of characters for Action, Issue and Risk is 1024 . Characters entered by you is ' + data.length+ '.');
					event.preventDefault();
				}
				
			}
			if($('#action').is(':checked')) 
		    {
				var data =CKEDITOR.instances['summernote'].getData();
				if(data.length>1024){
					alert('Maximum number of characters for Action, Issue and Risk is 1024 . Characters entered by you is ' + data.length+ '.');
					event.preventDefault();
				}
				
			}
			

			    if ( $('input:radio', this).is(':checked')) {
			  
			    } else {
			        
			    	alert('Kindly select a action item !');
			        
			        return false;
			    }
			
		  
      });
	  
	  
	  function FormNameB(formId) {
    	  $("#"+formId).submit(function(event){
    		    event.preventDefault();
    		    $('#editingair').hide();
    		    $('#deletingair').hide();
    		    $('#addingair').show();
    		    $('#specadd').hide();
    		    $('#specair').show();
    		    $('#OutComeDiv').hide();
    		    $('#PresDiscHeader').hide();
    		    var minutesidadd = $("input[name='minutesid']",this).val();
    		    var specnameadd= $("input[name='specname']",this).val();
    		    var agendasubidadd= $("input[name='agendasubid']",this).val();
    		    var scheduleagendaidadd= $("input[name='scheduleagendaid']",this).val();
    		    var formnameadd= $("input[name='formname']",this).val();
    		    var type=$("#OutComesId",this).val();
    		    var unit1idadd= $("input[name='unit1']",this).val();
    		 
    		    $("#minutesidair").val(minutesidadd);
    		    $("#specnameair").val(specnameadd);
    		    $("#agendasubidair").val(agendasubidadd);
    		    $("#scheduleagendaidair").val(scheduleagendaidadd);
    		    $("#formnameair").val(formnameadd);
    		    $("#unit1idair").val(unit1idadd);
    		    $.ajax({
    				type : "GET",
    				url : "CommitteeMinutesSpecAdd.htm",
    				data : {
    					
    					minutesid : minutesidadd,
    					specname:specnameadd,
    					agendasubid:agendasubidadd,
    					scheduleagendaid:scheduleagendaidadd,
    					formname:formnameadd,
    					
    				},
    				datatype : 'json',
    				success : function(result) {
    					
    					var result = JSON.parse(result);
    					var values = Object.keys(result).map(function(e) {
    						  return result[e]
    						});

    						if(scheduleagendaidadd==0){
    						document.getElementById('iditemsubspecofsubair').innerHTML = "" ;
        					}	
    						
							if(scheduleagendaidadd!=0){
    						document.getElementById('iditemsubspecofsubair').innerHTML = " / " + values[4]; 
        					}
							
		
							if(agendasubidadd==0){
	    						
	    						document.getElementById('iditemsubspecair').innerHTML = "";
	        				}
    						if(agendasubidadd!=0){
    						
    						document.getElementById('iditemsubspecair').innerHTML = " / " + values[3]; 
        					}
    						
    						
    					document.getElementById('iditemspecair').innerHTML = values[1];

    					$("#remarksair").val('');
    					$("#OutComeAirHead").val(type);
    					$("#editorair").val('');
    					$("#OutComeAir").val('C');
    					document.getElementById('outcomeair').innerHTML = " / "+type;
     					

      	  		         	 
    				}
    			});
    		   
    		  });
    	  

    }  

	  function FormNameA(formId) {
    	  $("#"+formId).submit(function(event){
    		    event.preventDefault();
    		    $('#editingair').hide();
    		    $('#deletingair').hide();
    		    $('#addingair').show();
    		    $('#specadd').hide();
    		    $('#specair').show();
    		    $('#OutComeDiv').hide();
    		    $('#PresDiscHeader').hide();
    		    var minutesidadd = $("input[name='minutesid']",this).val();
    		    var specnameadd= $("input[name='specname']",this).val();
    		    var agendasubidadd= $("input[name='agendasubid']",this).val();
    		    var scheduleagendaidadd= $("input[name='scheduleagendaid']",this).val();
    		    var formnameadd= $("input[name='formname']",this).val();
    		    var type=$("select[name='OutComesId']",this).val();
    		    var unit1idadd= $("input[name='unit1']",this).val();
    		 
    		    $("#minutesidair").val(minutesidadd);
    		    $("#specnameair").val(specnameadd);
    		    $("#agendasubidair").val(agendasubidadd);
    		    $("#scheduleagendaidair").val(scheduleagendaidadd);
    		    $("#formnameair").val(formnameadd);
    		    $("#unit1idair").val(unit1idadd);
    		    $.ajax({
    				type : "GET",
    				url : "CommitteeMinutesSpecAdd.htm",
    				data : {
    					
    					minutesid : minutesidadd,
    					specname:specnameadd,
    					agendasubid:agendasubidadd,
    					scheduleagendaid:scheduleagendaidadd,
    					formname:formnameadd,
    					
    				},
    				datatype : 'json',
    				success : function(result) {
    					
    					var result = JSON.parse(result);
    					var values = Object.keys(result).map(function(e) {
    						  return result[e]
    						});

    						if(scheduleagendaidadd==0){
    						document.getElementById('iditemsubspecofsubair').innerHTML = "" ;
        					}	
    						
							if(scheduleagendaidadd!=0){
    						document.getElementById('iditemsubspecofsubair').innerHTML = " / " + values[4]; 
        					}
							
		
							if(agendasubidadd==0){
	    						
	    						document.getElementById('iditemsubspecair').innerHTML = "";
	        				}
    						if(agendasubidadd!=0){
    						
    						document.getElementById('iditemsubspecair').innerHTML = " / " + values[3]; 
        					}
    						
    						
    					document.getElementById('iditemspecair').innerHTML = values[1];

    					$("#remarksair").val('');
    					$("#OutComeAir").val(type);
    					$("#editorair").val('');
    					if(type=="D"){
    						document.getElementById('outcomeair').innerHTML = " / Decision";
     					}
     					else if(type=="A"){
     						document.getElementById('outcomeair').innerHTML = " / Action";
     	  		        }
     					else if(type=="R"){
     						document.getElementById('outcomeair').innerHTML = " / Recommendation";
     					}
     					else if(type=="C"){
     						document.getElementById('outcomeair').innerHTML = " / Comment";
     					}
     					else if(type=="I"){
     						document.getElementById('outcomeair').innerHTML = " / Issue";
     					}
     					else if(type=="K"){
     						document.getElementById('outcomeair').innerHTML = " / Risk";
     					}

      	  		         	 
    				}
    			});
    		   
    		  });
    	  

    }  

    function FormName(formId) {
    	  $("#"+formId).submit(function(event){
    		    event.preventDefault();
    		    $('#editing').hide();
    		    $('#adding').show();
    		    $('#specadd').show();
    		    $('#specair').hide();
    		    var minutesidadd = $("input[name='minutesid']",this).val();
    		    var specnameadd= $("input[name='specname']",this).val();
    		    var agendasubidadd= $("input[name='agendasubid']",this).val();
    		    var scheduleagendaidadd= $("input[name='scheduleagendaid']",this).val();
    		    var unit1idadd= $("input[name='unit1id']",this).val();
    		    var formnameadd= $("input[name='formname']",this).val();
    		    
    		    $("#minutesidadd").val(minutesidadd);
    		    $("#specnameadd").val(specnameadd);
    		    $("#agendasubidadd").val(agendasubidadd);
    		    $("#scheduleagendaidadd").val(scheduleagendaidadd);
    		    $("#unit1idadd").val(unit1idadd);
    		    $("#formnameadd").val(formnameadd);
    		    
    		    $.ajax({
    				type : "GET",
    				url : "CommitteeMinutesSpecAdd.htm",
    				data : {
    					
    					minutesid : minutesidadd,
    					specname:specnameadd,
    					agendasubid:agendasubidadd,
    					scheduleagendaid:scheduleagendaidadd,
    					unit1:unit1idadd,
    					formname:formnameadd,
    					
    				},
    				datatype : 'json',
    				success : function(result) {
    					
    					var result = JSON.parse(result);
    					var values = Object.keys(result).map(function(e) {
    						  return result[e]
    						});

    						if(scheduleagendaidadd==0){
    						document.getElementById('iditemsubspecofsub').innerHTML = "" ;
        					}	
    						
							if(scheduleagendaidadd!=0){
    						document.getElementById('iditemsubspecofsub').innerHTML = " / " + values[4]; 
        					}
							
		
							if(agendasubidadd==0){
	    						
	    						document.getElementById('iditemsubspec').innerHTML = "";
	        				}
    						if(agendasubidadd!=0){
    						
    						document.getElementById('iditemsubspec').innerHTML = " / " + values[3]; 
        					}
    						
    					document.getElementById('iditemspec').innerHTML = values[1];
    			
    					
    					CKEDITOR.instances['summernote'].setData();
    					$("#remarks").val('');
    					/* drcdiv */
    					
      						 $("#decision").prop("checked", false);
      	  			         $("#recommendation").prop("checked", false);
      	  		             $("#comments").prop("checked", true); 
      	  		         	 $("#drcdiv").hide();
      	  		        
      	  		         	 
      	  		         if(formId=="myForm34" || formId=="myForm35" || formId=="myForm36"){
      	  	  				CKEDITOR.instances['summernote'].setReadOnly(true);
      	   	  		        }else{
      	   	  		       CKEDITOR.instances['summernote'].setReadOnly(false);
      	   	  		        }    
				
    				}
    			});
    		   
    		  });
    	  

    }  
    
    
    function FormNameEditB(formId, AgendaSubHead) {
  	  $("#"+formId).submit(function(event){
  		    event.preventDefault();
  		  $('#addingair').hide();
  		 $('#editingair').show();
  		 $('#deletingair').show();
  		 $('#specadd').hide();
	       $('#specair').show();
	       $('#OutComeDiv').hide();
	       $('#PresDiscHeader').show();
	       
  		    var itemidadd = $("input[name='scheduleminutesid']",this).val();
  		 	var specnameadd= $("input[name='specname']",this).val();
  		 	var formnameadd= $("input[name='formname']",this).val();
  		 	var unit1idadd= $("input[name='unit1']",this).val();
		 	
  		 	
  		 	$("#specnameair").val(specnameadd);
  		 	$("#formnameair").val(formnameadd);
  		 	$("#unit1idair").val(unit1idadd);
  		 	
  		    $.ajax({
  				type : "GET",
  				url : "CommitteeMinutesSpecEdit.htm",
  				data : {
  					scheduleminutesid : itemidadd,
  					specname:specnameadd,
  					forname:formnameadd,
  					
  				},
  				datatype : 'json',
  				success : function(result) {
  					
  					var result = JSON.parse(result);
  					var values = Object.keys(result).map(function(e) {
  						  return result[e]
  						});
  					
  					$("#scheduleideditair").val(values[2]);	
   		  			$("#minutesideditair").val(values[0]);
   		  		    $("#scheduleminutesideditair").val(values[3]);
   		  		    
   		  			if(values[6]==0){
					document.getElementById('iditemsubspecofsubair').innerHTML = ""; 
					}	
					if(values[6]!=0){
					document.getElementById('iditemsubspecofsubair').innerHTML = " / " + values[8]; 
					}	
   		  		    
					if(values[5]==0){	
					document.getElementById('iditemsubspecair').innerHTML = "";
					}

					if(values[5]!=0){
					document.getElementById('iditemsubspecair').innerHTML = " / " + values[7]; 
					}

  					
  					document.getElementById('iditemspecair').innerHTML = values[4];
	
  					
  					$("#remarksair").val(values[9]);
  					$("#OutComeAir").val(values[10]);
  					$("#editorair").val(values[1]);
  					$("#PresDiscHeaderVal").val(AgendaSubHead);
  					document.getElementById('outcomeair').innerHTML = " / "+AgendaSubHead;
  	  			
  				}
  			});
  		    
  		  });
  	  

  } 
    
    function FormNameEditA(formId) {
    	  $("#"+formId).submit(function(event){
    		    event.preventDefault();
    		  $('#addingair').hide();
    		 $('#editingair').show();
    		 $('#deletingair').show();
    		 $('#specadd').hide();
  	         $('#specair').show();
  	       $('#OutComeDiv').show();
  	     $('#PresDiscHeader').hide();
    		    var itemidadd = $("input[name='scheduleminutesid']",this).val();
    		 	var specnameadd= $("input[name='specname']",this).val();
    		 	var formnameadd= $("input[name='formname']",this).val();
    		 	var unit1idadd= $("input[name='unit1']",this).val();
     		    $("#unit1idair").val(unit1idadd);
    		 	
    		 	$("#specnameair").val(specnameadd);
    		 	$("#formnameair").val(formnameadd);
    		 	$("#unit1idair").val(unit1idadd);
    		 	
    		    $.ajax({
    				type : "GET",
    				url : "CommitteeMinutesSpecEdit.htm",
    				data : {
    					scheduleminutesid : itemidadd,
    					specname:specnameadd,
    					forname:formnameadd,
    					
    				},
    				datatype : 'json',
    				success : function(result) {
    					
    					var result = JSON.parse(result);
    					var values = Object.keys(result).map(function(e) {
    						  return result[e]
    						});
    					
    					$("#scheduleideditair").val(values[2]);	
     		  			$("#minutesideditair").val(values[0]);
     		  		    $("#scheduleminutesideditair").val(values[3]);
     		  		    
     		  			if(values[6]==0){
  					document.getElementById('iditemsubspecofsubair').innerHTML = ""; 
  					}	
  					if(values[6]!=0){
  					document.getElementById('iditemsubspecofsubair').innerHTML = " / " + values[8]; 
  					}	
     		  		    
  					if(values[5]==0){	
  					document.getElementById('iditemsubspecair').innerHTML = "";
  					}

  					if(values[5]!=0){
  					document.getElementById('iditemsubspecair').innerHTML = " / " + values[7]; 
  					}
  					

    					
    					document.getElementById('iditemspecair').innerHTML = values[4];
    					

    					
    					$("#remarksair").val(values[9]);
    					$("#OutComeAir").val(values[10]);
    					$("#editorair").val(values[1]);
    					
    					
    	  			    
    					if(values[10]=="D"){
    						document.getElementById('outcomeair').innerHTML = " / Decision";
     					}
     					else if(values[10]=="A"){
     						document.getElementById('outcomeair').innerHTML = " / Action";
     	  		        }
     					else if(values[10]=="R"){
     						document.getElementById('outcomeair').innerHTML = " / Recommendation";
     					}
     					else if(values[10]=="C"){
     						document.getElementById('outcomeair').innerHTML = " / Comment";
     					}
     					else if(values[10]=="I"){
     						document.getElementById('outcomeair').innerHTML = " / Issue";
     					}
     					else if(values[10]=="K"){
     						document.getElementById('outcomeair').innerHTML = " / Risk";
     					}
    	  			
    				}
    			});
    		    
    		  });
    	  

    } 
   
    function FormNameEdit(formId) {
  	  $("#"+formId).submit(function(event){
  		    event.preventDefault();
  		  $('#adding').hide();
  		 $('#editing').show();
  		$('#specadd').show();
	    $('#specair').hide();
  		    var itemidadd = $("input[name='scheduleminutesid']",this).val();
  		 	var specnameadd= $("input[name='specname']",this).val();
  		 	var formnameadd= $("input[name='formname']",this).val();
  		 	
  		 	
  		 	$("#specnameadd").val(specnameadd);
  		 	$("#formnameadd").val(formnameadd);
  		 	
  		    $.ajax({
  				type : "GET",
  				url : "CommitteeMinutesSpecEdit.htm",
  				data : {
  					scheduleminutesid : itemidadd,
  					specname:specnameadd,
  					forname:formnameadd,
  					
  				},
  				datatype : 'json',
  				success : function(result) {
  					
  					var result = JSON.parse(result);
  					var values = Object.keys(result).map(function(e) {
  						  return result[e]
  						});
  					
  					$("#scheduleidedit").val(values[2]);	
   		  			$("#minutesidedit").val(values[0]);
   		  		    $("#scheduleminutesidedit").val(values[3]);
   		  		    
   		  			if(values[6]==0){
					document.getElementById('iditemsubspecofsub').innerHTML = ""; 
					}	
					if(values[6]!=0){
					document.getElementById('iditemsubspecofsub').innerHTML = " / " + values[8]; 
					}	
   		  		    
					if(values[5]==0){	
					document.getElementById('iditemsubspec').innerHTML = "";
					}

					if(values[5]!=0){
					document.getElementById('iditemsubspec').innerHTML = " / " + values[7]; 
					}
					

  					
  					document.getElementById('iditemspec').innerHTML = values[4];
  					
  					CKEDITOR.instances['summernote'].setData(values[1]);
  					
  					$("#remarks").val(values[9]);
  					
  					if(values[10]=="D"){
 						 $("#decision").prop("checked", true);
 					}
 					else if(values[10]=="R"){
 						$("#recommendation").prop("checked", true);
 					}
 					else if(values[10]=="C"){
 						$("#comments").prop("checked",true);
 					}
  					$("#drcdiv").hide();
  	  			    
  	  			   if(formId=="myForm34" || formId=="myForm35" || formId=="myForm36"){
  	  				CKEDITOR.instances['summernote'].setReadOnly(true);
   	  		        }else{
   	  		       CKEDITOR.instances['summernote'].setReadOnly(false);
   	  		        }
  	  			
  				}
  			});
  		    
  		  });
  	  

  } 
 
   	
  
    </script>
   
   <script>
CKEDITOR.replace( 'summernote', {
	
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 380,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );

var genid="<%=GenId%>";
 $(document).ready(function(){

 	 $("#"+genid).click();
 	 
 	 if(unitt.charAt(0)==='#')
 	 {
 	 	$(unitt).click(); 
 	 }
 	 else
 	 {
 		$('#'+unitt).click(); 	 
 	 }
 
 

 	}); 
 
    
   

</script>


<script type='text/javascript'> 
function submitForm(formname)
{ 
  document.getElementById(formname).submit(); 
} 






</script>

</body>
</html>



