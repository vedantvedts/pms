<%@page import="com.ibm.icu.text.DecimalFormat,com.vts.pfms.milestone.dto.MileEditDto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<script src="./resources/js/multiselect.js"></script>
<link href="./resources/css/multiselect.css" rel="stylesheet"/>
 

<title>Milestone Update</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}
.multiselect-container>li>a>label {
  padding: 4px 20px 3px 20px;
}
.cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 108px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
  z-index: 9;
  display: inline-block;
  width: 28px;
  height: 52px;
  box-sizing: border-box;
  margin: 0 5px 0 0;
}
.cc-rockmenu .rolling .rolling_icon:hover .rolling {
  width: 312px;
}

.cc-rockmenu .rolling i.fa {
    font-size: 20px;
    padding: 6px;
}
.cc-rockmenu .rolling span {
    display: block;
    font-weight: bold;
    padding: 2px 0;
    font-size: 14px;
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:150px !important;
}
input[type="file"]{
    height:39px;
    }
input[type="file"]::-webkit-file-upload-button{
    height:28px;
    } 
</style>
</head>
 
<body>
  <%
  List<Object[]> AllLabsList = (List<Object[]>)request.getAttribute("AllLabsList");
  List<Object[]> StatusList=(List<Object[]>)request.getAttribute("StatusList");
  String LabCode =(String)session.getAttribute("labcode");
  
  System.out.println(LabCode);
  List<Object[]> EmpList=(List<Object[]>)request.getAttribute("EmpList");
  Object[] EditData=(Object[])request.getAttribute("EditData");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  MileEditDto EditMain=(MileEditDto)request.getAttribute("EditMain");
  List<Object[]> SubList=(List<Object[]> ) request.getAttribute("SubList");
  List<Object[]> ActionList=(List<Object[]> ) request.getAttribute("ActionList");
  String ses=(String)request.getParameter("result"); 
  String ses1=(String)request.getParameter("resultfail");
  String clusterid = (String)session.getAttribute("clusterid");
  
  Object[] projectdetails=(Object[])request.getAttribute("projectdetails");
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
	<div class="row" style="margin-top: -0px; margin-bottom: 5px;">

		<div class="col-md-6">

 			<div class="card shadow-nohover" >
				
				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white">  Activity  Update: <%=EditData[3] %></b><b class="text-white" style="float: right;"><%=projectdetails[1]%></b>  
        		</div>
        
        		<div class="card-body">
        	     			<form action="M-A-UpdateSubmit.htm" method="POST" name="myfrm" id="myfrm" enctype="multipart/form-data">
                		 <div class="row">
                		 
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">Progress</label>
                            	    <input type="number" name="Progress" id="progressid"  value="<%=EditData[5] %>" class="form-control item_name" max="100"  min="1" />						
                            		
                        		</div>
                    		</div>

                    		<div class="col-md-4">
                        		<div class="form-group">
                            		<label class="control-label">Attach File</label>
                    		<input type="file" name="FileAttach" id="FileAttach"  class="form-control wrap" aria-describedby="inputGroup-sizing-sm" maxlength="255" onchange="Filevalidation('FileAttach');" />
                                  
                                  </div>
                                  </div>
                                   <div class="col-md-6">
                        		<div class="form-group">
                            		<label class="control-label">Remarks</label>
                                     <input type="text" name="Remarks" class="form-control item_name" maxlength="255" required="required" value="Nil" />                            		
                        		</div>
                    		</div>
                    		</div>
                
        <div class="form-group" align="center" style="padding-bottom: 25px;" >			
	 		<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="SUBMIT" name="sub"  onclick="return editcheck('FileAttach');" > 
			<button type="submit" class="btn btn-primary btn-sm back " id="sub" value="C" name="sub" onclick="SubmitSBack();"  formaction="M-A-AssigneeList.htm"> BACK </button> 
		</div>
                              
                              <input type="hidden" name="MilestoneActivityId"	value="<%=EditMain.getMilestoneActivityId() %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=EditMain.getActivityId() %>" /> 
                              <input type="hidden" name="ProjectId"	value="<%=EditMain.getProjectId() %>" /> 
                              <input type="hidden" name="ActivityType"	value="<%=EditMain.getActivityType() %>" /> 
                               <input type="hidden" name="EndDate"	value="<%=EditData[2] %>" /> 
                              <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 	</form>
        
     </div>
        




<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 2px ;margin-top: -40px;">
         
       
        </div>
        </div>
</div>
<div class="col-md-6"   style="">
	<div class="card shadow-nohover" >
				
				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white"> Action Item: <%=EditData[3] %></b>
        		</div>
       
    	<div class="card-body" style="margin-top: -8px">
            <form name="specadd" id="specadd" action="MilActionSubmit.htm" method="post">
  
   				<div class="row" >
<%-- 					<div class="col-md-1"  align="left"></div>
   					<div class="col-sm-10" align="left"  >
<div class="form-group" style="text-align: justify;">
<label  >Action Item: 
</label><b   > <%=EditData[3] %></b>

</div>
</div> --%>

<div class="col-md-1"  align="left"></div>
  <div class="col-sm-3" align="left"  >
   <div class="form-group">
