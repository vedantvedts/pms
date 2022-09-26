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
<spring:url value="/resources/ckeditor/content.css" var="contentCss" />

<title>COMMITTEE SCHEDULE ACTION</title>

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
	margin:0px 4%;
}

		</style>
    </head>
 
 
<body>

<%



String specname=(String)request.getAttribute("specname");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
Object[] committeescheduleeditdata=(Object[])request.getAttribute("committeescheduleeditdata");
List<Object[]> committeescheduledata=(List<Object[]>)request.getAttribute("committeescheduledata");
List<Object[]> EmpList=(List<Object[]>)request.getAttribute("EmployeeList");

String projectid=committeescheduleeditdata[9].toString();

String GenId="GenAdd";
String MinutesBack=null;
MinutesBack=(String)request.getAttribute("minutesback");
if(MinutesBack==null){
	MinutesBack="NO";
}

%>


<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><center>
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></center>
                    <%} %>
                    
  
<nav class="navbar navbar-light bg-light"  style="margin-top: -1%">
	<a class="navbar-brand">
		
		<b style="color: #585858; font-size:19px;font-weight: bold;text-align: left; float:left" ><span style="color:#31708f"><%=committeescheduleeditdata[7] %> </span> <span style="color:#31708f;font-size: 15px"> (Meeting Date and Time : <%=sdf.format(sdf1.parse(committeescheduleeditdata[2].toString()))%> - <%=committeescheduleeditdata[3] %>)</span></b>

	</a>
	
	<%if(MinutesBack.equalsIgnoreCase("minutesback")){ %>
		
		 	<a  class="btn  btn-sm back" href="CommitteeScheduleMinutes.htm?committeescheduleid=<%=committeescheduleeditdata[6] %>"   style="margin-left: 50px; font-size:12px;font-weight: bold;width:62px; margin-top:-2px;" >BACK</a>

	<%} %>
	
	<%if(!MinutesBack.equalsIgnoreCase("minutesback")){ %>
	
 	<a  class="btn  btn-sm back" href="ActionList.htm"   style="margin-left: 50px; font-size:12px;font-weight: bold;width:62px; margin-top:-2px;" >BACK</a>
  
 	<%} %>
	
</nav>                    


<div class="container-fluid">   
          
<div class="row"> 

<div class="col-md-5" >
	<div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
    	<div class="card-body" style="margin-top: -8px" >
        	
        <%for(Object[] obj:committeescheduledata ){ %>
					
         <div class="panel panel-info" style="margin-top: 10px;" >
         
      		<div class="panel-heading ">
        		<h4 class="panel-title">
          			<span  style="font-size:14px"><%=obj[7] %>. <%=obj[4] %> 
          			<%if("3".equalsIgnoreCase(obj[7].toString())){%>/  <%=obj[5] %> /  <%=obj[6] %><%} %> 
          			<%if("5".equalsIgnoreCase(obj[7].toString())){%>    <%} %> 
          			(
          			<%if("K".equalsIgnoreCase(obj[2].toString())){%>Risk Task<%} %>
          			<%if("I".equalsIgnoreCase(obj[2].toString())){%>Issue Task<%} %>
          			<%if("A".equalsIgnoreCase(obj[2].toString())){%>Action Task<%} %>
          			<%if("R".equalsIgnoreCase(obj[2].toString())){%>Recommendation  Task<%} %>
          			)</span>  
        		</h4>
         	<div   style="float: right !important; margin-top:-23px; ">
		 		
	
       	</div>
      
      
		<div   style="float: right !important; margin-top:-25px; ">  
		
		
		
			<form name="myForm<%=obj[0] %>" id="myFormgen<%=obj[0] %>" action="ItemSpecAdd.htm" method="post">  
			<input type="hidden" name="specname" value="myFormgen<%=obj[0] %>">
			<input type="hidden" name="ScheduleId" value="<%=obj[3] %>">
			<input type="hidden" name="ProjectId" value="<%=obj[10] %>">
			<input class="form-control" type="hidden" name="scheduleminutesid" value="<%=obj[0] %>" readonly="readonly">
			<input class="form-control" type="hidden" name="minutesid" value="<%=obj[6] %>" readonly="readonly">
            <input class="form-control" type="hidden" name="agendasubid" value="<%=obj[9] %>" readonly="readonly">
			<input class="form-control" type="hidden" name="scheduleagendaid" value="<%=obj[7] %>" readonly="readonly">
			<input class="form-control" type="hidden" name="unitid" value="<%=obj[8] %>" readonly="readonly">
			<input class="form-control" type="hidden" name="type" value="<%=obj[2] %>" readonly="readonly">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			<input type="submit" name="sub" 
			<%if(!obj[11].toString().equalsIgnoreCase("0")){ %>
			 class="btn btn-warning btn-sm"
			 <%}else{ %>
			 class="btn btn-info btn-sm"
			  <%}if(specname!=null&&specname.equalsIgnoreCase("myFormgen"+obj[0])){ %> id="GenAdd" <%} %>  <%if(specname==null){ %> id="GenAdd" <%} %>   onclick="FormName('myFormgen<%=obj[0] %>')" value="Assign"  style="width:50px; height: 24px; font-size:10px; font-weight: bold; text-align: justify; "/>

			</form>
   		</div>
     </div>
     <!-- panel-heading end -->
  	
	  	<div id="collapse1" class="panel-collapse collapse in">
	
	     </div>      
	       
   </div>
   <!-- panel end -->   
   <%} %>
   

   

		</div><!-- Big card-body end -->
	
	</div><!-- Card End  -->
	
