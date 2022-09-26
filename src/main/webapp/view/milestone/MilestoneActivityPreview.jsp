<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Milestone Activity Preview</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
overflow-x: hidden; 
}
</style>

</head>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
Object[] getMA=(Object[])request.getAttribute("MilestoneActivity");
int RevisionCount=(Integer) request.getAttribute("RevisionCount");
List<Object[]> ActivityTypeList=(List<Object[]>)request.getAttribute("ActivityTypeList");
List<Object[]> MilestoneActivityA=(List<Object[]>)request.getAttribute("MilestoneActivityA");
	%>
<script type="text/javascript">
function changeempoic1(id,id3)
{
	var it='allempcheckbox1'+id3;
	var it2='EmpId'+id3;
  if (document.getElementById(it).checked) 
  {
    employeefetch(0,it2,id);
  } else {
	  employeefetch(<%=getMA[10] %>,it2,id);
  }
}


function changeempoic2(id1,id2)
{
	var it1='allempcheckbox2'+id2;
	var it12='EmpId1'+id2;
  if (document.getElementById(it1).checked) 
  {
    employeefetch(0,it12,id1);
  } else {
	  employeefetch(<%=getMA[10] %>,it12,id1);
  }
}	    
	  
function employeefetch(ProID,dropdownid,empid){
	
	
	$.ajax({		
		type : "GET",
		url : "ProjectEmpListEdit.htm",
		data : {
			projectid : ProID,
			EmpId:empid
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
						+values[i][1] + " (" +values[i][2]+")" 
						+ '</option>';
			} 
			 
			$('#'+dropdownid).html(s);
			$("#"+dropdownid).val(empid).change();
		}
	});


}  
</script>	
<body>
  <nav class="navbar navbar-light bg-light" style="margin-top: -1%;">
  <a class="navbar-brand"></a>
  <form class="form-inline"  method="POST" action="MilestoneActivityList.htm">
   <%if(getMA[13]!=null){ %>
    <input type="submit" class="btn btn-primary btn-sm submit "  value="Set Base Line ( <%=RevisionCount %> )" onclick="return confirm('Are You Sure To Submit ?')" formaction="M-A-Set-BaseLine.htm" > 
  
  <%} %>
  <%if(RevisionCount>0){ %>
  <input type="submit" class="btn btn-primary btn-sm preview "  value="Compare" style="margin-left: 10px;" formaction="MilestoneActivityCompare.htm"> 		
  <%} %>
  <input type="submit" class="btn btn-primary btn-sm back "  value="Back" style="margin-left: 10px;"> 	
		
      <input type="hidden" name="RevId"	value="<%=RevisionCount %>" /> 
      <input type="hidden" name="ProjectId"	value="<%=getMA[10] %>" /> 
      <input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0] %>" /> 

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
<div  class="panel-group" style="  "><h5 class="text-white" style="font-weight: bold;font-size: large;background-color: #055C9D; text-align: center;"><%=getMA[1] %> Milestone Activity Details</h5>  
<form   method="POST" action="MilestoneActivityEditSubmit.htm" id="form<%=getMA[0] %>M<%=getMA[10] %>">
<div class="row container-fluid" >
                             <div class="col-md-1 " ><br><label class="control-label">Type</label>  <br>  <b >Main</b>                    		
                        	</div>
                    		<div class="col-md-5 " ><br>
                    		<label class="control-label"> Activity Name:</label> <br> 
                    		 <textarea rows="1" cols="50" class="form-control "  <%if(RevisionCount>0){ %> readonly="readonly" <%} %> name="ActivityName" id="ActivityName"   style="width:100%;text-align: justify; " maxlength="1000" required="required"><%=getMA[4] %></textarea> 
                        	</div>
                        	
                        	<div class="col-md-2 " align="center"><br>
                        	<label class="control-label">From Date:</label><br>
                        	<input class="form-control " name="ValidFrom" id="DateCompletion"  value="<%=sdf.format(getMA[2]) %>"  required="required"  style="width:120px;" >
                        	
                        	</div>
                        	<div class="col-md-2 " align="center"><br>
                        		<label class="control-label">To Date:</label><br>
                        	<input class="form-control form-control" name="ValidTo" id="DateCompletion2"  value="<%=sdf.format(getMA[3]) %>"  required="required" style="width:120px;" >
                        		</div>
                        		<div class="col-md-1 " align="center" ><br>
                    		<label class="control-label">Weightage <br> </label>
                    		<input type="number" class="form-control " name="Weightage" id="Weightage<%=getMA[0] %>M<%=getMA[10] %>" required="required" min="1" max="100" value="<%=getMA[16] %>"  style="width:95px;">

                    		 
                        	</div>
                        	<div class="col-md-1 " ><br><label class="control-label"> &nbsp;&nbsp;Update<br></label><br>
                        	  <button type="button"  class="btn btn-sm edit" onclick="weightage_sum('<%=getMA[0] %>','<%=getMA[10] %>','M');"> <i class="fa fa-edit" aria-hidden="true"></i> </button>
                        	 <input type="submit" hidden="hidden" id="<%=getMA[0] %>M<%=getMA[10] %>sub"/> 
                        	  
	                              <input type="hidden" name="RevId"	value="<%=RevisionCount %>" /> 
	                              <input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0] %>" /> 
	                              <input type="hidden" name="ActivityId"	value="<%=getMA[0] %>" /> 
	                              <input type="hidden" name="ActivityType"	value="M" /> 
	                              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
                             
                        	</div>
                       		</div>
                       		<%if(RevisionCount==0) {%>
                       		<div class="row container-fluid" >
                             <div class="col-md-1 " >                    		
                        	</div>
                    		<div class="col-md-3 " ><br>
                    		<label class="control-label">Activity Type  </label>
                              		<select class="form-control selectdee" id="ActivityTypeId" required="required" name="ActivityTypeId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ActivityTypeList) {%>
										<option value="<%=obj[0]%>" <%if(getMA[15].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <% }%>><%=obj[1]%> </option>
											<%} %>
  									</select>
                    	      	</div>
                        	
                        	<div class="col-md-3 " align="center"><br>
                        	<label class="control-label">First Oic  </label>
                        	<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox1M" onchange="changeempoic1('<%=getMA[8]%>','M')" >
									</div>
                              		<select class="form-control selectdee" id="EmpIdM" required="required" name="EmpId">
    									
											
  									</select>
                        	</div>
                        	<div class="col-md-3 " align="center"><br>
                        		<label class="control-label">Second Oic </label>
                        		<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox2M" onchange="changeempoic2('<%=getMA[9]%>','M')" >
									</div>
                              		<select class="form-control selectdee" id="EmpId1M" required="required" name="EmpId1">
    									
  									</select>
  										</div>
                        
                       		</div>
                       		
                       		
                       		
                       		
