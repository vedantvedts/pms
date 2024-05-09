<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@page import="java.util.List , java.util.stream.Collectors,com.vts.pfms.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
 <script src="${ckeditor}"></script>
 <link href="${contentCss}" rel="stylesheet" />
<title>Project Slide</title>
<style type="text/css">
[type=radio] { 
  position: absolute;
  opacity: 0;
  width: 0;
  height: 0;
}

/* IMAGE STYLES */
[type=radio] + img {
  cursor: pointer;
}

/* CHECKED STYLES */
[type=radio]:checked + img {
  border: 1px solid #fff;
  box-shadow: 0 0 3px 3px #5b45b1;
  transition: 500ms all;
}
</style>
</head>
<body>
<%
Object[] projectdata = (Object[])request.getAttribute("projectdata");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
NFormatConvertion nfc=new NFormatConvertion();
double cost = Double.parseDouble(projectdata[3].toString());
String enduser="--";
if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("IA")){
	enduser="Indian Army";
}else if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("IN")){
	enduser="Indian Navy";
}else if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("IAF")){
	enduser="Indian Air Force";
}else if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("IH")){
	enduser="Home Land Security";
}else if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("DRDO")){
	enduser="DRDO";
}else if(projectdata!=null && projectdata[6]!=null && projectdata[6].toString().equalsIgnoreCase("OH")){
	enduser="Others";
}
%>
<div class="container-fluid">
	<div class="card shadow-nohover" style="border-radius: 36px;border-color: green; border-width: 6px;">
		<h4 class="card-title" align="center" style="color: #c72626;margin-top: 5px;height:"> <%if(projectdata!=null && projectdata[1]!=null){%><%=projectdata[1]%> <%}%></h4>
		<div class="card-body" style="padding: 0.25rem;">
			<div class="row">
				<div class="col-md-7">
				<div class="row"><div class="col">
					<table class="table meeting" style="font-weight: bold;" >
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold; color: #115bc9;">Project No :</td>
							<td style="width: 310px;"><%=projectdata[11]%></td>
						</tr>
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Category :</td>
							<td><%=projectdata[2]%></td>
						</tr>
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Cost Rs.:</td>
							<td><%=nfc.convert(cost/10000000)%> (In Cr)</td>
						</tr>
						
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">Application :</td>
							<td><%if(projectdata!=null && projectdata[10]!=null){%><%=projectdata[10]%><%}else{%> -- <%}%></td>
						</tr>
					</table>
					</div>
					<div class="col">
					<table class="table meeting" style="font-weight: bold;" >
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">User :</td>
							<td><%=enduser%></td>
						</tr>
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">DoS :</td>
							<td><%=sdf.format(projectdata[5]) %></td>
						</tr>
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;">PDC :</td>
							<td><%=sdf.format(projectdata[4]) %></td>
						</tr>
					</table>
					</div>
					</div>
				</div>
				<div class="col-md-4">
					<table class="table meeting" style="font-weight: bold;" >
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;width: 500px;">Objectives :</td>
							<td style="width: 740px;"><%=projectdata[7]%></td>
						</tr>
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;width: 500px;">Scope :</td>
							<td style="width: 720px;"><%if(projectdata!=null && projectdata[9]!=null){%><%=projectdata[9]%><%}else{%> -- <%}%></td>
						</tr>
						<tr>
							<td style="font-size: 1.02rem;font-weight: bold;color: #115bc9;width: 500px;">Deliverables :</td>
							<td style="width: 720px;"><%=projectdata[8]%></td>
						</tr>
					</table>
				</div>
			</div>	
			<hr style="margin: 0px 0px !important;">	
			<form action="AddProjectSlides.htm" method="post" enctype="multipart/form-data" id="formslide">	
			 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			 <input type="radio" name="silde" value="1"  />
			 <input type="radio" name="silde" value="2"  />
			<div class="card" style="margin-top: 5px;">
				 <div class="card-body">
				 <div class="container-fluid" >
				 	<div class="row" >
				 		<div class="col" >
				 			<div class="form-check form-check-inline" style="text-align: center;width: 100%">
									<label class="form-check-label" style="margin: auto;"  for="Status"> <b>Brief : </b> </label>
						</div>
						<textarea class="form-control" placeholder="Enter Maximum 5000 charcters" name="Status" id="ckeditor1" rows="5" cols="20" maxlength="5"></textarea>
				 		</div>
				 		<div class="col" >
				 			<div class="container-fluid" >
				 				<div class="row" >
				 					<div class="col" >
														<div class="form-group">
															<label><b> Image : </b></label><span class="mandatory">*</span>
															<input class="form-control form-control" type="file"
																name="Attachment1" id="Attachment1"
																accept="image/png, image/jpeg" required="required"
																maxlength="3" style="font-size: 15px;">
														</div>
												</div>
												<div class="col">
														<div class="form-group">
															<label><b> Attachment : </b></label>
																<input
																class="form-control form-control" type="file"
																name="Attachment2" id="Attachment2"
																accept="application/pdf, application/vnd.ms-excel"
																 maxlength="3"
																style="font-size: 15px;">
														</div>
												</div>
											</div>
											<div class="row" >
											<div class="col" >
						<div align="center">
							<input type="hidden" name="projectid" value="<%=projectdata[0]%>">
							<button type="button" style="margin-top: 10px;" class="btn btn-primary btn-sm add"  onclick="return checkData()">Submit </button>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</div>
						</div>
						</div>
				 			</div>
				 		</div>
				 		
				 	</div>
				 	<hr>
				 </div>
						
				</div>
			</div>
			</form>
		</div>
	</div>			
</div>		
<script type="text/javascript">

var editor_config = {
	
	maxlength: '4000',
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

		height: 150,
		
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
			{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } },
			]
	} ;
CKEDITOR.replace('ckeditor1', editor_config );


function checkData(){
	$("input[name='silde']")[0].checked= false;
	$("input[name='silde']")[1].checked= true;
	var silde = $("input[name='silde']").serializeArray();
	var status = CKEDITOR.instances['ckeditor1'].getData();
	var attachment  = $("#Attachment1").val();
	var attachment2  = $("#Attachment2").val();
	
	 if (silde.length === 0){
		  alert("Please Select Atleast One Silde!");
		  event.preventDefault();
		  return false;
	 }else if(attachment=='' || attachment=='null' || attachment==null){
		 alert("Please Select Image !");
		  event.preventDefault();
		  return false;
	 }else{
		 if(confirm("Are you sure to submit?")){
			 $("#formslide").submit();
			  event.preventDefault();
			 return true;
		 }else{
			 return false;
		 }
	 }
}
</script>						 
</body>
</html>