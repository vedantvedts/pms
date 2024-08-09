 <%@page import="com.vts.pfms.requirements.model.RequirementInitiation"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.util.stream.Collectors"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Specification Details</title>
<jsp:include page="../static/header.jsp"></jsp:include>
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
.multiselect-view>li>a>label {
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
	width: 10%;
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
	width: 100%;
	margin-top: 4%;
	background: #055C9D;
	font-size: 13px;
	font-family: font-family : 'Muli';
}

/* .viewbtn:hover {
	cursor: pointer !important;
	background-color: #22c8e5 !important;
	border: none !important;
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0
		rgba(0, 0, 0, 0.19) !important;
} */

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

#view {
	background-color: white;
	display: inline-block;
	margin-left: 2%;
	margin-top: 1%;
	box-shadow: 8px 8px 5px lightgrey;
	max-width: 85%;
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

#reqName {
	font-size: 20px;
	background: #f5f5dc;
	font-family: inherit;
	color: darkslategrey;
	font-weight: 500;
	display: flex;
	border-radius: 8px;
	align-items: center;
	box-shadow: 4px 4px 4px gray;
}
#reqName1 {
	font-size: 20px;
	background: #f5f5dc;
	font-family: inherit;
	color: darkslategrey;
	font-weight: 500;
	display: flex;
	border-radius: 8px;
	align-items: center;
	box-shadow: 4px 4px 4px gray;
	margin-bottom: 20px;
}

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

#reqdiv:hover {
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0
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





#container {
    background-color: white;
    display: inline-block;
    margin-left: 2%;
    margin-top: 1%;
    box-shadow: 8px 8px 5px lightgrey;
    max-width: 80%;
}
</style>
</head>
<body>
<%

