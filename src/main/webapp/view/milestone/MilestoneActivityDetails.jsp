<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Milestone Activity Details</title>
<jsp:include page="../static/header.jsp"></jsp:include>
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
	margin:0px 4%;
}

		</style>
</head>
<body>


<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
Object[] getMA=(Object[])request.getAttribute("MilestoneActivity");
List<Object[]> ActivityTypeList=(List<Object[]>)request.getAttribute("ActivityTypeList");
String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
<div class="alert alert-danger" role="alert" align="center">
<%=ses1 %>
 </div></div>
<%}if(ses!=null){ %>
<div align="center">
<div class="alert alert-success" role="alert" align="center">
<%=ses %>
</div></div>
<%} %>


<div class="container-fluid">   
          
<div class="row"> 

<div class="col-md-12" >
	<div class="card" style="border-color:#00DADA  ;margin-top: -1%;margin-bottom: 50px;" >
    	<div class="card-body" style="margin-top: -8px" >
        	
  
					
         <div class="panel panel-info" style="margin-top: 0px;" >
         
      		<div class="panel-heading ">
        		<h4 class="panel-title">
          			<span  style="font-size:14px"><%=getMA[1] %> :   MIL-<%=getMA[5] %>     <i class="fa fa-calendar" aria-hidden="true" style="margin-left: 20px;"></i> <%=sdf.format(getMA[2]) %> To <%=sdf.format(getMA[3]) %></span>  
        		</h4>
         	<div   style="float: right !important; margin-top:-23px; ">
		 		
	
       	</div>
      
      
		<div   style="float: right !important; margin-top:-20px; ">  
		<a data-toggle="collapse" data-parent="#accordion" href="#collapse1" > <i class="fa fa-plus" id="Clk" onclick="faChange('#Clk')"></i></a>

   		</div>
     </div>
     <!-- panel-heading end -->
  	
	  	<div id="collapse1" class="panel-collapse collapse in">
	  	<div class="row" style="margin-bottom: 20px;">
                    		<div class="col-md-6 " >
                    		<label class="control-label"  style="margin-left: 10px;text-align: justify;">Activity: <%=getMA[4] %> </label>
                        	</div>
                        	<div class="col-md-2 ">
                        	<label class="control-label">Type:  <%=getMA[17] %></label>
                        	</div>
                        	<div class="col-md-2 ">
                        	<label class="control-label">First OIC:  <%=getMA[6] %></label>
                        	</div>
                        	<div class="col-md-2 ">
                        	<label class="control-label">Second OIC:  <%=getMA[7] %></label>
                        	
                        	</div>
             </div>    
                 
                 <%List<Object[]> MilestoneActivityA=(List<Object[]>)request.getAttribute("MilestoneActivityA");
	  	  int ProjectSubCount=1;
	  	  if(MilestoneActivityA!=null&&MilestoneActivityA.size()>0){
	  	  for(Object[] obj:MilestoneActivityA){
	  	%>
	  	<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">

									<span  style="font-size:14px">Activity A<%=ProjectSubCount %>  <i class="fa fa-calendar" aria-hidden="true" style="margin-left: 20px;"></i> <%=sdf.format(obj[2]) %> To <%=sdf.format(obj[3]) %></span>				          		
						      
					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55<%=ProjectSubCount %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %>"  onclick="faChange('#Clk<%=ProjectSubCount %>')"></i></a>
					       		    </div>
					      </div>
					  			<div id="collapse55<%=ProjectSubCount %>" class="panel-collapse collapse in">
					  			<div class="row">
                    		<div class="col-md-6 " >
                    		<label class="control-label"  style="margin-left: 25px;text-align: justify;">Activity: <%=obj[4] %> </label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">Type:  <%=obj[12] %></label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">Weightage:  <%=obj[6] %></label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">First OIC:  <%=obj[14] %></label>
                        	</div>
                                 </div>  
					  			<%int Sub1Count=1; 
					  			List<Object[]> MilestoneActivityB=(List<Object[]>)request.getAttribute("MilestoneActivityB"+ProjectSubCount);				  	 
					  			if(MilestoneActivityB!=null&&MilestoneActivityB.size()>0){
					  	  	    for(Object[] obj1:MilestoneActivityB){
					  			%>
					  			
					  			
					  			<div class="row">  
				   <div class="col-md-12"  align="left"  style="margin-left: 0px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<span  style="font-size:14px">Activity B<%=Sub1Count %>  <i class="fa fa-calendar" aria-hidden="true" style="margin-left: 20px;"></i> <%=sdf.format(obj1[2]) %> To <%=sdf.format(obj1[3]) %></span>				          		

					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=ProjectSubCount %><%=Sub1Count %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %><%=Sub1Count %>" onclick="faChange('#Clk<%=ProjectSubCount %><%=Sub1Count %>')"></i></a>
					       		    </div>
					      </div>
					  			<div id="collapse55B<%=ProjectSubCount %><%=Sub1Count %>" class="panel-collapse collapse in">
					  			<div class="row">
                    		<div class="col-md-6 " >
                    		<label class="control-label"  style="margin-left: 25px;text-align: justify;">Activity: <%=obj1[4] %> </label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">Type:  <%=obj1[12] %></label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">Weightage:  <%=obj1[6] %></label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">First OIC:  <%=obj1[14] %></label>
                        	</div>
                                 </div>
					  			<%int Sub2Count=1; 
					  			List<Object[]> MilestoneActivityC=(List<Object[]>)request.getAttribute("MilestoneActivityC"+ProjectSubCount+Sub1Count);				  	 
					  			if(MilestoneActivityC!=null&&MilestoneActivityC.size()>0){
					  	  	  for(Object[] obj2:MilestoneActivityC){
					  			%>
					  			
					  			<div class="row">  
				   <div class="col-md-12"  align="left"  style="margin-left: 0px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        <span  style="font-size:14px">Activity C<%=Sub2Count %>  <i class="fa fa-calendar" aria-hidden="true" style="margin-left: 20px;"></i> <%=sdf.format(obj2[2]) %> To <%=sdf.format(obj2[3]) %></span>				          		
					        	
					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>"  onclick="faChange('#Clk<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>')"></i></a>
					       		    </div>
					      </div>
					  			<div id="collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" class="panel-collapse collapse in">
					  			  <div class="row">
                    		<div class="col-md-6 " >
                    		<label class="control-label"  style="margin-left: 25px;text-align: justify;">Activity: <%=obj2[4] %> </label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">Type:  <%=obj2[12] %></label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">Weightage:  <%=obj2[6] %></label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">First OIC:  <%=obj2[14] %></label>
                        	</div>
                                 </div>
					  			<%int Sub3Count=1; 
					  			List<Object[]> MilestoneActivityD=(List<Object[]>)request.getAttribute("MilestoneActivityD"+ProjectSubCount+Sub1Count+Sub2Count);				  	 
					  			if(MilestoneActivityD!=null&&MilestoneActivityD.size()>0){
					  	  	  for(Object[] obj3:MilestoneActivityD){
					  			%>
					  			
					  			<div class="row">  
				   <div class="col-md-12"  align="left"  style="margin-left:0px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					         <span  style="font-size:14px">Activity D<%=Sub3Count %>  <i class="fa fa-calendar" aria-hidden="true" style="margin-left: 20px;"></i> <%=sdf.format(obj3[2]) %> To <%=sdf.format(obj3[3]) %></span>				          		
					        	
					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" onclick="faChange('#Clk<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>')"></i></a>
					       		    </div>
					      </div>
					  			<div id="collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" class="panel-collapse collapse in">
					  			
					  			<div class="row">
                    		<div class="col-md-6 " >
                    		<label class="control-label"  style="margin-left: 25px;text-align: justify;">Activity: <%=obj3[4] %> </label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">Type:  <%=obj3[12] %></label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">Weightage:  <%=obj3[6] %></label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">First OIC:  <%=obj3[14] %></label>
                        	</div>
                                 </div>
					  			<%int Sub4Count=1; 
					  			List<Object[]> MilestoneActivityE=(List<Object[]>)request.getAttribute("MilestoneActivityE"+ProjectSubCount+Sub1Count+Sub2Count+Sub3Count);				  	 
					  			if(MilestoneActivityE!=null&&MilestoneActivityE.size()>0){
					  	  	  for(Object[] obj4:MilestoneActivityE){
					  			%>
					  			
					  			<div class="row">  
				   <div class="col-md-12"  align="left"  style="margin-left: 0px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	 <span  style="font-size:14px">Activity E<%=Sub4Count %>  <i class="fa fa-calendar" aria-hidden="true" style="margin-left: 20px;"></i> <%=sdf.format(obj4[2]) %> To <%=sdf.format(obj4[3]) %></span>				          		
					        	
					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       		<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" > <i class="fa fa-plus" id="Clk<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" onclick="faChange('#Clk<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>')"></i></a>
					       		    </div>
					      </div>
					  			<div id="collapse55B<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" class="panel-collapse collapse in">
					  			<div class="row">
                    		<div class="col-md-6 " >
                    		<label class="control-label"  style="margin-left: 25px;text-align: justify;">Activity: <%=obj4[4] %> </label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">Type:  <%=obj4[12] %></label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">Weightage:  <%=obj4[6] %></label>
                        	</div>
                        	<div class="col-md-2">
                        	<label class="control-label">First OIC:  <%=obj4[14] %></label>
                        	</div>
					  			
					  				
					  	
					  			
					  			
					  			
					  			
				   
	  	</div>

</div>


	
	  			
	     </div>      
	       
   </div>
   </div>
					 <%Sub4Count++;}} %> 			
					  	 <div class="row">  
				   <div class="col-md-12"  align="left"  style="margin-left: 0px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	Activity E<%=Sub4Count %>
					        </h4>

					      </div>
					 <div>
												<form action="MilestoneActivitySubAdd.htm" method="POST"
													name="milestoneaddfrm" id="milestoneaddfrm<%=Sub1Count %>">
													<div class="row container-fluid" align="center">
														<div class="col-sm-6" align="left">
															<div class="form-group">
																<label>Activity E Name: <span class="mandatory" style="color: red;">*</span>
																</label><br> 
																<input class="form-control " type="text" name="ActivityName" id="ActivityName<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" style="width: 100%" maxlength="1000" required="required">
															</div>
														</div>


														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">Activity Type </label> 
																<select class="form-control " id="ActivityType1<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" required="required" name="ActivityType">
																	<option disabled="true" selected value="">Choose...</option>
																	<%
																	for (Object[] actobj : ActivityTypeList) {
																	%>
																	<option value="<%=actobj[0]%>"><%=actobj[1]%>
																	</option>
																	<%
																	}
																	%>
																</select>
															</div>
														</div>

														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">From <span
																	class="mandatory" style="color: red;">*</span></label> <input
																	class="form-control " name="ValidFrom"
																	 required="required"  id="DateCompletionA<%=obj[0] %><%=obj1[0] %><%=obj2[0] %><%=obj3[0] %>"
																	value="<%=sdf.format(obj3[2])%>" readonly>
															</div>
														</div>
														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">To <span
																	class="mandatory" style="color: red;">*</span></label> <input
																	class="form-control " name="ValidTo"
																	 required="required"  id="DateCompletionA2<%=obj[0] %><%=obj1[0] %><%=obj2[0] %><%=obj3[0] %>"
																	disabled="disabled" value="<%=sdf.format(obj3[3])%>"
																	readonly>
															</div>
														</div>


													</div>




													<div class="form-group" align="center">


														<input type="submit"  class="btn btn-primary btn-sm submit " id="sub" value="SUBMIT" name="sub" onclick="return confirm('Are You Sure To Submit?');">
														<button type="submit" class="btn btn-primary btn-sm edit" id="sub"	value="C" name="sub" onclick="SubmitBack('<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>')"	formaction="MilestoneActivityDetails.htm">Edit</button>
														<input type="submit" class="btn btn-primary btn-sm back " id="sub" value="Back" name="sub" onclick="SubmitBack('<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>/<%=Sub4Count %>')" formaction="MilestoneActivityList.htm">
															<input type="hidden"name="ProjectId" value="<%=getMA[10]%>" />
													</div>
													<input type="hidden" name="LevelId"	value="5" /> 
													<input type="hidden" name="formname" value="<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %><%=Sub4Count %>" />
													<input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0]%>" /> 
												    <input type="hidden" name="ActivityId"	value="<%=obj3[0]%>" /> 
													 <input type="hidden" name="OicEmpId"	value="<%=getMA[8]%>" /> 
											        <input type="hidden" name="OicEmpId1"	value="<%=getMA[9]%>" /> 	
												
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												</form>
											</div>
						<script type="text/javascript">
var from5 ="<%=sdf.format(obj3[2])%>".split("-")
var dt55 = new Date(from5[2], from5[1] - 1, from5[0])
var to5 ="<%=sdf.format(obj3[3])%>".split("-")
var dt5 = new Date(to5[2], to5[1] - 1, to5[0])
$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %><%=obj3[0] %>').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :dt55,
	"maxDate" : dt5,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

var mindate5=dt55;
$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %><%=obj3[0] %>').on('change', function() {
    mindate5=$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %><%=obj3[0] %>').val();
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %><%=obj3[0] %>').prop("disabled",false);
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %><%=obj3[0] %>').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate5,
    	"maxDate" : dt5,
    	"cancelClass" : "btn-default",
    	showDropdowns : true,
    	locale : {
    		format : 'DD-MM-YYYY'
    	}
    	});
  });
  
  
  
  

$( document ).ready(function() {
    mindate5=$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %><%=obj3[0] %>').val();
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %><%=obj3[0] %>').prop("disabled",false);
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %><%=obj3[0] %>').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate5,
    	"maxDate" : dt5,
    	"cancelClass" : "btn-default",
    	showDropdowns : true,
    	locale : {
    		format : 'DD-MM-YYYY'
    	}
    	});
  });

	    
	</script> 	
					 <!-- end four --> 
					  </div>
					 
				  </div>
	  			</div>     
	  	</div>

</div>


	
	  			
	     </div>      
	       
   </div>
					 <%Sub3Count++;}} %> 			
					  	 <div class="row">  
				   <div class="col-md-12"  align="left"  style="margin-left: 0px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	Activity D<%=Sub3Count %>
					        </h4>

					      </div>
					 <div>
												<form action="MilestoneActivitySubAdd.htm" method="POST"
													name="milestoneaddfrm" id="milestoneaddfrm<%=Sub1Count %>">
													<div class="row container-fluid" align="center">
														<div class="col-sm-6" align="left">
															<div class="form-group">
																<label>Activity D Name: <span class="mandatory" style="color: red;">*</span>
																</label><br> 
																<input class="form-control " type="text" name="ActivityName" id="ActivityName<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" style="width: 100%" maxlength="1000" required="required">
															</div>
														</div>


														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">Activity Type </label> 
																<select class="form-control" id="ActivityType1<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>" required="required" name="ActivityType">
																	<option disabled="true" selected value="">Choose...</option>
																	<%
																	for (Object[] actobj : ActivityTypeList) {
																	%>
																	<option value="<%=actobj[0]%>"><%=actobj[1]%>
																	</option>
																	<%
																	}
																	%>
																</select>
															</div>
														</div>

														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">From <span
																	class="mandatory" style="color: red;">*</span></label> <input
																	class="form-control " name="ValidFrom"
																	 required="required"  id="DateCompletionA<%=obj[0] %><%=obj1[0] %><%=obj2[0] %>"
																	value="<%=sdf.format(obj2[2])%>" readonly>
															</div>
														</div>
														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">To <span
																	class="mandatory" style="color: red;">*</span></label> <input
																	class="form-control " name="ValidTo"
																	 required="required"  id="DateCompletionA2<%=obj[0] %><%=obj1[0] %><%=obj2[0] %>"
																	disabled="disabled" value="<%=sdf.format(obj2[3])%>"
																	readonly>
															</div>
														</div>


													</div>




													<div class="form-group" align="center">


														<input type="submit"  class="btn btn-primary btn-sm submit " id="sub" value="SUBMIT" name="sub" onclick="return confirm('Are You Sure To Submit?');">
														<button type="submit" class="btn btn-primary btn-sm edit " id="sub"	value="C" name="sub" onclick="SubmitBack('<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>')"	formaction="MilestoneActivityDetails.htm">Edit</button>
														<input type="submit" class="btn btn-primary btn-sm back " id="sub" value="Back" name="sub" onclick="SubmitBack('<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %><%=Sub3Count %>')" formaction="MilestoneActivityList.htm">
															<input type="hidden"name="ProjectId" value="<%=getMA[10]%>" />
													</div>
													<input type="hidden" name="LevelId"	value="4" /> 
													<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>/<%=Sub3Count %>" />
													<input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0]%>" /> 
												    <input type="hidden" name="ActivityId"	value="<%=obj2[0]%>" /> 
													 <input type="hidden" name="OicEmpId"	value="<%=getMA[8]%>" /> 
											        <input type="hidden" name="OicEmpId1"	value="<%=getMA[9]%>" /> 	
												
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												</form>
											</div>
						<script type="text/javascript">
