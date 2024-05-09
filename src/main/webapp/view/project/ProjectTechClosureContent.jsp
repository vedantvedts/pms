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
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<spring:url value="/resources/richtexteditor/richtexteditor.js" var="richtexteditorjs" />
<spring:url value="/resources/richtexteditor/richtexteditor.css" var="richtexteditorcss" />
<spring:url value="/resources/richtexteditor/plugins/all_plugins.js" var="allpluginsjs" />

<title>COMMITTEE SCHEDULE MINUTES</title>


<script src="${ckeditor}"></script>
<script src="${richtexteditorjs}"></script>
<script src="${allpluginsjs}"></script>


 <link href="${contentCss}" rel="stylesheet" />
 <link href="${richtexteditorcss}" rel="stylesheet" />

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
    width: 49px;
    height: 24px;
    font-size: 10px;
    font-weight: bold;
    text-align: justify;
    display: inline-block;
}
#ModalReq::after{
  content: "Add Chapter";
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

.editbtn
{
	background-color: green;
	width:auto; 
	height: 22px; 
	font-size:10px;
	font-weight: bold;
	text-align: justify; 
	margin-top : -9px;
	padding: 0px 3px 1px 3px; 
}


.hiddeninput
{
	width:50%;
	height: 25px;
	
	font-size: 1rem;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	padding: 2px;
	
}

 .btnx
{
	width:22px; 
	height: 22px;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	
}

.fa-lg
{
	margin-left: -5px;
	vertical-align: 0%;
	font-size: 1.4rem;
} 


	</style>
</head>
<body>

<%

String unit3=null;
unit3=(String)request.getAttribute("unit1");
if(unit3==null){
	  unit3="NO";
}
String unit21=null;
unit21=(String)request.getAttribute("unit2");
if(unit21==null){
	  unit21="NO";
}
 
String specname=(String)request.getAttribute("specname");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

String closureId=(String)request.getAttribute("closureId");
List<Object[]> ChapterList=(List<Object[]>)request.getAttribute("ChapterList");
List<Object[]> AppndDocList=(List<Object[]>)request.getAttribute("AppndDocList");

%>



<% String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
 String errorMsg=(String)request.getParameter("errorMsg");
 
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></div>
                    <%}if(errorMsg!=null){ %>
                    	<div align="center">
	<div class="alert alert-danger" role="alert" >
                     <%=errorMsg %>
                   </div></div>
           <%} %>         
                    
  
  	
<nav class="navbar navbar-light bg-light justify-content-between" id="main1" style="margin-top: -1%">
		<a class="navbar-brand">
			<b style="color: #585858; font-size:19px;font-weight: bold;text-align: left; float:left" ><span style="color:#31708f">Technical Closure Content </span></b>
	   </a>
	
		<form class="form-inline" method="GET" action=""  name="myfrm" id="myfrm"> 
			<input type="hidden" name="closureId" value="<%=closureId%>" >
			<button  class="btn  btn-sm back" formaction="TechClosureList.htm" style=" font-size:12px;" >BACK</button>
		</form>
