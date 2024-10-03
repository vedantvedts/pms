<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.Collector"%>
<%@page import="com.vts.pfms.requirements.model.IGIInterface"%>
<%@page import="com.vts.pfms.FormatConverter"%>

<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/Overall.css" var="StyleCSS" />
<link href="${StyleCSS}" rel="stylesheet" />
<spring:url value="/resources/js/excel.js" var="excel" />
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
<script src="${excel}"></script>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 14px;
}

.table thead tr, tbody tr {
	font-size: 14px;
}

body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}

#scrollButton {
	display: none; /* Hide the button by default */
	position: fixed;
	/* Fixed position to appear in the same place regardless of scrolling */
	bottom: 20px;
	right: 30px;
	z-index: 99; /* Ensure it appears above other elements */
	font-size: 18px;
	border: none;
	outline: none;
	background-color: #007bff;
	color: white;
	cursor: pointer;
	padding: 15px;
	border-radius: 4px;
}

h6 {
	text-decoration: none !important;
}

.multiselect-container>li>a>label {
	padding: 4px 20px 3px 20px;
}

.width {
	width: 210px !important;
}

.bootstrap-select {
	width: 400px !important;
}

#projectname {
	display: flex;
	align-items: center;
	justify-content: flex-start;
}

#div1 {
	display: flex;
	align-items: center;
	justify-content: center;
}

select:-webkit-scrollbar { /*For WebKit Browsers*/
	width: 0;
	height: 0;
}

.requirementid {
	border-radius: 5px;
	box-shadow: 10px 10px 5px lightgrey;
	margin: 1% 0% 3% 2%;
	padding: 5px;
	padding-bottom: 10px;
	display: inline-grid;
	width: 20%;
	background-color: antiquewhite;
	float: left;
	align-items: center;
	justify-content: center;
	overflow: auto;
	position: stickey;
}

.requirementid::-webkit-scrollbar {
	display: none;
}

.requirementid:hover {
	padding: 13px;
}

.viewbtn {
	width: 80%;
	margin-top: 4%;
	background: #055C9D;
	font-size: 15px;
	font-family: font-family : 'Muli';
	text-align: justify
}

.viewbtn:hover {
	cursor: pointer !important;
	background-color: #22c8e5 !important;
	border: none !important;
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 1rem 50px 0
		rgba(0, 0, 0, 0.19) !important;
}

.viewbtn1 {
	width: 100%;
	margin-top: 4%;
	background: #055C9D;
	font-size: 13px;
	font-family: font-family : 'Muli';
}

.viewbtn1:hover {
	background: green;
}

#container1 {
	background-color: white;
	display: inline-block;
	margin-left: 2%;
	margin-top: 1%;
	box-shadow: 8px 8px 5px lightgrey;
	max-width: 75%;
}

hr {
	margin-left: 0px !important;
	margin-bottom: 0px;
	!
	important;
}

.addreq {
	margin-left: -20%;
	margin-top: 5%;
}

#modalreqheader {
	background: #145374;
	height: 44px;
	display: flex;
	font-family: 'Muli';
	align-items: center;
	color: white;
}

#code {
	padding: 0px;
	width: 64%;
	font-size: 12px;
	margin-left: 2%;
	margin-bottom: 7%;
}

#addReqButton {
	display: flex;
	align-items: center;
	justify-content: center;
}

#modaal-A {
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	font-family: sans-serif;
}

#editreq {
	margin-bottom: 5px;
	display: flex;
	align-items: center;
	justify-content: flex-end;
}

#reqbtns {
	box-shadow: 2px 2px 2px;
	font-size: 15px;
	font-weight: 500;
}

#attachadd, #viewattach {
	margin-left: 1%;
	box-shadow: 2px 2px 2px black;
	font-size: 15px;
	font-weight: 500;
}

/* #reqName {
	font-size: 20px;
	background: #f5f5dc;
	font-family: inherit;
	color: darkslategrey;
	font-weight: 500;
	display: flex;
	border-radius: 8px;
	align-items: center;
	box-shadow: 4px 4px 4px gray;
} */

@
keyframes blinker { 20% {
	opacity: 0.65;
}

}
#attachmentadd, #attachmentaddedit {
	display: flex;
	margin-top: 2%;
}