<label  >PDC: <span class="mandatory" style="color: red;">* </span></label>
<input class="form-control " name="DateCompletion" id="DateCompletion" required="required" placeholder="" >

</div>
</div>

                             <div class="col-sm-3" align="left">
									<label> Priority : </label>
									<br>
									<select class="form-control selectdee " name="Priority"  required="required"  data-live-search="true" >                                                     
										<option value="H" >High</option>	
										<option value="L" >Low</option>
										<option value="M" >Medium</option>
										<option value="I" >Immediate</option>
									</select>	
								</div>
								
							<div class="col-sm-4" align="left">
									<label> Category : </label>
									<br>
									<select class="form-control selectdee " name="Category"  required="required"  data-live-search="true" >                                                     
										<option value="T" >Technical</option>	
										<option value="F" >Finance</option>
										<option value="M" >Managerial</option>
										<option value="L" >Logistic</option>
										<option value="O" >Others</option>
									</select>	
							</div>
</div>


<div class="row"  style="margin-bottom: 10px;">
 <div class="col-sm-2" align="left"  ></div>
 <div class="col-sm-3" align="left"  >
   <div class="form-group">
<label > Lab : <span class="mandatory" style="color: red;">* </span></label>

<br>

<select class=" form-control selectdee" name="AssigneeLabCode" id="LabCode" required="required" style="margin-top: -5px" onchange="AssigneeEmpList()" >
											<option disabled="disabled"  selected value="" >Choose...</option>
											<%if(AllLabsList!=null && AllLabsList.size()>0){	for (Object[] obj  : AllLabsList) {
												if(clusterid!=null && clusterid.equalsIgnoreCase(obj[1].toString())){
											%>
										     	<option value="<%=obj[3]%>" <%if(LabCode!=null && LabCode.equalsIgnoreCase(obj[3].toString())){ %>selected <%} %> ><%=obj[3] %> </option>
											<%}}}%>
											<option value="@EXP"> Expert</option>
										</select>	

</div>
</div>


 <div class="col-sm-5" align="left"  >
   <div class="form-group">
          <label > Assignee : </label>

	<!-- <div style="float: right;"  > 
		<label>All &nbsp; : &nbsp;&nbsp;</label>
		<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox" onchange="changeempdd()" >
	</div> -->
<br>

<select class="form-control selectdee" name="Assignee" id="Assignee" required="required"  data-live-search="true"  data-placeholder="Select Assignee" multiple>
                                                             

        <%for(Object[] obj:EmpList){ %>	
													
			<option value="<%=obj[0]%>"><%=obj[1]%>, <%=obj[2]%></option>	
																	
		<%} %>
</select>

</div>
</div>



 				</div>  
 				<div  align="center">
 				 				<input type="submit" name="sub"   style="margin-top: -10px;" class="btn  btn-sm submit" form="specadd"  id="adding" value="SUBMIT"  onclick="return confirm('Are you sure To Submit?')"/>
	          				<input type="hidden" name="ProjectId"	value="<%=EditMain.getProjectId() %>" /> 
	        			 <input type="hidden" name="MilestoneActivityId"	value="<%=EditMain.getMilestoneActivityId() %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=EditMain.getActivityId() %>" /> 
                              <input type="hidden" name="ActivityType"	value="A" /> 
	        		<input  type="hidden" name="Item" value="<%=EditData[3] %>"  style="width:100% " maxlength="1000">
			        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />         				
			       
		  
</div>	
 	<!-- Form End -->			
 				
 		
	 		</form>
  		</div>
 <div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 2px ;margin-top: 0px;"></div>
	</div>
	
