<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureTechnicalAppendices"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>



<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
 <spring:url value="/resources/font/summernote.woff" var="Summernotewoff" /> 
<spring:url value="/resources/font/summernote.ttf" var="Summernotettf" /> 
<spring:url value="/resources/font/summernote.eot" var="Summernoteeot" />

<title>COMMITTEE SCHEDULE MINUTES</title>

<spring:url value="/resources/css/projectModule/techClosure.css" var="techClosureCss"/>
<link rel="stylesheet" type="text/css" href="${techClosureCss}">

 <script src="${SummernoteJs}"></script>
 <link href="${SummernoteCss}" rel="stylesheet" />
 <script src="${Summernotettf}"></script>
  <script src="${Summernotettf}"></script>
   <script src="${Summernoteeot}"></script>

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

List<Object[]>  AppendicesList=(List<Object[]>)request.getAttribute("AppendicesList");

String TechClosureId=(String)request.getAttribute("TechClosureId");

%>



<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>       
                    
  
  	
<nav class="navbar navbar-light bg-light justify-content-between mt-01per" id="main1">
		<a class="navbar-brand">
			<b class="heading-bar"><span class="heading-color">Technical Closure Content </span></b>
	   </a>
	
		<form class="form-inline" method="GET" action=""  name="myfrm" id="myfrm"> 
			<input type="hidden" name="closureId" value="<%=closureId%>" >
			<button  class="btn  btn-sm back back-btn-font-size" formaction="TechClosureList.htm">BACK</button>
		</form>