</nav> 	
  
  
  
  
<div class="container-fluid">          
 <div class="row"> 
   <div class="col-md-5" >
	<div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
      <div class="card-body" id="scrollclass" style="height:500px;overflow-y:scroll " >
        <% int Sub0Count=1;
           if(ChapterList!=null && ChapterList.size()>0){
           for(Object[]obj:ChapterList) {
           if(obj[1].toString().equalsIgnoreCase("0")) {%>
          
             <div class="panel panel-info" style="margin-top: 10px;" id="">
		       <div class="panel-heading ">
		         <h4 class="panel-title">
                      <span class="ml-2" style="font-size:14px"><%=Sub0Count+" . "+obj[3] %> </span>  
                </h4>
         	       <div style="float: right !important; margin-top:-32px; ;" id="tablediv" >
		 		       <table style="text-align: right;" >
     				       <thead>
	             		      <tr>
	                 		    <th ><input type="hidden" id="subspan" value=""></th>
	             		      </tr>
	         		      </thead>
	         		
	         		<tbody>
	         		<tr>
         		      <td>
			         		<span id="">
 			         		     <a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=Sub0Count %>" > <i class="fa fa-plus faplus " id="Clk<%=Sub0Count %>"></i></a>
 			         		 </span>
	                  </td>
	                  
	         		   <td>
	         		       <button class="btn bg-transparent"  type="button" id="btnEditor<%=obj[0].toString()%>" onclick="showEditor('<%=obj[3].toString()%>',<%=obj[0].toString()%>)" ><i class="fa fa-file-text" aria-hidden="true" style="color:orange"></i></button>
	         		  </td> 
	         		</tr>
	         	</tbody>
	          </table>
	        </div>
	     </div>
	         
	        <%-----------------------------------Level-1 Start--------------------------------------%> 
	        <div id="collapse55B<%=Sub0Count%>" class="panel-collapse collapse in"> 
	        
	        <%
		  	int Sub1Count=1;
		  	for(Object[] obj1:ChapterList){
		  	if(obj1[1].toString().equalsIgnoreCase(obj[0].toString())){
	  	    %>
	        
	         	<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
	                   <div class="panel-heading">
					        <h4 class="panel-title">
					        	
						           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %>" action="" method="post">
						 
										<span  style="font-size:14px" ><%=Sub0Count %>.<%=Sub1Count %></span>
										<span  style="font-size:14px" id="span_<%=obj1[0]%>"><%=obj1[3]%>  &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj1[0] %>')"></i> </span>	
							          	<input type="text" name="ChapterName" class="hiddeninput" id="input_<%=obj1[0]%>" value="<%=obj1[3] %>" style="display: none;" maxlength="255">
							          	<button type="submit" class="btn btn-sm btn-info editbtn" style="display: none;" id="btn_<%=obj1[0]%>" formaction="SubChapterEdit.htm" formmethod="post" onclick="return confirm('Are You Sure To Update ? ');">UPDATE</button>
							          	<button type="button" class="btnx" style="color: red;display: none;" id="btnx_<%=obj1[0] %>" onclick="moduleeditdisable('<%=obj1[0] %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
							          	
							          	<input type="hidden" name="ChapterId" value="<%=obj1[0]%>" >
							          	<input type="hidden" name="ClosureId" value="<%=closureId%>">
							          	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						          	
						          	</form>
					       	  </h4>
					       	  
					       		<div style="float: right !important; margin-top:-24px; " > 
					       			<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=Sub0Count %><%=Sub1Count %>"> <i class="fa fa-plus faplus " id="Clk<%=Sub0Count %><%=Sub1Count %>"></i></a>
					       		    <button class="btn bg-transparent"  type="button" id="btnEditor<%=obj1[0].toString()%>" onclick="showEditor('<%=obj1[3].toString()%>',<%=obj1[0].toString()%>)" ><i class="fa fa-file-text" aria-hidden="true" style="color:orange"></i></button>
					       			
					       			
					       		</div>
					      </div>
					      
					      
					      
					     <%-----------------------------------Level-2 Start--------------------------------------%> 
					      <div id="collapse55B<%=Sub0Count %><%=Sub1Count %>" class="panel-collapse collapse in">
					  			
					  			<%
						  			int Sub2Count=1; 
						  	  	 	for(Object[] obj2:ChapterList){
						  	  		if(obj1[0].toString().equalsIgnoreCase(obj2[1].toString()) ){
					  			%>
					  			
					               <div class="row">  
								    <div class="col-md-11"  align="left"  style="margin-left: 20px;">
							          <div class="panel panel-info">
									     <div class="panel-heading">
									        <h4 class="panel-title">
					        	
									           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>" action="" method="post">
									 
													
									          		<span  style="font-size:14px"><%=Sub0Count %>.<%=Sub1Count %>.<%=Sub2Count %> </span>
									          		<span  style="font-size:14px" id="span_<%=obj2[0]%>"> <%=obj2[3] %> &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj2[0] %>')"></i> </span>
									          		<input type="text" name="ChapterName" class="hiddeninput" id="input_<%=obj2[0]%>" value="<%=obj2[3] %>" style="display: none;" maxlength="255">
										          	<button type="submit" class="btn btn-sm btn-info editbtn" style="display: none;" id="btn_<%=obj2[0]%>" formaction="SubChapterEdit.htm" formmethod="post" onclick="return confirm('Are You Sure To Update ? ');">UPDATE</button>
										          	<button type="button" class="btnx" style="color: red;display: none;" id="btnx_<%=obj2[0] %>" onclick="moduleeditdisable('<%=obj2[0]%>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
										          	
										          	 <input type="hidden" name="ChapterId" value="<%=obj2[0]%>" >
							          	             <input type="hidden" name="ClosureId" value="<%=closureId%>">     
										          	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									          		
									          </form>
					       		            </h4>
									       		 <div style="float: right !important; margin-top:-28px; " > 
									       		      <button class="btn bg-transparent"  type="button" id="btnEditor<%=obj2[0].toString()%>" onclick="showEditor('<%=obj2[3].toString()%>',<%=obj2[0].toString()%>)" ><i class="fa fa-file-text" aria-hidden="true" style="color:orange"></i></button>
									       		</div>
									       		 
									      </div>
									   </div>
									 </div>  
					              </div> 
					    
					   <%Sub2Count++;}} %>    
					      
					     <%------------------------Level-2 Chapter Add ---------------------------------------%>
					         
			             <div class="row">  
				             <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				                  <div class="panel panel-info">
								      <div class="panel-heading">
								        <h4 class="panel-title">
					        	
						                   <form  id="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>" action="SubChapterAdd.htm" method="post">
						 
						 
						                       <input type="hidden" name="SectionId" value="<%=obj1[2]%>">				
											   <input type="hidden" name="ChapterParentId" value="<%=obj1[0]%>">
											   <input type="hidden" name="ClosureId" value="<%=closureId%>">
						                       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						                       
						                       <span  style="font-size:14px"><%=Sub0Count %>.<%=Sub1Count %>.<%=Sub2Count %></span>
						          		
								          		<div style="margin-top:-20px; margin-left:35px;">
								          		      <input class="form-control" type="text" name="ChapterName"  required="required" maxlength="255" style="width:150px; height:25px; "> 
								          		</div>
								          		
								          		<div style="margin-top:-22px; margin-left: 200px;">
								          		     <input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>" value="ADD"  style="width:42px; height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
								          		</div>
						          	        </form>
					       		          </h4>
					       		     </div>
					              </div>
					          </div>
	  			          </div>
	  			        <%------------------------Level-2 Chapter Add End ---------------------------------------%>    
	  			            
	  			</div>
	  			<%-------------------------Level 2 End ------------------------------------------------------------%>
	  			  
			 </div>
		</div>
					
					      <%Sub1Count++;}} %>
					      
					      <%------------------------Level-1 Chapter Add ---------------------------------------%>
					      
					      <div class="row">  
				             <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				                   <div class="panel panel-info">
								      <div class="panel-heading">
								        <h4 class="panel-title">
					        	
									           <form  id="myFormB<%=Sub0Count%>" action="SubChapterAdd.htm" method="post">
									 
													<input type="hidden" name="SectionId" value="<%=obj[2]%>">				
													<input type="hidden" name="ChapterParentId" value="<%=obj[0]%>">
													<input type="hidden" name="ClosureId" value="<%=closureId%>">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													
									          		<span style="font-size:14px"><%=Sub0Count %>.<%=Sub1Count %></span>
									          		
									          		<div style="margin-top:-20px; margin-left:55px;">
									          		     <input class="form-control" type="text" name="ChapterName"  required="required" maxlength="255" style="width:150px; height:25px; "> 
									          		</div>
									          		
									          		<div style="margin-top:-22px; margin-left: 220px;">
									          			<input type="submit" name="sub" class="btn btn-info btn-sm"  form="myFormB<%=Sub0Count %>" value="ADD"  style="width:42px; height: 22px; font-size:10px; font-weight: bold; text-align: justify; "/>
									          		</div>
									          		
									          	</form>
					       
					                       </h4>
					                    </div>
					                </div>
								  </div>
					  			</div>
					  			
					<%------------------------Level-1 Chapter Add End ---------------------------------------%>
	  			
	  		</div>
		 </div>
	         
	       <%Sub0Count++;}}} %>
	    			
			<br>
			<%-------------------------  Add New Section Button ----------------------------------------------------%>
	    	    <button type="button"  class="btn btn-sm  ml-2 font-weight-bold" data-toggle="modal" data-target="#exampleModalLong" id="ModalReq" style="color:#31708f;"><i class="fa fa-arrow-right text-primary" aria-hidden="true"></i>&nbsp; </button>
          </div>
	    </div>
	 </div>

        <%-------------------  RichText Editor -------------------------------------%>
                  
	          <div class="col-md-7" id="richtexteditor" >
	         	<form action="SubChapterEdit.htm" method="POST" id="myfrm1">
	      		 <div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
	      			<h5 class="heading ml-4 mt-3" id="editorHeading" style="font-weight:500;color: #31708f;display:none;"></h5><hr>
	      			<h5 class="heading ml-4 mt-3" id="editorHeading1" style="font-weight:500;color: #31708f;"><%if(ChapterList != null && ChapterList.size()>0){ %> <%=ChapterList.get(0)[3] %><%} %> </h5><hr>
					  <div class="card-body" style="margin-top: -8px" >
					    <div class="row">	
					        <div class="col-md-12 " align="left" style="margin-left: 0px; width: 100%;">
					          <div id="div_editor1"></div>
					
					         <textarea name="ChapterContent" style="display: none;"></textarea>
					          <div class="mt-2" align="center" id="detailsSubmit">
					             <span id="EditorDetails"></span>
				    
					    			<input type="hidden"  id='chapterid' name='ChapterId' value="">
					    			<input type="hidden" name="ClosureId" value="<%=closureId%>" >
					    			<input type="hidden" id="chaptername" name="ChapterName" value="" >
					    			
									<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
					                   <span id="Editorspan">
					                      <button type="submit" class="btn btn-sm btn-success submit mt-2 " onclick=EditorValueSubmit()>SUBMIT</button>
					                  </span>
						          </div>
						      </div>
						   </div>
						  </div>
		         		</div> 
	         		</form>
		        </div>
		       
		  <%-----------------------------------  RichText Editor -------------------------------------%> 
		  
		  
		   <%-----------------------------------  Appendices Cloning -------------------------------------%> 
		   
		      <div class="col-md-7" id="DocumentTable" style="display:none;">
	         	<form action="ProjectClosureAppendixDocSubmit.htm" method="GET" id="">
	      		 <div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
	      			<h5 class="heading ml-4 mt-3" id="" style="font-weight:500;color: #31708f;">Appendices</h5><hr>
	      			
					  <div class="card-body" style="margin-top: -8px" >
					    <div class="row">
					       <div class="col-md-12 " align="left" style="margin-left: 0px; width: 100%;">
					          <div class="row">
                      		    <div class="col-md-12" align="left">
									<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
										     <b style="font-family: 'Lato',sans-serif;font-size: large;">Attachments</b>
									</label>
							    </div>
				              </div>
				             <table style="width: 94%;margin-left: 3%;" id="trialresultstable">
								<thead style = "background-color: #055C9D; color: white;text-align: center;">
									<tr>
									    <th style="width: 10%;padding: 0px 5px 0px 5px;">Appendix</th>
								    	<th style="width: 40%;padding: 0px 5px 0px 5px;">Document Name</th>
								    	<th style="width: 25%;padding: 0px 5px 0px 5px;">Attachment</th>
								    	<td style="width: 5%;">
											<button type="button" class=" btn btn_add_trialresults "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
										</td>
									</tr>
								</thead>
								 <tbody>
									<tr class="tr_clone_trialresults">
												
									    <td style="width: 20%;padding: 10px 5px 0px 5px;" >
											  <input type="text" class="form-control item" name="Appendix" id="appendix" value="Appendix-A">
										</td>
													
										   <td style="width: 40%;padding: 10px 5px 0px 5px;" >
												<select class="form-control" name="DocumentName">
												    <option value="0"  selected disabled>Select</option>
													    <%for(Object[] obj:AppndDocList){ %>
													          <option value="<%=obj[0] %>" ><%=obj[1] %></option>
													     <%}%>
												</select>
											</td>
												
											<td style="width: 25%;padding: 10px 5px 0px 5px;">
												  <input type="file" class="form-control item" name="attachment" accept=".pdf" required>
											</td>
												
											<td style="width: 5% ; ">
												 <button type="button" class=" btn btn_rem_trialresults " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
											</td>
										</tr>
								    </tbody>
				               </table>
				             
				                 <div align="center">
				                     <button type="submit" class="btn btn-sm btn-success submit mt-2 " name="Action" value="Add" onclick="return confirm('Are You Sure To Submit')" >SUBMIT</button>
				              </div>
				            </div>
	                     </div>
		             </div>
                  </div> 
                  <input type="hidden"  id='chapterids' name='ChapterId' value="">
				  <input type="hidden" name="ClosureId" value="<%=closureId%>" >
               </form>
             </div>
             
              <%-----------------------------------  Appendices Cloning -------------------------------------%> 
       
   </div>
 </div>

			
			
			