</div><!-- col-md-7 end -->
</div>

 <div class="row"> 
 <% if(SubList.size()>0){ %>  


   <div class="col-md-6" style="padding-left: 10px">
				
				
							
							<div class="table-responsive">
    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" style="margin-top: 20px;">
						<thead>
							<tr>
								<th colspan="7" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;text-transform: capitalize;" >Activity Updated Details </th>									
							</tr>	
							<tr>					
								<th style="text-align: left;">As On Date</th>
								<th style="">Progress %</th>
								<th style="">Remarks</th>								
							 	<th style="">Attachment</th>
							 	<!-- <th style="">Upload</th> -->
								<!-- <th style="">Action</th> -->
							</tr>
						</thead>
						<tbody>					
					 	<%int  count=1;
						for(Object[] obj: SubList){ %>
														
						<tr >
						
							 
							
		
								<td style="width: 15%;">
									<%=sdf.format(obj[2])%>
								</td>
								
								<td style="width: 15%;">
									
									<div class="progress" style="background-color:#cdd0cb !important">
  										<div class="progress-bar progress-bar-striped" role="progressbar" style="width: <%=obj[1]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><%=obj[1]%></div>
									</div>
				
										</td>
								
								<td style="word-wrap: break-word !important;min-width: 10%;max-width:15%;white-space: normal !important;text-align: justify;word-break: break-all;"> 
									<%=obj[3]%>
								</td>
								
								<td style="text-align: left; width: 3%;">
								
							 <% 
						        if(obj[4].toString().length()!=0 && obj[4]!=null){
						        %>
						        <div  align="center">
										<a  
										 href="ActivityAttachDownload.htm?ActivitySubId=<%=obj[0]%>" 
										 target="_blank"><i class="fa fa-download"></i></a>
									</div>
								
									
								<%}else{ %>
								
								<div  align="center">-</div>
								 <%} %>
									
						
								</td>
								
								
						
						</tr>
														
							<% count++; } %>
						</tbody>
					</table>
				</div> 
			
				</div>
			 	
  		



	

  <%}else{ %>
   <div class="col-md-6" style="padding-left: 10px"> </div>
  <% }if(ActionList.size()>0){ %>  


   <div class="col-md-6" style="padding-left: 10px">
				
				
							
							<div class="table-responsive">
    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" style="margin-top: 20px;">
						<thead>
							<tr>
								<th colspan="7" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;text-transform: capitalize;" >Action Assigned </th>									
							</tr>	
							<tr>
							    <th style="">Assignee</th>
							    <th style="">Date of Assigned</th>					
								<th style="text-align: left;">PDC</th>
								
								<th style="">Progress %</th>
																
							 	
							 	<!-- <th style="">Upload</th> -->
								<!-- <th style="">Action</th> -->
							</tr>
						</thead>
						<tbody>					
					 	<%int  count=1;
						for(Object[] obj: ActionList){ %>
														
						<tr >
						
							 
							
		                        <td style="width:18% !important; "><%=obj[1]%>, <%=obj[2]%></td>
								<td width="12%">
									<%=sdf.format(obj[3])%>
								</td>
								<td width="12%">
									<%=sdf.format(obj[4])%>
								</td>
								<td style="width:8% !important; "><%if(obj[11]!=null){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[11]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=obj[11]%>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Yet Started .
															</div>
															</div> <%} %></td>
						
								
								
														
								
						</tr>
														
							<% count++; } %>
						</tbody>
					</table>
				</div> 
			
				</div>

  <%} %> 
  
   </div>
</div>
   
<script type="text/javascript">
function editcheck(editfileid)
{
	const fi = $('#'+editfileid )[0].files[0].size;							 	
   	
    if (document.getElementById(editfileid).files.length !=0 && file >= 50 ) 
    {
    	event.preventDefault();
     	alert("File too Big, please select a file less than 50mb");
    } else
    {
    	return confirm('Are you Sure To Submit?');
    }
}



</script>
 
<script type="text/javascript">
						
	Filevalidation = (fileid) => 
	{
		const fi = $('#'+fileid )[0].files[0].size;							 	
		const file = Math.round((fi / 1024/1024));
		if (file >= 50) 
		{
			alert("File too Big, please select a file less than 50mb");
		} 
s    }
						
</script>   



<script type="text/javascript">

function changeempdd()
{
	var labcode =$('#LabCode').val();
	
  if (document.getElementById('allempcheckbox').checked) 
  {
    employeefetch(0,labcode);
  } else {
	  employeefetch(<%=projectdetails[0]%> , labcode);
  }
}

	
	function employeefetch(ProID, labcode){
			
				
						$.ajax({		
							type : "GET",
							url : "ProjectEmpListFetch.htm",
							data : {
								projectid : ProID,
								labCode	  :labcode
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


function SubmitSBack(){
	$('#progressid').prop("min",false);
	
	
}



</script>




<script>
var from ="<%=sdf.format(EditData[1]) %>".split("-")
var dt = new Date(from[2], from[1] - 1, from[0])
var to ="<%=sdf.format(EditData[2]) %>".split("-")
var dt1 = new Date(to[2], to[1] - 1, to[0])
$('#DateCompletion').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	"minDate":new Date(),
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

	

$(document).ready(function() {
	   $('#StatusId').on('change', function() {
			var from = $("#StatusId").val();
			if ( from == '3' || from == '5'){
		       
				$('#DateCompletion').prop("disabled",false);
			}else{
				$('#DateCompletion').prop("disabled",true);
			}
			
		   });
	}); 

	</script>  
<script type="text/javascript">

 $(document).ready(function(){	
	 
	 AssigneeEmpList();
}); 	
 
 
 
 
		function AssigneeEmpList(){
		
			$('#chairperson').val("");
			
				var $LabCode = $('#LabCode').val();
			
						if($LabCode!=""){
				
									$.ajax({
		
										type : "GET",
										url : "ActionAssigneeEmployeeList.htm",
										data : {
											LabCode  : $LabCode,
											
											   },
										datatype : 'json',
										success : function(result) {
		
										var result = JSON.parse(result);
								
										var values = Object.keys(result).map(function(e) {
									 				 return result[e]
									  
														});
								
											var s = '';
											s += '<option value="">Choose ...</option>';
											if($LabCode == '@EXP'){
												
											}
											for (i = 0; i < values.length; i++) 
											{
												
												s += '<option value="'+values[i][0]+'">'+values[i][1] + '(' +values[i][3]+')' + '</option>';
											} 
											 
											$('#Assignee').html(s);

										}
									});		
		}
	}
		
		
		

</script>

</body>
</html>