</nav> 	
  
  
  
  
<div class="container-fluid">          
 <div class="row"> 
   <div class="col-md-5" >
	<div class="card card-content">
      <div class="card-body card-body-content" id="scrollclass">
        <% int Sub0Count=1;
           if(ChapterList!=null && ChapterList.size()>0){
           for(Object[]obj:ChapterList) {
           if(obj[1].toString().equalsIgnoreCase("0")) {%>
          
             <div class="panel panel-info mt10">
		       <div class="panel-heading ">
		         <h4 class="panel-title">
                      <span class="ml-2 fs14"><%=Sub0Count+" . "+(obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " )%> </span>  
                </h4>
         	       <div class="icon-align" id="tablediv" >
		 		       <table class="text-right" >
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
	         		       <button class="btn bg-transparent btn-org-color"  type="button" id="btnEditor<%=obj[0].toString()%>" onclick="showEditor('<%=obj[3].toString()%>',<%=obj[0].toString()%>)" ><i class="fa fa-file-text" aria-hidden="true"></i></button>
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
				   <div class="col-md-11 ml20"  align="left">
	                   <div class="panel-heading">
					        <h4 class="panel-title">
					        	
						           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %>" action="" method="post">
						 
										<span  class="fs14"><%=Sub0Count %>.<%=Sub1Count %></span>
										<span  class="fs14" id="span_<%=obj1[0]%>"><%=obj1[3]!=null?StringEscapeUtils.escapeHtml4(obj1[3].toString()): " - " %>  &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj1[0] %>')"></i> </span>	
							          	<input type="text" name="ChapterName" class="hiddeninput dis-none" id="input_<%=obj1[0]%>" value="<%=obj1[3]!=null?StringEscapeUtils.escapeHtml4(obj1[3].toString()): ""  %>" maxlength="255">
							          	<button type="submit" class="btn btn-sm btn-info editbtn dis-none" id="btn_<%=obj1[0]%>" formaction="SubChapterEdit.htm" formmethod="post" onclick="return confirm('Are You Sure To Update ? ');">UPDATE</button>
							          	<button type="button" class="btnx cancel-btn" id="btnx_<%=obj1[0] %>" onclick="moduleeditdisable('<%=obj1[0] %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
							          	
							          	<input type="hidden" name="ChapterId" value="<%=obj1[0]%>" >
							          	<input type="hidden" name="ClosureId" value="<%=closureId%>">
							          	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						          	
						          	</form>
					       	  </h4>
					       	  
					       		<div class="fr-mt24" > 
					       			<a data-toggle="collapse" data-parent="#accordion" href="#collapse55B<%=Sub0Count %><%=Sub1Count %>"> <i class="fa fa-plus faplus " id="Clk<%=Sub0Count %><%=Sub1Count %>"></i></a>
					       		    <button class="btn bg-transparent btn-org-color"  type="button" id="btnEditor<%=obj1[0].toString()%>" onclick="showEditor('<%=obj1[3].toString()%>',<%=obj1[0].toString()%>)" ><i class="fa fa-file-text" aria-hidden="true"></i></button>
					       			
					       			
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
								    <div class="col-md-11 ml20"  align="left">
							          <div class="panel panel-info">
									     <div class="panel-heading">
									        <h4 class="panel-title">
					        	
									           <form  id="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>" action="" method="post">
									 
													
									          		<span  class="fs14"><%=Sub0Count %>.<%=Sub1Count %>.<%=Sub2Count %> </span>
									          		<span  class="fs14" id="span_<%=obj2[0]%>"> <%=obj2[3]!=null?StringEscapeUtils.escapeHtml4(obj2[3].toString()): " - "  %> &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj2[0] %>')"></i> </span>
									          		<input type="text" name="ChapterName" class="hiddeninput dis-none" id="input_<%=obj2[0]%>" value="<%=obj2[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): ""  %>" maxlength="255">
										          	<button type="submit" class="btn btn-sm btn-info editbtn dis-none" id="btn_<%=obj2[0]%>" formaction="SubChapterEdit.htm" formmethod="post" onclick="return confirm('Are You Sure To Update ? ');">UPDATE</button>
										          	<button type="button" class="btnx cancel-btn" id="btnx_<%=obj2[0] %>" onclick="moduleeditdisable('<%=obj2[0]%>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
										          	
										          	 <input type="hidden" name="ChapterId" value="<%=obj2[0]%>" >
							          	             <input type="hidden" name="ClosureId" value="<%=closureId%>">     
										          	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									          		
									          </form>
					       		            </h4>
									       		 <div class="fr-mt28"> 
									       		      <button class="btn bg-transparent btn-org-color"  type="button" id="btnEditor<%=obj2[0].toString()%>" onclick="showEditor('<%=obj2[3].toString()%>',<%=obj2[0].toString()%>)" ><i class="fa fa-file-text" aria-hidden="true"></i></button>
									       		</div>
									       		 
									      </div>
									   </div>
									 </div>  
					              </div> 
					    
					   <%Sub2Count++;}} %>    
					      
					     <%------------------------Level-2 Chapter Add ---------------------------------------%>
					         
			             <div class="row">  
				             <div class="col-md-11 ml20"  align="left">
				                  <div class="panel panel-info">
								      <div class="panel-heading">
								        <h4 class="panel-title">
					        	
						                   <form  id="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>" action="SubChapterAdd.htm" method="post">
						 
						 
						                       <input type="hidden" name="SectionId" value="<%=obj1[2]%>">				
											   <input type="hidden" name="ChapterParentId" value="<%=obj1[0]%>">
											   <input type="hidden" name="ClosureId" value="<%=closureId%>">
						                       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						                       
						                       <span  class="fs14"><%=Sub0Count %>.<%=Sub1Count %>.<%=Sub2Count %></span>
						          		
								          		<div class="chapter-name">
								          		      <input class="form-control chapter-name-iput" type="text" name="ChapterName"  required="required" maxlength="255"> 
								          		</div>
								          		
								          		<div class="sub">
								          		     <input type="submit" name="sub" class="btn btn-info btn-sm btn-pro"  form="myFormB<%=Sub0Count %><%=Sub1Count %><%=Sub2Count %>" value="ADD"/>
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
				             <div class="col-md-11 ml20"  align="left">
				                   <div class="panel panel-info">
								      <div class="panel-heading">
								        <h4 class="panel-title">
					        	
									           <form  id="myFormB<%=Sub0Count%>" action="SubChapterAdd.htm" method="post">
									 
													<input type="hidden" name="SectionId" value="<%=obj[2]%>">				
													<input type="hidden" name="ChapterParentId" value="<%=obj[0]%>">
													<input type="hidden" name="ClosureId" value="<%=closureId%>">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													
									          		<span class="fs14"><%=Sub0Count %>.<%=Sub1Count %></span>
									          		
									          		<div class="mt20-ml55">
									          		     <input class="form-control chapter-name-iput" type="text" name="ChapterName"  required="required" maxlength="255"> 
									          		</div>
									          		
									          		<div class="mt22-ml220">
									          			<input type="submit" name="sub" class="btn btn-info btn-sm btn-pro"  form="myFormB<%=Sub0Count %>" value="ADD"/>
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
	    	    <button type="button"  class="btn btn-sm  ml-2 font-weight-bold add-section-btn" data-toggle="modal" data-target="#exampleModalLong" id="ModalReq"><i class="fa fa-arrow-right text-primary" aria-hidden="true"></i>&nbsp; </button>
          </div>
	    </div>
	 </div>

        <%-------------------  SummerNote Editor -------------------------------------%>
                  
	          <div class="col-md-7" id="summernoteeditor" >
	         	<form action="SubChapterEdit.htm" method="POST" id="myfrm1">
	      		 <div class="card sn-editor">
	      			<h5 class="heading ml-4 mt-3 editor-heading" id="editorHeading"></h5><hr>
	      			<h5 class="heading ml-4 mt-3 editor-heading1" id="editorHeading1"><%if(ChapterList != null && ChapterList.size()>0){ %> <%=ChapterList.get(0)[3]!=null?StringEscapeUtils.escapeHtml4(ChapterList.get(0)[3].toString()): " - "  %><%} %> </h5><hr>
					  <div class="card-body mt-08">
					    <div class="row">	
					        <div class="col-md-12 ml0-w100" align="left">
					          <div id="summernote" class="height500"></div>
					         
					         
					         <textarea name="ChapterContent" id="" class="dis-none"></textarea>
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
		       
		  <%-----------------------------------  SummerNote Editor -------------------------------------%> 
		  
		  
		   <%-----------------------------------  Appendices Cloning -------------------------------------%> 
		   
		      <div class="col-md-7 dis-none" id="DocumentTable">
	         	<form action="ProjectClosureAppendixDocSubmit.htm" method="POST"  enctype="multipart/form-data">
	      		 <div class="card appendices">
	      			<h5 class="heading ml-4 mt-3 appendices-fw" id="">Appendices</h5><hr>
	      			
					  <div class="card-body mt-08">
					    <div class="row">
					       <div class="col-md-12 ml0-w100" align="left">
					          <div class="row">
                      		    <div class="col-md-12" align="left">
									<label class="attachment-label">
										     <b class="attachments">Attachments</b>
									</label>
							    </div>
				              </div>
				             <table class="w94-ml3" id="trialresultstable">
								<thead class="trialResultsTbl">
									<tr>
									    <th class="appendix-label">Appendix</th>
								    	<th class="documentName-label">Document Name</th>
								    	<th class="attachment-label1">Attachment</th>
								    	 <%if(AppendicesList!=null && AppendicesList.size()>0) {%>
								    	 
									    <th class="action-label">Action</th>
									    	
										<%} %>
								    	<td class="width-5">
											<button type="button" class="btn btn_add_trialresults green-color"> <i class="btn btn-sm fa fa-plus"></i></button>
										</td>
									</tr>
								</thead>
								
								 <tbody>
								 <%if(AppendicesList !=null && AppendicesList.size()>0) {
									for(Object[] obj :AppendicesList) {%>
									<tr class="tr_clone_trialresults">
										<td class="width20">
										    <input type="text" class="form-control item" name="Appendix"  id="appendix" value="<%if(obj[1]!=null) {%><%=StringEscapeUtils.escapeHtml4(obj[1].toString()) %><%} %>">
										</td>	
										
										<td class="width40">
										     <input type="text" class="form-control item" name="DocumentName"  value="<%if(obj[2]!=null) {%><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%} %>">
										</td>
										
										<td class="width25">
											<input type="file" class="form-control item" name="attachment" accept=".pdf">
											<input type="hidden" name="attatchmentname" value="<%if(obj[3]!=null && !obj[3].toString().isEmpty()) {%><%=StringEscapeUtils.escapeHtml4(obj[1].toString()) %><%} %>">
										</td>
										<td class="width10" id="actiontd">
											<%if(obj[3]!=null && !obj[3].toString().isEmpty()) {%>
												<button type="submit" class="btn btn-sm padding5px8px" id="attachedfile" name="attachmentfile" formmethod="post" formnovalidate="formnovalidate"
 		  				 							 value="<%=obj[0] %>" formaction="AppendicesDocumentDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Attatchment Download">
 														<i class="fa fa-download fa-lg"></i>
 											   </button>
											<%} %>
										</td>	
										<td class="width5per">
											<button type="button" class="btn btn_rem_trialresults" > <i class="btn btn-sm fa fa-minus red-color"></i></button>
										</td>									
									</tr>
								<%} } else {%>
								 
									<tr class="tr_clone_trialresults">
												
									    <td class="width20">
											  <input type="text" class="form-control item" name="Appendix" id="appendix" value="Appendix-A">
										</td>
													
										   <td class="width40">
												<select class="form-control" name="DocumentName">
												    <option value="0"  selected disabled>Select</option>
													    <%for(Object[] obj:AppndDocList){ %>
													          <option value="<%=obj[1] %>" ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></option>
													     <%}%>
												</select>
											</td>
												
											<td class="width25">
												  <input type="file" class="form-control item" name="attachment" accept=".pdf" required>
											</td>
												
											<td class="width5per">
												 <button type="button" class=" btn btn_rem_trialresults " > <i class="btn btn-sm fa fa-minus red-color"></i></button>
											</td>
										</tr>
										<%} %>
								    </tbody>
				               </table>
				             
				                 <div align="center">
				                 
				                 <%if(AppendicesList!=null && AppendicesList.size()>0) {%>
				                 
									<button type="submit" class="btn btn-sm btn-warning btn-sm edit btn-acp" name="Action" value="Edit" onclick="return confirm('Are you sure to Update?');" >UPDATE</button>
										
								<%} else{%>
										    <button type="submit" class="btn btn-sm btn-success submit mt-2 " name="Action" value="Add" onclick="return confirm('Are You Sure To Submit')" >SUBMIT</button>
				                     <%} %>
				              </div>
				            </div>
				            
				            	
				       </div>
		             </div>
                  </div> 
                  <input type="hidden"  id='chapterids' name='ChapterId' value="">
				  <input type="hidden" name="ClosureId" value="<%=closureId%>" >
				  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
               </form>
             </div>
             
              <%-----------------------------------  Appendices Cloning -------------------------------------%> 
       
   </div>
 </div>
<br>
			
<form>			
	<div align="center">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	    <button type="submit"  class="btn btn-sm print-tech-closure-btn" name="TechAndClosureId"  value="<%=closureId%>/<%=TechClosureId%>" formaction="TechnicalClosureReportDownload.htm" formtarget="_blank">Print Technical Closure Report</button>
	</div>
</form>	
		
<form action="ChapterAdd.htm" method="POST" id="myform2">          	  	
 <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
   <div class="modal-dialog modal-dialog-jump" role="document">
    <div class="modal-content mt-5 ml-10per">
      <div class="modal-header p-1 pl-3 modal-header-choose-chapter">
        <h5 class="modal-title font-weight-bold choose-chapter-color" id="exampleModalLongTitle">Choose Chapter</h5>
        <button type="button" class="close text-danger mr-2" data-dismiss="modal" aria-label="Close">
          <span class="font-weight-bolder opacity1" aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span>
        </button>
      </div>
        
     
       <div class="modal-body justify-content-center">
         <table class="table table-bordered table-hover table-striped table-condensed border1px">
            <thead> 
	           <tr class="border1px-bgcolor1">
	           
		            <td align="center" class="border1px-bgcolor2">Select</td>
		            <td align="center" class="border1px-bgcolor3">Chapter</td>
	          </tr>
	         
	       </thead>
         
         <tbody  id="modal_table_body" ></tbody>
         
       </table>
     
           <div align="center" id="chaptersubmit"></div>
     
   <br>
     
        <div class="text-center">
               <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" id="AddNewSection" onclick="AddSection()">ADD NEW </button>
		</div>
		
		<div align="center" class="dis-none" id="SubmitButton">
		
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
                        htmlStr += '<td class="tabledata text-center"><button type="button" class="tick-btn tick-btn-color" disabled>&#10004;</button></td>';
                    } else {
                        htmlStr += '<td class="tabledata text-center"><input type="checkbox" name="SectionId" value="' + existingData[i][0] + '"></td>';
                    }
                    htmlStr += '<td class="tabledata text-left">' + existingData[i][2] + '</td>';
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
	
	var secname=$('input[name="SectionName"]').val()
	if(secname=='' || secname==null){
		
		alert('Please Enter New Chapter');
		return false;
		
	}
	
	else{
	$.ajax({
		type:'GET',
		url:'AddSection.htm',
		datatype:'json',
		data:{
			closureId:<%=closureId%>,
			SectionName:secname,
		},
		success:function(result){
			var result=JSON.parse(result);
			var htmlStr='';
			
			if(result.length>0){
				
			var lastResult = result[result.length - 1];
			
			htmlStr += '<tr>';
			htmlStr += '<td class="tabledata text-center"><input type="checkbox" class="" name="SectionId" value='+lastResult[0]+' ></td>';
			htmlStr += '<td class="tabledata text-left">'+ lastResult[2] + '</td>';
		    htmlStr += '</tr>';
		    
			$('#modal_table_body').append(htmlStr);
				
			$('input[name="SectionName"]').val('');
			
			}
		},
		
	 })
	 
    }
}