<form action="ChapterAdd.htm" method="POST" id="myform2">          	  	
 <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
   <div class="modal-dialog modal-dialog-jump" role="document">
    <div class="modal-content mt-5" style="margin-left:-10%;">
      <div class="modal-header p-1 pl-3" style="background: #C4DDFF">
        <h5 class="modal-title font-weight-bold" id="exampleModalLongTitle" style="color: #31708f">Choose Chapter</h5>
        <button type="button" class="close text-danger mr-1" data-dismiss="modal" aria-label="Close">
          <span class="font-weight-bolder" aria-hidden="true" style="opacity:1;">&times;</span>
        </button>
      </div>
        
     
       <div class="modal-body" style="justify-content: center;align-items:center;">
         <table class="table table-bordered table-hover table-striped table-condensed" style="border:1px solid black;">
            <thead> 
	           <tr style="border:1px solid black;background-color:#055C9D;">
	           
		            <td align="center" style="border:1px solid black;width:10%;color:#FFFF">Select</td>
		            <td align="center" style="border:1px solid black;width:80%;color:#FFFF">Chapter</td>
	          </tr>
	         
	       </thead>
         
         <tbody  id="modal_table_body" ></tbody>
         
       </table>
     
           <div align="center" id="chaptersubmit"></div>
     
   <br>
     
        <div style="text-align:center;">
               <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" id="AddNewSection" onclick="AddSection()">ADD NEW </button>
		</div>
		
		<div align="center" style="display: none" id="SubmitButton">
		
			  <input class="form-control" type="text" name="SectionName" placeholder="Enter New Chapter" >
			  <br>
			  <button type="button" class="btn btn-primary" data-toggle="modal"  onclick="SectionSubmit()" >Add </button>
			  <button type="button" class="btn btn-danger" data-toggle="modal"  onclick="CloseButton()" >Close </button>
		
		</div>
      </div>
   		            <input type="hidden" name="ClosureId" value="<%=closureId%>"> 
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
        			
     
			    </div>
			</div>
	    </div>   	
   </form> 


