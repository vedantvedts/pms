<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Project Requirements</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label{
font-weight: bold;
  font-size: 14px;
}
.table thead tr,tbody tr{
    font-size: 14px;
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
  width: 120px;
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
	width:210px !important;
}
.bootstrap-select {
  width: 400px !important;
}
#projectname{
display:flex;
align-items:center;
justify-content:flex-start;
}
#div1{
display:flex;
align-items:center;
justify-content:center;
}
select:-webkit-scrollbar { /*For WebKit Browsers*/
    width: 0;
    height: 0; 
}
.requirementid{
	border-radius:5px;
	box-shadow: 10px 10px 5px lightgrey;
    margin:1% 0% 3% 2%;
    padding: 5px;
    padding-bottom:10px;
     display: inline-grid;
    width: 10%;
  /*  height:300px; */

    background-color: antiquewhite;
    float: left;
 
    align-items: center;
    justify-content: center;
    overflow: auto;
    position:stickey;

}
.requirementid::-webkit-scrollbar{
display:none;
}
.viewbtn{

	width:100%;
    margin-top: 4%;
    background: #055C9D;
    font-size: 13px;
    font-family: font-family: 'Muli';
}
.viewbtn1:hover{
background: green;
}
.viewbtn1{

	width:100%;
    margin-top: 4%;
    background: #055C9D;
    font-size: 13px;
    font-family: font-family: 'Muli';
}
.viewbtn1:hover{
background: green;
}
#container{
background-color:white;
display:inline-block;
margin-left:2%;
margin-top:1%;
box-shadow:8px 8px 5px lightgrey;
}
hr{
margin-left:0px !important;
}
/*  #priority{
display:flex;
  align-items: center;
    justify-content: flex-end;
}

#prioritydata{
display:flex;
  align-items: center;
    justify-content: flex-start;
}  */
.addreq{
margin-left:-10%;
}
#modalreqheader{
background: #145374;
    height: 44px;
    display: flex;
    font-family: 'Muli';
    align-items: center;
    color: white;
}
</style>
</head>
<%
List<Object[]> ProjectIntiationList=(List<Object[]>)request.getAttribute("ProjectIntiationList"); 
 	String projectshortName=(String)request.getAttribute("projectshortName");
	String initiationid=(String)request.getAttribute("initiationid");
	String projectTitle=(String)request.getAttribute("projectTitle");
 	List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList"); 
 	List<Object[]>RequirementTypeList=(List<Object[]>)request.getAttribute("reqTypeList");
%>

<body style="background-color: white;">
<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	
	<div align="center" >
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center" >
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </div>
    
    
 <%} %>
<div id="reqmain" class="card-slider">
    <form class="form-inline"  method="POST" action="ProjectRequirement.htm">
  <div class="row W-100" style="width: 80%; margin-top: -0.5%;">
                                    <div class="col-md-2" id="div1">
                            		<label class="control-label" style="font-size:15px;color:#07689f ;">Project Name :</label>
                            		</div>
                            		<div class="col-md-2" style="margin-top: 3px;" id="projectname">
                              		<select class="form-control selectdee" id="project" required="required" name="project">
                              		<option disabled="true"  selected value="">Choose...</option>
                              		<%if(!ProjectIntiationList.isEmpty()) {
                                        for(Object[]obj:ProjectIntiationList){%>
    									<option    value="<%=obj[0]+"/"+obj[4]+"/"+obj[5]%>" <%if(obj[4].toString().equalsIgnoreCase(projectshortName)) {%>selected<%} %>><%=obj[4] %></option>
    									<%}} %>
  									</select>
  									</div>
  									
 
