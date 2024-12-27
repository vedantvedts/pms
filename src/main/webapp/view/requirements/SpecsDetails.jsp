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
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />



<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />

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
	width: 15%;
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
.note-editing-area{

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
	justify-content: end;
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

.note-editing-area{


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
String click = (String)request.getAttribute("click"); 
List<Object[]>RequirementList = (List<Object[]>)request.getAttribute("RequirementList");
List<Object[]>specsList = (List<Object[]>)request.getAttribute("specsList");
List<Object[]>SpecMasterList = (List<Object[]>)request.getAttribute("SpecMasterList");
List<Object[]>RequirementLists = new ArrayList<>();
ObjectMapper objectMapper = new ObjectMapper();
String jsonArray = null;;
if(RequirementList!=null && RequirementList.size()>0){
	RequirementLists=RequirementList.stream().filter(e->e[15]!=null && !e[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
	 jsonArray = objectMapper.writeValueAsString(RequirementLists);
}

String reqInitiationId = (String) request.getAttribute("reqInitiationId");
List<Object[]>productTreeList = (List<Object[]>)request.getAttribute("productTreeList");

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
								<div class="col-md-6" id="projecthead">
									<h5 style="margin-left: 1%;">
										Specification Details
									</h5>
								</div>
								<div class="col-md-6" id="addReqButton">
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
										
										<button class="btn btn-success btn-sm submit" style="margin-top: -3%;" type="button" onclick="showMoadal()">ADD HEADINGS</button>
		<!-- 								<button class="btn btn-success btn-sm submit" style="margin-top: -3%;"
											type="button" onclick='addData()' data-toggle="tooltip"
											data-placement="top" data-original-data=""
											title="ADD SPECIFICATION DETAILS">ADD SPECIFICATION DETAILS</button> -->
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
					<div class="requirementid" style="display:block; height:70vh;overflow: auto ;<%if(specsList==null || specsList.size()==0){%> display:none;<%}%>">
					
					<%if(specsList!=null && specsList.size()>0) {
						int count=0;
						List<Object[]>specsListMain=specsList.stream().filter(e->e[7].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
						for(Object[]obj:specsListMain){
					
					%>
					
					<div  style="display: flex; align-items: center; margin-top: 8px; width: 100%">
					<button style="text-decoration: underline" type="button" class="btn btn-secondary  mt-2" onclick="addData(<%=obj[0].toString() %>,<%=obj[8].toString() %>)" id="btn<%=obj[0].toString()%>"><%=(++count)+" . "+obj[1].toString() %> &nbsp;&nbsp;<i class="fa fa-plus-square" aria-hidden="true"></i> </button>
					<button class="btn btn-sm bg-transparent" type="button" onclick="deleteSpc(<%=obj[0].toString()%>)">
							<i class="fa fa-trash-o" aria-hidden="true" style="color:red;"></i>
					</button>
					</div>
									<%
					List<Object[]>specsListSub = new ArrayList<>();
					specsListSub=specsList.stream().filter(e->e[7].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());
					%>
					<%if(specsListSub!=null && specsListSub.size()>0) {
					int subcount=0;
					%>
					<div class="subdivs" id="div<%=obj[0]%>" style="display:none;">
					<%for(Object[]obj1:specsListSub) {%>
					<div style="display: flex; align-items: center; margin-top: 8px; width: 90%">
					<button type="button" class="btn btn-secondary viewbtn mt-2" onclick="showDetails(<%=obj1[0].toString() %>)" id="btn<%=obj1[0].toString()%>"><%=count+"."+(++subcount)+". "+obj1[1].toString() %> </button>
					
					<button class="btn btn-sm bg-transparent" type="button" onclick="deleteSpc(<%=obj1[0].toString()%>)">
					<i class="fa fa-trash-o" aria-hidden="true" style="color:red;"></i>
					</button>
					</div>
					<%} %>
					</div>
					
					
					<%} %>
					<%}}else{ %>
					<button  type="button" class="btn btn-secondary viewbtn mt-2" style="width:100%" >
							No Data Available
					</button>
					<%} %>
					</div>
						
						
			<div class="container" id="container" style="<%if(specsList==null || specsList.size()==0){%> display:none;<%}%>">
			<form action="specificationAdd.htm" method="POST">
			<div class="row" id="row1">
			
				<div class="col-md-12" id="reqdiv" style="background: white;">
					<div class="card-body" id="cardbody">
						
							<div class="row" id ="specsDiv" style="display: none;">
								<div class="col-md-3">
									<label id="specsId" style="font-size: 17px; margin-top: 5%; color: #07689f">
											
										</label>
										
								</div>
								
							</div>
								<div class="row">
							
								
								<div class="col-md-3" >
									<label style="font-size: 17px; margin-top: 5%; color: #07689f">
											Linked Requirements
										</label>
								</div>
									<div class="col-md-6" style="margin-top: 1%;">
										<div class="form-group">
											<%if ((RequirementLists != null) && (!RequirementLists.isEmpty())) {%>
												<select  class="form-control selectdee" name="linkedRequirements" id="linkedRequirements" data-width="80%" data-live-search="true" multiple onchange="getReqDetails()">
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
								<div class="col-md-9" id="Editor">
			   			

<!-- 								<textarea required="required" name="description" class="form-control" id="descriptionadd" maxlength="4000" rows="5" cols="53" placeholder="Maximum 4000 Chararcters"></textarea>
 -->								</div>
    								<textarea name="description" style="display: none;"  id="ConclusionDetails"></textarea>	
								</div>
								<div class="row mt-2">
								 
								<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Specification Parameter: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-2">
								<input type="text" class="form-control" name="specParameter" id="specParameter" required="required">
								</div>
								
								<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%;float:right; color: #07689f">Specification Unit: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-2">
								<input type="text" class="form-control" name="specUnit" id="specUnit" required="required">
								</div>
								
								<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%;float:right; color: #07689f">Specification Value: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-2">
								<input type="text" class="form-control" name="specValue" id="specValue" required="required">
								</div>
								
								</div>
									<%if(productTreeMainId.equalsIgnoreCase("0")){ %>
								
								<div class="row">
									<div class="col-md-2">
										<label style="font-size: 17px; margin-top: 5%; color: #07689f">
											Linked subsystem
										</label>
									</div>
									<div class="col-md-7" style="margin-top: 1%;">
										<div class="form-group">
											<%if ((productTreeList != null) && (!productTreeList.isEmpty())) {%>
												<select class="form-control selectdee" name="LinkedSub" id="LinkedSub" data-width="80%" data-live-search="true" multiple >
													<option value="" disabled="disabled">---Choose----</option>
													<%for (Object[] obj : productTreeList) {%>
														<option value="<%=obj[0]%>"><%=obj[1]+" "+obj[2] %></option>
													<%}%>
												</select>
											<%} else {%>
												<input class="form-control" name="" id="LinkedSub"  readonly placeholder="No para specified for Project">
											<%} %>
										</div>
									</div>
								</div>
							
								<%} %>
								
							
							
								<div align="center" class="mt-2">
								<button id="submitbtn" type="submit" class="btn btn-sm submit" onclick="submitData()" name="action" value="add">SUBMIT </button>
								<button id="editbtn" type="submit" class="btn btn-sm edit" style="display:none;" onclick="submitData()" name="action" value="update">UPDATE </button>
								<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> 
								<input type="hidden" name="specParentId" id="specParentId">
								<input type="hidden" name="MainId" id="MainId">
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
								<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Specification Id :</label>
								</div>
								<div class="col-md-8">
								
								<p style="font-size: 1rem;font-weight: bold;margin-top: 2%" id="specName"></p>
								</div>
								<div class="col-md-1">
								<button class="btn btn-sm bg-transparent" id="btnedit" onclick="edit(this)"><i class="fa fa-pencil-square-o fa-lg" style="color:orange" aria-hidden="true"></i></button>
								</div>
								</div>
									<hr>
								<div class="row">
								<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Linked Requirements :</label>
								</div>
								<div class="col-md-8">
								<p style="font-size: 1rem;font-weight: bold;margin-top: 2%" id="linkedreq"></p>
								</div>
								</div>
									<hr>
								<div class="row">
								<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Specification Parameter :</label>
								</div>
								<div class="col-md-8">
								<p style="font-size: 1rem;font-weight: bold;margin-top: 2%" id="specparam"></p>
								</div>
								</div>
										<hr>
								<div class="row">
									<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Specification Value :</label>
								</div>
								<div class="col-md-8">
								<p style="font-size: 1rem;font-weight: bold;margin-top: 2%" id="specValues"></p>
								</div>															
								</div>
									<hr>
								<div class="row">
									<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Specification Unit :</label>
								</div>
								<div class="col-md-8">
								<p style="font-size: 1rem;font-weight: bold;margin-top: 2%" id="specUnits"></p>
								</div>								
								</div>
									<hr>
								<div class="row">
								<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Description :</label>
								</div>
								
								<div class="col-md-8">
								<p style="font-size: 1rem;font-weight: bold;margin-top: 2%" id="DescriptionDetails"></p>
								</div>
								</div>
									<%if(productTreeMainId.equalsIgnoreCase("0")){ %>
								<hr>
								<div class="row">
								<div class="col-md-2" style="margin-top: 1%">
										<h5
											style="font-size: 20px; color: #005086; width: fit-content">Linked SubSystem:
										</h5>
									</div>

									<div class="col-md-10" style="margin-top: 1%;">
										<p id="subsytemshow" style="font-size: 18px;"></p>
									</div>
								</div>
								<%} %>
								</div>
							</div>
				</div>
				
				
				<!-- Modal for Headings -->
				<div class="modal fade" id="exampleModalHeading" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="width:150%;margin-left: -35%;">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">SPECIFICATIONS</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
     <div align="center">
     <form action="SpecificationSelectSubmit.htm" method="post">
     <%List<Object[]>SpecMasterListsub= new ArrayList<>();
     if(SpecMasterList!=null && !SpecMasterList.isEmpty()){
    	 SpecMasterListsub=SpecMasterList.stream().filter(i->i[2]!=null && i[2].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
     }
     %>
     <div class="row">
     <%for(Object[]obj:SpecMasterListsub) {%>
     <div class="col-md-4">
     		       		<input name="specValue" type="checkbox" value="<%=obj[0].toString()+"/"+obj[1].toString()+"/"+obj[3].toString()%>">
						       		<input name="SpecNames" type="hidden" value="<%=obj[1].toString()%>">
						       		<span class="ml-1 mt-2 text-primary" style="font-weight: 600"><%=obj[1].toString() %></span><br>
     </div>
     <%} %>
     
     </div>
   
     <div align="center" class="mt-2 mb-2">
     <button type="submit" class="btn btn-sm submit" onclick="setValue()">SUBMIT</button>
     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	<input type="hidden" name="projectId" value="<%=projectId%>">
	<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
		<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
			<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">	
     </div>
       </form>
     </div>
   
     <div align="center">
       <form action="MainSpecificationAdd.htm" method="post">
     <table class="table">
      <thead>
        <tr>
            <th>Specification Code</th>
            <th>Specification Name</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody id="specificationTable">
		<tr>
		<td style="width:30%;"><input type="text" name="specificationCode" class="form-control" maxlength="5" required placeholder="Max 5 Characters"> </td>
		<td><input type="text" name="SpecificationName" class="form-control" maxlength="250" required placeholder="Max 250 Characters"></td>
		<td><button type="button" class="btn btn-sm" id="plusbutton"><i class="fa fa-plus" aria-hidden="true"></i></button></td>
		</tr>
		</tbody>     
     </table>
     
     <div align="center">
     <button type="submit" class="btn btn-sm submit">ADD NEW</button>
     </div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	<input type="hidden" name="projectId" value="<%=projectId%>">
	<input type="hidden" name="initiationId" value="<%=initiationId%>"> 
		<input type="hidden" name="productTreeMainId" value="<%=productTreeMainId%>">
			<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>">	
      </form>
     </div>
    
      </div>
  
    </div>
  </div>
</div>
				
				<button onclick="scrollToTop()" id="scrollButton"
			data-toggle="tooltip" data-placement="top" data-original-data=""
			title="Go to Top">
			<i class="fa fa-arrow-up" aria-hidden="true"></i>
		</button>	
<script>
var jsObjectLists=[];
<%if(reqInitiationId!=null){%>
$.ajax({
	type:'GET',
	url:'RequirementListsForSpecification.htm',
	datatype:'json',
	data:{
		reqInitiationId:<%=reqInitiationId%>,
	},
	 success : function(result){
		 jsObjectLists = JSON.parse(result);
	
		
	 }
})


var editvalue="add";


<%}%>

var productreelist = [];

<%if(productTreeList!= null &&  productTreeList.size()>0){ 
	for(Object[]obj:productTreeList){
	%>
	productreelist.push(['<%= obj[0].toString() %>', '<%= obj[2].toString() %>']);

<%}}%>
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
		var jsObjectList = jsObjectLists;

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
		 if(Data.SpecValue!==undefined){
				
			 $('#specValues').html(Data.SpecValue);
		 }else{
			 $('#specValues').html("-");
		 }
	var Linkesubsystem = "";
			
			var LinkedSubArray = [];
			
			if(Data.LinkedSubSystem===undefined){
				LinkedSubArray = [];
			}else{
				LinkedSubArray = Data.LinkedSubSystem.split(",");
			}
			
			console.log(LinkedSubArray.length)
			if(LinkedSubArray.length==0){
				$('#subsytemshow').html("-");	
			
			}else{
				
				for(var i =0;i<LinkedSubArray.length;i++){
					for(var j=0;j< productreelist.length;j++){
						
						if(LinkedSubArray[i]===productreelist[j][0]){
							Linkesubsystem = Linkesubsystem+productreelist[j][1]+'<br>'
						}
						
					}
				}
				
				$('#subsytemshow').html(Linkesubsystem);	
			}
		 
		 
		 }
	 })
 }

 function addData(a,b){
	 $('.viewbtn').css("background","#055C9D");
		/*$('#btn'+a).css("background","green"); */
	 $('#row1').show();
	 $('#row2').hide();
	 $('#linkedRequirements').val(" ").trigger('change');
	 $('#descriptionadd').val("");
	 $('#specParameter').val("");
	 $('#specUnit').val("");
	 $('#submitbtn').show();
	 $('#editbtn').hide();
	 $('#SpecsIdedit').val("");
	 $('#MainId').val(b);
	 $('#specValue').val("");
	 $('#specParentId').val(a);
	 $('#specsDiv').hide();
	 $('#Editor').summernote('code', "");
	 editvalue="add";
	/*  $('.subdivs').hide(); */
	 $('#div' + a).toggle();
	
 }
 
 
 function edit(ele){
	 editvalue="edit";
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
			 /* $('#descriptionadd').val(Data.Description); */
			 $('#Editor').summernote('code', Data.Description);
			 console.log(Data.LinkedSubSystem)
			 if(Data.LinkedSubSystem!==undefined){
			 var LinkedSubSystem = Data.LinkedSubSystem.split(",");
			 $('#LinkedSub').val(LinkedSubSystem).trigger('change');
			 }
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
			 if(Data.SpecValue!==undefined){
				 $('#specValue').val(Data.SpecValue);
			 }else{
				 $('#specValue').val("");
			 }
			 $('#submitbtn').hide();
			 $('#editbtn').show();
			 $('#specsDiv').show();
			 $('#specsId').html("Specification Id :"+Data.SpecificationName);
			 $('#SpecsIdedit').val(value);
		 }
	 })
	 
 }

	$(document).ready(function() {
		var value=<%=SpecsId.toString()%>;
		var value1='<%=specsList!=null && specsList.size()>0?specsList.get(0)[0]:"0" %>';
		if(value!==0){
			showDetails(value)
		}else{
			$('#btn'+value1).click();
		console.log("value1--"+value1)
		}
	});
	
	
	/* 	  $('#Editor').summernote({
			  width: 800,   //don't use px
			
			  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
			 
		      lineHeights: ['0.5']
		
		 });  */

	$('#Editor').summernote({
		width: 800,
	     toolbar: [
             // Adding font-size, font-family, and font-color options along with other features
             ['style', ['bold', 'italic', 'underline', 'clear']],
             ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
             ['insert', ['picture', 'table']],  // 'picture' for image upload, 'table' for table insertion
             ['para', ['ul', 'ol', 'paragraph']],
             ['height', ['height']]
         ],
         fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],  // Font size options
         fontNames: ['Arial', 'Courier New', 'Helvetica', 'Times New Roman', 'Verdana'],  // Font family options
         buttons: {
             // Custom superscript and subscript buttons
             superscript: function() {
                 return $.summernote.ui.button({
                     contents: '<sup>S</sup>',
                     tooltip: 'Superscript',
                     click: function() {
                         document.execCommand('superscript');
                     }
                 }).render();
             },
             subscript: function() {
                 return $.summernote.ui.button({
                     contents: '<sub>S</sub>',
                     tooltip: 'Subscript',
                     click: function() {
                         document.execCommand('subscript');
                     }
                 }).render();
             }
         },
 
	   	height:300
	    });
	    

	
	
	
	function getReqDetails(){
		if(editvalue==="add"){
		  var selectedOptions=$('#linkedRequirements').val()
		
		   var html="";
	   for (var j = 0; j < selectedOptions.length; j++) {
			 for(var i=0;i<jsObjectLists.length;i++){
				 if(jsObjectLists[i][0]==selectedOptions[j]){
					 var datas=jsObjectLists[i][4];
					   console.log(datas+" "+typeof datas)
					 html=html+(j+1)+"."+jsObjectLists[i][4]+'<br>'
				 }
			 }
			     
		} 
	   $('#Editor').summernote('code', html);
	   $('textarea[name=description]').val(html);
		}
	}

	
	window.onscroll = function() { scrollFunction() };
		function scrollFunction() {
    var scrollButton = document.getElementById("scrollButton");
    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
      scrollButton.style.display = "block";
    } else {
      scrollButton.style.display = "none";
    }
  	}
	// Scroll to the top when the button is clicked
	function scrollToTop(){
document.body.scrollTop = 0; // For Safari
document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE, and Opera
	}
	
	
	function submitData(){
		console.log($('#Editor').summernote('code'))
		   $('textarea[name=description]').val($('#Editor').summernote('code'));
		   if(confirm('Are you sure to submit?')){
			   
		   }else{
			   event.preventDefault();
			   return false;
		   }
	}
	
	function deleteSpc(a){
		console.log("a"+a)
		if(confirm('Are you sure to delete?')){
			$.ajax({
				type:'GET',
				url:'deleteInitiationSpe.htm',
				datatype:'json',
				data:{
					SpecsId:a,
				},
				success:function(result){
					
					var ajaxresult = JSON.parse(result);
					console.log(ajaxresult)
					if(Number(ajaxresult)>0){
						alert("Specification Deleted Successfully!")
					}
					window.location.reload();
				}
				
			})
			
		}else{
			event.preventDefault();
			return false;
		}
	}
	
	
	function showMoadal(){
		$('#exampleModalHeading').modal('show');
	}
	
	
	  $("#plusbutton").click(function() {
          var newRow = `
              <tr>
                  <td><input type="text" name="specificationCode" class="form-control" maxlength="5" required placeholder="Max 5 Characters"></td>
                  <td><input type="text" name="SpecificationName" class="form-control" maxlength="250" required placeholder="Max 250 Characters"></td>
                  <td><button type="button" class="btn btn-sm"><i class="fa fa-minus" aria-hidden="true"></i></button></td>
              </tr>
          `;
          $("#specificationTable").append(newRow);

          // Attach event handler for the newly added minus button
          $("#specificationTable tr:last-child td:last-child button").click(function() {
              $(this).closest("tr").remove();
          });
      });
	  
	  <%
		 if(click!=null || (specsList==null || specsList.size()==0)){
		 %>
		showMoadal();
		
		<%}%> 
		
		
		function setValue(){
			  var checkedValues = [];
		        $('input[name="specValue"]:checked').each(function() {
		            checkedValues.push($(this).val());
		        });
		        if(checkedValues.length>0){
		        	if(confirm('Are you sure to submit?')){
		        		
		        	}else{
		        		event.preventDefault();
		        		return false;
		        	}
		        }else{
		        	alert("Please select any of the specification!");
		        	event.preventDefault();
	        		return false;
		        }
		 
		}
		
</script>				
</body>
</html>