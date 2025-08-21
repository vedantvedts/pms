<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
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
					<div class="col-6"><a class="btn btn-sm back" href="ProjectList.htm" style="float: right;">BACK</a></div>
				</div>
			</div>	
			<div class="card-body" style="min-height: 35rem;">
				<div class="row" style="padding:0px 15px" >
					<div class="col-5" style="border: 1px solid #B1D0E0;border-radius: 10px; margin-left:140px; padding:15px 10px;min-height:33rem;">
						<div class="table-responsive">
	   						<table class="table table-bordered table-hover table-striped table-condensed" id="myTable"> 
							<thead style = "background-color: #055C9D; color: white;text-align: center;">
								<tr>
									<th style="width:5% ;" ><h5 >SN</h5></th>
									<th style="width:50% ;" ><h5 >Filename</h5></th>
									<th style="width:30% ;" ><h5>Action</h5></th>
									
								</tr>
							</thead>
						 	<tbody>
							 		<%
							 		int count =1;
							 		for(Object[] attach : AttachList){ %>
									<tr class="tr_clone">
									<td align="center"><%=count%></td>
										<td style="width:70% ;" >
											<%=attach[1]!=null?StringEscapeUtils.escapeHtml4(attach[1].toString()): " - " %>
										</td>	
										<td style="width:20% ; ">
										<div class="row" style="margin-right: 0px !important;">
											<form action="ProjectMasterAttachDownload.htm" method="post" target="_blank"> 
												<button type="submit" class="btn"><i class="btn btn-sm fa fa-download" style="color: green; "></i></button>
												<input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
												<input type="hidden" name="attachid" value="<%=attach[0]%>">
											</form>
												<form action="ProjectMasterAttachDelete.htm" method="post" >
												<button type="submit" class="btn" onclick="return confirm('Are You sure To Delete?');"><i class="btn btn-sm fa fa-trash-o" style="color: red; "></i></button>
												<input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}" />
												<input type="hidden" name="attachid" value="<%=attach[0]%>">
												<input type="hidden" name="projectid" value="<%=projectid%>">
											</form>
											</div>
										</td>	
																			
									</tr>
									
									<%count++;} %>
									<%if(AttachList.size()==0){ %>
									<tr><td colspan="3" style="text-align: center;">Files Not Found</td></tr>
									<%} %>
							</tbody> 
						</table>
						</div>
					</div>&nbsp;
					<div class="col-5" style="border: 1px solid #B1D0E0; border-radius: 10px;padding:15px 10px;min-height:33rem;" >
						<form action="ProjectMasterAttachAdd.htm" method="post" enctype="multipart/form-data">
							<table style="width:100% ; " >
								<thead style = "background-color: #055C9D; color: white;text-align: center;">
									<tr>
										<td style="width:45%; padding: 0px 5px 0px 5px;" ><h5>Filename</h5></td>
										<td style="width:45%; padding: 0px 5px 0px 5px;"><h5>Attachment</h5></td>
										<td style="width:10%;">
											<button type="button" class=" btn btn_add "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
										</td>
									</tr>
								</thead>
							 	<tbody>
									<tr class="tr_clone">
										<td style="width:45% ; padding: 10px 5px 0px 5px;  " >
											<input type="text" class="form-control item" name="filename" maxlength="255" required="required" >
										</td>	
										<td style="width:45% ;padding: 10px 5px 0px 5px; ">
											<input type="file" id="file0" class="form-control item" name="attachment" onchange="Filevalidation('file0');"  required="required" >
										</td>	
										<td style="width:10% ; ">
											<button type="button" class=" btn btn_rem " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
										</td>									
									</tr>
								</tbody> 
							</table>
							<div align="center" style="margin-top: 15px;">
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