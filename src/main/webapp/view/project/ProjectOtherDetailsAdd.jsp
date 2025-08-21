<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>


<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/content.css" var="contentCss" />

 <script src="${ckeditor}"></script>
 <link href="${contentCss}" rel="stylesheet" />


<title>PROJECT OTHER  ADD</title>
<style type="text/css">

.template_faq {
    background: #edf3fe none repeat scroll 0 0;
}
.panel-group {
    background: #fff none repeat scroll 0 0;
    border-radius: 3px;
    box-shadow: 0 5px 30px 0 rgba(0, 0, 0, 0.04);
    margin-bottom: 0;
    padding: 30px;
}
#accordion .panel {
    border: medium none;
    border-radius: 0;
    box-shadow: none;
    margin: 0 0 15px 10px;
}
#accordion .panel-heading {
    border-radius: 30px;
    padding: 0;
}
#accordion .panel-title a {
    background: #40a8c4 none repeat scroll 0 0;
    border: 1px solid transparent;
    border-radius: 30px;
    color: #fff;
    display: block;
    font-size: 18px;
    font-weight: 600;
    padding: 12px 20px 12px 50px;
    position: relative;
    transition: all 0.3s ease 0s;
}
#accordion .panel-title a.collapsed {
    background: #fff none repeat scroll 0 0;
    border: 1px solid #ddd;
    color: #333;
}
#accordion .panel-title a::after, #accordion .panel-title a.collapsed::after {
    background: #40a8c4 none repeat scroll 0 0;
    border: 1px solid transparent;
    border-radius: 50%;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.58);
    color: #fff;
    content: "\f068";
    font-family: FontAwesome;
    font-size: 25px;
    height: 55px;
    left: -20px;
    line-height: 55px;
    position: absolute;
    text-align: center;
    top: -5px;
    transition: all 0.3s ease 0s;
    width: 55px;
}
#accordion .panel-title a.collapsed::after {
    background: #fff none repeat scroll 0 0;
    border: 1px solid #ddd;
    box-shadow: none;
    color: #333;
    content: "\f067";
}
#accordion .panel-body {
    background: transparent none repeat scroll 0 0;
    border-top: medium none;
    padding: 20px 25px 10px 9px;
    position: relative;
}
#accordion .panel-body p {
    border-left: 1px dashed #8c8c8c;
    padding-left: 25px;
}



</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String IntiationId=(String) request.getAttribute("IntiationId");
Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes");
List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList"); 

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



<div class="container">
	<div class="row" >
		<div class="col-md-12">