</div> <!-- col-md-5 end -->





<div class="col-md-7"   style="">
	
	<div class="card" style="margin-top: 2%;">
	<div class="card-header" style="background-color: #055C9D;">
	    		    <div class="row"> 

                   <div class="col-sm-5" align="left"  >
      				<h6 style="color: white;font-weight: bold;font-size: 1.2rem !important " align="left">

      				 </h6>
  	                   </div>     
  	                   <div class="col-sm-7" align="left"  >       
  	                    <div class="input-group">
																	<input type="text" class="form-control"
																		placeholder="Search Action Id to Link Old Action" name="ItemDescription"
																		id="ItemDescriptionSearch">
																	<div class="input-group-append">
																		<button class="btn btn-secondary" type="button"
																			style="font-size: 10px;"
																			id="ItemDescriptionSearchBtn">
																			<i class="fa fa-search"></i>
																		</button>
																	</div>
																</div>
																</div>
																</div>
      			</div>
    	<div class="card-body" style="margin-top: -8px">
            <form name="specadd" id="specadd" action="CommitteeActionSubmit.htm" method="post">
  
   				<div class="row"  style="margin-bottom: 10px;">
   					
   					<div class="col-md-12"  align="left">
						<label>
						<b id="iditemspec" style="font-size:18px " ></b>
						<b id="iditemsubspecofsub" style="font-size:18px " ></b>
						<b id="iditemsubspec" style="font-size:18px " ></b><b id="iditemsubspecofsubspec" style="font-size:18px " ></b> <b id="action" style="font-size:18px " ></b>
						

							<input type="hidden" name="scheduleminutesid" id="minutesidadd" >
							<input type="hidden" name="ScheduleId" id="ScheduleAdd">
							<input type="hidden" name="ProjectId" id="ProjectAdd">
							<input type="hidden" name="Type" id="TypeAdd">
							<input type="hidden" name="ScheduleSpec" id="ScheduleSpec">
							<input type="hidden" name="specname" id="specnameadd">
							
							<input type="hidden" name="minutesback" value="<%=MinutesBack %>">
						</label>
					</div>
					<div class="col-md-1"  align="left"></div>
   					<div class="col-sm-10" align="left"  >
<div class="form-group" style="text-align: justify;">
<label  >Action Item: <span class="mandatory" style="color: red;" >*</span>
</label><br><b id="iditem" style="font-size:18px " ></b>
<input  type="hidden" name="Item" id="additem"   style="width:100% " maxlength="1000">
</div>
</div>
<div class="col-md-1"  align="left"></div>
<div class="col-md-1"  align="left"></div>
  <div class="col-sm-3" align="left"  >
   <div class="form-group">
<label  >PDC: <span class="mandatory" style="color: red;">* </span>
</label>
<input class="form-control " name="DateCompletion" id="DateCompletion" required="required" placeholder="" >

<input type="hidden" name="meetingdate" value="<%=committeescheduleeditdata[2]%>" >

</div>
</div>



 <div class="col-sm-7" align="left"  >
   <div class="form-group">
<label > Assignee : 
</label>
<%if(Long.parseLong(projectid)>0){ %>
	<div style="float: right;"  > <label>All &nbsp; : &nbsp;&nbsp;</label>
		<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox" onchange="changeempdd()" >
	</div>
<%} %>
<br>
<select class="form-control selectdee" name="Assignee" id="Assignee" required="required"  data-live-search="true"  data-placeholder="Select Assignee" multiple>
                                                             

                                                            <%for(Object[] obj:EmpList){ %>	
																	
															<option value="<%=obj[0]%>"><%=obj[1]%>, <%=obj[2]%></option>	
																	
															<%} %>
															</select>

</div>
</div>
  
				


 				</div>  
 				<div class="row" align="center">
 <div class="col-sm-2" align="left"  ></div>
 <div class="col-sm-4" align="left"  >
   <div class="form-group" id="OldList">