<script type="text/javascript">

function AddSection(){
	
	$('#AddNewSection').hide();
	$('#SubmitButton').show();
}

function CloseButton(){
	
	$('#AddNewSection').show();
	$('#SubmitButton').hide();
	
}

// to show the existing sections list
$(document).ready(function() {
	
    
    $.ajax({
        type: 'GET',
        url: 'AddSection.htm', 
        dataType: 'json',
        data:{
        	closureId:<%=closureId%>,
        	ExistingSection:'Y',
        },
        success: function(existingData) {
            
            if (existingData.length > 0) {
                var htmlStr = '';
                
                for (var i = 0; i <existingData.length; i++) {
                    htmlStr += '<tr>';
                    if (existingData[i][3] === 'S') {
                        htmlStr += '<td class="tabledata" style="text-align: center;"><button type="button" class="tick-btn" disabled style="color:#008000;font-size:20px;">&#10004;</button></td>';
                    } else {
                        htmlStr += '<td class="tabledata" style="text-align: center;"><input type="checkbox" name="SectionId" value="' + existingData[i][0] + '"></td>';
                    }
                    //htmlStr += '<td class="tabledata" style="text-align: center;" ><input type="checkbox" name="SectionId"  value="' + existingData[i][0] + '" ></td>';
                    htmlStr += '<td class="tabledata" style="text-align: left;" >' + existingData[i][2] + '</td>';
                    htmlStr += '</tr>';
                    htmlStr += '</tr>';
                }
                $('#chaptersubmit').html('<button type="submit" class="btn btn-sm btn-success submit mt-2 " onclick=ChapterAdd()>SUBMIT</button>');
                
                $('#modal_table_body').html(htmlStr);
                
            }
        },
       
    });
});


