<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>

<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/content.css" var="contentCss" />

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
	margin:0px 2%;
}

.fa-thumbs-up {
  font-family: FontAwesome, 'Quicksand', Quicksand, sans-serif;
}

.form-inline{

display: inline-block;
}


.form-check-input:checked ~ .form-check-label::before {
    color: #fff;
    border-color: #7B1FA2;
    background-color: red;
}
.inputx{
width:50%;
display:inline;
}
.fa-plus{
color:green;
}
.fa-minus{
color:red;
}
.fa-pencil{
color:blue;
}
.fa-times{
color:red;
}
input[type=checkbox] {
	accent-color: green;
}
.spansub{
    width: 60px;
    height: 24px;
    font-size: 10px;
    font-weight: bold;
    text-align: justify;
    display: inline-block;
}
#ModalReq::after{
  content: "Other Requirements";
  display: none;
  opacity:0;
}
#ModalReq:hover::after{
display:inline-block;
animation: fade-in 1s ease forwards;
}

@keyframes fade-in {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
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
.modal-dialog-jump {
  animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.2);
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

</style>
</head>
<body>
<%
String initiationid=(String)request.getAttribute("initiationid");
String project=(String)request.getAttribute("project");
String[]projectDetails=project.split("/");
List<Object[]>AppendixList= (List<Object[]>)request.getAttribute("AppendixList");
List<Object[]>AcronymsList= (List<Object[]>)request.getAttribute("AcronymsList");
List<Object[]>PerformanceList= (List<Object[]>)request.getAttribute("PerformanceList");

%>
</head>
<body>
<nav class="navbar navbar-light bg-light justify-content-between"  style="margin-top: -1%">
		<a class="navbar-brand">
		<b style="color: #585858; font-size:19px;font-weight: bold;text-align: left; float:left" ><span style="color:#31708f">APPENDIX SECTION </span> <span style="color:#31708f;font-size: 19px"> </span></b>
		</a>
		<form action="#">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="project" value="<%=project%>">
		<input type="hidden" name="initiationid" value="<%=initiationid%>"> 
     	<button class="btn btn-info btn-sm  back ml-2 mt-1" formaction="ProjectOverAllRequirement.htm" formmethod="get" formnovalidate="formnovalidate" style="float:right;">BACK</button>
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
<div class="container-fluid">
<div class="row">
<div class="col-md-6">
<div  class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
<%-- <%if(!AppendixList.isEmpty()) {
	int i=0;
for(Object[]obj:AppendixList){
%>

	 <div class="panel panel-info" style="margin: 10px 10px 0px 10px;" id="<%="div"+obj[0].toString()%>">
      	<div class="panel-heading ">
        <h4 class="panel-title" id="showpanel<%=obj[0].toString()%>">
       
        <button class="btn btn-sm  bg-transparent" type="button"
												id="btns<%=obj[0].toString()%>"
												style="width: 44px; height: 24px; font-size: 10px; font-weight: bold; text-align: justify; display: inline-block;"
												onclick="showSpan(<%=obj[0].toString()%>)"
												data-toggle="tooltip" data-placement="right"
												data-original-data="" title=""
												data-original-title="EDIT">
												<i class="fa fa-lg fa-pencil" aria-hidden="true"
													style="color: blue;"></i>
											</button>
        </h4>
         <form action="ReqAppendixEdit.htm" action="post">
        <h4 id="hidepanel<%=obj[0].toString()%>" style="display:none;">
       
		<span class="ml-2" style="font-size:14px;font-weight: bold"><%=i +" ."%></span>&nbsp;<input class="form-control inputx" type="text" name="Appendix" value="<%=obj[1].toString()%>"style="padding:0px; line-height: 0px;" maxlength="255 characters" required>        
       
       <button type="submit" class="btn btn-sm btn-info spansub" onclick="return confirm('Are you sure to update?')">update</button>
       
        <button class="btn bg-transparent" type="button"onclick="hideUpdateSpan(<%=obj[0].toString()%>)">
			<i class="fa fa-times" aria-hidden="true"></i>
		</button>
        </h4>
        </form>
        </div>
        </div>

	<%}} %> --%>
		
		<!-- panel 1 -->
		<div class="panel panel-info" style="margin: 10px 10px 0px 10px;">
		<div class="panel-heading ">
		<h4 class="panel-title" >
		<span class="ml-2" style="font-size:16px">1.&nbsp;Acronyms and Definition</span>  
	<%if(AcronymsList.size()>0) {%>	<button class="btn btn-sm " style="float:right;margin-top: -1%; margin-left: 1%;" onclick="showTable1()"><i class="fa fa-eye text-primary" aria-hidden="true"></i></button><%} %>
		<button class="btn btn-sm btn-info spansub" style="float:right" onclick="showAcronyms()">UPLOAD</button>
		</h4>
		</div>
		</div>
		
		<!-- panel 2-->
		<div class="panel panel-info" style="margin: 10px 10px 0px 10px;">
		<div class="panel-heading ">
		<h4 class="panel-title" >
		<span class="ml-2" style="font-size:16px">2.&nbsp;Key performance parameters/key system attributes</span>  
		<%if(PerformanceList.size()>0){ %>		<button class="btn btn-sm " style="float:right;margin-top: -1%; margin-left: 1%;" onclick="showTable2()"><i class="fa fa-eye text-primary" aria-hidden="true"></i></button><%} %>
		<button class="btn btn-sm btn-info spansub" style="float:right" onclick="showperformance()">UPLOAD</button>
		</h4>
		</div>
		</div>
		
		<!-- panel 3  -->
		<div class="panel panel-info" style="margin: 10px 10px 0px 10px;">
		<div class="panel-heading ">
		<h4 class="panel-title" >
		<span class="ml-2" style="font-size:16px">3.&nbsp;Requirements Traceability Matrices</span>  
		</h4>
		</div>
		</div>
		
		<!-- panel 4  -->
		<div class="panel panel-info" style="margin: 10px 10px 0px 10px;">
		<div class="panel-heading ">
		<h4 class="panel-title" >
		<span class="ml-2" style="font-size:16px" >4.&nbsp;Test Verification Matrices</span>  
				<button class="btn btn-sm btn-info spansub" style="float:right" onclick="showTest()">UPLOAD</button>
		</h4>
		</div>
		</div>
		
<%-- 	         	    <div class="row" id="inputDiv" style="">  
   					<div class="col-md-11 mt-1"  align="left"  style="margin-left: 10px;">
					<div class="panel panel-info">
					<div class="panel-heading">
					<form action="ReqAppendixAdd.htm" method="POST">
	    			<h4 class="panel-title">
	    			<input type="hidden" name="project" value="<%=project%>">
	    			<input type="hidden" name="initiationid" value="<%=initiationid%>">
	    			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	           		<input class="form-control inputx" id="inputx" name="AppendixName" style="padding:0px; line-height: 0px;" maxlength="255 characters" required="required">
	           		<button class="btn btn-success btn-sm ml-3" type="submit"  onclick="return confirm('Are you sure to submit?')"
	           		style="width:44px; height: 24px; font-size:10px; font-weight: bold; text-align: justify;display:inline-block;"
	           		>ADD</button>
	       		    </h4>
	       		    </form>
	        		</div>
	        		</div>
	        		</div>
	        		</div> --%>
</div>
</div>
<div class="col-md-6 mt-2 bg-light" <%if(AcronymsList.size()==0 && PerformanceList.size()==0) {%> style="display:none;"<%}else{ %> style="display:block;" <%} %>>
<div class="row p-2">
<div class="col-md-12" id="myDiv1" >
<div  class="bg-info text-light p-2 mb-2" align="center" style="font-size:16px">Acronyms and Definition </div>
<table class="table table-bordered mt-2" id="myTable1" >
<thead>
<tr>
<td style="width:10%;text-align: center;">SN</td>
<td style="width:40%;text-align: center;">Acronyms</td>
<td style="width:50%;text-align: center;">Definition</td>
</tr>
</thead>
<tbody>
<%if(AcronymsList.size()>0){
int row=0;
	for(Object[] obj:AcronymsList){
	%>
<tr>
<td style="text-align: center"><%=++row  %> </td>
<td style="text-align: center"><%=obj[1].toString() %></td>
<td style="text-align: justify;padding-left: 5px;"><%=obj[2].toString() %></td>
</tr>
<%}} %>
</tbody>
</table>
</div>

<!-- table2 -->
<div class="col-md-12" id="myDiv2" >
<div class="bg-info text-light p-2 mb-2" align="center" style="font-size:16px">Key performance parameters/key system attributes </div>
<table class="table table-bordered mt-2" id="myTable2" >
<thead>
<tr>
<td style="width:10%;text-align: center;">SN</td>
<td style="width:40%;text-align: center;">Key MOE's</td>
<td style="width:50%;text-align: center;">Values</td>
</tr>
</thead>
<tbody>
<%if(PerformanceList.size()>0){
int row=0;
	for(Object[] obj:PerformanceList){
	%>
<tr>
<td style="text-align: center"><%=++row  %> </td>
<td style="text-align: center"><%=obj[1].toString() %></td>
<td style="text-align: justify;padding-left: 5px;"><%=obj[2].toString() %></td>
</tr>
<%}} %>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
<!--  AcronymsModal -->
<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id="AcronymsModal" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
   <div class="modal-header" id="ModalHeader" style="background: #055C9D;color:white;">
        <h5 class="modal-title" >Upload Acronyms</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="text-light">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <form action="AccronymsExcelUpload.htm" method="post" enctype="multipart/form-data">
      <div class="row">
      <div class="col-md-8">
      <input class="form-control" type="file" id="excel_fileA" name="filenameA" required="required" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
      </div>
      <div class="col-md-4">
	<span class="text-primary">Download format</span>
	<button class="btn btn-sm" type="submit" name="Action" value="GenerateExcel" formaction="AccronymsExcelUpload.htm" formmethod="post" formnovalidate="formnovalidate" ><i class="fa fa-file-excel-o" aria-hidden="true" style="color: green;"></i></button>
	</div>
    <input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
    <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
	<input type="hidden" name="project" value="<%=project%>">
	<input type="hidden" name="initiationid" value="<%=initiationid%>"> 					
      </div>
      <div align="center" class="mt-2" id="uploadDivA" style="display:none;">
	<button type="submit" name="Action" value="UploadExcel" class="btn btn-sm btn-info"  onclick="return confirm('Are you sure to submit?')">Upload</button>
      </div>
      </form>
      </div>
    </div>
  </div>
</div>


<!-- System Atrributes -->
<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id="PerformanceModal" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
   <div class="modal-header" id="ModalHeader" style="background: #055C9D;color:white;">
        <h5 class="modal-title" >Upload Performance parameters</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="text-light">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <form action="PerformanceExcelUpload.htm" method="post" enctype="multipart/form-data">
      <div class="row">
      <div class="col-md-8">
      <input class="form-control" type="file" id="excel_fileB" name="filenameB" required="required" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
      </div>
      <div class="col-md-4">
	<span class="text-primary">Download format</span>
	<button class="btn btn-sm" type="submit" name="Action" value="GenerateExcel" formaction="PerformanceExcelUpload.htm" formmethod="post" formnovalidate="formnovalidate" ><i class="fa fa-file-excel-o" aria-hidden="true" style="color: green;"></i></button>
	</div>
    <input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
    <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
	<input type="hidden" name="project" value="<%=project%>">
	<input type="hidden" name="initiationid" value="<%=initiationid%>"> 					
	
      </div>
      <div align="center" class="mt-2" id="uploadDivB" style="display:none;">
	<button type="submit" name="Action" value="UploadExcel" class="btn btn-sm btn-info"  onclick="return confirm('Are you sure to submit?')">Upload</button>
      </div>
      </form>
      </div>
    </div>
  </div>
</div>


<!-- Test Verification Modal -->
<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id="tesModal" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
   <div class="modal-header" id="ModalHeader" style="background: #055C9D;color:white;">
       <h5 class="modal-title" >Upload Test Verification Matrices</h5>
       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
         <span aria-hidden="true" class="text-light">&times;</span>
       </button>
      </div>
     <div class="modal-body">
     <form action="TestVerificationUpload.htm" method="post" enctype="multipart/form-data">
     <div class="row">
     <div class="col-md-12">
     <input class="form-control" type="file" id="excel_fileC" name="filenameC" required="required" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" required="required">
    </div>
  
    <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
	<input type="hidden" name="project" value="<%=project%>">
	<input type="hidden" name="initiationid" value="<%=initiationid%>"> 					
	
     </div>
     <div align="center" class="mt-2" id="uploadDivC" >
	  <input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" />
	<button type="submit" name="Action" value="UploadExcel" class="btn btn-sm btn-info"  onclick="return confirm('Are you sure to submit?')">Upload</button>
      </div>
      </form>
      </div>
    </div>
  </div>
</div>

<script>
$(function () {
	$('[data-toggle="tooltip"]').tooltip()
	})
	
	function showSpan(a){
	$('#showpanel'+a).hide();
	$('#hidepanel'+a).show();
	}
	
	function hideUpdateSpan(a){
		$('#showpanel'+a).show();
		$('#hidepanel'+a).hide();
	}
	
	function showAcronyms(){
		$('#AcronymsModal').modal('show');
	}
	
	function showperformance(){
		$('#PerformanceModal').modal('show');
	}
	
	function showTest(){
		$('#tesModal').modal('show');
	}
	
	$(document).ready(function(){
		 $("#myTable1").DataTable({
		 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 5
	});
	});
	$(document).ready(function(){
		 $("#myTable2").DataTable({
		 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 5
	});
	});
	
	function showTable1(){
		$('#myDiv1').show();
		$('#myDiv2').hide();
		
	}
	
	function showTable2(){
		$('#myDiv2').show();
		$('#myDiv1').hide();
	}
	const excel_fileA = document.getElementById('excel_fileA');
	const excel_fileB = document.getElementById('excel_fileB');
	
	excel_fileA.addEventListener('change', (event) => {
		var reader = new FileReader();
		reader.readAsArrayBuffer(event.target.files[0]);
		reader.onload = function (event){
			var data = new Uint8Array(reader.result);
			var work_book = XLSX.read(data, {type:'array'});
			
			var sheet_name = work_book.SheetNames;
			
	    	var sheet_data = XLSX.utils.sheet_to_json(work_book.Sheets[sheet_name[0]],{header:1});

	    	
	    	const code = [];
	    	
	    	const gname= [];
	    	
	    	const acronymsList = [];
	    	
	     	var checkExcel = 0;
	     	
	     	if(sheet_data.length > 0){
	     		
	     		for (var row =0; row <sheet_data.length;row++){
	     			
	     			for(var cell = 0;cell<3;cell++){
	     			
	     				if(row==0){
    						if(cell==1 && "Acronyms" != sheet_data[row][cell]){  checkExcel++;}
            				if(cell==2 && "Definition" != sheet_data[row][cell]){  checkExcel++;}
            			}
	     			}
	     		}
	     	}
	     	 var AcronymsListJs = [<%int i=0; for (Object[] obj:AcronymsList ){%>  "<%= obj[1]%>" <%= i+1 <AcronymsList.size() ? ",":"" %><%}%>]; 
	     	
	     	 var AcronymsDetails = [];
	     	 
	     	 for (var i in sheet_data){
	     		AcronymsDetails.push(sheet_data[i][1]+"");
	     	 }
	     	 const duplicates = AcronymsDetails.filter((item,index) =>  index !== AcronymsDetails.indexOf(item));
	     	 
	     	 const indexval = [];
	     	 
	     	 for (var i in duplicates){
	     		 indexval.push(AcronymsDetails.indexOf(duplicates[i]));
	     	 }
	     	 var dbDuplicates = [];
	     	 
	     		AcronymsListJs.forEach(function (item){
	     		var isPresent = AcronymsDetails.indexOf(item);
	     		if(isPresent !== -1){
	     			dbDuplicates.push(isPresent);
	     			}
	     		});
	     	 
	     	 
	     	var msg="";
	     	if(checkExcel>0){
	     		msg="Upload Acronym Document!";
	     		alert(msg);
	     		excel_fileA.value="";
	     	}else{
	     		$('#uploadDivA').show();	
	     	}
		}
		
		
	});
	
	excel_fileB.addEventListener('change', (event) => {
		
		var reader = new FileReader();
		reader.readAsArrayBuffer(event.target.files[0]);
		reader.onload = function (event){
			var data = new Uint8Array(reader.result);
			var work_book = XLSX.read(data, {type:'array'});
			
			var sheet_name = work_book.SheetNames;
			
	    	var sheet_data = XLSX.utils.sheet_to_json(work_book.Sheets[sheet_name[0]],{header:1});

	    	
	    	const code = [];
	    	
	    	const gname= [];
	    	
	    	const acronymsList = [];
	    	
	     	var checkExcel = 0;
	     	
	     	if(sheet_data.length > 0){
	     		
	     		for (var row =0; row <sheet_data.length;row++){
	     			
	     			for(var cell = 0;cell<3;cell++){
	     			
	     				if(row==0){
    						if(cell==1 && "Key MOE'S" != sheet_data[row][cell]){  checkExcel++;}
            				if(cell==2 && "Values" != sheet_data[row][cell]){  checkExcel++;}
            				console.log(sheet_data[row][cell]+cell)
            				
            			}
	     			}
	     		}
	     	}
	     	
	     	 var PerformanceListJs = [<%int j=0; for (Object[] obj:PerformanceList ){%>  "<%= obj[1]%>" <%= j+1 <PerformanceList.size() ? ",":"" %><%}%>]; 
	     	 
	     	 var PerformanceDetails = [];
	     	 
	     	 for(var i in sheet_data){
	     		PerformanceDetails.push(sheet_data[i][1]+"");
	     	 }
	     	 
	     	 const duplicates = PerformanceDetails.filter((item,index) => index !== PerformanceDetails.indexOf(item));
	     	 
	     	 const indexval = [];
	     	 
	     	 for (var i in duplicates){
	     		 indexval.push(PerformanceDetails.indexOf(duplicates[i]));
	     	 }
	     	 	var dbDuplicate = [];
	     		PerformanceListJs.forEach(function (item){
	     		var isPresent = PerformanceDetails.indexOf(item);
	     		if(isPresent !== -1){
	     		dbDuplicate.push(isPresent);
	     		}
	     	});
	     		 
	     	var msg="";
	     	if(checkExcel>0){
	     		msg="Upload Performance parameters Document!";
	     		alert(msg);
	     		excel_fileB.value="";
	     	}else{
	    		$('#uploadDivB').show();	
	     	}
		}
		
		

	});
	
</script>
</body>
</html>