String initiationId = (String)request.getAttribute("initiationId");
String projectId = (String)request.getAttribute("projectId");
String productTreeMainId = (String)request.getAttribute("productTreeMainId");
String SpecsInitiationId = (String)request.getAttribute("SpecsInitiationId"); 
String SpecsId = (String)request.getAttribute("SpecsId"); 
List<Object[]>RequirementList = (List<Object[]>)request.getAttribute("RequirementList");
List<Object[]>specsList = (List<Object[]>)request.getAttribute("specsList");
List<Object[]>RequirementLists = new ArrayList<>();
ObjectMapper objectMapper = new ObjectMapper();
String jsonArray = null;;
if(RequirementList!=null && RequirementList.size()>0){
	RequirementLists=RequirementList.stream().filter(e->e[15]!=null && !e[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
	 jsonArray = objectMapper.writeValueAsString(RequirementLists);
}


%>
	<%String ses=(String)request.getParameter("result"); 
 	  String ses1=(String)request.getParameter("resultfail");
	  if(ses1!=null){
	%>
	<div align="center">

		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</div>
	<%} %>	


	<div id="reqmain" class="card-slider">
			<div class="container-fluid" style="" id="main">
				<div class="row">
					<div class="col-md-12">
						<div class="card shadow-nohover" style="margin-top: -0px;">
							<div class="row card-header"
								style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
								<div class="col-md-9" id="projecthead">
									<h5 style="margin-left: 1%;">
										Specification Details
									</h5>
								</div>
								<div class="col-md-3" id="addReqButton">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
									<input type="hidden" name="projectId" value="<%=projectId%>">
									<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
									<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
									<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">	
									<form action="#">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
										<input type="hidden" name="projectId" value="<%=projectId%>">
										<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
										<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
										<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">	
										<button class="btn btn-success btn-sm submit" style="margin-top: -3%;"
											type="button" onclick='addData()' data-toggle="tooltip"
											data-placement="top" data-original-data=""
											title="ADD SPECIFICATION DETAILS">ADD SPECIFICATION DETAILS</button>
										<button class="btn btn-info btn-sm  back ml-2"
											formaction="ProjectSpecificationDetails.htm" formmethod="get"
											formnovalidate="formnovalidate" style="margin-top: -3%;">BACK</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>
					<div class="requirementid" style="display:block;">
					
					<%if(specsList!=null && specsList.size()>0) {
				int count=0;
						for(Object[]obj:specsList){
					
					%>
					
					<button type="button" class="btn btn-secondary viewbtn mt-2" onclick="showDetails(<%=obj[0].toString()%>)" id="btn<%=obj[0].toString()%>"><%=obj[1].toString() %> </button>
					<%}}else{ %>
					<button  type="button" class="btn btn-secondary viewbtn mt-2" style="width:100%" >
							No Data Available
					</button>
					<%} %>
					</div>
						
						
			<div class="container" id="container" >
			<form action="specificationAdd.htm" method="POST">
			<div class="row" id="row1">
			
				<div class="col-md-12" id="reqdiv" style="background: white;">
					<div class="card-body" id="cardbody">
						
							
								<div class="row">
							
								
								<div class="col-md-3" >
									<label style="font-size: 17px; margin-top: 5%; color: #07689f">
											Linked Requirements
										</label>
								</div>
									<div class="col-md-6" style="margin-top: 1%;">
										<div class="form-group">
											<%if ((RequirementLists != null) && (!RequirementLists.isEmpty())) {%>
												<select  class="form-control selectdee" name="linkedRequirements" id="linkedRequirements" data-width="80%" data-live-search="true" multiple onchange="">
													<option value="" disabled="disabled">---Choose----</option>
													<%for (Object[] obj : RequirementLists) {%>
														<option value="<%=obj[0]%>"><%=obj[1]%></option>
													<%}%>
												</select>
											<%} else {%>
												<input class="form-control" name="" id="linkedRequirements"  readonly placeholder="No requirements specified for this  Project">
											<%} %>
										</div>
									</div>
								</div>
								
									<div class="row">
								<div class="col-md-3">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Description: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-9">
								<textarea required="required" name="description" class="form-control" id="descriptionadd" maxlength="4000" rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
								</div>
								</div>
								<div class="row mt-2"> 
								<div class="col-md-3">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Specification Parameter: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-2">
								<input type="text" class="form-control" name="specParameter" id="specParameter" required="required">
								</div>
								<div class="col-md-3">
								<label style="font-size: 17px; margin-top: 5%;float:right; color: #07689f">Specification Unit: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-2">
								<input type="text" class="form-control" name="specUnit" id="specUnit" required="required">
								</div>
								</div>
								
								
							
							
								<div align="center" class="mt-2">
								<button id="submitbtn" type="submit" class="btn btn-sm submit" onclick="return confirm('Are you sure to submit?')" name="action" value="add">SUBMIT </button>
								<button id="editbtn" type="submit" class="btn btn-sm edit" style="display:none;" onclick="return confirm('Are you sure to submit?')" name="action" value="update">UPDATE </button>
								<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> 
								 <input type="hidden" name="projectId" value="<%=projectId%>"> <input
								type="hidden" name="initiationId" value="<%=initiationId%>"> <input
								type="hidden" name="productTreeMainId"
								value="<%=productTreeMainId%>"> <input type="hidden"
								name="SpecsInitiationId" value="<%=SpecsInitiationId%>">
								<input type="hidden" id="SpecsIdedit" name="SpecsId" >
							</div>
								
								
								</div>
								</div>
								</div>
								</form>	
								
								<div id="row2" style="display: none;">
								
								<div class="row">
								<div class="col-md-3">
								<label style="font-size: 17px;float: right; margin-top: 5%; color: #07689f">Specification Id :</label>
								</div>
								<div class="col-md-8">
								
								<p style="font-size: 1rem;font-weight: bold;margin-top: 2%" id="specName"></p>
								</div>
								<div class="col-md-1">
								<button class="btn btn-sm bg-transparent" id="btnedit" onclick="edit(this)"><i class="fa fa-pencil-square-o fa-lg" style="color:orange" aria-hidden="true"></i></button>
								</div>
								</div>
								
								<div class="row">
								<div class="col-md-3">
								<label style="font-size: 17px;float: right; margin-top: 5%; color: #07689f">Linked Requirements :</label>
								</div>
								<div class="col-md-8">
								<p style="font-size: 1rem;font-weight: bold;margin-top: 2%" id="linkedreq"></p>
								</div>
								</div>
								
								<div class="row">
								<div class="col-md-3">
								<label style="font-size: 17px;float: right; margin-top: 5%; color: #07689f">Specification Parameter :</label>
								</div>
								<div class="col-md-8">
								<p style="font-size: 1rem;font-weight: bold;margin-top: 2%" id="specparam"></p>
								</div>
								</div>
								
								<div class="row">
									<div class="col-md-3">
								<label style="font-size: 17px;float: right; margin-top: 5%; color: #07689f">Specification Unit :</label>
								</div>
								<div class="col-md-8">
								<p style="font-size: 1rem;font-weight: bold;margin-top: 2%" id="specUnits"></p>
								</div>								
								</div>
								<div class="row">
								<div class="col-md-3">
								<label style="font-size: 17px;float: right; margin-top: 5%; color: #07689f">Description :</label>
								</div>
								
								<div class="col-md-8">
								<p style="font-size: 1rem;font-weight: bold;margin-top: 2%" id="DescriptionDetails"></p>
								</div>
								</div>
								
								</div>
							</div>
				</div>
				
				
<script>
 function showDetails(value){
	 $('#row1').hide();
	 $('#row2').show();
	 $('#btnedit').val(value);
		$('.viewbtn').css("background","#055C9D");
		$('#btn'+value).css("background","green");
	 $.ajax({
		 type:'GET',
		 url:'getSpecificationData.htm',
		 data:{
			 SpecsId:value
		 },
		 datatype:'json',
		 success : function(result){
			 var Data = JSON.parse(result);
		$('#specName').html(Data.SpecificationName);
		$('#DescriptionDetails').html(Data.Description);
		var LinkedRequirements = Data.LinkedRequirement.split(",");
		var tempArray=[];
		var jsObjectList = JSON.parse('<%= jsonArray %>');
		console.log("jsObjectList"+jsObjectList)
		if(jsObjectList!=null){
		for(var i =0;i<jsObjectList.length;i++){
			
			if(LinkedRequirements.includes(jsObjectList[i][0]+"")){
				tempArray.push(jsObjectList[i][1]);
			}
		}
		}
		var temp =tempArray.toString();
		
		if(temp.length>0){
			$('#linkedreq').html(temp);
		}else{
			$('#linkedreq').html("No Requirements are linked !");
		}
		
		 if(Data.SpecsParameter!==undefined){
			 console.log(Data.SpecsParameter)
			 $('#specparam').html(Data.SpecsParameter);
		 }else{
			 $('#specparam').html("-");
		 }
		 
		 if(Data.SpecsUnit!==undefined){
			 console.log(Data.SpecsUnit)
			 $('#specUnits').html(Data.SpecsUnit);
		 }else{
			 $('#specUnits').html("-");
		 }
		
		
		 }
	 })
 }

 function addData(){
	 $('#row1').show();
	 $('#row2').hide();
	 $('#linkedRequirements').val(" ").trigger('change');
	 $('#descriptionadd').val("");
	 $('#specParameter').val("");
	 $('#specUnit').val("");
	 $('#submitbtn').show();
	 $('#editbtn').hide();
	 $('#SpecsIdedit').val("");
 }
 
 
 function edit(ele){
	 $('#row1').show();
	 $('#row2').hide();
	 var value=ele.value;
	 $.ajax({
		 type:'GET',
		 url:'getSpecificationData.htm',
		 data:{
			 SpecsId:value
		 },
		 datatype:'json',
		 success : function(result){
			 var Data = JSON.parse(result);
			 
			 var LinkedRequirements = Data.LinkedRequirement.split(",");
		     $('#linkedRequirements').val(LinkedRequirements).trigger('change');
			 $('#descriptionadd').val(Data.Description);
			 if(Data.SpecsParameter!==undefined){
				 $('#specParameter').val(Data.SpecsParameter);
			 }else{
				 $('#specParameter').val("");
			 }
			 
			 if(Data.SpecsUnit!==undefined){
				 $('#specUnit').val(Data.SpecsUnit);
			 }else{
				 $('#specUnit').val("");
			 }
			 $('#submitbtn').hide();
			 $('#editbtn').show();
			 $('#SpecsIdedit').val(value);
		 }
	 })
	 
 }
 
	$(document).ready(function() {
		var value=<%=SpecsId.toString()%>;
		if(value!==0){
		showDetails(value)
		}
	});
</script>				
</body>
</html>