<script type="text/javascript">

changeempoic1(<%=getMA[8] %>,'M');
changeempoic2(<%=getMA[9] %>,'M');



		
</script>
   
   
                       		<%} %>
                       		 </form>
                       		 <script type="text/javascript">




	

		
</script>
                  	
</div>

</div>
<div class="col-md-12">
<%


if(MilestoneActivityA!=null&&MilestoneActivityA.size()>0){
	int countA=1;
	for(Object[] ActivityA:MilestoneActivityA){
		List<Object[]> MilestoneActivityB=(List<Object[]>)request.getAttribute("MilestoneActivityB"+countA);
%>


	
		


					                        	 <form   method="POST" action="MilestoneActivityEditSubmit.htm" id="form<%=getMA[0] %>A<%=ActivityA[0] %>">
					
						<div class="row container-fluid" >
						    <div class="col-md-1 " ><label class="control-label" style="margin-left: 8px;"></label><br> <b style="margin-left: 8px;">A-<%=countA %></b><br>
                    		
                        	</div>
						  <div class="col-md-5 " ><br>
                    		 <textarea rows="1" cols="50" class="form-control " <%if(RevisionCount>0){ %> readonly="readonly" <%} %> name="ActivityName" id="ActivityName"   style="width:100%;text-align: justify; " maxlength="1000" required="required"><%=ActivityA[4] %></textarea> 
                        	</div>
                        	
                        	<div class="col-md-2 " align="center"><br>
                        	<input class="form-control " name="ValidFrom" id="DateCompletionA<%=ActivityA[0] %>"  value="<%=sdf.format(ActivityA[2]) %>"  required="required" style="width:120px;;" >
                        	
                        	</div>
                        	<div class="col-md-2 " align="center"><br>
                        	<input class="form-control " name="ValidTo" id="DateCompletionA2<%=ActivityA[0] %>"  value="<%=sdf.format(ActivityA[3]) %>"  required="required"  style="width:120px;;" >
                        		</div>
                        		<div class="col-md-1 " align="center" ><br>      


                    		<input type="number" class="form-control "  name="Weightage" id="Weightage<%=getMA[0] %>A<%=ActivityA[0] %>" required="required" min="0" max="100" value="<%=ActivityA[6] %>" style="width:95px;" >
                    	
                    		
                    		 
                        	</div>
                            <div class="col-md-1 "><br>
                        	  <button type="button"  class="btn btn-sm edit" onclick="weightage_sum('<%=getMA[0] %>','<%=ActivityA[0] %>','A','1');"> <i class="fa fa-edit" aria-hidden="true"></i> </button>
                        	 
                        	  <input type="submit" hidden="hidden" id="<%=getMA[0] %>A<%=ActivityA[0] %>sub"/> 
                              <input type="hidden" name="RevId"	value="<%=RevisionCount %>" /> 
                              <input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0] %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=ActivityA[0] %>" /> 
                              <input type="hidden" name="ActivityType"	value="A" /> 
                              <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                              
                        
                        	</div>
                        	</div>
                        	<%if(RevisionCount==0) {%>
                       		<div class="row container-fluid" >
                             <div class="col-md-1 " >                    		
                        	</div>
                    		<div class="col-md-3 " ><br>
                    		<label class="control-label">Activity Type  </label>
                              		<select class="form-control selectdee" id="ActivityTypeId" required="required" name="ActivityTypeId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ActivityTypeList) {%>
										<option value="<%=obj[0]%>" <%if(ActivityA[11].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <% }%>><%=obj[1]%> </option>
											<%} %>
  									</select>
                    	      	</div>
                        	
                        	<div class="col-md-3 " align="center"><br>
                        	<label class="control-label">First Oic  </label>
                        	<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox1<%=ActivityA[0] %>" onchange="changeempoic1('<%=ActivityA[13]%>','<%=ActivityA[0] %>')" >
									</div>
                              		<select class="form-control selectdee" id="EmpId<%=ActivityA[0] %>" required="required" name="EmpId">
    									
											
  									</select>
                        	</div>
                        	<div class="col-md-3 " align="center"><br>
                        		<label class="control-label">Second Oic </label>
                        		<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox2<%=ActivityA[0] %>" onchange="changeempoic2('<%=ActivityA[15]%>','<%=ActivityA[0] %>')" >
									</div>
                              		<select class="form-control selectdee" id="EmpId1<%=ActivityA[0] %>" required="required" name="EmpId1">
    									
  									</select>
  										</div>
  										
  							</div>			
  <script type="text/javascript">

changeempoic1(<%=ActivityA[13] %>,<%=ActivityA[0] %>);
changeempoic2(<%=ActivityA[15] %>,<%=ActivityA[0] %>);


</script>

  										
  										
                        
                       		
                       		<%} %>
                        	
                      </form>
							<script type="text/javascript">