<%-- <%
if(DetailsList.isEmpty()){
%>
<p>asdsadasd</p>
<%}else{ 
for (Object[] obj : DetailsList) {%> --%>


		<form action="ProjectOtherDetailsAddSubmit.htm" method="POST" name="myfrm" id="myfrm" >	

			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			
				<div class="panel panel-default ">
					
					<div class="panel-heading" role="tab" id="headingOne">
						<h4 class="panel-title">
							<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
								Requirements
							</a>
						</h4>			
					</div>
					
					<div id="collapseOne" class="panel-collapse collapse in show" role="tabpanel" aria-labelledby="headingOne">
						<div class="panel-body">
							
							<%-- <%if(obj[0]!=null) {%><%=obj[0] %><%}else{ %>
							
							<p> 
							sadas
							</p>
							
							<%} %> --%>
								
						</div>
					</div>
				
				</div>
				
		<!-- ***** Objective ****** -->		
				
				<div class="panel panel-default">
				
					<div class="panel-heading" role="tab" id="headingTwo">
						<h4 class="panel-title">
							<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
								Objective 
							</a>
						</h4>
					</div>
					
					<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
							
							<div class="panel-body">
							<p>
								<div class="row"> 
									<div class="col-md-12"  style="top: 10px;">
									
										<div class="card" >
											<div class="card-body">
									    		
									  
									   				<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
														<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote1" class="center">		</div>
												
														</div>
									  
									  					<textarea name="Objective" style="display:none;"></textarea>
									  
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
														<input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
									 			
									 				</div>  
												
												
									 			<br>
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
										</div>
									</div>
								</div>
							</div>
							
						</div>
					</div>
						
			<!-- ***** Scope ******* -->									
						
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingThree">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
										Scope
									</a>
								</h4>
							</div>
							<div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
								<div class="panel-body">
							<p>
								<div class="row"> 
									<div class="col-md-12"  style="top: 10px;">
									
										<div class="card" >
											<div class="card-body">
									    		
									  
									   				<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
														<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote2" class="center">		</div>
												
														</div>
									  
									  					<textarea name="Scope" style="display:none;"></textarea>
									  
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
														<input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
									 			
									 				</div>  
												
												
									 			<br>
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
										</div>
									</div>
								</div>
							</div>
							</div>
						</div>
						
				<!-- ******** Multi-lab Work Share **************  -->		
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingFour">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
										Multi-Lab Work Share
									</a>
								</h4>
							</div>
							<div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
								<div class="panel-body">
							<p>
								<div class="row"> 
									<div class="col-md-12"  style="top: 10px;">
									
										<div class="card" >
											<div class="card-body">
									    		
									  
									   				<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
														<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote3" class="center">		</div>
												
														</div>
									  
									  					<textarea name="MultiLabWorkShare" style="display:none;"></textarea>
									  
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
														<input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
									 			
									 				</div>  
												
												
									 			<br>
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
										</div>
									</div>
								</div>
							</div>
							</div>
						</div>
						
				<!-- *********** Earlier Work *************** -->		
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingFive">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
										Earlier Work
									</a>
								</h4>
							</div>
							<div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
								<div class="panel-body">
							<p>
								<div class="row"> 
									<div class="col-md-12"  style="top: 10px;">
									
										<div class="card" >
											<div class="card-body">
									    		
									  
									   				<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
														<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote4" class="center">		</div>
												
														</div>
									  
									  					<textarea name="EarlierWork" style="display:none;"></textarea>
									  
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
														<input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
									 			
									 				</div>  
												
												
									 			<br>
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
										</div>
									</div>
								</div>
							</div>
							</div>
						</div>
						
			<!-- *********** Competency Established ***********  -->		
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingSix">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
										Competency Established 
									</a>
								</h4>
							</div>
							<div id="collapseSix" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSix">
								<div class="panel-body">
							<p>
								<div class="row"> 
									<div class="col-md-12"  style="top: 10px;">
									
										<div class="card" >
											<div class="card-body">
									    		
									  
									   				<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
														<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote5" class="center">		</div>
												
														</div>
									  
									  					<textarea name="CompentencyEstablished" style="display:none;"></textarea>
									  
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
														<input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
									 			
									 				</div>  
												
												
									 			<br>
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
										</div>
									</div>
								</div>
							</div>
							</div>
						</div>		
		
		<!-- ************** Need of Project **************** -->					
							
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingSeven">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
										Need of Project
									</a>
								</h4>
							</div>
							<div id="collapseSeven" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSeven">
								<div class="panel-body">
							<p>
								<div class="row"> 
									<div class="col-md-12"  style="top: 10px;">
									
										<div class="card" >
											<div class="card-body">
									    		
									  
									   				<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
														<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote6" class="center">		</div>
												
														</div>
									  
									  					<textarea name="NeedOfProject" style="display:none;"></textarea>
									  
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
														<input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
									 			
									 				</div>  
												
												
									 			<br>
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
										</div>
									</div>
								</div>
							</div>
							</div>
						</div>
						
				<!-- ********** Technology Challenges ***** -->
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingEight">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseEight" aria-expanded="false" aria-controls="collapseEight">
										Technology Challenges
									</a>
								</h4>
							</div>
							<div id="collapseEight" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingEight">
								<div class="panel-body">
							<p>
								<div class="row"> 
									<div class="col-md-12"  style="top: 10px;">
									
										<div class="card" >
											<div class="card-body">
									    		
									  
									   				<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
														<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote7" class="center">		</div>
												
														</div>
									  
									  					<textarea name="TechnologyChallanges" style="display:none;"></textarea>
									  
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
														<input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
									 			
									 				</div>  
												
												
									 			<br>
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
										</div>
									</div>
								</div>
							</div>
							</div>
						</div>
						
				<!-- Risk Mitigation -->		
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingNine">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseNine" aria-expanded="false" aria-controls="collapseNine">
										Risk Mitigation 
									</a>
								</h4>
							</div>
							<div id="collapseNine" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingNine">
								<div class="panel-body">
							<p>
								<div class="row"> 
									<div class="col-md-12"  style="top: 10px;">
									
										<div class="card" >
											<div class="card-body">
									    		
									  
									   				<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
														<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote8" class="center">		</div>
												
														</div>
									  
									  					<textarea name="RiskMitiagation" style="display:none;"></textarea>
									  
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
														<input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
									 			
									 				</div>  
												
												
									 			<br>
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
										</div>
									</div>
								</div>
							</div>
							</div>
						</div>
						
					<!-- Proposal -->	
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingTen">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTen" aria-expanded="false" aria-controls="collapseTen">
										Proposal
									</a>
								</h4>
							</div>
							<div id="collapseTen" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTen">
								<div class="panel-body">
							<p>
								<div class="row"> 
									<div class="col-md-12"  style="top: 10px;">
									
										<div class="card" >
											<div class="card-body">
									    		
									  
									   				<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
														<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote9" class="center">		</div>
												
														</div>
									  
									  					<textarea name="Proposal" style="display:none;"></textarea>
									  
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
														<input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
									 			
									 				</div>  
												
												
									 			<br>
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
										</div>
									</div>
								</div>
							</div>
							</div>
						</div>
						
						<!-- Realization Plan -->
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="headingEleven">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseEleven" aria-expanded="false" aria-controls="collapseEleven">
										Realization Plan
									</a>
								</h4>
							</div>
							<div id="collapseEleven" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingEleven">
								<div class="panel-body">
							<p>
								<div class="row"> 
									<div class="col-md-12"  style="top: 10px;">
									
										<div class="card" >
											<div class="card-body">
									    		
									  
									   				<div class="row"  style="margin-bottom: 10px;margin-top: -5px;">
														<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
										
															<div  id="summernote10" class="center">		</div>
												
														</div>
									  
									  					<textarea name="RealizationPlan" style="display:none;"></textarea>
									  
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
														<input type="hidden" name="IntiationId" value="<%=IntiationId %>" /> 
									 			
									 				</div>  
												
												
									 			<br>
									 			
									 			<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
									 		</div>
										</div>
									</div>
								</div>
							</div>
							</div>
						</div>
						
					
						<div class="form-group" align="center" >
							<button type="submit" class="btn btn-primary btn-sm submit" value="SUBMIT"   name="sub">SUBMIT </button>
							<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
						</div>
					
				</div>
				
				 
				
				
		</form>


<%-- <%}} %> --%>

 
        
		</div>
	</div>