var from4 ="<%=sdf.format(obj2[2])%>".split("-")
var dt44= new Date(from4[2], from4[1] - 1, from4[0])
var to4 ="<%=sdf.format(obj2[3])%>".split("-")
var dt4 = new Date(to4[2], to4[1] - 1, to4[0])
$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %>').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :dt44,
	"maxDate" : dt4,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

var mindate4=dt44;
$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %>').on('change', function() {
    mindate4=$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %>').val();
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %>').prop("disabled",false);
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %>').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate4,
    	"maxDate" : dt4,
    	"cancelClass" : "btn-default",
    	showDropdowns : true,
    	locale : {
    		format : 'DD-MM-YYYY'
    	} 
    	});
  });
  
  
  
  

$( document ).ready(function() {
    mindate4=$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %>').val();
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %>').prop("disabled",false);
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %><%=obj2[0] %>').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate4,
    	"maxDate" : dt4,
    	"cancelClass" : "btn-default",
    	showDropdowns : true,
    	locale : {
    		format : 'DD-MM-YYYY'
    	}
    	});
  });

	    
	</script> 	
					 <!-- end three --> 			
					  			
					   </div>
					 
				  </div>
	  			</div>     
	  	</div>

</div>


	
	  			
	     </div>      
	       
   </div>
					 <%Sub2Count++;}} %> 			
					  	 <div class="row">  
				   <div class="col-md-12"  align="left"  style="margin-left:0px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	Activity C<%=Sub2Count %>
					        </h4>

					      </div>
					 <div>
												<form action="MilestoneActivitySubAdd.htm" method="POST"
													name="milestoneaddfrm" id="milestoneaddfrm<%=Sub1Count %>">
													<div class="row container-fluid" align="center">
														<div class="col-sm-6" align="left">
															<div class="form-group">
																<label>Activity C Name: <span class="mandatory" style="color: red;">*</span>
																</label><br> 
																<input class="form-control " type="text" name="ActivityName" id="ActivityName<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" style="width: 100%" maxlength="1000" required="required">
															</div>
														</div>


														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">Activity Type </label> 
																<select class="form-control " id="ActivityType1<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>" required="required" name="ActivityType">
																	<option disabled="true" selected value="">Choose...</option>
																	<%
																	for (Object[] actobj : ActivityTypeList) {
																	%>
																	<option value="<%=actobj[0]%>"><%=actobj[1]%>
																	</option>
																	<%
																	}
																	%>
																</select>
															</div>
														</div>

														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">From <span
																	class="mandatory" style="color: red;">*</span></label> <input
																	class="form-control " name="ValidFrom"
																	 required="required"  id="DateCompletionA<%=obj[0] %><%=obj1[0] %>"
																	value="<%=sdf.format(obj1[2])%>" readonly>
															</div>
														</div>
														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">To <span
																	class="mandatory" style="color: red;">*</span></label> <input
																	class="form-control " name="ValidTo"
																	 required="required"  id="DateCompletionA2<%=obj[0] %><%=obj1[0] %>"
																	disabled="disabled" value="<%=sdf.format(obj1[3])%>"
																	readonly>
															</div>
														</div>


													</div>




													<div class="form-group" align="center">


														<input type="submit"  class="btn btn-primary btn-sm submit " id="sub" value="SUBMIT" name="sub" onclick="return confirm('Are You Sure To Submit?');">
														<button type="submit" class="btn btn-primary btn-sm edit" id="sub"	value="C" name="sub" onclick="SubmitBack('<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>')"	formaction="MilestoneActivityDetails.htm">Edit</button>
														<input type="submit" class="btn btn-primary btn-sm back " id="sub" value="Back" name="sub" onclick="SubmitBack('<%=ProjectSubCount %><%=Sub1Count %><%=Sub2Count %>')" formaction="MilestoneActivityList.htm">
															<input type="hidden"name="ProjectId" value="<%=getMA[10]%>" />
													</div>
													<input type="hidden" name="LevelId"	value="3" /> 
													<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>/<%=Sub2Count %>" />
													<input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0]%>" /> 
												    <input type="hidden" name="ActivityId"	value="<%=obj1[0]%>" /> 
													 <input type="hidden" name="OicEmpId"	value="<%=getMA[8]%>" /> 
											        <input type="hidden" name="OicEmpId1"	value="<%=getMA[9]%>" /> 	
												
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												</form>
											</div>
						<script type="text/javascript">