function SectionSubmit(){
	
	
	$.ajax({
		type:'GET',
		url:'AddSection.htm',
		datatype:'json',
		data:{
			closureId:<%=closureId%>,
			SectionName:$('input[name="SectionName"]').val(),
		},
		success:function(result){
			var result=JSON.parse(result);
			var htmlStr='';
			
			if(result.length>0){
				
			var lastResult = result[result.length - 1];
			
			htmlStr += '<tr>';
			htmlStr += '<td class="tabledata" style="text-align: center;" ><input type="checkbox" class="" name="SectionId" value='+lastResult[0]+' ></td>';
			htmlStr += '<td class="tabledata" style="text-align: left;" >'+ lastResult[2] + '</td>';
		    htmlStr += '</tr>';
		    
			$('#modal_table_body').append(htmlStr);
				
			$('input[name="SectionName"]').val('');
			
			}
		},
		
	 })
	 
}

function ChapterAdd(){
	
	if(confirm("Are you sure you want to submit?")){
		
		 $('#myForm2').submit();
	    return true;
	}else{
	   event.preventDefault();
	   return false;
	  }
	}

function moduleeditenable(moduleid)
{
	$('#span_'+moduleid).hide();
	$('#input_'+moduleid).show();
	$('#btn_'+moduleid).show();	
	$('#btnx_'+moduleid).show();
}