</div>

  

	
<script type="text/javascript">

function Add(myfrm){
	
	 event.preventDefault();
	 var ShortName = $("#ShortName"). val();
		

$
.ajax({

type : "GET",
url : "ProjectShortNameCount.htm",
data : {
	ProjectShortName : ShortName
},
datatype : 'json',
success : function(result) {

	var result = JSON.parse(result);
	var values = Object.keys(result).map(function(e) {
		  return result[e]
		});


	if(result>0){
	   
		alert("Short Name Already Present")


}else{
	$('#myfrm').submit();
}
}
}); 

}


(function($) {
	'use strict';
	
	
	jQuery(document).on('ready', function(){
	
			$('a.page-scroll').on('click', function(e){
				var anchor = $(this);
				$('html, body').stop().animate({
					scrollTop: $(anchor.attr('href')).offset().top - 50
				}, 1500);
				e.preventDefault();
			});		

	}); 	

				
})(jQuery);

</script>

	 <script type="text/javascript">

	  $('#myForm').submit(function() {
	         
		 // var codee= tinymce.get("summernote").getContent();
		  //$('textarea[name=NoteText]').val(codee);
		  
		  
		  var data =CKEDITOR.instances['summernote'].getData();
		  $('textarea[name=NoteText]').val(data);
		  
		  
		  
      });


    
  $(document).ready(function(){
		
		$.ajax({
			type : "GET",
			url : "ProjectName.htm",
			
			datatype : 'json',
			success : function(result) {
				
				var result = JSON.parse(result);
				
			
				$('#ProjectName').html(result); 
			}
		});

	});
    </script>
   
<script>
CKEDITOR.replace( 'summernote', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>
<script>
CKEDITOR.replace( 'summernote1', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>
<script>
CKEDITOR.replace( 'summernote2', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>
<script>
CKEDITOR.replace( 'summernote3', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>
<script>
CKEDITOR.replace( 'summernote4', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>
<script>
CKEDITOR.replace( 'summernote5', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>
<script>
CKEDITOR.replace( 'summernote6', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>
<script>
CKEDITOR.replace( 'summernote7', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>
<script>
CKEDITOR.replace( 'summernote8', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>
<script>
CKEDITOR.replace( 'summernote9', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>
<script>
CKEDITOR.replace( 'summernote10', {
	
toolbar: [{
          name: 'clipboard',
          items: ['PasteFromWord', '-', 'Undo', 'Redo']
        },
        {
          name: 'basicstyles',
          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
        },
        {
          name: 'links',
          items: ['Link', 'Unlink']
        },
        {
          name: 'paragraph',
          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
        },
        {
          name: 'insert',
          items: ['Image', 'Table']
        },
        {
          name: 'editing',
          items: ['Scayt']
        },
        '/',

        {
          name: 'styles',
          items: ['Format', 'Font', 'FontSize']
        },
        {
          name: 'colors',
          items: ['TextColor', 'BGColor', 'CopyFormatting']
        },
        {
          name: 'align',
          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        },
        {
          name: 'document',
          items: ['Print', 'PageBreak', 'Source']
        }
      ],
     
    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

	customConfig: '',

	disallowedContent: 'img{width,height,float}',
	extraAllowedContent: 'img[width,height,align]',

	height: 200,

	
	contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

	
	bodyClass: 'document-editor',

	
	format_tags: 'p;h1;h2;h3;pre',

	
	removeDialogTabs: 'image:advanced;link:advanced',

	stylesSet: [
	
		{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
		{ name: 'Cited Work', element: 'cite' },
		{ name: 'Inline Quotation', element: 'q' },

		
		{
			name: 'Special Container',
			element: 'div',
			styles: {
				padding: '5px 10px',
				background: '#eee',
				border: '1px solid #ccc'
			}
		},
		{
			name: 'Compact table',
			element: 'table',
			attributes: {
				cellpadding: '5',
				cellspacing: '0',
				border: '1',
				bordercolor: '#ccc'
			},
			styles: {
				'border-collapse': 'collapse'
			}
		},
		{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
		{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } }
	]
} );


</script>



</body>
</html>