<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/projectModule/projectAttachments.css" var="projectAttachments" />
<link href="${projectAttachments}" rel="stylesheet" />
<title> Project Attachments </title>
</head>
<body>
<%
Object[] projectdata=(Object[]) request.getAttribute("projectdata");

List<Object[]> AttachList=(List<Object[]>) request.getAttribute("AttachList");

String projectid=(String ) request.getAttribute("projectid");
String filesize=  (String)request.getAttribute("filesize");
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
                    
	<div class="container-fluid">
		<div class="card">
			<div class="card-header">
				<div class="row">
					<div class="col-6"><h4><%=projectdata[1]!=null?StringEscapeUtils.escapeHtml4(projectdata[1].toString()): " - " %></h4></div>
					<div class="col-6"><a class="btn btn-sm back float-right" href="ProjectList.htm">BACK</a></div>
				</div>
			</div>	
			<div class="card-body">
				<div class="row cs-row">
					<div class="col-5 cs-div">
						<div class="table-responsive">
	   						<table class="table table-bordered table-hover table-striped table-condensed" id="myTable"> 
							<thead class="cs-thead">
								<tr>
									<th class="w-5"><h5 >SN</h5></th>
									<th class="w-50" ><h5 >Filename</h5></th>
									<th class="w-30" ><h5>Action</h5></th>
									
								</tr>
							</thead>
						 	<tbody>
							 		<%
							 		int count =1;
							 		for(Object[] attach : AttachList){ %>
									<tr class="tr_clone">
									<td align="center"><%=count%></td>
										<td class="w-70">
											<%=attach[1]!=null?StringEscapeUtils.escapeHtml4(attach[1].toString()): " - " %>
										</td>	
										<td class="w-20">
										<div class="row">
											<form action="ProjectMasterAttachDownload.htm" method="post" target="_blank"> 
												<button type="submit" class="btn"><i class="btn btn-sm fa fa-download text-success"></i></button>
												<input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
												<input type="hidden" name="attachid" value="<%=attach[0]%>">
											</form>
												<form action="ProjectMasterAttachDelete.htm" method="post" >
												<button type="submit" class="btn" onclick="return confirm('Are You sure To Delete?');"><i class="btn btn-sm fa fa-trash-o text-danger"></i></button>
												<input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
												<input type="hidden" name="attachid" value="<%=attach[0]%>">
												<input type="hidden" name="projectid" value="<%=projectid%>">
											</form>
											</div>
										</td>	
																			
									</tr>
									
									<%count++;} %>
									<%if(AttachList.size()==0){ %>
									<tr><td colspan="3" class="text-center">Files Not Found</td></tr>
									<%} %>
							</tbody> 
						</table>
						</div>
					</div>&nbsp;
					<div class="col-5 cs-div">
						<form action="ProjectMasterAttachAdd.htm" method="post" enctype="multipart/form-data">
							<table class="w-100">
								<thead class="cs-thead">
									<tr>
										<td class="cs-file"><h5>Filename</h5></td>
										<td class="cs-file"><h5>Attachment</h5></td>
										<td class="w-10">
											<button type="button" class=" btn btn_add "> <i class="btn btn-sm fa fa-plus text-success p-0"></i></button>
										</td>
									</tr>
								</thead>
							 	<tbody>
									<tr class="tr_clone">
										<td class="cs-file">
											<input type="text" class="form-control item" name="filename" maxlength="255" required="required" >
										</td>	
										<td class="cs-file">
											<input type="file" id="file0" class="form-control item" name="attachment" onchange="Filevalidation('file0');"  required="required" >
										</td>	
										<td class="w-10">
											<button type="button" class=" btn btn_rem " > <i class="btn btn-sm fa fa-minus text-danger p-0"></i></button>
										</td>									
									</tr>
								</tbody> 
							</table>
							<div align="center" class="mt-15">
								<button type="submit" class="btn btn-sm submit" name="submit" value="SUBMIT" onclick="" >SUBMIT</button>
								<input type="hidden" name="ProjectId" value="<%=projectid %>" >
								<input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
							</div>
						</form>						
					</div>
				</div>
			</div>
			
		</div>
	</div>

<script type="text/javascript">
var count=0;
$("table").on('click','.btn_add' ,function() {
	
	var $tr = $('.tr_clone').last('.tr_clone');
	var $clone = $tr.clone();
	$tr.after($clone);
	
	
	$clone.find("input").val("").end();
	count++;
	  
	var id='\''+'file'+count+'\'';
	  
	$clone.find("input:file").prop("id", 'file'+count).attr("onchange", 'Filevalidation('+id+')').val("").end();
	
});


$("table").on('click','.btn_rem' ,function() {
	
var cl=$('.tr_clone').length;
	
if(cl>1){
	
   $('.items').select2("destroy");        
   var $tr = $(this).closest('.tr_clone');
  
   var $clone = $tr.remove();
   $tr.after($clone);
   $('.items').select2();
   /* $clone.find('.items').select2('val', ''); */
   
}
   
});




</script>

<script type="text/javascript">
						
    function Filevalidation (fileid) 
    {
        const fi = $('#'+fileid )[0].files[0].size;							 	
        const file = Math.round((fi/1024/1024));
        if (file >= <%=filesize%> ) 
        {
        	alert("File too Big, please select a file less than <%=filesize%> mb");
        } 
    }
</script> 

</body>
</html>