var from3 ="<%=sdf.format(obj1[2])%>".split("-")
var dt33 = new Date(from3[2], from3[1] - 1, from3[0])
var to3 ="<%=sdf.format(obj1[3])%>".split("-")
var dt3 = new Date(to3[2], to3[1] - 1, to3[0])
$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %>').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :dt33,
	"maxDate" : dt3,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

var mindate3=dt33;
$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %>').on('change', function() {
    mindate=$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %>').val();
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %>').prop("disabled",false);
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %>').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate3,
    	"maxDate" : dt3,
    	"cancelClass" : "btn-default",
    	showDropdowns : true,
    	locale : {
    		format : 'DD-MM-YYYY'
    	}
    	});
  });
  
  
  
  

$( document ).ready(function() {
    mindate3=$('#DateCompletionA'+'<%=obj[0] %><%=obj1[0] %>').val();
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %>').prop("disabled",false);
    $('#DateCompletionA2'+'<%=obj[0] %><%=obj1[0] %>').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate3,
    	"maxDate" : dt3,
    	"cancelClass" : "btn-default",
    	showDropdowns : true,
    	locale : {
    		format : 'DD-MM-YYYY'
    	}
    	});
  });

	    
	</script> 	
					<!-- end two	 -->		
		 </div>
					 
				  </div>
	  			</div>     
	  	</div>

