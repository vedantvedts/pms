<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.milestone.model.FileDocMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Documents List</title>
<spring:url value="/resources/css/fileRepo/DocumentsList.css" var="documentsList" />
<link href="${documentsList}" rel="stylesheet" />
</head>
<%

List<FileDocMaster> docmasterlist=(List<FileDocMaster>)request.getAttribute("docmasterlist");

%>

<body>


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




	<div class="container-fluid">
		<div class="card">
			<div class="card-header">
				<div><h4>Documents List</h4></div>
			</div>
			<div class="card-body min-height" >
				<div class="row">
					<div class="col-12">
						<div class="row" >
								<div class="col-md-12">		
									<ul>	
									<%for(FileDocMaster obj :docmasterlist)
									{ 
										if(obj.getLevelId()==1)
										{%>  
										<li >
										<form   method="get">
											<span class="caret"  onclick="onclickchange(this);" >
								            		<%=obj.getLevelName()!=null?StringEscapeUtils.escapeHtml4(obj.getLevelName()): " - " %>
								            	</span>
								            	<span  class="span-font" id="span_<%=obj.getFileUploadMasterId()%>"> &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj.getFileUploadMasterId() %>')"></i> </span>	
											     <input type="text" name="levelname" class="hiddeninput description-input display-none"   id="inputx_<%=obj.getFileUploadMasterId()%>"  value="<%=obj.getLevelName()%>"  maxlength="255" >
											     <button type="submit" class="btn btn-sm btn-info editbtn display-none"  id="btn_<%=obj.getFileUploadMasterId()%>" formaction="DocumentListNameEdit.htm" formmethod="get" onclick="return confirm('Are You Sure To Edit ? ');">UPDATE</button>
											     <button type="button" class="btnx btn-tick" id="btnx_<%=obj.getFileUploadMasterId()%>" onclick="moduleeditdisable('<%=obj.getFileUploadMasterId() %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
											     <input type="hidden" value="<%=obj.getFileUploadMasterId()%>" name="filerepmasterid">
											 <ul  class="nested">
										</form>
								<!-- ----------------------------------------level 1------------------------------------- -->	
													<%for(FileDocMaster obj1 :docmasterlist)
													{ 
														if(obj1.getLevelId()==2 && obj1.getParentLevelId()==obj.getFileUploadMasterId() )
														{%>  
														<li>
														<form   method="get">	
																<span class="caret" onclick="onclickchange(this);" >
								             						<%=obj1.getLevelName()!=null?StringEscapeUtils.escapeHtml4(obj1.getLevelName()): " - " %>
								             					</span>
																
															<span  class="span-font" id="span_<%=obj1.getFileUploadMasterId()%>">  &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj1.getFileUploadMasterId() %>')"></i> </span>
															 <input type="text" name="levelname" class="hiddeninput description-input display-none" id="inputx_<%=obj1.getFileUploadMasterId()%>" value="<%=obj1.getLevelName()%>"  maxlength="255" >	
														    <button type="submit" class="btn btn-sm btn-info editbtn display-none"  id="btn_<%=obj1.getFileUploadMasterId()%>" formaction="DocumentListNameEdit.htm" formmethod="get" onclick="return confirm('Are You Sure To Edit ? ');">UPDATE</button>
															<button type="button" class="btnx btn-tick" id="btnx_<%=obj1.getFileUploadMasterId()%>" onclick="moduleeditdisable('<%=obj1.getFileUploadMasterId() %>')">   <i class="fa fa-times" aria-hidden="true"></i></button></button>
															<input type="hidden" value="<%=obj1.getFileUploadMasterId()%>" name="filerepmasterid">	
																<ul class="nested">
													</form>
												<!-- ----------------------------------------level 2------------------------------------- -->	
														 		<%for(FileDocMaster obj2 :docmasterlist)	{ %>
																
																		<%if( obj2.getLevelId()==3 && obj2.getParentLevelId()==obj1.getFileUploadMasterId()) 
																		{%>
																		
																			<li>
																   			 <form action="#">
																				<span>
																					<span class="caret-last" onclick="onclickchange(this);" >
																						<%=obj2.getLevelName()!=null?StringEscapeUtils.escapeHtml4(obj2.getLevelName()): " - " %>(<%=obj2.getDocShortName()!=null?StringEscapeUtils.escapeHtml4(obj2.getDocShortName()): " - " %>)
																					</span>
																					<span  class="span-font" id="span_<%=obj2.getFileUploadMasterId()%>">  &nbsp;&nbsp;&nbsp;<i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="moduleeditenable('<%=obj2.getFileUploadMasterId() %>')"></i> </span>	
																				      <input type="text" name="levelname" class="display-none hiddeninput description-input" id="inputx_<%=obj2.getFileUploadMasterId()%>" value="<%=obj2.getLevelName()%>"  maxlength="255" >
																				    <button type="submit" class="btn btn-sm display-none btn-info editbtn"  id="btn_<%=obj2.getFileUploadMasterId()%>" formaction="DocumentListNameEdit.htm" formmethod="get" onclick="return confirm('Are You Sure To Edit ? ');">UPDATE</button>
																				   <button type="button" class="btnx btn-tick" id="btnx_<%=obj2.getFileUploadMasterId()%>" onclick="moduleeditdisable('<%=obj2.getFileUploadMasterId() %>')"><i class="fa fa-times fa-lg " aria-hidden="true"  ></i></button>
																				   <input type="hidden" value="<%=obj2.getFileUploadMasterId()%>" name="filerepmasterid">
																				</span>
																				</form>
																			</li>	
																		<%}
																	} %>	
																	
																
																	
																	<li class="mt-1 mr-2 mb-1 ml-0" >
																		<span class="caret-last">
																			<span>
																				<button class="btn btn-sm btn-info " type="button" onclick="showmodal('<%=obj1.getFileUploadMasterId()%>');">
																					<i class="fa fa-plus" aria-hidden="true"  ></i>
																					Add New File
																				</button>
																			</span>
																		</span>
																	</li>	
																	
												<!-- ----------------------------------------level 2------------------------------------- -->
												
																</ul>
															<%}
														} %>
														</li>	
														<li class="mt-1 mr-2 mb-1 ml-0" >
															<form action="FileLevelSubLevelAdd.htm" method="post" autocomplete="off"  id="form_<%=obj.getFileUploadMasterId()%>"   >
																<span class="caret-plus">
																	<input type="text" name="levelname" value="" class="levelinput description-input" id="input_<%=obj.getFileUploadMasterId()%>"  placeholder="New Sub Level Name" maxlength="255"  required="required" >
																	<button type="button" class="btn btn-sm btn-info editbtn"  id="submitbtn_<%=obj.getFileUploadMasterId()%>"  id="submitbtn_<%=obj.getFileUploadMasterId()%>" onclick="return levelnamecheck('<%=obj.getFileUploadMasterId()%>');"   >ADD</button>
																	
																</span>
																<input type="hidden" name="levelid" value="2">
																<input type="hidden" name="parentlevel"  value="<%=obj.getFileUploadMasterId()%>" >
																<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
															</form>
														</li>	
														
										<!-- ----------------------------------------level 1------------------------------------- -->
													</ul> 
												</li>
											<%}
											} %>
												<li class="mt-1 mr-2 mb-1 ml-0" >
													<form action="FileLevelSubLevelAdd.htm" method="post" autocomplete="off" id="form_0">
														<span class="caret-plus">
															<input type="text" name="levelname" value="" class="levelinput description-input" id="input_0" placeholder="New Level Name" maxlength="255"  required="required">
															<button type="button" class="btn btn-sm btn-info editbtn" id="submitbtn_0"  onclick="return levelnamecheck('0');" >ADD</button>
														</span>
														<input type="hidden" name="levelid" value="1">
														<input type="hidden" name="parentlevel" value="0">
														<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
													</form>
												</li>	
											</ul>							
								</div>
								
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
	

