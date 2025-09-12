<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>PMS</title>
<spring:url value="/resources/css/fileRepo/PreProjectFileUpload.css" var="preProjectFileUpload" />
<link href="${preProjectFileUpload}" rel="stylesheet" />
</head>
<body>
	<%List<Object[]> ProjectIntiationList=(List<Object[]>)request.getAttribute("ProjectIntiationList"); 
	String projectshortName=(String)request.getAttribute("projectshortName");
    String initiationid=(String)request.getAttribute("initiationid");
    String projectTitle=(String)request.getAttribute("projectTitle");
    String filesize=(String) request.getAttribute("filesize"); 
  	String stepdidno=(String)request.getAttribute("stepdidno");
  	String proejecttypeid=(String)request.getAttribute("proejecttypeid");
  
	List<Object[]>steps=(List<Object[]>)request.getAttribute("stepsName"); 
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
	<div id="reqmain" class="card-slider">
		<form class="form-inline" method="POST"
			action="PreProjectFileUpload.htm">
			<div class="row W-100 w-80 m-t-5 " >
				<div class="col-md-2" id="div1">
					<label class="control-label project-font">Project Name :</label>
				</div>
				<div class="col-md-2 mt-1"  id="projectname">
					<select class="form-control selectdee" id="project"
						required="required" name="project">
						<%if(!ProjectIntiationList.isEmpty()) {
                                        for(Object[]obj:ProjectIntiationList){%>
						<option value="<%=obj[0]+"/"+obj[4]+"/"+obj[5]+"/"+obj[11]%>"
							<%if(obj[4].toString().equalsIgnoreCase(projectshortName)) {%>
							selected <%} %>><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></option>
						<%}} %>
					</select>
			
				</div>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input id="submit" type="submit"
					name="submit" value="Submit" hidden="hidden">
			</div>
		</form>	
		<div class="container-fluid"  id="main">
			<div class="row">
				<div class="col-md-12">
					<div class="card shadow-nohover" >
						<div class="row card-header main-bg">
							<div class="col-md-10" id="projecthead">
								<h5 class="ml-1">
									<%="Document Upload for  Project "+(projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName): " - ") %>
								</h5>
							</div>
							<div class="col-md-2" id="addReqButton">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden"
									name="projectshortName" value="<%=projectshortName %>" /> <input
									type="hidden" name="IntiationId" value="<%=initiationid %>" />
							</div>
						</div>
						<div class="card-body bg-shadow">
							<div class="row">
								<div class="col-md-6">
									<form action="#">
										<ul class="m-l-4">
											<%for(Object[]obj:steps) {%>
											<li><span class="caret" id="span<%=obj[0] %>"
												onclick="onclickchange(this,'<%=obj[0]%>','<%=obj[1]%>');"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></span>
												<ul class="nested" id="<%=obj[0]%>"></ul></li>
											<%} %>
										</ul>
									</form>
								</div>

								<div class="col-md-6 border" id="filestable">
									<div class="filestable-padding"
										align="center">
										<span id="tablehead"></span>
									</div>
									<form action="#">
										<div class="form-width">
											<div class="table-responsive ">
												<table class="table table-bordered  " id="MyTable1">
													<thead class="text-center">
														<tr>
															<th class="w-0" >SN</th>
															<th class="w-40" >Name</th>
															<th class="w-22" >UpdateOn</th>
															<th class="w-5" >Ver</th>
															<th >Action</th>
														</tr>
													</thead>
													<tbody id="listtbody">

													</tbody>
												</table>
											</div>
											</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!--modal for file upload  -->
	<form class="form-horizontal" role="form"
		action="PreProjectFileSubmit.htm" method="POST" id="myform2"
		enctype="multipart/form-data">
		<div class="modal fade bd-example-modal-lg" id="exampleModalLong"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-jump">
				<div class="modal-content addreq mt-16">
					<div class="modal-header" id="modalreqheader">
						<h5 class="modal-title" id="exampleModalLabel">Document
							Upload</h5>
						<button type="button" class="close text-white" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="col-md-12 mt-3" >
							<div class="row mt-1">
								<div class="col-md-4 ">
									<label id="fileName">Document Name:</label><span
										class="mandatory" >*</span>
								</div>
								<div class="col-md-5">
									<input type="text" class="form-control" id="filename"
										name="filename" required maxlength="255"
										onchange="oninputChange()" placeholder="max 255 characters">
								</div>
								<div class="col-md-12 mt-3" >
									<div class="row mt-1">
										<div class="col-md-4 ">
											<label id="file">Choose File:</label><span class="mandatory">*</span>
										</div>
										<div class="col-md-5">
											<input class="form-control" required type="file"
												name="Attachment" id="Attachment1"
												accept=".pdf"
												onchange=" editcheck('Attachment1',1)">
										</div>
									</div>
								</div>
								<div class="col-md-12 mt-3" >
									<div class="row mt-1">
										<div class="col-md-4 ">
											<label id="filedesc">Document Description:</label><span
												class="mandatory">*</span>
										</div>
										<div class="values"></div>
										<div class="col-md-5">
											<input type="text" class="form-control line-height" maxlength="512"
												name="description" >
										</div>
									</div>
								</div>
							</div>
						</div>

						<input type="hidden" name="IntiationId" value="<%=initiationid %>" />
						<input type="hidden" name="projectshortName"
							value="<%=projectshortName %>" />
						<div class="form-group mt-4" align="center">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<button type="submit" class="btn btn-primary btn-sm submit"
								id="add" name="action" value="SUBMIT"
								onclick="return reqCheck('myform1');">SUBMIT</button>
							<input type="hidden" name="versionvalue">
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<!--  -->

	<!-- modal for soc -->


	<!-- modal for version change  -->
	<form class="form-horizontal" role="form"
		action="PreProjectFileSubmit.htm" method="POST" id="myform2"
		enctype="multipart/form-data">
		<div class="modal fade bd-example-modal-lg" id="versionUpload"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-jump">
				<div class="modal-content addreq mt-16" >
					<div class="modal-header" id="modalreqheader">
						<h5 class="modal-title" id="exampleModalLabel">Document
							Version Upload</h5>
						<button type="button" class="close text-white" data-dismiss="modal"
							aria-label="Close" >
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="col-md-12 mt-3" >
							<div class="row mt-1">
								<div class="col-md-4 ">
									<label id="fileName">Document Name:</label>
								</div>
								<div class="col-md-5">
									<input type="text" class="form-control" name="filename"
										id="versionfile" readonly>
								</div>
							</div>
						</div>
						<div class="col-md-12 mt-3">
							<div class="row mt-1">
								<div class="col-md-4 ">
									<label id="file">Choose File:</label><span class="mandatory">*</span>
								</div>
								<div class="col-md-5">
									<input class="form-control" type="file" name="Attachment"
										id="Attachment1" accept=".pdf"
										onchange=" editcheck('Attachment1',1)" required>
								</div>
							</div>
						</div>
						<div class="col-md-12 mt-3" >
							<div class="row mt-1">
								<div class="col-md-4 ">
									<label id="file">Is this New Version?</label>
								</div>
								<div class="col-md-4">
									<input type="radio" name="isnewver" id="isnewvery" value="Y">&nbsp;&nbsp;Yes
									&emsp; <input type="radio" name="isnewver" id="isnewvery"
										value="N" checked>&nbsp;&nbsp;No
								</div>
							</div>
						</div>
						<div id="versioneditvalues"></div>
						<div class="col-md-12 mt-3" >
							<div class="row mt-1">
								<div class="col-md-4 ">
									<label id="filedesc">Document Description:</label><span
										class="mandatory" >*</span>
								</div>
								<div class="col-md-5">
									<input type="text" class="form-control line-height" maxlength="512"
										name="description" >
								</div>
							</div>
						</div>

						<input type="hidden" name="IntiationId" value="<%=initiationid %>" />
						<input type="hidden" name="projectshortName"
							value="<%=projectshortName %>" />
						<div class="form-group mt-4" align="center" >
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<button type="submit" class="btn btn-primary btn-sm submit"
								id="add1" name="action" value="SUBMIT"
								onclick="return reqCheck('myform1');"></button>

						</div>
					</div>

				</div>
			</div>
		</div>
	</form>

	<!--  -->
	<script>
		$(document).ready(function() {
			   $('#project').on('change', function() {
				   var temp=$(this).children("option:selected").val();
				   $('#submit').click(); 
			   });
			});		
		
		<%if(projectshortName!=null){%>
		$(document).ajaxComplete(function(){
			$('#main').css("display", "inline-block");
			$('#main').css("margin-top", "0.5%");
			$('#message').css("display","block");

		});
		<%}%>
		
		var toggler = document.getElementsByClassName("caret");
		var i;

		for (i = 0; i < toggler.length; i++) {
		  toggler[i].addEventListener("click", function() {
		    this.parentElement.querySelector(".nested").classList.toggle("active");
		    this.classList.toggle("caret-down");
		  });
		}
		 
		 function onclickchange(ele,stepid,stepname)
		 {
			
		 	elements = document.getElementsByClassName('caret');
		     for (var i1 = 0; i1 < elements.length; i1++) {
		     	$(elements[i1]).css("color", "black");
		     	$(elements[i1]).css("font-weight", "");
		     }
           elements = document.getElementsByClassName('caret-last');
		     for (var i1 = 0; i1 < elements.length; i1++) {
		     	$(elements[i1]).css("color", "black");
		     	$(elements[i1]).css("font-weight", "");
		     } 
		 $(ele).css("color", "green");
		 $(ele).css("font-weight", "700");
		  $('#filestable').css("display","none");
		 
			var initiationId=<%=initiationid%>;
		 $('.values').html('<input type="hidden" id="stepnames" name="stepid" value="'+stepid+'">')
		 var html="";
		 if(stepid!=3){
		 $.ajax({
			 type:'GET',
			 url:'PreprojectFiles.htm',
			 datatype:'json',
			 data:{
				 stepid:stepid,
				 initiationid:initiationId,
			 },
		 success:function(result){
			 
			 var ajaxresult=JSON.parse(result);
			 for(var i=0;i<ajaxresult.length;i++){
		
		
				 html=html+"<li><span class='caret file' id='file"+ajaxresult[i][8]+"' onclick='showTable("+ajaxresult[i][8]+","+ajaxresult[i][1]+","+ajaxresult[i][2]+")'>"+ajaxresult[i][4]+"(Ver -" +ajaxresult[i][6]+")"+"</span><button class='btn verupload' type='button' onclick='uploadshow("+ajaxresult[i][2]+","+ajaxresult[i][6]+","+JSON.stringify(ajaxresult[i][4])+","+ajaxresult[i][8]+")' ><i class='fa fa-upload icon-col' aria-hidden='true'></i></button><button type='submit' class='btn' id='download'  name='DocId'  formaction='ProjectRequirementAttachmentDownload.htm' formtarget='_blank' formmethod='GET' value='"+ajaxresult[i][8]+","+ajaxresult[i][6]+","+ajaxresult[i][1]+","+ajaxresult[i][2]+"' ><i class='fa fa-download' ></i></button></li>"
			 }
			 console.log(ajaxresult.length+"----")
			 /*button for adding files in list  */
				 $('#'+stepid).html(html+'<li class="m-t-5"><span class="caret"><button class="btn btn-sm btn-info" type="button" onclick="show()">Add File</button></span></li>');
			 }
			 
		 })
		 }else if(stepid==3){
			 html=html+"<li class='mt-1'><span class='caret soc' id='soc1' onclick='socDoc("+1+","+stepid+")'>FYPL/DRDODivisionDocument/Roadmap of DRDO plan Project </span ><span class='socDocuments' id='socdoc1'></span></li>"
			 +"<li class='mt-1'><span class='caret soc' id='soc2' onclick='socDoc("+2+","+stepid+")'>System Analysis Report </span><span class='socDocuments' id='socdoc2'></span></li>"
			 +"<li class='mt-1'><span class='caret soc' id='soc3' onclick='socDoc("+3+","+stepid+")'> Cluster Council Recommendation </span><span class='socDocuments' id='socdoc3'></span></li>"
			 +"<li class='mt-1'><span class='caret soc' id='soc4' onclick='socDoc("+4+","+stepid+")'>Peer Review Committee Recommendation(MM/TD) </span><span class='socDocuments' id='socdoc4'></span></li>"
			 +"<li class='mt-1'><span class='caret soc' id='soc5' onclick='socDoc("+5+","+stepid+")'>PDR committee Recommendation </span><span class='socDocuments' id='socdoc5'></span></li>"
			 +"<li class='mt-1'><span class='caret soc' id='soc6' onclick='socDoc("+6+","+stepid+")'>DMC-AON Recommendation </span><span class='socDocuments' id='socdoc6'></span></li>"
			 +"<li class='mt-1'><span class='caret soc' id='soc7' onclick='socDoc("+7+","+stepid+")'>TRL Analysis Report </span><span class='socDocuments' id='socdoc7'></span></li>"
			 +"<li class='mt-1'><span class='caret soc' id='soc8' onclick='socDoc("+8+","+stepid+")'>Project Execution plan Attachment </span><span class='socDocuments' id='socdoc8'></span></li>"
			;
			$('#'+stepid).html(html);
		 }
		 showStepTable(stepid,initiationId);
		 
		 }
		 
		 	 function socDoc(Documentid,stepid,name) {
		 		  $('.soc').css("color","black");
				  $('.soc').css("font-weight", "400");
				  $('#soc'+Documentid).css("color","green");
				  $('#soc'+Documentid).css("font-weight", "700");
				  
				 var fileName= String(document.getElementById('soc'+Documentid).innerHTML);
				 console.log(typeof fileName);
				  var initiationId=<%=initiationid%>;
				  $.ajax({
					 type:'GET',
					 url:'ProjectFilesSoc.htm',
					 datatype:'json',
					 data:{
						 Documentid:Documentid,
						 stepid:stepid,
						 initiationid:initiationId,
					 },
					 success:function(result){
						 var ajaxresult=JSON.parse(result);
						 console.log(ajaxresult);
						 if(stepid==3){
						 $('#filename').val(fileName);
						 $('#filename').attr("readonly", true);
						 $('.values').html('<input type="hidden" id="stepnames" name="stepid" value="'+stepid+'"><input type="hidden" name="doccount" value="'+Documentid+'">')
						 }
						 if(ajaxresult==null){
							 var val = "<button class='btn btn-sm btn-info' type='button' onclick='showforSoc()'>Add File</button>";
							 $('.socDocuments').html('');
							 $('#socdoc'+Documentid).html(val);
							 showTable(Documentid,initiationId,stepid);
						 }else{
							 $('.socDocuments').html('');
							 showTable(Documentid,initiationId,stepid);
							 $('#socdoc'+Documentid).html("<button class='btn btn-transparent' type='button' onclick='uploadshow("+ajaxresult[2]+","+ajaxresult[6]+","+JSON.stringify(ajaxresult[4])+","+ajaxresult[8]+")' ><i class='fa fa-upload icon-col' aria-hidden='true'></i></button><button type='submit' class='btn' id='download'  name='DocId'  formaction='ProjectRequirementAttachmentDownload.htm' formtarget='_blank' formmethod='GET' value='"+ajaxresult[8]+","+ajaxresult[6]+","+ajaxresult[1]+","+ajaxresult[2]+"' ><i class='fa fa-download' ></i></button>");
						 }
					 }
				  })
				  
		 	 }
		 function show(){
			 $('#filename').val("");
			 $('#filename').attr("readonly", false);
			 $('#exampleModalLong').modal('show');
		 }
		 // show Soc Modal
		 function showforSoc(){
			 $('#exampleModalLong').modal('show');
		 }
		 
		 	function uploadshow(stepid,version,filename,DocumentCount){
			 	
				document.getElementById('versionfile').value=filename;
				$('#versioneditvalues').html('<input type="hidden" value='+version+' id="versionid"><input type="hidden" value="'+stepid+'" name="stepid"> <input type="hidden" value="'+DocumentCount+'"name="doccount">');
				$('#add1').html('UPLOAD VERSION '+(parseFloat(version)+.1).toFixed(1)+'<input type="hidden" name="versionvalue" value='+(parseFloat(version)+.1).toFixed(1)+'>');
			    $('#versionUpload').modal('show');
		 }
		 
		 function reqCheck(frmid){
				if(window.confirm('Are you sure to save?')){
					document.getElementById(frmid).submit(); 
				}else{
					event.preventDefault();
					return false;
				}
			}
		 
		 var count=0;
		 function editcheck(editfileid,alertn)
		 {
		 	const fi = $('#'+editfileid )[0].files[0].size;							 	
		     const file = Math.round((fi / 1024/1024));
		     
		     
		     const filesize1=<%=filesize%>;
		     console.log(fi+"    "+filesize1+"   "+file);
		    
		     
		     if (document.getElementById(editfileid).files.length!=0 && file >= <%=filesize%> ) 
		     {
		     	if(alertn==1){
		 	    	
		     		alert("File too Big, please select a file less than <%=filesize%> mb");
		     	}else
		     	{
		     		count++;
		     	}
		      	
		     }
		 }
		 //  to check whether the version is new version or not
		 //  if new version , version will be next nearest integer
		 //  if not new version , version will be (version+".1")
 		 $(document).ready(function () {
		        $('input[type=radio][name=isnewver]').change(function () {
		            if (this.value == 'Y') {
		            var version1=$('#versionid').val();
		         
		            
		            version=Math.ceil(version1);
		            if(version==version1){
		            	version=version+1;
		            }
		            $('#add1').html('UPLOAD VERSION '+version+'<input type="hidden" name="versionvalue" value='+version+'>');
		            
		            console.log(version);
		            }
		            if (this.value == 'N') {
		            	 var version=$('#versionid').val();
				       version= (parseFloat(version)+.1).toFixed(1);
				       $('#add1').html('UPLOAD VERSION '+version+'<input type="hidden" name="versionvalue" value='+version+'>');
				       console.log(version);
		            }
		        });
		    });
		 
		  var table1=$("#MyTable1").DataTable({		 
				 "lengthMenu": [5,10,25, 50, 75, 100 ],
				 "pagingType": "simple",
				 "pageLength": 5,
				 "language": {
				      "emptyTable": "Files not Found"
				    }
			});
		  
			/*show table for each file  */
		  function showTable(documentcount,inititationid,stepid){
			  $('.file').css("color","black");
			  $('.file').css("font-weight", "400");
			  $('#file'+documentcount).css("color","green");
			  $('#file'+documentcount).css("font-weight", "700");
			  $('#filestable').css("display","block");
			  
			
			table1.destroy();
			  
			  $.ajax({
				  type:'GET',
				  url:'projectFilesList.htm',
				  datatype:'json',
				  data:{
					  inititationid:inititationid,
					  documentcount:documentcount,
					  stepid:stepid,
				  },
				  success:function(result){
					  var ajaxresult=JSON.parse(result);
					
					  var html="";
					  for(var i=0;i<ajaxresult.length;i++){
							   const date = new Date(ajaxresult[i][3]);
 							   const formattedDate = date.toLocaleDateString('en-GB', {
                               day: '2-digit',
                               month: '2-digit',
                               year: 'numeric',
                               }).replace(/\//g, '-');
						  html=html+"<tr><td>"+(i+1)+"</td><td>"+ajaxresult[i][0]+"</td><td>"+formattedDate+"</td><td>"+ajaxresult[i][2]+"</td><td><button type='submit' class='btn' id='download'  name='DocId'  formaction='ProjectRequirementAttachmentDownload.htm' formtarget='_blank' formmethod='GET' value='"+ajaxresult[i][5]+","+ajaxresult[i][2]+","+ajaxresult[i][6]+","+ajaxresult[i][7]+"'><i class='fa fa-download' ></i></button></td></tr>"
					  }
					  $('#listtbody').html(html);
					
				   table1=$("#MyTable1").DataTable({		 
							 "lengthMenu": [5,10,25, 50, 75, 100 ],
							 "pagingType": "simple",
							 "pageLength": 5,
							 "language": {
							      "emptyTable": "Files not Found"
							    }
						}); 
				  }
			  })
		  }
		  /*show table for each step  */
				
		  function showStepTable(stepid,initiationid){
			
			  table1.destroy();
			  $.ajax({
				  Type:'GET',
				  url:'ProjectStepFiles.htm',
				  datatype:'json',
				  data:{
					  stepid:stepid,
					  initiationid:initiationid,
				  },
				  success:function(result){
					  var ajaxresult=JSON.parse(result);
					  var html="";
					  for(var i=0;i<ajaxresult.length;i++){
						  const date = new Date(ajaxresult[i][1]);
						   const formattedDate = date.toLocaleDateString('en-GB', {
                          day: '2-digit',
                          month: '2-digit',
                          year: 'numeric',
                          }).replace(/\//g, '-');
						  html=html+"<tr><td align='center'>"+(i+1)+"</td><td>"+ajaxresult[i][0]+"</td><td align='center'>"+formattedDate+"</td><td align='center'>"+ajaxresult[i][2]+"</td><td align='center'><button type='submit' class='btn' id='download'  name='DocId'  formaction='ProjectRequirementAttachmentDownload.htm' formtarget='_blank' formmethod='GET' value='"+ajaxresult[i][6]+","+ajaxresult[i][2]+","+ajaxresult[i][4]+","+ajaxresult[i][5]+"'><i class='fa fa-download' ></i></button></td></tr>"
					  }
					  
					  $('#filestable').css("display","block");
					  $('#listtbody').html(html);
					  table1=$("#MyTable1").DataTable({		 
							 "lengthMenu": [5,10,25, 50, 75, 100 ],
							 "pagingType": "simple",
							 "pageLength": 5,
							 "language": {
							      "emptyTable": "Files not Found"
							    }
						}); 
				  }
			  })
		  }
		  
		  
		// calling the show table method when page is loaded according to stepid  
		  $(document).ready(function(){
			  var initiationId=<%=initiationid%>;
			  var stepdidno=<%=stepdidno%>;
			 $('#span'+stepdidno).css("color","green");
			 $('#span'+stepdidno).css("font-weight", "700");
			  showStepTable(stepdidno,initiationId);
		 }) ;
				 
		  $(function () {
			  $('[data-toggle="tooltip"]').tooltip()
			})
	
	//  checking that for particular stepid the given name already exist or not
		function oninputChange(){
			  var stepid=document.getElementById("stepnames").value;
			  var filename=document.getElementById("filename").value;
			 	$.ajax({
			 		type:'GET',
					 url:'PreprojectFiles.htm',
					 datatype:'json',
					 data:{
						 stepid:stepid,
						 initiationid:<%=initiationid%>,
					 },
					 success:function(result){
						 var ajaxresult=JSON.parse(result);
						 var myArray=[];
						 if(ajaxresult.length!=0){
							 for(var i=0;i<ajaxresult.length;i++){
								 myArray.push(ajaxresult[i][4]);
							 }
						 }
						if(myArray.includes(filename)){
							alert("Document Name already Exist")
							document.getElementById("filename").value="";
						}
					 }
			 	})
		  }
		  
	
		</script>
</body>
</html>