</div>


	
	  			
	     </div>      
	       
   </div>
					 <%Sub1Count++;}} %> 			
					  	 <div class="row">  
				   <div class="col-md-12"  align="left"  style="margin-left: 0px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	Activity B<%=Sub1Count %>
					        </h4>

					      </div>
					 <div>
												<form action="MilestoneActivitySubAdd.htm" method="POST"
													name="milestoneaddfrm" id="milestoneaddfrm<%=Sub1Count %>">
													<div class="row container-fluid" align="center">
														<div class="col-sm-6" align="left">
															<div class="form-group">
																<label>Activity B Name: <span class="mandatory" style="color: red;">*</span>
																</label><br> 
																<input class="form-control " type="text" name="ActivityName" id="ActivityName<%=ProjectSubCount %><%=Sub1Count %>" style="width: 100%" maxlength="1000" required="required">
															</div>
														</div>


														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">Activity Type </label> 
																<select class="form-control " id="ActivityType1<%=ProjectSubCount %><%=Sub1Count %>" required="required" name="ActivityType">
																	<option disabled="true" selected value="">Choose...</option>
																	<%
																	for (Object[] actobj : ActivityTypeList) {
																	%>
																	<option value="<%=actobj[0]%>"><%=actobj[1]%>
																	</option>
																	<%
																	}
																	%>
																</select>
															</div>
														</div>

														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">From <span
																	class="mandatory" style="color: red;">*</span></label> <input
																	class="form-control " name="ValidFrom"
																	 required="required"  id="DateCompletionA<%=obj[0] %>"
																	value="<%=sdf.format(obj[2])%>" readonly>
															</div>
														</div>
														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">To <span
																	class="mandatory" style="color: red;">*</span></label> <input
																	class="form-control " name="ValidTo"
																	 required="required"  id="DateCompletionA2<%=obj[0] %>"
																	disabled="disabled" value="<%=sdf.format(obj[3])%>"
																	readonly>
															</div>
														</div>


													</div>




													<div class="form-group" align="center">


														<input type="submit"  class="btn btn-primary btn-sm submit " id="sub" value="SUBMIT" name="sub" onclick="return confirm('Are You Sure To Submit?');">
														<button type="submit" class="btn btn-primary btn-sm edit" id="sub"	value="C" name="sub" onclick="SubmitBack('<%=ProjectSubCount %><%=Sub1Count %>')"	formaction="MilestoneActivityDetails.htm">Edit</button>
														<input type="submit" class="btn btn-primary btn-sm back " id="sub" value="Back" name="sub" onclick="SubmitBack('<%=ProjectSubCount %><%=Sub1Count %>')" formaction="MilestoneActivityList.htm">
															<input type="hidden"name="ProjectId" value="<%=getMA[10]%>" />
													</div>
													<input type="hidden" name="LevelId"	value="2" /> 
													<input type="hidden" name="formname" value="<%=ProjectSubCount %>/<%=Sub1Count %>" />
													<input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0]%>" /> 
												    <input type="hidden" name="ActivityId"	value="<%=obj[0]%>" /> 
													 <input type="hidden" name="OicEmpId"	value="<%=getMA[8]%>" /> 
											        <input type="hidden" name="OicEmpId1"	value="<%=getMA[9]%>" /> 	
												
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												</form>
											</div>
						<script type="text/javascript">
