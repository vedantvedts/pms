<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/content.css" var="contentCss" />

 <script src="${ckeditor}"></script>
 <link href="${contentCss}" rel="stylesheet" />
<title>FEED BACK</title>
<style type="text/css">
.table thead tr th {
	background-color: aliceblue;
	
}

.table thead tr td {
	background-color: #f9fae1;
	text-align: left;
}



</style>
</head>
<body>


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


	<div class="row">
		<div class="col-md-12 ">
			<div class="card shadow-nohover" >
				<div class="card-header" >
					<div class="row">
						<div class="col-md-6"><h3>FEEDBACK</h3></div>
						<div class="col-md-6"><a class="btn btn-sm back" href="FeedBack.htm" style="float: right;">BACK</a></div>
					</div>
				</div>
				<div class="card-body">
				
					<form action="FeedBackAdd.htm" method="POST" id="Feedbackadd">
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped table-condensed " id="myTable16">
								<thead>
									<tr>
										<th style="text-align: left;"><label>Feedback Type: <span class="mandatory" style="color: red;">*</span></label></th>
										<td>
											<select class="form-control selectdee" id="ftype" name="feedbacktype" data-container="body" data-live-search="true"   style="font-size: 5px;">
												<option value=""  selected="selected"	hidden="true">--Select--</option>
												<option value="B">Bug</option>
												<option value="C">Content Change</option>
												<option value="U">User Interface</option>
												<option value="N">New Requirement</option>
											</select>
										</td>
									</tr>
									<tr>
										<th style="text-align: left;"><label>Feedback: <span class="mandatory" style="color: red;">*</span></label></th>
										<td colspan="3">
							            	<textarea  id="summernote" class="center"></textarea>
											<textarea name="Feedback" style="display: none;"></textarea>
										</td>
									</tr>
							
								</thead>
							</table>
						</div>
						
						<div align="center">
							<input type="submit" class="btn btn-primary btn-sm editbasic"  value="Submit"  name="sub" onclick="return confirm('Are You Sure to Submit?');"/>
						</div>
																	
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
															
				</div>
			</div>
		</div>
	</div>	





 

 
</body>
<script type="text/javascript">

	  $("#Feedbackadd").on('submit', function (e) {

		  var data =CKEDITOR.instances['summernote'].getData();
		  console.log(data);
		  var feedbacktype = $('#ftype').val();
		  if(data=='' ){
			  alert("Please Enter Feedback!");
			  return false;
		  }else if(feedbacktype=='' ){
			  alert("Please Select Feedback Type!");
			  return false;
		  }else{
			  $('textarea[name=Feedback]').val(data);
			  return true;
		  }
			  
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
  
</html>