function moduleeditdisable(moduleid)
{
	$('#span_'+moduleid).show();
	$('#input_'+moduleid).hide();
	$('#btn_'+moduleid).hide();	
	$('#btnx_'+moduleid).hide();
}

var editor1 = new RichTextEditor("#div_editor1");

function showEditor(a,b){
	
	 $('#editorHeading').show();
	 $('#editorHeading1').hide();
	 $('#editorHeading').html(a);
	 $('#Editor').html(a);
	 $('#chapterid').val(b);
	 $('#chapterids').val(b);
	 $('#chaptername').val(a);
	 
	 if(a==='APPENDICES'){
		 
		 $('#richtexteditor').hide();
		 $('#editorHeading').hide();
		 $('#editorHeading1').hide();
		 $('#DocumentTable').show();
		 
	 }else{
		 
		 $('#richtexteditor').show();
		 $('#DocumentTable').hide();
	  }
	
	$.ajax({
		type:'GET',
		url:'ChapterContent.htm',
		datatype:'json',
		data:{
			ChapterId:b,
		},
		success:function(result){
		var ajaxresult=JSON.parse(result);
		if(ajaxresult[1]==null){
		
		    ajaxresult[1]=""
		    $('#Editorspan').html('<button type="submit" class="btn btn-sm btn-success submit mt-2 " onclick=EditorValueSubmit()>SUBMIT</button>');
		}else{
		    $('#Editorspan').html('<button type="submit" class="btn btn-sm btn-warning mt-2 edit" onclick=EditorValueSubmit()>UPDATE</button>');
		}
		    editor1.setHTMLCode(ajaxresult[1]);
		}
	 })
	}
	