<div class="modal fade  bd-example-modal-lg" tabindex="-1" role="dialog" id="newfilemodal">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Document Type Add</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" align="center">
       <form action="FileNameAdd.htm" method="POST" autocomplete="off" id="newfileform" >
       		<table class="w-100 p-3">
	       		<tr >
		       		<th class="w-20 p-10">Name</th>
		       		<td class="p-10">
						<input type="text" name="levelname" value="" class="form-control description-input" id="modallevelname" placeholder="New File Name" maxlength="255" required="required" >
					</td>
				</tr>
				<tr>
					<th class="w-20 p-10" >Short Name</th>
					<td class="p-10" >
						<input type="text" name="docshortname" value="" class="form-control description-input" id="modalsname" placeholder="New File Name" maxlength="15" required="required" >
					</td>
				</tr>
				<tr>
					<th class="w-20 p-10"  >Document Id</th>
					<td class="p-10"  >
						<input type="number" name="docid" value="" class="form-control" id="modalidocid" placeholder="Docid" maxlength="10" required="required" >
					</td>
				</tr>
			</table>
			<button type="button" class="btn btn-sm submit" id="modalsubmitbtn"  onclick="return filenamecheck();" >ADD</button>
			
			<input type="hidden" name="levelid" value="3">
			<input type="hidden" name="parentlevel" id="modalparentlevel" value="">
			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
		</form>
      </div>
      <div class="modal-footer">
       
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">