#download, #deletedownload {
	box-shadow: 2px 2px 2px grey;
	margin-left: 1%;
	margin-top: 1%;
	margin-right: 1%;
}

#headerid, #headeridedit {
	margin-top: 1%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 1%;
}
/* #reqdiv{
    background-image: url(view/images/background.jpg);
    background-repeat: no-repeat;
    background-size: cover;

} */
#reqdiv:hover {
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 1rem 50px 0
		rgba(0, 0, 0, 0.19) !important;
}

#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px;
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}

#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px;
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}

.multiselect {
	padding: 4px 90px;
	background-color: white;
	border: 1px solid #ced4da;
	height: calc(2.25rem + 2px);
}
.modal-dialog-jump-pop {
	animation: jumpIn .5s ease;
}
.modal-dialog-jump {
	animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.3);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

.spnaclick{
padding:5px;
float: right;
}

table{
font-size: 1rem;
}
</style>
</head>
<body>
<% String DocIgiId = (String)request.getAttribute("DocIgiId");
List<IGIInterface>Intefaces = (List<IGIInterface>)request.getAttribute("Intefaces");
List<Object[]>parameters = (List<Object[]>)request.getAttribute("parameters");
%>


		<div class="container-fluid" style="" id="main">
			<div class="row">
				<div class="col-md-12">
					<div class="card shadow-nohover" style="margin-top: -0px;">
						<div class="row card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
							<div class="col-md-8" id="projecthead">
							
							</div>
							<div class="col-md-3" >
							<button class="btn btn-sm submit" style="margin-top: -2%;" onclick="showModal()">ADD INTERFACE TYPES</button>
							</div>
							<div class="col-md-1" id="addReqButton">
								<form action="#">
										<input type="hidden" name="DocIgiId" value="<%=DocIgiId%>">
									
										<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
										<button class="btn btn-info btn-sm  back ml-2"
										formaction="IgiDocumentDetails.htm" formmethod="get"
										formnovalidate="formnovalidate" style="margin-top: -3%;">BACK</button>
								</form>
								
								
							</div>	
								
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="requirementid" style="display:block;<%if(Intefaces!=null &&Intefaces.size()>9){%>height:500px;<%}%>">
		<%if(Intefaces!=null && Intefaces.size()>0) {
			List<IGIInterface>Intefaces1 = new ArrayList<>();
			Intefaces1=Intefaces.stream().filter(e->e.getParentId().toString().equalsIgnoreCase("0")).collect(Collectors.toList());
		%>
		
		<%
		int count=0;
		for(IGIInterface i:Intefaces1) {
			
		%>
		
				<div>	<button  type="button" class="btn btn-secondary  mt-2" style="width:84%;font-size: 13px;" id="<%=i.getInterfaceId() %>" value="<%=i.getInterfaceId()%>"  onclick="showDetails(<%=i.getInterfaceId()%>,'M')">
						 <%=(++count)+". "+ i.getInterfaceName() %>
					</button>&nbsp;
					<button style="width:10%;background: white;" class="btn btn-sm" onclick="openSubReqModal()" data-toggle="tooltip" data-placement="top" data-original-data="" title="">
						<i class="fa fa-plus-square" aria-hidden="true"></i>
					</button> </div>
		
		<%} %>
	
		<%} %>
			</div>
		<div class="container" id="container1">
		 <div class="row" id="row1">
					<div class="col-md-12">
								<div class="row mt-2">
									<div class=col-md-3>
										<label style="font-size: 1rem;   color: #07689f">
											Interface Name:<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class=col-md-6>
									<input class="form-control" type="text" id="interfaceName" name="interfaceName" maxlength="255" placeholder = "max 255 characters">
									</div>
									</div>
									</div>
									
		
					<div class="col-md-12">
								<div class="row mt-2">
									<div class=col-md-3>
										<label style="font-size: 1rem;   color: #07689f">
											Description:<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class=col-md-6>
										<div id="Editor" class="center"></div>
									<textarea style="display:none;"  id="description" name="Description" maxlength="1000" placeholder = "max 1000 characters"></textarea>
									</div>
									</div>
									</div>
		 
		 <div class="col-md-8 ml-2 mt-2">
		 <table class="table table-bordered" id="deliverablesTable2">
		 <thead>
		 <tr>
		
		 <th style="font-size: 1rem;   color: #07689f">Parameter</th>
		 <th style="font-size: 1rem;   color: #07689f">Parameter Value</th>
		 <th>									  <button type="button" class=" btn btn_add_deliverables2 " style=""> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
		 </th>
		 </tr>
		 </thead>
		 <tbody id="addTbody"> 
		 <% int parameterCount=0;%>
		
		 <tr class="tr_clone_deliverables2">
		 <td style="font-size: 1rem;text-align: left;">
			<select class="form-control selectdee specialselect parameter" id="parameterid" name="parameterid" style="width:100%;">
			<%for(Object[]obj:parameters){ %>
			<option value="<%=obj[0].toString()%>"><%=obj[1].toString() %></option>
			<%} %>
		 </select>
		 
		 </td>
		 
		 <td>
		 <input name="parametervalue" class="form-control" maxlength="255">
		 </td>
		 <td>
													<button type="button" class="btn btn_rem_deliverables2" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
 
 	 </td>
		 </tr>
		 
		 </tbody>
		 <tr style="boder:none;">
		 <td style="border:none;text-align:center;">
		 <button class="btn" onclick="addTablerow('add')"><i class="fa fa-plus" aria-hidden="true"></i></button>
		 </td>
		 </tr>
		 </table>
		 </div>
		</div>
		</div>