function ChapterAdd(){

	  var isChecked = $('input[name="SectionId"]:checked').length > 0;

	    if (!isChecked) {
	        alert('Please select at least one chapter.');
	        event.preventDefault(); 
	        return false;
	    } else {
	       
	        if(confirm("Are you sure you want to submit?")) {
	            
	            $('#myForm2').submit(); 
	        }else{
	     	   event.preventDefault();
	    	   return false;
	    	  }
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




 function showEditor(a,b){
	
	 $('#editorHeading').show();
	 $('#editorHeading1').hide();
	 $('#editorHeading').html(a);
	 $('#Editor').html(a);
	 $('#chapterid').val(b);
	 $('#chapterids').val(b);
	 $('#chaptername').val(a);
	 $('#summernote1').hide();
	 
	
	 console.log("a---"+a);
	 
	 if(a=== 'APPENDICES' || a=== 'appendices' || a=== 'Appendices'){
		 
		 console.log("a--===");
		 $('#summernoteeditor').hide();
		 $('#editorHeading').hide();
		 $('#editorHeading1').hide();
		 $('#DocumentTable').show();

		 
	 }else{
		 
		 $('#summernoteeditor').show();
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
		  
		    $('#summernote').summernote('code', ajaxresult[1]);
		    
		   
		}
	 })
	 
	} 
	
/* $('#myfrm1').submit(function() {
	 var data =editor1.getHTMLCode();
	 $('textarea[name=ChapterContent]').val(data);
	 }); */
	 
	 <%if(ChapterList != null && ChapterList.size()>0){ %> 
	 $(document).ready(function() {
		 $('#summernote').summernote('code', '<%=ChapterList.get(0)[4] %>');
	 });
	 <%} %>
	 
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



 $(document).ready(function() {
	 $('#summernote').summernote({
		  width: 900,   //don't use px
		
		  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana'],
		 
	      lineHeights: ['0.5']
	
	 });

$('#summernote').summernote({
      
       tabsize: 2,
       height: 1000
     });
     
     
<%-- var content = '<% if(ChapterList != null && ChapterList.size()>0){ %> <%=ChapterList.get(0)[4] %><%}%>';
$('#summernote1').summernote('code', content); --%>
//$('#summernote').hide();

 $('#myfrm1').submit(function() {
    
	  var codeee=$('#summernote').summernote('code');
	 // codeee=codeee.replace(/<\/?[^>]+(>|$)/g, "")
	  $('textarea[name=ChapterContent]').val($('#summernote').summernote('code'));
 });
}); 




</script>

</body>
</html>



