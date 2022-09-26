<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>

<title> TCC  ADD</title>
<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}
.card b{
	font-size: 20px;
}

</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("EmployeeList");
String Pfmstccid = (String)request.getAttribute("Pfmstccid");
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







    <div class="container">
    
<div class="row" style="">

<div class="col-md-12">

 <div class="card shadow-nohover" >
<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;margin-top: ">
        
                    <b class="text-white">Technology Council Committee Add</b>
           
        </div>
        
        <div class="card-body">
        <form action="TechnicalCommitteeCreate.htm" method="POST" name="myfrm" id="myfrm">
                <div class="row">
                
   
                    <div class="col-md-2 ">
                        <div class="form-group">
                            <label class="control-label">From Date</label>
       <input  class="form-control form-control"  data-date-format="dd/mm/yyyy" id="startdate" name="Fromdate"  required="required"  style="margin-bottom: -10px; margin-top: -5px;" >
         
                        </div>
                    </div>
                    
                    
                    <div class="col-md-4 ">
                        <div class="form-group">
                            <label class="control-label">Chairperson</label>
                              <select class="custom-select" id="ChairMain" required="required" name="ChairMain" style="margin-top: -5px"> 
    <option disabled="true"  selected value="">Choose...</option>
    <% for (Object[] obj : EmployeeList) {%>
<option value="<%=obj[0]%>"><%=obj[1]%> (<%=obj[2] %>) </option>
<%} %>
  </select>
                        </div>
                    </div>
                   
                   
         <div class="col-md-4">
                        <div class="form-group">
                            <label class="control-label">Member Secretary</label>
    <select class="custom-select" id="secretary" required="required" name="Secretary" style="margin-top: -5px">
    <option disabled="true"  selected value="">Choose...</option>
    <% for (Object[] obj : EmployeeList) {%>
<option value="<%=obj[0]%>"><%=obj[1]%> (<%=obj[2] %>)</option>
<%} %>
  </select>
                        </div>
                    </div>            
                </div>

            
      		<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" style="margin-top: 30px;">
													<thead>  
												<tr id="Memberrow0" ><th >Member Name</th><th><i class="btn btn-sm fa fa-plus" style="color: green;"  onclick="MemberAdd()"></i></th></tr>
													
													<input type="hidden"  id="MemberAdd" value="0" />
													<tr id="Memberrow0">
			<td ><select class="form-control "name="Member" id="Member0" required="required" style=" font-weight: bold; text-align-last: left; width: 500px;" data-live-search="true" data-container="body">
																
	          <option disabled="true"  selected value="">Choose...</option>
			    <% for (Object[] obj : EmployeeList) {%>
     <option value="<%=obj[0]%>"><%=obj[1]%> (<%=obj[2] %>)</option>
    <%} %>					
</select>
</td>									
                                                       
														
													
					 <td><i class="btn btn-sm fa fa-minus" style="color: red;" id="MemberMinus0" onclick="Memberremove(this)" ></i></td>								
													</tr>
													</thead>
													</table>
      
      
         
        <div class="form-group" align="center">

 <input type="submit" class="btn btn-primary btn-sm submit " onclick="Add(myfrm)" value="SUBMIT"> 

 <% if(ses1==null || ! ses1.equalsIgnoreCase( "No Active Technical Council Committee Found, Add New Committee ")){ %> 
<a href="PresentTechnicalCommittee.htm" class="btn btn-primary btn-sm submit back">BACK</a>
   <%} %> 
 


</div>

<input type="hidden" name="pfmstccid" value="<%=Pfmstccid %>">

	<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> 
 	</form>
        
     </div>   
        

<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px ">
         
       
        </div>
        </div>
</div>
</div>


  

	
<script type="text/javascript">









function MemberAdd(){
	
	var colnerow=$('#myTable20 tr:last').attr('id');
	  

	  var MemberRowId=colnerow.split("Memberrow");
	  var MemberId=Number(MemberRowId[1])+1
	  var row = $("#myTable20 tr").last().clone().find('textarea').val('').end();
	 
      row.attr('id', 'Memberrow'+MemberId );
      
     
      row.find('#Member' + MemberRowId[1]).attr('id', 'Member' +MemberId);
  
      row.find('#MemberMinus' + MemberRowId[1]).attr('id', 'MemberMinus' +MemberId);  
    
      $("#myTable20").append(row);
	
     
	
	 $("#MemberAdd").val(PaymentRowId); 
 }
 
 
function Memberremove(elem){
	 
	  var id = $(elem).attr("id");
	  var Membersplitid=id.split("MemberMinus");
	  var Memberremoveid="#Memberrow"+Membersplitid[1];

	
		
		 $(Memberremoveid).remove();
		  

			$('#Member' + Membersplitid[0]).prop("required", false);

	}
 
 
 

 
function Add(myfrm){

    
    var fieldvalues = $("select[name='Member']")
  .map(function(){return $(this).val();}).get();
    
    var $ChairMain = $("#ChairMain").val();
    var $secretary = $("#secretary").val();
    
	if($ChairMain==$secretary){
		 alert("Chairperson and Secretary Should Not Be The Same Person ");	   
		 event.preventDefault();
			return false;
	}
    
    for (var i = 0; i < fieldvalues.length; i++) {
    	
    	if($ChairMain==fieldvalues[i]){
    		 alert("Chairperson Should Not Be A Member ");	   
    		 event.preventDefault();
    			return false;
    	}
    	
    	if($secretary==fieldvalues[i]){
   		 alert("Secretary Should Not Be A Member ");	   
   		 event.preventDefault();
   			return false;
   	}

    } 


  return true;
}

 
 
 
 
$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :new Date(),
	"startDate" : new Date(),

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
var aYearFromNow = new Date();
aYearFromNow.setFullYear(aYearFromNow.getFullYear() + 1);
 
$('#enddate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :new Date(),
	"startDate" :aYearFromNow,

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
 
 
$('#startdate').change(function () {
    var startDate = document.getElementById("startdate").value;

   var dateMomentObject = moment(startDate, "DD-MM-YYYY"); // 1st argument - string, 2nd argument - format
   var dateObject = dateMomentObject.toDate();
  
 
   
   var newdateMomentObject =moment(startDate, "DD-MM-YYYY");
   
   var newdateObject = newdateMomentObject.toDate();
    newdateObject = newdateObject.setFullYear(newdateObject.getFullYear() + 1)

//var dateTime2 = moment(newdateObject).format("DD-MM-YYYY");

   
   $('#enddate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" :dateObject,
		"startDate" :newdateObject,

		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});


        //document.getElementById("enddate").value = dateTime2;
    
});
 
 
</script>
<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
</body>
</html>