<label > Old Action No : 
</label><br>
<select class="form-control selectdee " name="OldActionNo" id="OldActionNoId" hidden="hidden" data-live-search="true"  style="width:100% " >
                                                       
															</select>

</div>
</div>

 <div class="col-sm-4" align="left"  ><br>
 				 				<input type="submit" name="sub"   style="margin-top: 10px;" class="btn  btn-sm submit" form="specadd"  id="adding" value="SUBMIT"  onclick="return confirm('Are you sure To Submit?')"/>
	          					<button  class="btn  btn-sm back" style="margin-top: 10px;" onclick="resetSubmit()" >Reset</button>
	          				
	        			
	        		
			        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />         				
			       
</div>			  
</div>	
 	<!-- Form End -->			
 				
 				<div class="table-responsive">
    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTabl" style="margin-top: 20px;">
						<thead>
							<tr>
								<th colspan="4" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;" >Assigned List</th>									
							</tr>	
							<tr>					
								<th style="text-align: left;">Action Item</th>
								<!-- <th style="">Date of Completion</th> -->
								<th style="">PDC</th>
								<!-- <th style="">Date of Action</th> -->
								<th style="">Assigned Date</th>								
							 	<th style="">Assignee </th>			
							</tr>
						</thead>
		                 <tbody>
		                 </tbody>
					</table>
				</div> 	

	 		</form>
  		</div>
 
	</div>
	
</div><!-- col-md-7 end -->


</div> <!-- main row end -->

</div>


<script type="text/javascript">