$('#myfrm1').submit(function() {
	 var data =editor1.getHTMLCode();
	 $('textarea[name=ChapterContent]').val(data);
	 });
	 
function EditorValueSubmit(){
	if(confirm("Are you sure you want to submit?")){
		return true;
	}else{
	   event.preventDefault();
	   return false;
	}
  }

</script>


<script type="text/javascript">

$(document).ready(function(){
    // Add minus icon for collapse element which is open by default
    $(".collapse.show").each(function(){
    	$(this).prev(".panel-heading").find(".faplus").addClass("fa-minus").removeClass("fa-plus");
    });
    
    // Toggle plus minus icon on show hide of collapse element
    $(".collapse").on('show.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".faplus").removeClass("fa-plus").addClass("fa-minus");
    }).on('hide.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".faplus").removeClass("fa-minus").addClass("fa-plus");
    });
});

$('#Clk').click();

<%String FormName=(String)request.getAttribute("FromName");
if(FormName!=null){
	String [] id=FormName.split("/");
	String IdName="Clk";
	for(int i=0;i<id.length;i++){
		IdName=IdName.concat(id[i]);
%>
      $('#<%=IdName%>').click();
<%}}%>


//Appendices Document Attachment Cloning

$(document).ready(function() {
    var alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    $("#trialresultstable").on('click','.btn_add_trialresults' ,function() {
        var $tr = $('.tr_clone_trialresults').last('.tr_clone_trialresults');
        var $clone = $tr.clone();

        $tr.after($clone);

        var milestoneno = $clone.find("#appendix").val();
        var lastChar = milestoneno.charAt(milestoneno.length - 1);
        var index = alphabet.indexOf(lastChar);
        var nextChar = alphabet[index + 1];

        if (nextChar) {
            $clone.find("#appendix").val("Appendix-" + nextChar);
        } else {
            // Handle if we reach the end of the alphabet
            // For simplicity, let's reset to 'A', you can modify this logic as per your requirement
            $clone.find("#appendix").val("Appendix-A");
        }

        // Clear input and textarea fields
        //$clone.find("input, textarea").val("");
    });

    $("#trialresultstable").on('click','.btn_rem_trialresults' ,function() {
        var $rows = $('.tr_clone_trialresults');

        if ($rows.length > 1) {
            var $rowToRemove = $(this).closest('.tr_clone_trialresults');
            var indexToRemove = $rows.index($rowToRemove);

            // Remove the row
            $rowToRemove.remove();

            // Update the milestoneno2 values for the remaining rows
            $('.tr_clone_trialresults').each(function(index, row) {
                var $currentRow = $(row);
                var newChar = alphabet.charAt(index);
                $currentRow.find("#appendix").val("Appendix-" + newChar);
            });
        }
    });
});





</script>

</body>
</html>