var from2 ="<%=sdf.format(getMA[2])%>".split("-")
var dt22 = new Date(from2[2], from2[1] - 1, from2[0])
var to2 ="<%=sdf.format(getMA[3])%>".split("-")
var dt2 = new Date(to2[2], to2[1] - 1, to2[0])
$('#DateCompletionA'+'<%=obj[0] %>').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :dt22,
	"maxDate" : dt2,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

var mindate2=dt22;
$('#DateCompletionA'+'<%=obj[0] %>').on('change', function() {
    mindate2=$('#DateCompletionA'+'<%=obj[0] %>').val();
    $('#DateCompletionA2'+'<%=obj[0] %>').prop("disabled",false);
    $('#DateCompletionA2'+'<%=obj[0] %>').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate2,
    	"maxDate" : dt2,
    	"cancelClass" : "btn-default",
    	showDropdowns : true,
    	locale : {
    		format : 'DD-MM-YYYY'
    	}
    	});
  });
  
  
  
  

$( document ).ready(function() {
    mindate2=$('#DateCompletionA'+'<%=obj[0] %>').val();
    $('#DateCompletionA2'+'<%=obj[0] %>').prop("disabled",false);
    $('#DateCompletionA2'+'<%=obj[0] %>').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate2,
    	"maxDate" : dt2,
    	"cancelClass" : "btn-default",
    	showDropdowns : true,
    	locale : {
    		format : 'DD-MM-YYYY'
    	}
    	});
  });

	    
	</script> 							
											
					 </div>
					 
				  </div>
	  			</div>     
	  	</div>