function changeempdd()
{
  if (document.getElementById('allempcheckbox').checked) 
  {
    employeefetch(0);
  } else {
	  employeefetch(<%=committeescheduleeditdata[9]%>);
  }
}

	
	function employeefetch(ProID){
			
				
						$.ajax({		
							type : "GET",
							url : "ProjectEmpListFetch.htm",
							data : {
								projectid : ProID
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
								 
								$('#Assignee').html(s);
								
							}
						});
		
		
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
   
    

</script>
	

 <script type="text/javascript">
	 
	
	$("#OldList").hide();

	
	$("#ItemDescriptionSearchBtn").click(function(){
		   $('#OldActionNoId').empty();
		var $ItemSearch = $("#ItemDescriptionSearch").val();
		  $("#loader ").show(); 
		
		
		
		  if ($ItemSearch === ""){
			 alert("Search Content Requried");
			 $("#loader ").hide();
		  }else{
					  
			  $
				.ajax({

					type : "GET",
					url : "ActionNoSearch.htm",
					data : {
						ActionSearch : $ItemSearch
					},
					datatype : 'json',
					success : function(result) {

						var result = JSON.parse(result);
						var values = Object.values(result).map(function(key, value) {
							  return result[key,value]
							});
						var size = Object.keys(values).length;
						var s = '';
						 $("#OldList").show(); 
					     $("#OldActionNoId").prop("disable",false);
					    $("#OldActionNoId").empty();
					     $.each(values, function(key, value) {   
					         $('#OldActionNoId')   
					             .append($("<option></option>")
					                        .attr("value", value[0])
					                        .text(value[1]+", "+value[2])); 
					    });
					    
						$("#loader ").hide(); 
					}
				}); 
			  
			  
			  
		  }
		}); 
	
	
	function resetSubmit(){
		event.preventDefault();
		 $("#OldList").hide(); 
	     $("#OldActionNoId").prop("disable",true);

	}
	
	

    function FormName(formId) {
    	  $("#"+formId).submit(function(event){
    		    event.preventDefault();
    		    $('#adding').show();
    		   
    		    var minutesidadd = $("input[name='minutesid']",this).val();
    		    var specnameadd= $("input[name='specname']",this).val();
    		    var agendasubidadd= $("input[name='agendasubid']",this).val();
    		    var scheduleagendaidadd= $("input[name='scheduleagendaid']",this).val();
    		    var scheduleminutesidadd = $("input[name='scheduleminutesid']",this).val();
    		    var scheduleid= $("input[name='ScheduleId']",this).val();
    		    var projectid= $("input[name='ProjectId']",this).val();
    		    var unitidadd= $("input[name='unitid']",this).val();
    		    var typeadd= $("input[name='type']",this).val();
    		    $("#minutesidadd").val(scheduleminutesidadd);
    		    $("#specnameadd").val(specnameadd);
    		    $("#ScheduleAdd").val(scheduleid);
    		    $("#ProjectAdd").val(projectid);
    		    $("#TypeAdd").val(typeadd);
    		    var specall;
    		    var type;
    		    if(typeadd=='A'){
    		    	type="(Action Task)";
    		    }else if(typeadd=='I'){
    		    	type="(Issue Task)";
    		    }else{
    		    	type="(Risk Task)";
    		    }
    		    $.ajax({
    				type : "GET",
    				url : "CommitteeMinutesSpecAdd.htm",
    				data : {
    					
    					minutesid : minutesidadd,
    					specname:specnameadd,
    					agendasubid:agendasubidadd,
    					scheduleagendaid:scheduleagendaidadd,
    					minutesunitid:unitidadd,
    					
    				},
    				datatype : 'json',
    				success : function(result) {
    					
    					var result = JSON.parse(result);
    					var values = Object.keys(result).map(function(e) {
    						  return result[e]
    						});
    					    specall=values[1];
    					    document.getElementById('iditemspec').innerHTML = values[1]; 
    						if(minutesidadd==1 || minutesidadd==2){
    						document.getElementById('iditemsubspecofsub').innerHTML = "" ;
    						document.getElementById('iditemsubspec').innerHTML = "";
    						document.getElementById('iditemsubspecofsubspec').innerHTML = "";
        					}	
    						
							if(minutesidadd==3){
    						document.getElementById('iditemsubspecofsub').innerHTML = " / " + values[4]; 
    						document.getElementById('iditemsubspec').innerHTML = " / " + values[3]; 
    						specall=specall+" / " + values[4]+" / " + values[5]+" / " + values[3];
    						document.getElementById('iditemsubspecofsubspec').innerHTML = " / " + values[5]; 
        					}
							if(minutesidadd==4 || minutesidadd==5 || minutesidadd==6){
	    						document.getElementById('iditemsubspec').innerHTML = "";
	    						document.getElementById('iditemsubspecofsubspec').innerHTML = "";
	    						document.getElementById('iditemsubspecofsub').innerHTML = " / " + values[5]; 
	    						specall=specall+" / " + values[5]; 
	        				}
							document.getElementById('action').innerHTML =type;
							
							$("#ScheduleSpec").val(specall);
    					  
				
    				}
    			});
    		    $
    		    .ajax({

    		    	type : "GET",
    		    	url : "ScheduleActionItem.htm",
    		    	data : {
    		    		ScheduleMinutesId : scheduleminutesidadd
    		    		
    		    	},
    		    	datatype : 'json',
    		    	success : function(result) {

    		    		var result = JSON.parse(result);
    		    		var values = Object.keys(result).map(function(e) {
    		    			  return result[e]
    		    			});
    		    	
    		    		document.getElementById('iditem').innerHTML =result;
						
						$("#additem").val(result);
    		    	
    		    	}
    		    });
    		    
    		   
    		    
    		    $
    		    .ajax({

    		    	type : "GET",
    		    	url : "ScheduleActionList.htm",
    		    	data : {
    		    		ScheduleMinutesId : scheduleminutesidadd
    		    		
    		    	},
    		    	datatype : 'json',
    		    	success : function(result) {

    		    		var result = JSON.parse(result);
    		    		var values = Object.keys(result).map(function(e) {
    		    			  return result[e]
    		    			});
    		    		var s = '';
    		    		
    		    		 $("#myTabl tbody tr").hide();
    		    		 $("#myTabl thead tr").show(); 
    		    		 
    		    		 if(values.length==0){
    		    			$("#myTabl thead tr").hide(); 
    		    		 }
    		    		 
    		    		for (i = 0; i < values.length; i++) {
    		    
    		    			  var tempday = moment(JSON.stringify(values[i][3]), "MMM-DD-YYYY");
    		    			  var formatday= moment(tempday).format("DD-MM-YYYY");
    		    			  var tempday1 = moment(JSON.stringify(values[i][4]), "MMM-DD-YYYY");
    		    			  var formatday1= moment(tempday1).format("DD-MM-YYYY");
    		    			   
    		    			 markup = "<tr><td  style='overflow-wrap: break-word; word-break: break-all; white-space: normal;max-width:20%;min-width:20%;'> "+  values[i][5]  + "</td><td style='width:15%;'> "+  formatday1  + "</td><td style='width:15%;'> "+  formatday  + "</td><td style='width:20%;'> "+  values[i][1] +', '+values[i][2]  + "</td></tr>"; 
    		                 tableBody = $("#myTabl tbody"); 
    		                 tableBody.append(markup);   		            
		
    		    			
    		    }
    		    	
    		    	
    		    	}
    		    }); 
    		    
    		    
    		    
    		   
    		  });
    	  

    }  
    
	$('#DateCompletion').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		/* "minDate" : new Date(), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	$("#myTabl").DataTable({
		"lengthMenu": [  5,10,25, 50, 75, 100 ],
		"pagingType": "simple"


		  
		});
  
    </script>
   
   <script>


 var genid="<%=GenId%>";
$(document).ready(function(){
	 $("#"+genid).click();

	});   
   

</script>
</body>
</html>


