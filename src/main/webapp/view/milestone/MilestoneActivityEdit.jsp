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
 

<title>Milestone Edit</title>
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
  List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
  List<Object[]> ActivityTypeList=(List<Object[]>)request.getAttribute("ActivityTypeList");
  Object[] EditData=(Object[])request.getAttribute("EditData");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  MileEditDto EditMain=(MileEditDto)request.getAttribute("EditMain");

 %>

    
  <div class="container">
	<div class="row" style="margin-top: -0px; margin-bottom: 5px;">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
				
				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white">Milestone Activity Edit</b>
        		</div>
        
        		<div class="card-body">
        	     			<form action="MilestoneActivityEditSubmit.htm" method="POST" name="editfrm" id="editfrm">
                		 <div class="row">
                		 <%if("0".equalsIgnoreCase(EditMain.getRevisionNo())) {%>
                		
                   
                          <div  <%if("M".equalsIgnoreCase(EditMain.getActivityType())) {%> class="col-sm-10" 
                          <%}else if("A".equalsIgnoreCase(EditMain.getActivityType())) {%> class="col-sm-6" 
                          <%}else{ %>
                           class="col-sm-6" 
                          <%} %>
                          align="left"  >
                          <div class="form-group">
                           <label  >Activity Name: <span class="mandatory" style="color: red;" >*</span>
                           </label><br>
                             <input class="form-control " type="text"name="ActivityName" id="ActivityName" value="<%=EditData[3] %>"  style="width:100% " maxlength="1000" required="required">
                           </div>
                           </div>             
                           
                              		
                         <%if("M".equalsIgnoreCase(EditMain.getActivityType())) {%>
                            <div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">Activity Type  </label>
                              		<select class="form-control selectdee" id="ActivityTypeId" required="required" name="ActivityTypeId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ActivityTypeList) {%>
										<option value="<%=obj[0]%>" <%if(EditData[9].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <% }%>><%=obj[1]%> </option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
                                
                    		<div class="col-md-4">
                        		<div class="form-group">
                            		<label class="control-label">First Oic  </label>
                              		<select class="form-control selectdee" id="EmpId" required="required" name="EmpId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : EmployeeList) {%>
										<option value="<%=obj[0]%>" <%if(EditData[7].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <% }%>><%=obj[1]%>, <%=obj[2]%> </option>
											<%} %>
											
											
  									</select>
                        		</div>
                    		</div>
                    		<div class="col-md-4 ">
                        		<div class="form-group">
                            		<label class="control-label">Second Oic </label>
                              		<select class="form-control selectdee" id="EmpId1" required="required" name="EmpId1">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : EmployeeList) {%>
										<option value="<%=obj[0]%>" <%if(EditData[8].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <% }%>><%=obj[1]%>, <%=obj[2]%> </option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
                    		<%}%>
                    		 <%if("A".equalsIgnoreCase(EditMain.getActivityType())) {%>
                                	<div class="col-md-2">
                        		<div class="form-group">
                            			<label class="control-label">Weightage <span class="mandatory" style="color: red;" >*</span></label>
    					            <input type="number" class="form-control " name="Weightage" id="Weightage" required="required" min="0" max="100" value="<%=EditData[7] %>"  >
                      
                        		</div>
                    		</div>
                                
                    
                    		<%}} %>
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">From</label>
    					            <input class="form-control " name="ValidFrom" id="DateCompletion"  value="<%=sdf.format(EditData[1]) %>"  required="required" readonly="readonly" >
                        		</div>
                    		</div>
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">To</label>
    					            <input class="form-control " name="ValidTo" id="DateCompletion2"  value="<%=sdf.format(EditData[2]) %>"  required="required"  readonly="readonly">
    					            
                        		</div>
                    		</div>
                   
                    		</div>
                

            
      	
         
        <div class="form-group" align="center" <%if(!"0".equalsIgnoreCase(EditMain.getRevisionNo())) {%> style="margin-top: -50px; " <%} %> >
			
			
	 		<input type="button" class="btn btn-primary btn-sm submit " id="sub" value="SUBMIT" name="sub"  onclick="editfrmsubmit('editfrm');" > 
		   <button type="submit" class="btn btn-primary btn-sm back " id="sub" value="C" name="sub" onclick="SubmitBack()"  formaction="MilestoneActivityDetails.htm"> Back </button> 
			
		
		</div>
                              <input type="hidden" name="RevId"	value="<%=EditMain.getRevisionNo() %>" /> 
                              <input type="hidden" name="MilestoneActivityId"	value="<%=EditMain.getMilestoneActivityId() %>" /> 
                              <input type="hidden" name="ActivityId"	value="<%=EditMain.getActivityId() %>" /> 
                              <input type="hidden" name="ActivityType"	value="<%=EditMain.getActivityType() %>" /> 
                              <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 	</form>
        
     </div>`     
        




<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px ;margin-top: -40px;">
         
       
        </div>
        </div>
</div>
</div>
</div>  



   
   

   

  
<script>

function SubmitBack(){
	$('#EmpId').prop("required",false);
	$('#EmpId1').prop("required",false);
	$('#ActivityName').prop("required",false);
	
}
</script>




<script>
var from ="<%=sdf.format(EditData[1]) %>".split("-")
var dt = new Date(from[2], from[1] - 1, from[0])
var to ="<%=sdf.format(EditData[2]) %>".split("-")
var dt1 = new Date(to[2], to[1] - 1, to[0])
var mindate=dt;
$('#DateCompletion').on('change', function() {
    mindate=$('#DateCompletion').val();

    $('#DateCompletion2').daterangepicker({
    	"singleDatePicker" : true,
    	"linkedCalendars" : false,
    	"showCustomRangeLabel" : true,
    	"minDate" :mindate,
    	<%if(!"M".equalsIgnoreCase(EditMain.getActivityType())) {%>
    	"maxDate" : dt1,
    	<%}%>
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
	<%if(!"M".equalsIgnoreCase(EditMain.getActivityType())) {%>
	"maxDate" : dt1,
	<%}%>
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
$('#DateCompletion2').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :mindate,
	<%if(!"M".equalsIgnoreCase(EditMain.getActivityType())) {%>
	"maxDate" : dt1,
	<%}%>
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
	});

function SubmitBack(){
	$('#ActivityName').prop("required",false);
	$('#ActivityType').prop("required",false);
	
}		
	</script>  
	
<script type="text/javascript">




function editfrmsubmit(frmid){
	
	var activitytype= '<%=EditMain.getActivityType()%>' ;
	if(activitytype==='A'){
		var totalweightage = 0;
		var neweightage=parseInt($('#Weightage').val());
		var oldweightage= <%=EditData[7].toString()%>;
		
		$.ajax({
			type : "GET",
			url : "MilestoneTotalWeightage.htm",
			data : {
				MilestoneActivityId : '<%=EditMain.getMilestoneActivityId() %>' ,
				
			},
			datatype : 'json',
			success : function(result) {
				totalweightage = JSON.parse(result);				
				totalweightage = totalweightage - oldweightage;	
				totalweightage = totalweightage + neweightage;				
				if(totalweightage>100){
						var ret = alert('Total Weightage of Main Milestone Activity is '+totalweightage+',\n Update Other Milestones ');
				}
				else if(totalweightage <= 100){
					
					var confirmval=confirm('Total Weightage of Main Milestone Activity is '+totalweightage+',\n Are You Sure To Submit?');
					if(confirmval){
					$('#'+frmid).submit();
					}
				}
			}
		
			});	
		
		
		
		
		
	}else if(activitytype==='M' || activitytype==='B' || activitytype==='C'){
		var confirmval=confirm('Are You Sure To Submit?');
		if(confirmval){
		$('#'+frmid).submit();
		}
	}
		
		

}




</script>	



</body>
</html>