function filenamecheck()
{
	var $modallevelname = $('#modallevelname').val();
	var $modalsname = $('#modalsname').val();
	var $modalidocid = $('#modalidocid').val();
	
	var $modalparentlevel = $('#modalparentlevel').val();

	if($modallevelname.trim()!=="" &&  $modalsname.trim()!=="" && $modalidocid.trim()!=="" ){
		 $.ajax({
			
				type : "GET",
				url : "FileNameCheck.htm",
				data : {
					levelname : $modallevelname,
					shortname : $modalsname,
					docid : $modalidocid,
					parentlevelid : $modalparentlevel
				},
				datatype: 'json',
				success : function(ajaxresult){
					var result = JSON.parse(ajaxresult);
					/* console.log(result);
					console.log(typeof(result[0])); */
					if(result[0]>0){
						alert('Level Name Already Exist !');
					}else if(result[1]>0){
						alert('Short Name Already Exist !');
					}else if(result[2]>0){
						alert('Document Id Already Exist !');
					}else if(confirm('Are You Sure to Add ?')){
						
						$('#newfileform').submit();
					}
					
					
					
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					alert("Internal Error Occured !!");
		            alert("Status: " + textStatus);
		            alert("Error: " + errorThrown); 
		        }  
				
				
			}) 
		
		}else
		{
			alert ('Please Fill All The Fields ');
		}
}



function showmodal(parentid)
{   
	
	$('#modalparentlevel').val(parentid);
	$('#modallevelname').val('');
	$('#modalsname').val('');
	 $('#modalidocid').val('');
	$('#newfilemodal').modal('show');
}



function levelnamecheck(pid)
{
	var $levelname = $('#input_'+pid).val();
    console.log("pid--"+pid)
    console.log("$levelname--"+$levelname)

	if($levelname.trim()!==""){
		 $.ajax({
			
				type : "GET",
				url : "FileLevelSublevelNameCheck.htm",
				data : {
					levelname : $levelname,
				},
				datatype: 'json',
				success : function(result){
					
					if(Number(result)>0)
					{
						alert('Level Name Already Exists !! \nTry Again.');
					}else
					{
						/* return confirm('Are You Sure To Edit ? '); */
						 if ( confirm('Are You Sure To Add ? '))
						{
							$('#form_'+pid).submit();	
						} 
						
					}
					
					
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					alert("Internal Error Occured !!");
		            alert("Status: " + textStatus);
		            alert("Error: " + errorThrown); 
		        }  
				
				
			}) 
	}else {
		
		alert('Please Enter File Name !');
		
	}
		
	
}

</script>

<script type="text/javascript">

 var toggler = document.getElementsByClassName("caret");
var i;
for (i = 0; i <toggler.length; i++) {
  toggler[i].addEventListener("click", function() {	
	this.parentElement.querySelector(".nested").classList.toggle("active");   
    this.classList.toggle("caret-down");
  });
}


function onclickchange(ele)
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

}
function moduleeditenable(moduleid)
{   
	
	$('#span_'+moduleid).hide();
	$('#inputx_'+moduleid).show();
	$('#btn_'+moduleid).show();	
	$('#btnx_'+moduleid).show();
}

function moduleeditdisable(moduleid)
{
	$('#span_'+moduleid).show();
	$('#inputx_'+moduleid).hide();
	$('#btn_'+moduleid).hide();	
	$('#btnx_'+moduleid).hide();
}
</script>

</script>
</body>
</html>