<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
 </div>
 </form>
  <div class="container-fluid" style="display:none;" id="main">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0px;">
				<div class="row card-header" style="background: #C4DDFF; box-shadow:2px 2px 2px grey;">
			     <div class="col-md-10" id="projecthead">
			     <h5 style="margin-left:1%;"> <%="Project" +" "+projectshortName+" "+ "Requirements List" %> </h5>
			     </div>
			     <div class="col-md-2">  <!-- <form action="" method="POST" id="ReqAdd"> -->
                   					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                   					<input type="hidden" name="projectshortName" value="<%=projectshortName %>" />
									<input type="hidden" name="IntiationId" value="<%=initiationid %>" />
									<button class="btn btn-success btn-sm" style="margin-top: -2%;" type="button" onclick='showdata()'>ADD REQUIREMENETS</button>
								<!-- 	</form> -->
									</div>
			     </div>
			     </div>
			     </div>
			     </div>
			     </div>
			    <%if((RequirementList!=null) &&(!RequirementList.isEmpty())){ %> 
<div class="requirementid" style="display:block;<%if(RequirementList.size()>9){%>height:500px;<%}%>">

<%int count=1;
for(Object []obj:RequirementList) {%>
<button type="button" class="btn btn-secondary <%if(count==RequirementList.size() ){%>viewbtn1<%}else {%>viewbtn<%} %>" id="" value="<%=obj[0]%>"><%=obj[1] %></button>
<%count++;} %>
</div>


<div class="container" id="container">
<div class="row" >
		<div class="col-md-12" id="reqdiv">
		<div class="card-body"  id="cardbody">
        			<div class="row">
        			<div class="col-md-10" style="" >
        			 <h5 style="font-size: 22px; color: #005086;width: fit-content ">Brief</h5>
        			 	<hr>
        			</div>
        			<div class="col-md-2" style="margin-bottom: 5px" id="editreq">
																
												
													</div>
        			
        			<div class="col-md-12" style="" >
        			 <p id="brief"  style="font-size: 18px;"></p>
        			<hr>
        			</div>
        			<div class="col-md-12">
        			<div class="row">
        			<div class="col-md-6" style="" >
        			<h5 style="font-size: 22px; color: #005086; ">Linked Requirements: </h5>
        			<span id="linked"  style="font-size: 18px;"></span>
        			
        			</div>
        			
        	 	<div class="col-md-5" style="" >
        			<div class="row">
        			<div class="col-md-3"><h5 style="font-size: 22px; color: #005086; " id="priority">Priority :</h5></div>
        			<p id="Prioritytext"  style="font-size: 18px;"></p>
        			</div>
        			</div> 
        			<hr>
        		</div>
        		<hr>
        		</div>
        		<div class="col-md-12" style="" >
        			 <h5 style="font-size: 22px; color: #005086;width: fit-content ">Description</h5>
        			 	<hr>
        			</div>
        			<div class="col-md-12" style="" >
        			<p id="description" style="font-size: 18px;">
        			</p>
        			<hr>
        			</div>
        		
        			</div>
        			
		</div>
		</div>
</div>
<%}else{ %>

<div class="row" id="message" style="display:none;">
<div class="col-md-12" style="height:150px;display:flex; align-items: center; justify-content: center;">
<label><h4 style="font-family: 'Muli';"><%-- No Requirement is there to show for <%=projectshortName %> --%></h4><hr></label>

</div>

</div>

<%} %>
</div>


 <!-- modal for add -->
 <form class="form-horizontal" role="form" action="ProjectRequirementAddSubmit.htm" method="POST" id="myform1" >
