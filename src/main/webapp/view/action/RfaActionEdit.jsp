<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
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

<title>RFA Action Edit</title>

<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}

.form-group {
    margin-top: 0.5rem;
    margin-bottom: 1rem;
}
#filealert {
    color: red;
    font-weight:bold;
    font-size: 19px;
    margin-left: 22%;
    margin-top: 5px;
  }
</style>

</head>
<body>


<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
Object[] RfaAction=(Object[]) request.getAttribute("RfaAction");
Object[] rfaAttachDownload=(Object[]) request.getAttribute("rfaAttachDownload");
List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
List<Object[]> ProjectTypeList=(List<Object[]>)request.getAttribute("ProjectTypeList");
List<Object[]> PriorityList=(List<Object[]>)request.getAttribute("PriorityList");
List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
List<Object[]> AssigneeList=(List<Object[]>) request.getAttribute("AssigneeEmplList"); 
List<Object[]> vendorList=(List<Object[]>)request.getAttribute("vendorList");
String Project="";
String assigneeLab=(String)request.getAttribute("assigneeLab");
%>
<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</center>
	<%}if(ses!=null){ %>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</center>
	<%} %>

<div class="container-fluid">
	<form action="#" method="POST" name="myfrm" id="myfrm" autocomplete="off" enctype="multipart/form-data" >
 			<div class="card shadow-nohover" style="margin-top:0px">		
				<div class="row card-header">
			   			<div class="col-md-6">
							<h4>RFA EDIT</h4>
						</div>
						<div class="col-md-3">
							
						</div>						
						
					 </div>
        
        		<div class="card-body">
            <div class="row">
		                    <div class="col-md-1">
		                        <div class="form-group">
		                            <label class="control-label">Project</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
			             
			  							<%for (Object[] obj : ProjectList) { 
											if(obj[0].toString().equalsIgnoreCase(RfaAction[2].toString())){
												Project=obj[0].toString();
											%>
											<input class="form-control" name="projectCode" value="<%=obj[4].toString()%>" readonly="readonly">
											<%}} %>
			  						
		                        </div>
		                    </div>
		                    
		                   <div class="col-md-2">
		                       <div class="form-group">
		                            <label class="control-label"> RFA No.</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
		                            <input  class="form-control"  name="rfano" id="rfano" readonly="readonly"  value="<%=RfaAction[3]%>">	
		                      </div>
		                   </div> 
		                    
						<input type="hidden" name="rfaid" value="<%=RfaAction[0] %>">
		                    <div class="col-md-2">
		                        <div class="form-group">
		                            <label class="control-label">Priority</label>
		                            	<select class="custom-select"  required="required"name="priority" id="priority">
										    <option disabled="true"  selected value="">Choose...</option>
											<% for (Object[] obj : PriorityList) {%>
											<option value="<%=obj[0]%>"<%if(obj[0].toString().equalsIgnoreCase(RfaAction[5].toString())){ %> selected <%} %>><%= "(" + obj[0] + ")" + obj[1]%></option>
											<%} %>
		  								</select>
		                        </div>
		                    </div>
		                   </div>
		                    <div class="row">
		                    <%if(RfaAction[15].toString().equalsIgnoreCase("E")){ %>
		                        <div class="col-md-3" id="vendorDiv" style="">
		                     <div class="form-group">
		                            <label class="control-label"> Vendor</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
		                            <select class="form-control selectdee" required="required" name="vendor" id="vendor"  onchange="chooseEmp()">                   
		                            <option  value="" selected>SELECT</option>
		                            <% if(vendorList!=null && vendorList.size()>0){
		                            for(Object[] obj : vendorList) { %>
		                            <option value="<%=obj[0]+"/"+obj[3]%>"   <%if((assigneeLab).equalsIgnoreCase(obj[0].toString())) {%> selected <%}else {%> disabled <%} %>><%=obj[1]%>( <%=obj[0] %> )</option>
		                            <%}} %>
		                           </select>
		                           <!--  <input  class="form-control"  name="rfano" id="rfano"  required="required"  placeholder="Enter RFA Number" > -->	
		                      </div>
		                   </div> 
		                    <%} %>
		                  <div class="col-md-4">
		                     <div class="form-group">
		                            <label class="control-label">Assigned To</label>
		                     <select class="form-control selectdee" required="required" name="assignee" id="assignee" multiple="multiple" data-placeholder= "Select Employees">                   
		                         <% for(Object[] obj : EmployeeList) { %>
		                         <option value="<%=obj[0]%>"><%=obj[1]%> , <%=obj[2]%></option>
		                         <%} %>
		                      </select>
		                  </div>
		                </div> 
		                
		                  <div class="col-md-1">
		                       <div class="form-group">
		                            <label class="control-label">RFA Date</label>
						  			<input  class="form-control form-control date"  data-date-format="dd-mm-yyyy" id="datepicker1" name="rfadate"  
						  			value="<%=new FormatConverter().SqlToRegularDate(  RfaAction[4].toString() )%>" style="width: 110%;">						
		                        </div>
		                  </div> 
		                  
		                   <div class="col-md-4">
		                     <div class="form-group">
		                         <label class="control-label">CC To</label>
		                         <select class="form-control selectdee" name="CCEmpName" id="CCEmpName" multiple="multiple" data-placeholder= "Select Employees">                   
		                         <% for(Object[] obj : EmployeeList) { %>
		                         <option value="<%=obj[0].toString()%>/<%=obj[3].toString()%>"><%=obj[1]%> , <%=obj[2]%></option>
		                         <%} %>
		                      </select>
		                  </div>
		                </div>   
		            
		          </div>
		          
		            <br>
		      
		            <div class="row">
		                  <div class="col-md-2" style="max-width: 18%">
		                      <label class="control-label"> Problem Statement</label>
		                  </div>
		                  <div class="col-md-10">
		                      <textarea class="form-control" rows="2" cols="30" name="statement" id="statement"><%=RfaAction[6].toString() %></textarea>
		                  </div>
		            </div>
		            
		            <br>
		            
		         <div class="row">
		            
		                 <div class="col-md-2">
		                 <label class="control-label">Description</label>
		                   <span class="mandatory" style="color: #cd0a0a;">*</span>
		              </div>
		            <div class="col-md-10">
	      			<div class="card"  >
	      			<h5 class="heading ml-4 mt-3" id="editorHeading" style="font-weight:500;color: #31708f;"></h5><hr>
    				<div class="card-body" >
					<div class="row">	
					<div class="col-md-12" align="left" style="margin-left: 0px; width: 100%;">
					<div id="Editor" class="center"><%=RfaAction[7].toString() %></div>
					<textarea name="description" id="description" style="display: none;"></textarea>
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
					</div>
					</div>
					</div>
					</div>
	         		</div>
		          </div>
		            
		            <br>
		            
		            <div class="row">
		                  <div class="col-md-2" style="max-width: 18%">
		                      <label class="control-label">References</label>
		                  </div>
		                  <div class="col-md-10">
		                       <textarea class="form-control" rows="2" cols="30" name="reference" id="reference"><%=RfaAction[8].toString() %></textarea>
		                  </div> 
		            </div>
		            
		            <br>
		           
		            <div class="row">
		                <div class="col-md-4" style="max-width: 18%">
		                      <label class="control-label">Attachment</label>
		                  </div>
		                  <div class="col-md-4" style="max-width: 40%;margin-left: -22px;">    
		                      <input class="form-control" type="file" name="attachment"  id="attachment" accept="application/pdf , image/*" oninput="validateFile(this)">
		                  </div>
		                  <%if(rfaAttachDownload!=null){ %> 
		                  <div class="col-md-4" style="max-width: 40%">    
		                      <button  type="submit" class="btn btn-sm "  style="margin-left: 0rem;" name="filename" value=""  formaction="RfaAttachmentDownload.htm" formtarget="_blank" ><i class="fa fa-download fa-lg" ></i></button>
		                      <span><%=rfaAttachDownload[3]%></span>
		                  </div>
		                    <input type="hidden" name="type" value="ARD">
		                    <input type="hidden" name="rfaId" value="<%=rfaAttachDownload[1]%>">
		                 <%} %>
		                  <div id="filealert"></div>
		            </div>
		            
		             <br>
		            
		        <div class="form-group" align="center" >
					 <input type="button" class="btn btn-primary btn-sm submit" onclick="return editRfa()" formaction="RfaAEditSubmit.htm" value="SUBMIT" id="rfaEditSubBtn"> 
					 <a class="btn btn-info btn-sm  shadow-nohover back" href="RfaAction.htm?Project=<%=Project%>" >Back</a>
				</div>

				<input type="hidden" name="${_csrf.parameterName}"		value="${_csrf.token}" /> 
 		
   </div>    
        

        
        </div>
