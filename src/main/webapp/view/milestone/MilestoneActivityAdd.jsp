<%@page import="com.ibm.icu.text.DecimalFormat"%>
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
 

<title>Milestone List</title>
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
</style>
</head>
 
<body>
  <%
  
  List<Object[]> allLabList=(List<Object[]>)request.getAttribute("allLabList");
  List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
  List<Object[]> ActivityTypeList=(List<Object[]>)request.getAttribute("ActivityTypeList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  String projectDirector=(String)request.getAttribute("projectDirector");
  Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");

  String labcode = (String)session.getAttribute("labcode");
 %>



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
    
  <div class="container">
	<div class="row" style="margin-top: -25px; margin-bottom: 5px;">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
				
				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white"><%=ProjectDetail[2] %>(<%=ProjectDetail[1] %>) Milestone Activity Add</b>
        		</div>
        
        		<div class="card-body">
        	     	<form action="MilestoneActivityAddSubmit.htm" method="POST" name="myfrm" id="myfrm">
                		<div class="row">
                   
         					 		<!-- <div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">Milestone No</label>
    					            <input class="form-control " name="MilestoneNo" required="required"  type="number" min="0" max="9999999" >
                        		</div>
                    		</div> -->
                       		<div class="col-sm-10" align="left"  >
                          		<div class="form-group">
                           			<label  >Activity Name: <span class="mandatory" style="color: red;" >*</span></label><br>
                             		<input class="form-control " type="text"name="ActivityName" id="ActivityName"  style="width:100% " maxlength="1000" required="required">
                           		</div>
                           	</div>
                           
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">Activity Type  </label>
                              		<select class="form-control selectdee" id="ActivityType" required="required" name="ActivityType">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ActivityTypeList) {%>
										<option value="<%=obj[0]%>"><%=obj[1]%> </option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
                    
                		</div>
                		<div class="row">
							<div class="col-md-2">
								<label  >Lab: <span class="mandatory" style="color: red;" >*</span></label><br>
								<select class="form-control selectdee" name="labCode" id="labCode1" required onchange="renderEmployeeList('1')" data-placeholder= "Lab Name">
								    <% for (Object[] obj : allLabList) { %>
								    	<option value="<%=obj[3]%>" <%if(labcode.equalsIgnoreCase(obj[3].toString())) {%>selected<%} %> ><%=obj[3]%></option>
								    <%}%>
								</select>
							</div>
                    		<div class="col-md-4">
                        		<div class="form-group">
                            		<label class="control-label">First OIC  </label>
                            		<div style="float: right;"  > <label>All : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox1" onchange="changeempoic1()" >
									</div>
                              		<select class="form-control selectdee" id="EmpId" required="required" name="EmpId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : EmployeeList) {%>
										<option value="<%=obj[0]%>"><%=obj[1]%>, <%=obj[2]%> </option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
                    		<div class="col-md-2">
                    			<label  >Lab: <span class="mandatory" style="color: red;" >*</span></label><br>
								<select class="form-control selectdee" name="labCode1" id="labCode2" required onchange="renderEmployeeList('2')" data-placeholder= "Lab Name">
								    <% for (Object[] obj : allLabList) { %>
								    	<option value="<%=obj[3]%>" <%if(labcode.equalsIgnoreCase(obj[3].toString())) {%>selected<%} %> ><%=obj[3]%></option>
								    <%}%>
								</select>
							</div>
                    		<div class="col-md-4 ">
                        		<div class="form-group">
                            		<label class="control-label">Second OIC </label>
                            		<div style="float: right;"  > <label>All : &nbsp;&nbsp;</label>
										<input type="checkbox" style="float: right; margin-top : 6px;" id="allempcheckbox2" onchange="changeempoic2()" >
									</div>
                              		<select class="form-control selectdee" id="EmpId1" required="required" name="EmpId1">
    									<option disabled="true" selected value="">Choose...</option>
    										<% for (Object[] obj : EmployeeList) {%>
											<option value="<%=obj[0]%>"><%=obj[1]%>, <%=obj[2]%> </option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
                    	</div>
                    		
						<div class="row">
							<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">From</label>
    					            <input class="form-control " name="ValidFrom" id="DateCompletion" required="required"  >
                        		</div>
                    		</div>
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">To</label>
    					            <input class="form-control " name="ValidTo" id="DateCompletion2" required="required"  disabled="disabled">
                        		</div>
                    		</div>
						</div>
            
      					<input type="hidden" id="currLabCode" value="<%=labcode%>">
         
        <div class="form-group" align="center" >
			
			
	 		<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="SUBMIT" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
		   <input type="submit" class="btn btn-primary btn-sm back " id="sub" value="Back" name="sub" onclick="SubmitBack()"  formaction="MilestoneActivityList.htm"> 
			   <input type="hidden" name="projectDirector" value="<%=projectDirector%>">  
		
		</div>
      <input type="hidden" name="ProjectId"	value="<%=ProjectId %>" /> 

	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 	</form>
        
     </div>`     
        




<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px ;margin-top: -40px;">
         
       
        </div>
        </div>
</div>
</div>
</div>  



<script type="text/javascript">

	function changeempoic1() {
		if (document.getElementById('allempcheckbox1').checked)  {
	    	employeefetch(0,'EmpId');
	  	} else {
			employeefetch(<%=ProjectId%>,'EmpId');
	  	}
	}
	
	
	function changeempoic2() {
		if (document.getElementById('allempcheckbox2').checked) {
	    	employeefetch(0,'EmpId1');
	  	} else {
			employeefetch(<%=ProjectId%>,'EmpId1');
	  	}
	}

	function employeefetch(ProID,dropdownid){
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
							+values[i][1] + ", " +values[i][2] 
							+ '</option>';
				} 
				 
				$('#'+dropdownid).html(s);
				
			}
		});
		
	}
		
</script>
  
<script>

function SubmitBack(){
	$('#EmpId').prop("required",false);
	$('#EmpId1').prop("required",false);
	$('#ActivityName').prop("required",false);
	$('#ActivityType').prop("required",false);
	
}

</script>

<script>
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
	
	var mindate;
	$('#DateCompletion').on('change', function() {
	    mindate=$('#DateCompletion').val();
	    $('#DateCompletion').prop("disabled",false);
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

<script type="text/javascript">
	function renderEmployeeList(rowId) {
		var labCode  = $('#labCode'+rowId).val();
		var currLabCode  = $('#currLabCode').val();
		
		employeeListByLabCode(rowId, labCode);
		
		if(currLabCode!=labCode) {
			$('#allempcheckbox'+rowId).hide();
		}else {
			$('#allempcheckbox'+rowId).show();
			$('#allempcheckbox'+rowId).prop('checked', true);
		}
	}
	
	function employeeListByLabCode(rowId, labcode) {

		var rowIdShort = rowId==1?"":(rowId-1);
		$('#EmpId'+rowIdShort).empty(); 
		$.ajax({
		       type: "GET",
		       url: "GetLabcodeEmpList.htm",
		       data: {
		       	LabCode: labcode
		       },
		       dataType: 'json',
		       success: function(result) {
		    	   if (result != null) {
		    		   $('#EmpId'+rowIdShort).append('<option disabled="disabled" selected value="">Choose...</option>');
		                for (var i = 0; i < result.length; i++) {
		                    var data = result[i];
		                    var optionValue = data[0];
		                    var optionText = data[1].trim() + ", " + data[3]; 
		                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
		                    $('#EmpId'+rowIdShort).append(option); 
		                }
		                //$('#EmpId'+(rowId==1?"":rowId)).select2('refresh');
		           }
		       }
		   });
	}
</script>

</body>
</html>