<div class="modal fade bd-example-modal-lg"  id="exampleModalLong"tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
  <div class="modal-dialog modal-lg" >
    <div class="modal-content addreq" style=" width:120%;" >
      <div class="modal-header" id="modalreqheader">
        <h5 class="modal-title" id="exampleModalLabel">Requirements</h5>
      </div>
      <div class="modal-body">
   		<div class="col-md-12">
   		<div class="row">
   		<div class="col-md-4" >
   		<label style="font-size: 17px;margin-top: 5%;  margin-left: 5%; color: #07689f ">Type of Requirements<span class="mandatory" style="color: red;">*</span></label>
   		</div>
   		<div class=col-md-3>
   				<select required="required" id="select" name="reqtype" class="form-control selectpicker" data-width="80%" data-live-search="true" style="margin-top:5%">
							<option disabled="disabled" value="" selected="selected">Choose..</option>
							<%if(!RequirementTypeList.isEmpty()){
							for(Object[] obj:RequirementTypeList){ %>
							<option value="<%=obj[0]+" "+obj[1]+" "+obj[3]%>"><%=obj[3]+"-"+obj[2]%></option>
							<%}}%>
							</select>
   		</div>
   		<div class=col-md-2>
   		<label style="font-size: 17px;margin-top: 7%;  margin-left: 0.1rem;color: #07689f">Priority<span class="mandatory" style="color: red;">*</span></label>
   		</div>
		<div class=col-md-3>
						<select required="required" id="select" name="priority" class="form-control selectpicker" data-width="80%" data-live-search="true" style="margin-top:5%">
							<option disabled="disabled" value="" selected="selected">Choose..</option>
							<option value="Low">Low</option>
							<option  value="Medium">Medium</option>
							<option  value="High">High</option>
							</select> 		
   		</div>
   		</div>
   		<div class="col-md-12">
   		<div class="row">
   		<div class="col-md-4">
   		<label style="font-size: 17px;margin-top: 5%; color: #07689f ">Linked Requirements<span class="mandatory" style="color: red;">*</span></label>
   		</div>
   		<div class="col-md-6" style="margin-top:1%;">
   								<div class="form-group">
						 
							<%if((RequirementList!=null) &&(!RequirementList.isEmpty())){%>
							<select class="form-control selectdee" name="linkedRequirements" id="linkedRequirements"  data-width="80%"data-live-search="true"   data-placeholder="Choose" multiple >
			
							<%for(Object[] obj:RequirementList){ %>
							<option value="<%=obj[1]%>"><%=obj[1]%></option>
							<%}%>
							</select>
							<%}else{%>
							<select name="linkedRequirements" id="linkedRequirements" data-width="80%" class="form-control">
       						 <option selected disabled>Choose...</option>
   									   </select>
						<%} %>
							
						</div>
									
   		</div>
   		</div>
   		</div>
   		
   		<div class=col-md-12 >
   		<div class="row">
   		<div class="col-md-4">
   		<label style="font-size: 17px;margin-top: 5%; color: #07689f; margin-left: 0.1rem">Requirement Brief<span class="mandatory" style="color: red;">*</span></label>
   		</div>
   			<div class="col-md-8" style="margin-top: 10px">
									<div class="form-group">
										<input type="text" name="reqbrief"class="form-control" id="reqbrief" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
									</div>
								</div>
   		</div></div>
   		<div class=col-md-12 >
        			<div class="row">
        			<div class="col-md-6"  >
      				  <label style="margin:0px ;font-size:17px;color: #07689f">Requirement Description:<span class="mandatory" style="color: red;">*</span></label>
        			</div></div></div>
        			<div class="col-md-12">
        			<div class="row">
        				<div class="col-md-12" id="textarea" style="">
									<div class="form-group">
										<textarea required="required" name="description" class="form-control"  id="descriptionadd" maxlength="4000"  rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
									</div>
								</div>
        			</div>
        			</div>
        			<input type="hidden" name="IntiationId" value="<%=initiationid %>" /> 
												<input type="hidden" name="projectshortName" value="<%=projectshortName %>" /> 
        										<div class="form-group" align="center" >
        										<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
												<button type="submit" class="btn btn-primary btn-sm submit" id="add" name="action" value="SUBMIT" onclick= "return reqCheck('myform1');">SUBMIT</button>
      
      </div>
    </div>
  </div>
</div>

</div>
</div>
</form>

<!-- modal for edit -->
 <form class="form-horizontal" role="form" action="ProjectRequirementAddSubmit.htm" method="POST" id="myform1" >