<div class="modal fade" id="exampleModalHeading" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="width:170%;margin-left: -35%;">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">SPECIFY INTERFACE TYPE</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
     <div align="center">

     </div>
   
     <div align="center">
       <form action="BasicInterFaceSubmit.htm" method="post">
     <table class="table">
      <thead>
        <tr>
            <th>Interface Code</th>
            <th>Interface Name</th>
            <th>Interface Description</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody id="InterfaceTable">
		<tr>
		<td style="width:10%;"><input type="text" name="InterfaceCode" class="form-control" maxlength="3" required placeholder="Max 3 Characters"> </td>
		<td><input type="text" name="InterfaceName" class="form-control" maxlength="250" required placeholder="Max 250 Characters"></td>
		<td style="width:50%;"><input type="text" name="InterfaceDescription" class="form-control" maxlength="1000" required placeholder="Max 1000 Characters"></td>
		<td><button type="button" class="btn btn-sm" id="plusbutton"><i class="fa fa-plus" aria-hidden="true"></i></button></td>
		</tr>
		</tbody>     
     </table>
     
     <div align="center">
     <button type="submit" class="btn btn-sm submit" onclick="return confirm('Are you sure to submit?')">ADD NEW</button>
     </div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
		<input type="hidden" name="DocIgiId" value="<%=DocIgiId%>">
	
      </form>
     </div>
    
      </div>
  
    </div>
  </div>
</div>	


		<!-- parameter Modal  -->
		
		<div class="modal fade" id="exampleModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-body">
      
		 <div class="col-md-12">
			<table class="table table-bordered">
			<thead>
			<tr>
			<th colspan="2">Parameter Name</th>
			
			</tr>
			</thead>
			<tbody id="parametersadd">
			<tr>
			<td><input type="text" class="form-control param"  maxlength="250"  placeholder="Max 250 Characters"></td>
			<td><button type="button" class="btn btn-sm" id="plusbuttonparam" onclick="addrow()"><i class="fa fa-plus" aria-hidden="true"></i></button></td>
			</tr>
			</tbody>
			</table>
		 </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="addParameter()">Save changes</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">

function showModal(){
	$('#exampleModalHeading').modal('show');
}
$('.specialselect').select2();
var specialcount = 1;

$("#deliverablesTable2").on('click','.btn_add_deliverables2' ,function() {
	$('.specialselect').select2("destroy");
	var $tr = $('.tr_clone_deliverables2').last();
	var $clone = $tr.clone();
	$tr.after($clone);
	var cl=$('.tr_clone_deliverables2').length;
	++specialcount;
	$clone.find(".specialselect.parameter").attr("id", 'parameterid' + specialcount);
	$('.specialselect').select2();
    $clone.find('.specialselect').select2('val', '');
});
$("#deliverablesTable2").on('click','.btn_rem_deliverables2' ,function() {
	
	var cl=$('.tr_clone_deliverables2').length;

	if(cl>1){
	
	   var $tr = $(this).closest('.tr_clone_deliverables2');
	  
	   var $clone = $tr.remove();
	   $tr.after($clone);
	   
	}
	   
	}); 