</div>


	
	  			
	     </div>      
	       
   </div>
	  	
	  	<%ProjectSubCount++;}} %>
	  	
   <!-- panel end -->  
	  	
	  	
  <div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;margin-bottom: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	Activity A<%=ProjectSubCount %>
					        </h4>

					      </div>
					 <div>
												<form action="MilestoneActivitySubAdd.htm" method="POST"
													name="milestoneaddfrm" id="milestoneaddfrm">
													<div class="row container-fluid" align="center">
														<div class="col-sm-6" align="left">
															<div class="form-group">
																<label>Activity A Name: <span class="mandatory" style="color: red;">*</span>
																</label><br> 
																<input class="form-control " type="text" name="ActivityName" id="ActivityName<%=ProjectSubCount %>" style="width: 100%" maxlength="1000" required="required">
															</div>
														</div>

														<%--  <div class="col-md-2" align="left" >
                        		<div class="form-group">
                            		<label class="control-label">Weightage <span class="mandatory" style="color: red;" >*</span></label>
    					            <input type="number" class="form-control " name="Weightage" id="Weightage" required="required" min="0" max=<%=100 %>  >
                        		</div>
                    		</div> --%>

														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">Activity Type </label> 
																<select class="form-control " id="ActivityType1<%=ProjectSubCount %>" required="required" name="ActivityType">
																	<option disabled="true" selected value="">Choose...</option>
																	<%
																	for (Object[] obj : ActivityTypeList) {
																	%>
																	<option value="<%=obj[0]%>"><%=obj[1]%>
																	</option>
																	<%
																	}
																	%>
																</select>
															</div>
														</div>

														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">From <span
																	class="mandatory" style="color: red;">*</span></label> <input
																	class="form-control " name="ValidFrom"
																	id="DateCompletion" required="required"
																	value="<%=sdf.format(getMA[2])%>" readonly>
															</div>
														</div>
														<div class="col-md-2" align="left">
															<div class="form-group">
																<label class="control-label">To <span
																	class="mandatory" style="color: red;">*</span></label> <input
																	class="form-control " name="ValidTo"
																	id="DateCompletion2" required="required"
																	disabled="disabled" value="<%=sdf.format(getMA[3])%>"
																	readonly>
															</div>
														</div>


													</div>




													<div class="form-group" align="center">


														<input type="submit"
															class="btn btn-primary btn-sm submit " id="sub"
															value="SUBMIT" name="sub"
															onclick="return confirm('Are You Sure To Submit?');">
														<button type="submit"
															class="btn btn-primary btn-sm edit " id="sub"
															value="C" name="sub" onclick="SubmitBack('<%=ProjectSubCount %>')"
															formaction="MilestoneActivityDetails.htm">
															Edit</button>
														<input type="submit" class="btn btn-primary btn-sm back "
															id="sub" value="Back" name="sub" onclick="SubmitBack('<%=ProjectSubCount %>')"
															formaction="MilestoneActivityList.htm"> 
															 <input type="hidden"
															name="ProjectId" value="<%=getMA[10]%>" />
													</div>
													<input type="hidden" name="LevelId"	value="1" /> 
													<input type="hidden" name="formname" value="<%=ProjectSubCount %>" />
													<input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0]%>" /> 
													<input type="hidden" name="ActivityId"	value="<%=getMA[0]%>" /> 
												    <input type="hidden" name="OicEmpId"	value="<%=getMA[8]%>" /> 
											        <input type="hidden" name="OicEmpId1"	value="<%=getMA[9]%>" /> 	
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												</form>
											</div>
					 </div>
					 
				  </div>
	  			</div>                  		
  			

 
          
   

   

		</div><!-- Big card-body end -->
	
	</div><!-- Card End  -->
	