<div class="modal fade bd-example-modal-lg"  id="exampleModalLongedit"tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
  <div class="modal-dialog modal-lg" >
    <div class="modal-content addreq" style=" width:120%;" >
      <div class="modal-header" id="modalreqheader">
        <h5 class="modal-title" id="exampleModalLabel">Requirements</h5>
      </div>
      <div class="modal-body">
   		<div class="col-md-12">
   		<div class="row">
   		<div class="col-md-4" >
   		<label style="font-size: 17px;margin-top: 5%;  margin-left: 5%; color: #07689f ">Type of Requirements<span class="mandatory" style="color: red;">*</span></label>
   		</div>
   		<div class=col-md-3>
   				<select required="required" id="select" name="reqtypeedit" class="form-control selectpicker" data-width="80%" data-live-search="true" style="margin-top:5%">
							<option disabled="disabled" value="" selected="selected">Choose..</option>
							<%if(!RequirementTypeList.isEmpty()){
							for(Object[] obj:RequirementTypeList){ %>
							<option value="<%=obj[0]+" "+obj[1]+" "+obj[3]%>"><%=obj[3]+"-"+obj[2]%></option>
							<%}} %>
							</select>
   		</div>
   		<div class=col-md-2>
   		<label style="font-size: 17px;margin-top: 7%;  margin-left: 0.1rem;color: #07689f">Priority<span class="mandatory" style="color: red;">*</span></label>
   		</div>
		<div class=col-md-3>
						<select required="required" id="select" name="priorityedit" class="form-control selectpicker" data-width="80%" data-live-search="true" style="margin-top:5%">
							<option disabled="disabled" value="" selected="selected">Choose..</option>
							<option value="Low">Low</option>
							<option  value="Medium">Medium</option>
							<option  value="High">High</option>
							</select> 		
   		</div>
   		</div>
   		<div class="col-md-12">
   		<div class="row">
   		<div class="col-md-4">
   		<label style="font-size: 17px;margin-top: 5%; color: #07689f ">Linked Requirements<span class="mandatory" style="color: red;">*</span></label>
   		</div>
   		<div class="col-md-6" style="margin-top:1%;">
   								<div class="form-group">
						 <select class="form-control selectdee" name="linkedRequirementsedit" id="linkedRequirementsedit"  data-width="80%"data-live-search="true"   data-placeholder="Choose" multiple >
			
							<%if((RequirementList!=null) &&(!RequirementList.isEmpty())){%>
							<%for(Object[] obj:RequirementList){ %>
							<option value="<%=obj[1]%>"><%=obj[1]%></option>
							<%}}%>
					
							</select>
						</div>
									
   		</div>
   		</div>
   		</div>
   		
   		<div class=col-md-12 >
   		<div class="row">
   		<div class="col-md-4">
   		<label style="font-size: 17px;margin-top: 5%; color: #07689f; margin-left: 0.1rem">Requirement Brief<span class="mandatory" style="color: red;">*</span></label>
   		</div>
   			<div class="col-md-8" style="margin-top: 10px">
									<div class="form-group">
										<input type="text" name="reqbriefedit"class="form-control" id="reqbriefedit" maxlength="255" required="required" placeholder="Maximum 250 Chararcters">
									</div>
								</div>
   		</div></div>
   		<div class=col-md-12 >
        			<div class="row">
        			<div class="col-md-6"  >
      				  <label style="margin:0px ;font-size:17px;color: #07689f">Requirement Description:<span class="mandatory" style="color: red;">*</span></label>
        			</div></div></div>
        			<div class="col-md-12">
        			<div class="row">
        				<div class="col-md-12" id="textarea" style="">
									<div class="form-group">
										<textarea required="required" name="descriptionedit" class="form-control"  id="descriptionedit" maxlength="4000"  rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
									</div>
								</div>
        			</div>
        			</div>
        			<input type="hidden" name="IntiationId" value="<%=initiationid %>" /> 
												<input type="hidden" name="projectshortName" value="<%=projectshortName %>" /> 
        										<div class="form-group" align="center" >
        										<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
												<button type="submit" class="btn btn-primary btn-sm submit" id="add" name="action" value="SUBMIT" onclick= "return reqCheck('myform1');">SUBMIT</button>
      
      </div>
    </div>
  </div>
</div>

</div>
</div>
</form>