var from ="<%=sdf.format(getMA[2])%>".split("-")
var dt = new Date(from[2], from[1] - 1, from[0])
var to ="<%=sdf.format(getMA[3])%>".split("-")
var dt1 = new Date(to[2], to[1] - 1, to[0])
$('#DateCompletionA'+'<%=ActivityA[0] %>').daterangepicker({
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

var mindate=dt;
$('#DateCompletionA'+'<%=ActivityA[0] %>').on('change', function() {
    mindate=$('#DateCompletionA'+'<%=ActivityA[0] %>').val();
    $('#DateCompletionA2'+'<%=ActivityA[0] %>').prop("disabled",false);
    $('#DateCompletionA2'+'<%=ActivityA[0] %>').daterangepicker({
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
  
  
  
  

$( document ).ready(function() {
    mindate=$('#DateCompletionA'+'<%=ActivityA[0] %>').val();
    $('#DateCompletionA2'+'<%=ActivityA[0] %>').prop("disabled",false);
    $('#DateCompletionA2'+'<%=ActivityA[0] %>').daterangepicker({
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

	    
	</script>	                   
								
							<%


if(MilestoneActivityB!=null&&MilestoneActivityB.size()>0){
	int countB=1;
	for(Object[] ActivityB:MilestoneActivityB){
		List<Object[]> MilestoneActivityC=(List<Object[]>)request.getAttribute("MilestoneActivityC"+countA+countB);	
%>


	                              <form   method="POST" action="MilestoneActivityEditSubmit.htm" id="form<%=ActivityA[0] %>B<%=ActivityB[0] %>">
		
						    <div class="row container-fluid" >
						     <div class="col-md-1 " ><br> <label class="control-label"></label><b style="margin-left: 16px;">B-<%=countB %></b>
                    		
                        	</div>
						    <div class="col-md-5 " ><br>
                    		 <textarea rows="1" cols="50" class="form-control " <%if(RevisionCount>0){ %> readonly="readonly" <%} %> name="ActivityName" id="ActivityName"   style="width:100%;text-align: justify; " maxlength="1000" required="required"><%=ActivityB[4] %></textarea> 
                        	</div>
                        	
                        	<div class="col-md-2 " align="center"><br>
                        	<input class="form-control " name="ValidFrom" id="DateCompletionB<%=ActivityA[0] %><%=ActivityB[0] %>"  value="<%=sdf.format(ActivityB[2]) %>"  required="required"  style="width:120px;;" >
                        	
                        	</div>
                        	<div class="col-md-2 " align="center"><br>
                        	<input class="form-control " name="ValidTo" id="DateCompletionB2<%=ActivityA[0] %><%=ActivityB[0] %>"  value="<%=sdf.format(ActivityB[3]) %>"  required="required"  style="width:120px;;" >
                        		</div>
                            <div class="col-md-1 " align="center" ><br>      
                    				

                    		<input type="number" class="form-control "  name="Weightage" id="Weightage<%=ActivityA[0] %>B<%=ActivityB[0] %>" required="required" min="0" max="100" value="<%=ActivityB[6] %>"  style="width:95px;" >
                    	
                    		
                    		 
                        	</div>
                        	<div class="col-md-1 "><br>
                        	  <button type="button"  class="btn btn-sm edit" onclick="weightage_sum('<%=ActivityA[0] %>','<%=ActivityB[0] %>','B','2');"> <i class="fa fa-edit" aria-hidden="true"></i> </button>
                        	 
                        	  <input type="submit" hidden="hidden" id="<%=ActivityA[0] %>B<%=ActivityB[0] %>sub"/> 
                              <input type="hidden" name="RevId"	value="<%=RevisionCount %>" /> 
                              <input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0] %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=ActivityB[0] %>" /> 
                              <input type="hidden" name="ActivityType"	value="B" /> 
                              <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                                                  	</div>
							</div>	
							<%if(RevisionCount==0) {%>
                       		<div class="row container-fluid" >
                             <div class="col-md-1 " >                    		
                        	</div>
                    		<div class="col-md-3 " ><br>
                    		<label class="control-label">Activity Type  </label>
                              		<select class="form-control selectdee" id="ActivityTypeId" required="required" name="ActivityTypeId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ActivityTypeList) {%>
										<option value="<%=obj[0]%>" <%if(ActivityB[11].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <% }%>><%=obj[1]%> </option>
											<%} %>
  									</select>
                    	      	</div>
                        	
                       <div class="col-md-3 " align="center"><br>
                        	<label class="control-label">First Oic  </label>
                        	<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox1<%=ActivityA[0] %><%=ActivityB[0] %>" onchange="changeempoic1('<%=ActivityB[13]%>','<%=ActivityA[0] %><%=ActivityB[0] %>')" >
									</div>
                              		<select class="form-control selectdee" id="EmpId<%=ActivityA[0] %><%=ActivityB[0] %>" required="required" name="EmpId">
    									
											
  									</select>
                        	</div>
                        	<div class="col-md-3 " align="center"><br>
                        		<label class="control-label">Second Oic </label>
                        		<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox2<%=ActivityA[0] %><%=ActivityB[0] %>" onchange="changeempoic2('<%=ActivityB[15]%>','<%=ActivityA[0] %><%=ActivityB[0] %>')" >
									</div>
                              		<select class="form-control selectdee" id="EmpId1<%=ActivityA[0] %><%=ActivityB[0] %>" required="required" name="EmpId1">
    									
  									</select>
  										</div>
  										
  							</div>			
  <script type="text/javascript">

changeempoic1(<%=ActivityB[13] %>,<%=ActivityA[0] %><%=ActivityB[0] %>);
changeempoic2(<%=ActivityB[15] %>,<%=ActivityA[0] %><%=ActivityB[0] %>);


</script>
                       		<%} %>
							
						 </form>   
						 
							<script type="text/javascript">
var from ="<%=sdf.format(ActivityA[2])%>".split("-")
var dt = new Date(from[2], from[1] - 1, from[0])
var to ="<%=sdf.format(ActivityA[3])%>".split("-")
var dt1 = new Date(to[2], to[1] - 1, to[0])
$('#DateCompletionB'+'<%=ActivityA[0] %><%=ActivityB[0] %>').daterangepicker({
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


var mindate=dt;
$('#DateCompletionB'+'<%=ActivityA[0] %><%=ActivityB[0] %>').on('change', function() {
    mindate=$('#DateCompletionB'+'<%=ActivityA[0] %><%=ActivityB[0] %>').val();
    $('#DateCompletionB2'+'<%=ActivityA[0] %><%=ActivityB[0] %>').prop("disabled",false);
    $('#DateCompletionB2'+'<%=ActivityA[0] %><%=ActivityB[0] %>').daterangepicker({
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
  
  
  
$( document ).ready(function() {
    mindate=$('#DateCompletionB'+'<%=ActivityA[0] %><%=ActivityB[0] %>').val();
    $('#DateCompletionB2'+'<%=ActivityA[0] %><%=ActivityB[0] %>').prop("disabled",false);
    $('#DateCompletionB2'+'<%=ActivityA[0] %><%=ActivityB[0] %>').daterangepicker({
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
	    
	</script> 					 
						 
						<!-- B end -->
						
							<%


if(MilestoneActivityC!=null&&MilestoneActivityC.size()>0){
	int countC=1;
	for(Object[] ActivityC:MilestoneActivityC){
		List<Object[]> MilestoneActivityD=(List<Object[]>)request.getAttribute("MilestoneActivityD"+countA+countB+countC);	

		
%>


	
		

					
						<form   method="POST" action="MilestoneActivityEditSubmit.htm" id="form<%=ActivityB[0] %>C<%=ActivityC[0] %>">
                            <div class="row container-fluid" >
                             <div class="col-md-1 " ><br> <label class="control-label"></label><b style="margin-left: 24px;">C-<%=countC %></b>
                    		
                        	</div>
                        	
						    <div class="col-md-5 " ><br>
                    		 <textarea rows="1" cols="50" class="form-control " <%if(RevisionCount>0){ %> readonly="readonly" <%} %> name="ActivityName" id="ActivityName"   style="width:100%;text-align: justify; " maxlength="1000" required="required"><%=ActivityC[4] %></textarea> 
                        	</div>
                        	
                        	<div class="col-md-2 " align="center"><br>
                        	<input class="form-control " name="ValidFrom" id="DateCompletionC<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>"  value="<%=sdf.format(ActivityC[2]) %>"  required="required" style="width:120px;;" >
                        	
                        	</div>
                        	<div class="col-md-2 " align="center"><br>
                        	<input class="form-control " name="ValidTo" id="DateCompletionC2<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>"  value="<%=sdf.format(ActivityC[3]) %>"  required="required"  style="width:120px;;" >
                        		</div>
                        		<div class="col-md-1 " align="center" ><br>      
                    		<input type="number" class="form-control " name="Weightage" id="Weightage<%=ActivityB[0] %>C<%=ActivityC[0] %>" required="required" min="0" max="100" value="<%=ActivityC[6] %>"  style="width:95px;">
                    		
                    		 
                        	</div>
                        	<div class="col-md-1 "><br>
                              
                        	  <button type="button"  class="btn btn-sm edit" onclick="weightage_sum('<%=ActivityB[0] %>','<%=ActivityC[0] %>','C','3');"> <i class="fa fa-edit" aria-hidden="true"></i> </button>
                        	  <input type="submit" hidden="hidden" id="<%=ActivityB[0] %>C<%=ActivityC[0] %>sub"/> 
                        	  
                              <input type="hidden" name="RevId"	value="<%=RevisionCount %>" /> 
                              <input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0] %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=ActivityC[0] %>" /> 
                              <input type="hidden" name="ActivityType"	value="C" /> 
                              <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                                                    	</div>
                                                    	 
                        	</div>
                        	<%if(RevisionCount==0) {%>
                       		<div class="row container-fluid" >
                             <div class="col-md-1 " >                    		
                        	</div>
                    		<div class="col-md-3 " ><br>
                    		<label class="control-label">Activity Type  </label>
                              		<select class="form-control selectdee" id="ActivityTypeId" required="required" name="ActivityTypeId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ActivityTypeList) {%>
										<option value="<%=obj[0]%>" <%if(ActivityC[11].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <% }%>><%=obj[1]%> </option>
											<%} %>
  									</select>
                    	      	</div>
                        	
                       <div class="col-md-3 " align="center"><br>
                        	<label class="control-label">First Oic  </label>
                        	<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox1<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>" onchange="changeempoic1('<%=ActivityC[13]%>','<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>')" >
									</div>
                              		<select class="form-control selectdee" id="EmpId<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>" required="required" name="EmpId">
    									
											
  									</select>
                        	</div>
                        	<div class="col-md-3 " align="center"><br>
                        		<label class="control-label">Second Oic </label>
                        		<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox2<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>" onchange="changeempoic2('<%=ActivityC[15]%>','<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>')" >
									</div>
                              		<select class="form-control selectdee" id="EmpId1<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>" required="required" name="EmpId1">
    									
  									</select>
  										</div>
  										
  							</div>			
  <script type="text/javascript">

changeempoic1(<%=ActivityC[13] %>,<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>);
changeempoic2(<%=ActivityC[15] %>,<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>);


</script>
                       		<%} %>
                        	
	                        </form> 
	                        
	           					<script type="text/javascript">
var from ="<%=sdf.format(ActivityB[2])%>".split("-")
var dt = new Date(from[2], from[1] - 1, from[0])
var to ="<%=sdf.format(ActivityB[3])%>".split("-")
var dt1 = new Date(to[2], to[1] - 1, to[0])
$('#DateCompletionC'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>').daterangepicker({
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


var mindate=dt;
$('#DateCompletionC'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>').on('change', function() {
    mindate=$('#DateCompletionC'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>').val();
    $('#DateCompletionC2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>').prop("disabled",false);
    $('#DateCompletionC2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>').daterangepicker({
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
  
  
  
$( document ).ready(function() {
    mindate=$('#DateCompletionC'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>').val();
    $('#DateCompletionC2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>').prop("disabled",false);
    $('#DateCompletionC2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %>').daterangepicker({
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
	    
	</script> 	     
	
								<%


if(MilestoneActivityD!=null&&MilestoneActivityD.size()>0){
	int countD=1;
	for(Object[] ActivityD:MilestoneActivityD){
		List<Object[]> MilestoneActivityE=(List<Object[]>)request.getAttribute("MilestoneActivityE"+countA+countB+countC+countD);	
%>


	                              <form  method="POST" action="MilestoneActivityEditSubmit.htm" id="form<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>">
		
						    <div class="row container-fluid" >
						     <div class="col-md-1 " ><br> <label class="control-label"></label><b style="margin-left: 30px;">D-<%=countD %></b>
                    		
                        	</div>
						    <div class="col-md-5 " ><br>
                    		 <textarea rows="1" cols="50" class="form-control " <%if(RevisionCount>0){ %> readonly="readonly" <%} %> name="ActivityName" id="ActivityName"   style="width:100%;text-align: justify; " maxlength="1000" required="required"><%=ActivityD[4] %></textarea> 
                        	</div>
                        	
                        	<div class="col-md-2 " align="center"><br>
                        	<input class="form-control " name="ValidFrom" id="DateCompletionB<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>"  value="<%=sdf.format(ActivityD[2]) %>"  required="required"  style="width:120px;;" >
                        	
                        	</div>
                        	<div class="col-md-2 " align="center"><br>
                        	<input class="form-control " name="ValidTo" id="DateCompletionB2<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>"  value="<%=sdf.format(ActivityD[3]) %>"  required="required"  style="width:120px;;" >
                        		</div>
                            <div class="col-md-1 " align="center" ><br>      
                    				

                    		<input type="number" class="form-control "  name="Weightage" id="Weightage<%=ActivityC[0] %>D<%=ActivityD[0] %>" required="required" min="0" max="100" value="<%=ActivityD[6] %>"  style="width:95px;" >
                    	
                    		
                    		 
                        	</div>
                        	<div class="col-md-1 "><br>
                        	  <button type="button"  class="btn btn-sm edit" onclick="weightage_sum('<%=ActivityC[0] %>','<%=ActivityD[0] %>','D','4');"> <i class="fa fa-edit" aria-hidden="true"></i> </button>
                        	 
                        	  <input type="submit" hidden="hidden" id="<%=ActivityC[0] %>D<%=ActivityD[0] %>sub"/> 
                              <input type="hidden" name="RevId"	value="<%=RevisionCount %>" /> 
                              <input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0] %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=ActivityD[0] %>" /> 
                              <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                                                  	</div>
							</div>
							<%if(RevisionCount==0) {%>
                       		<div class="row container-fluid" >
                             <div class="col-md-1 " >                    		
                        	</div>
                    		<div class="col-md-3 " ><br>
                    		<label class="control-label">Activity Type  </label>
                              		<select class="form-control selectdee" id="ActivityTypeId" required="required" name="ActivityTypeId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ActivityTypeList) {%>
										<option value="<%=obj[0]%>" <%if(ActivityD[11].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <% }%>><%=obj[1]%> </option>
											<%} %>
  									</select>
                    	      	</div>
                                                <div class="col-md-3 " align="center"><br>
                        	<label class="control-label">First Oic  </label>
                        	<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox1<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>" onchange="changeempoic1('<%=ActivityD[13]%>','<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>')" >
									</div>
                              		<select class="form-control selectdee" id="EmpId<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>" required="required" name="EmpId">
    									
											
  									</select>
                        	</div>
                        	<div class="col-md-3 " align="center"><br>
                        		<label class="control-label">Second Oic </label>
                        		<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox2<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>" onchange="changeempoic2('<%=ActivityD[15]%>','<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>')" >
									</div>
                              		<select class="form-control selectdee" id="EmpId1<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>" required="required" name="EmpId1">
    									
  									</select>
  										</div>
  										
  							</div>			
  <script type="text/javascript">

changeempoic1(<%=ActivityD[13] %>,<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>);
changeempoic2(<%=ActivityD[15] %>,<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>);


</script>
                       		<%} %>
								
						 </form>   
						 
							<script type="text/javascript">
var from ="<%=sdf.format(ActivityC[2])%>".split("-")
var dt = new Date(from[2], from[1] - 1, from[0])
var to ="<%=sdf.format(ActivityC[3])%>".split("-")
var dt1 = new Date(to[2], to[1] - 1, to[0])
$('#DateCompletionB'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>').daterangepicker({
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


var mindate=dt;
$('#DateCompletionB'+'<%=ActivityD[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>').on('change', function() {
    mindate=$('#DateCompletionB'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>').val();
    $('#DateCompletionB2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>').prop("disabled",false);
    $('#DateCompletionB2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>').daterangepicker({
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
  
  
  
$( document ).ready(function() {
    mindate=$('#DateCompletionB'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>').val();
    $('#DateCompletionB2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>').prop("disabled",false);
    $('#DateCompletionB2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %>').daterangepicker({
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
	    
	</script> 					 
						 
						<!-- B end -->
						
							<%


if(MilestoneActivityE!=null&&MilestoneActivityE.size()>0){
	int countE=1;
	for(Object[] ActivityE:MilestoneActivityE){
		
%>


	
		

					
						<form   method="POST" action="MilestoneActivityEditSubmit.htm" id="form<%=ActivityD[0] %>E<%=ActivityE[0] %>">
                            <div class="row container-fluid" >
                             <div class="col-md-1 " ><br> <label class="control-label"></label><b style="margin-left: 36px;">E-<%=countE %></b>
                    		
                        	</div>
                        	
						    <div class="col-md-5 " ><br>
                    		 <textarea rows="1" cols="50" class="form-control " <%if(RevisionCount>0){ %> readonly="readonly" <%} %> name="ActivityName" id="ActivityName"   style="width:100%;text-align: justify; " maxlength="1000" required="required"><%=ActivityE[4] %></textarea> 
                        	</div>
                        	
                        	<div class="col-md-2 " align="center"><br>
                        	<input class="form-control " name="ValidFrom" id="DateCompletionC<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>"  value="<%=sdf.format(ActivityE[2]) %>"  required="required" style="width:120px;;" >
                        	
                        	</div>
                        	<div class="col-md-2 " align="center"><br>
                        	<input class="form-control " name="ValidTo" id="DateCompletionC2<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>"  value="<%=sdf.format(ActivityE[3]) %>"  required="required"  style="width:120px;;" >
                        		</div>
                        		<div class="col-md-1 " align="center" ><br>      
                    		<input type="number" class="form-control " name="Weightage" id="Weightage<%=ActivityD[0] %>E<%=ActivityE[0] %>" required="required" min="0" max="100" value="<%=ActivityE[6] %>"  style="width:95px;">
                    		
                    		 
                        	</div>
                        	<div class="col-md-1 "><br>
                              
                        	  <button type="button"  class="btn btn-sm edit" onclick="weightage_sum('<%=ActivityD[0] %>','<%=ActivityE[0] %>','E','5');"> <i class="fa fa-edit" aria-hidden="true"></i> </button>
                        	  <input type="submit" hidden="hidden" id="<%=ActivityD[0] %>E<%=ActivityE[0] %>sub"/> 
                        	  
                              <input type="hidden" name="RevId"	value="<%=RevisionCount %>" /> 
                              <input type="hidden" name="MilestoneActivityId"	value="<%=getMA[0] %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=ActivityE[0] %>" /> 
                              <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                                                    	</div>
                                                    	 
                        	</div>
                        	<%if(RevisionCount==0) {%>
                       		<div class="row container-fluid" >
                             <div class="col-md-1 " >                    		
                        	</div>
                    		<div class="col-md-3 " ><br>
                    		<label class="control-label">Activity Type  </label>
                              		<select class="form-control selectdee" id="ActivityTypeId" required="required" name="ActivityTypeId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ActivityTypeList) {%>
										<option value="<%=obj[0]%>" <%if(ActivityE[11].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <% }%>><%=obj[1]%> </option>
											<%} %>
  									</select>
                    	      	</div>
                        	
                        <div class="col-md-3 " align="center"><br>
                        	<label class="control-label">First Oic  </label>
                        	<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox1<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>" onchange="changeempoic1('<%=ActivityE[13]%>','<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>')" >
									</div>
                              		<select class="form-control selectdee" id="EmpId<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>" required="required" name="EmpId">
    									
											
  									</select>
                        	</div>
                        	<div class="col-md-3 " align="center"><br>
                        		<label class="control-label">Second Oic </label>
                        		<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox2<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>" onchange="changeempoic2('<%=ActivityE[15]%>','<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>')" >
									</div>
                              		<select class="form-control selectdee" id="EmpId1<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>" required="required" name="EmpId1">
    									
  									</select>
  										</div>
  										
  							</div>			
  <script type="text/javascript">

changeempoic1(<%=ActivityE[13] %>,<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>);
changeempoic2(<%=ActivityE[15] %>,<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>);


</script>
                       		<%} %>
                        	
	                        </form> 
	                        
	           					<script type="text/javascript">
var from ="<%=sdf.format(ActivityD[2])%>".split("-")
var dt = new Date(from[2], from[1] - 1, from[0])
var to ="<%=sdf.format(ActivityD[3])%>".split("-")
var dt1 = new Date(to[2], to[1] - 1, to[0])
$('#DateCompletionC'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>').daterangepicker({
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


var mindate=dt;
$('#DateCompletionC'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>').on('change', function() {
    mindate=$('#DateCompletionC'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>').val();
    $('#DateCompletionC2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>').prop("disabled",false);
    $('#DateCompletionC2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>').daterangepicker({
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
  
  
  
$( document ).ready(function() {
    mindate=$('#DateCompletionC'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>').val();
    $('#DateCompletionC2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>').prop("disabled",false);
    $('#DateCompletionC2'+'<%=ActivityA[0] %><%=ActivityB[0] %><%=ActivityC[0] %><%=ActivityD[0] %><%=ActivityE[0] %>').daterangepicker({
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
	    
	</script> 	             
						<!-- C end -->
									
									
	
		<%countE++;}}else{
	%>
				
	
<%} %>	
									
									
									
		
		<%countD++;}}else{
	%>
					
	
<%} %>	        
						<!-- C end -->
									
									
	
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
	
	<div  class="col-md-12">
	<br><br>
	<br><br><br><br><br>
	</div>
	</div>
									</div>	
<script type="text/javascript">
function weightage_sum(id,activityid,type,levelid){
	var sum=Number($('#Weightage'+id+type+activityid).val());
	event.preventDefault();
	  $
		.ajax({

			type : "GET",
			url : "WeightageSum.htm",
			data : {
				Id: id,
				ActivityId   : activityid,
					Type     :type,
					LevelId  :levelid
			},
			datatype : 'json',
			success : function(result) {

				var result = JSON.parse(result);
				var Msg="Project MileStone";
				if('M'==type){
					
				}else{
					Msg='Activity '+type;
				}
				 console.log(sum);
				 sum+=Number(result);
				 console.log(result);
				 console.log(sum);
                 if(sum>100){
                	 
                	 alert('Total '+Msg+' Weightage='+sum+',Total '+Msg+' Weightage Should not greater  than 100.'); 
                 }else if(sum<=100){
                	 if(confirm('Total '+Msg+' Weightage='+sum+', Are you sure to Submit ?')){
                	
                			 $('#'+id+type+activityid+'sub').click();
                		
                		 
                	 } 
                 }else{
                	 event.preventDefault(); 
                 }
				
			}
		}); 
	
}  

</script>
													
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
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

/* ---------------------------------------dinesh--------------------------------------- */
$( document ).ready(function() {
    mindate=$('#DateCompletion').val();
    $('#DateCompletion2').prop("disabled",false);
    $('#DateCompletion2').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate,
    	"cancelClass" : "btn-default",
    	showDropdowns : true,
    	locale : {
    		format : 'DD-MM-YYYY'
    	}
    	});
  });
  
	    
	</script>  
	
</body>
</html>