</div>	
</div>
</div>
</div>
</div>					
<script type="text/javascript">

var from ="<%=sdf.format(getMA[2])%>".split("-")
var dt = new Date(from[2], from[1] - 1, from[0])
var to ="<%=sdf.format(getMA[3])%>".split("-")
var dt1 = new Date(to[2], to[1] - 1, to[0])
var mindate=dt;
$('#DateCompletion').on('change', function() {
    mindate=$('#DateCompletion').val();
    $('#DateCompletion2').prop("disabled",false);
    $('#DateCompletion2').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate,
    	"maxDate" : dt1,
    	"cancelClass" : "btn-default",
    	showDropdowns : true,
    	locale : {
    		format : 'DD-MM-YYYY'
    	}
    	});
  });
$('#DateCompletion').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :dt,
	"maxDate" : dt1,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$( document ).ready(function() {
    mindate=$('#DateCompletion').val();
    $('#DateCompletion2').prop("disabled",false);
    $('#DateCompletion2').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate,
    	"maxDate" : dt1,
    	"cancelClass" : "btn-default",
    	showDropdowns : true,
    	locale : {
    		format : 'DD-MM-YYYY'
    	}
    	});
  });


function SubmitBack(idd){
	$('#ActivityType1'+idd).prop("required",false);
	$('#ActivityName'+idd).prop("required",false);
	
}
</script>

<script>
	
	
	function faChange(id){
		if($(id).hasClass('fa-minus')){
			$(id).removeClass("fa-minus").addClass("fa-plus");
		}else{
			$(id).removeClass("fa-plus").addClass("fa-minus");
		}
	}

$('#Clk').click();
<%String FormName=(String)request.getAttribute("FromName");
if(FormName!=null){
	String [] id=FormName.split("/");
	String IdName="Clk";
	for(int i=0;i<id.length;i++){
		IdName=IdName.concat(id[i]);
%>
      $('#<%=IdName%>').click();
<%}}%>
</script>  



</body>
</html>