$("#plusbutton").click(function() {
    var newRow = `
        <tr>
		<td style="width:10%;"><input type="text" name="InterfaceCode" class="form-control" maxlength="3" required placeholder="Max 3 Characters"> </td>
		<td><input type="text" name="InterfaceName" class="form-control" maxlength="250" required placeholder="Max 250 Characters"></td>
		<td style="width:50%;"><input type="text" name="InterfaceDescription" class="form-control" maxlength="1000" required placeholder="Max 1000 Characters"></td>
            <td><button type="button" class="btn btn-sm"><i class="fa fa-minus"  aria-hidden="true"></i></button></td>
        </tr>
    `;
    $("#InterfaceTable").append(newRow);

    // Attach event handler for the newly added minus button
    $("#InterfaceTable tr:last-child td:last-child button").click(function() {
        $(this).closest("tr").remove();
    });
});
function addrow() {
    var newRow = `
        <tr>
		<td><input type="text" class="form-control param" maxlength="250"  placeholder="Max 250 Characters"></td>
            <td><button type="button" class="btn btn-sm"><i class="fa fa-minus"  aria-hidden="true"></i></button></td>
        </tr>
    `;
    $("#parametersadd").append(newRow);

    // Attach event handler for the newly added minus button
    $("#parametersadd tr:last-child td:last-child button").click(function() {
        $(this).closest("tr").remove();
    });
};
var tablerow = 	document.getElementById('parametersadd').innerHTML;
function addTablerow(a){
	
 $('#exampleModal').modal('show'); 

 $('#parametersadd').html(tablerow )

}

var parameters= [];

<%for(Object[]obj:parameters){%>
parameters.push('<%=obj[1].toString().toUpperCase()%>')
<%}%>
function addParameter(){
	
	
	  const inputs = document.querySelectorAll('.param');
      const values = [];
      // Loop through each input and get its value
      inputs.forEach(input => {
    	  if(!parameters.includes((input.value+"").trim().toUpperCase()) ){
         if((input.value+"").trim().length>0)
    		  values.push(input.value);
    	  }else{
    		  alert("Parameter already Exists!");
    		  return ;
    		  event.preventDefault();
    	  }
      });
      if(values.length==0){
    	  alert("Please Specify Parameter!")
      }
      else{
    	  
    	    $.ajax({
    	    	  type:'get',
    	    	  url:'AddParameters.htm',
    	    	  datatype:'json',
    	    	  data:{
    	    		  parameters:values+"",
    	    	  },
    	    	  success:function(result){
    	    		  
    	    		  var ajaxresult = JSON.parse(result);
    	    		  console.log(ajaxresult)
    	    		  
    	    		   const tbody = document.getElementById('addTbody');
      
      // Get the number of rows in the tbody
      var rowCount = tbody.getElementsByTagName('tr').length;
		console.log(rowCount)
		var html=""
		for(var i=0;i<ajaxresult.length;i++){
       var newRow = '<tr class="tr_clone_deliverables2">'+
		'<td ><input type="hidden" name="ParameterId" value="'+ajaxresult[i][0]+'">'+ajaxresult[i][1]+'</td>'+
		'<td><input name="parametervalue" class="form-control" maxlength="255"></td>'+
		'<td><button type="button" class="btn btn_rem_deliverables2" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px 0px;"></i></button></td>'
		'</tr>';
  html=html+newRow;
		}
 $("#addTbody").append(html); 
    	    	  }
    	    	  
    	      }) 
    	  
      }
  
      
     
      
      
      
	console.log(values)
	console.log(parameters)
	$('#exampleModal').modal('hide');
}
$(document).ready(function() {
	 $('#Editor').summernote({
		  width: 900,   //don't use px
		
		  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
		 
	      lineHeights: ['0.5']
	
	 });

$('#Editor').summernote({
   
    tabsize: 5,
    height: 1000
  });

  
});
</script>
</body>
</html>