<script>
$(document).ready(function() {
	   $('#project').on('change', function() {
		   var temp=$(this).children("option:selected").val();
		   $('#submit').click(); 
	   });
	});
	<%if(projectshortName!=null){%>
$(document).ajaxComplete(function(){
	$('#main').css("display", "inline-block");
	$('#main').css("margin-top", "0.5%");
	$('#message').css("display","block");

});



	$('.viewbtn').click(function(){
		$('.viewbtn1').css("background","#055C9D");
		$('.viewbtn').css("background","#055C9D");
		$(this).css("background","green");
		
		var value=$(this).val();
		console.log(value);
		
		$.ajax({
			type:'GET',
			url:'RequirementJsonValue.htm',
			datatype:'json',
			data:{
				inititationReqId:value
			},
		success:function(result){
			 var ajaxresult=JSON.parse(result); 
			console.log(ajaxresult[1]);
			console.log(ajaxresult[2]);
			console.log(ajaxresult[3]);
			console.log(ajaxresult[4]);
			$('#brief').html(ajaxresult[2]);
			$('#linked').html(ajaxresult[6]);
			$('#Prioritytext').html(ajaxresult[5]);
			$('#description').html(ajaxresult[3]);
			
			$('#editreq').html('<button type="button" title="EDIT" class="btn btn-warning " onclick="edit()" name="action" value="'+ajaxresult[7] +'"id="reqbtn2" ><i class="fa fa-pencil" aria-hidden="true" style="color:green; font-size: 10px; float:right;"></i></button>');

			
			
			
		}
		})
	});
<%}%>
</script>
<script type="text/javascript">
function reqCheck(frmid){

	var description=$('#descriptionadd').val();
	var reqbrief=$('#reqbrief').val();
	
	
	console.log(description.length)

	if(description===null||description===""||reqbrief===null||reqbrief===""){
		window.alert('Please fill all the fields');
	}else if
		(description.length>4000){
			var extra=description.length-4000;
			window.alert('Description exceed 4000 characters, '+extra+'characters are extra')
			return false;
		} 
	else{

	if(window.confirm('Are you sure to save?')){
		document.getElementById(frmid).submit(); 
	}else{
		event.preventDefault();
		return false;
	}
	}
}
<%if((RequirementList!=null) &&(!RequirementList.isEmpty())){%>
$(document).ready(function(){
$('.viewbtn1').click();
});

$('.viewbtn1').click(function(){
	$('.viewbtn').css("background","#055C9D");
	$(this).css("background","green");
	
	var value=$(this).val();
	console.log(value);
	
	$.ajax({
		type:'GET',
		url:'RequirementJsonValue.htm',
		datatype:'json',
		data:{
			inititationReqId:value
		},
	success:function(result){
		 var ajaxresult=JSON.parse(result); 
		console.log(ajaxresult[1]);
		console.log(ajaxresult[2]);
		console.log(ajaxresult[3]);
		console.log(ajaxresult[4]);
		$('#brief').html(ajaxresult[2]);
		$('#linked').html(ajaxresult[6]);
		$('#Prioritytext').html(ajaxresult[5]);
		$('#description').html(ajaxresult[3]);
		
		$('#editreq').html('<button type="button" title="EDIT" class="btn btn-warning " onclick="edit()" name="action" value="'+ajaxresult[7] +'"id="reqbtn2" ><i class="fa fa-pencil" aria-hidden="true" style="color:green; font-size: 10px; float:right;"></i></button>');
		
		
	}
	})
});
<%}%>
function showdata(){

    $('#exampleModalLong').modal('show');
}


function edit(){
	
	var value=$('#reqbtn2').val();
	
	console.log(value);
	$.ajax({
		type:'GET',
		url:'RequirementJsonValue.htm',
		datatype:'json',
		data:{
			inititationReqId:value
		},
	success:function(result){
		 var ajaxresult=JSON.parse(result); 
		 console.log(ajaxresult);
		 
		 
		console.log(ajaxresult[1]);
		console.log(ajaxresult[2]);
		console.log(ajaxresult[3]);
		console.log(ajaxresult[4]);
		

		
		
		
	}
	})
 	$('#exampleModalLongedit').modal('show'); 
}

</script>
</body>
</html>