</form>
</div>
  
  
  <script type="text/javascript">
  function editRfa() {
	  var priority=$('#priority').val();
	  var statement=$('#statement').val();
	  var description=$('#description').val();
	  var reference=$('#reference').val();
	  
/* 	 if(priority==""||priority==null || priority=="null"){
				 alert('Please Select priority');
				   return false;
		   }else if(statement==""||statement==null || statement=="null"){
				 alert('Please Enter statement');
				 document.getElementById("statement").style.boxShadow = "rgb(239, 7, 7) 0px 0px 1px 1px";
				   return false;
		   }else if(description==""||description==null || description=="null"){
				 alert('Please Enter description');
				 document.getElementById("description").style.boxShadow = "rgb(239, 7, 7) 0px 0px 1px 1px";
				   return false;
		   }else if(reference==""||reference==null || reference=="null"){
				 alert('Please Enter reference');
				 document.getElementById("reference").style.boxShadow = "rgb(239, 7, 7) 0px 0px 1px 1px";
				   return false;} */
	  
	  var confirmation=confirm("Are you sure you want to edit RFA details?");
	  if(confirmation){
		  var form = document.getElementById("myfrm");
		   
          if (form) {
        	  
        	  var data =CKEDITOR.instances['Editor'].getData();
        		 $('textarea[name=description]').val(data);
        	  
              var rfaEditSubBtn = document.getElementById("rfaEditSubBtn");
              if (rfaEditSubBtn) {
                  var formactionValue = rfaEditSubBtn.getAttribute("formaction");
                   form.setAttribute("action", formactionValue);
                    form.submit();
                }
           }
	  } else{
    	  return false;
	  }
	
}
  
	$('#datepicker1').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,

		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	  $('#reference,#description,#statement').keyup(function (){
		  $('#reference,#description,#statement').css({'-webkit-box-shadow' : 'none', '-moz-box-shadow' : 'none','background-color' : 'none', 'box-shadow' : 'none'});
			  });
	  
	  $("input").on("keypress", function(e) {
		    if (e.which === 32 && !this.value.length)
		        e.preventDefault();
		});
	  $("textarea").on("keypress", function(e) {
		    if (e.which === 32 && !this.value.length)
		        e.preventDefault();
		});
	  
	  function chooseEmp(){
			var labCode=$('#vendor').val().split("/")[1];
			var vendortype=$('#vendor').val().split("/")[0];
			
			$.ajax({
					
					type : "GET",
					url : "ActionAssigneeEmployeeList.htm",
					data : {
						LabCode : labCode,	
					},
					datatype : 'json',
					success : function(result) {
						var result = JSON.parse(result);
						var values = Object.keys(result).map(function(e) {
							return result[e]
						});
						
						var s = '';
						s += '<option   value="">SELECT</option>';
						if(labCode == '@EXP'){
							values = values.filter(e => e[4] == vendortype)
						} 
						console.log(values)
						for (i = 0; i < values.length; i++) 
						{

							s += '<option value="'+values[i][0]+'">'+values[i][1] + ', ' +values[i][3] + '</option>';
						} 
						$('#assignee').html('');
						$('#assignee').html(s);
					 /* $('#ApprovingOfficer').val(''+value).trigger('change'); */ 
						var assignEmp = <%=request.getAttribute("AssignEmp") %>
						$('#assignee').val(assignEmp).trigger('change');
					}
				});
		}
	  $( document ).ready(function() {
		  
		  <%if(RfaAction[15].toString().equalsIgnoreCase("E")){ %>
		  chooseEmp()
		  <%}%>
		  var assignEmp = <%=request.getAttribute("AssignEmp") %>;
		  var ccEmpName = <%=request.getAttribute("RfaCCEmp") %>;
		  console.log(ccEmpName);
		  $('#CCEmpName').val(ccEmpName).trigger('change');
		  console.log(assignEmp);
		  $('#assignee').val(assignEmp).trigger('change');
		});
	  
	 <%--  $( document ).ready(function() {
		  var ccEmpName = <%=request.getAttribute("RfaCCEmp") %>;
		  console.log(ccEmpName);
		  $('#CCEmpName').val(ccEmpName).trigger('change');
		});
	   --%>
	  	 
 var editor_config = {
	 				
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

	 					height: 250,

	 					
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
	 						{ filebrowserUploadUrl: '/path/to/upload-handler'},
	 					]
	 				} ;
CKEDITOR.replace('Editor',editor_config);

</script> 
<script>
function validateFile(input) {
  const file = input.files[0];
  const allowedTypes = ['image/jpeg', 'image/png', 'application/pdf'];

  if (!file) return;

  if (!allowedTypes.includes(file.type)) {
    document.getElementById('filealert').innerText = 'Only image and PDF files are allowed!';
    // Clearing the file input to prevent submission
    input.value = '';
  } else {
    document.getElementById('filealert').innerText = '';
  }
}
</script>
  
</body>
</html>