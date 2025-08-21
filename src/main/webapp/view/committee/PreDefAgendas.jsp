<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title></title>
</head>
<body>

<%
	List<Object[]> DefAgendas=(List<Object[]>)request.getAttribute("DefAgendas"); 
	String committeeid = (String)request.getAttribute("committeeid");
	List<Object[]> committeeslist=(List<Object[]>)request.getAttribute("committeeslist");
	String committeecode =null; 
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
		<div class="card" >
			<div class="card-header">
				<div class="row">
					<div class="col-6"><h5>Add New Agenda</h5> </div>
					<div class="col-6">
						<form action="PreDefinedAgendas.htm" method="post" style="float:right ; ">
							<table>
								<tr>
									<td>
										<h5>Committee : &nbsp;&nbsp;&nbsp; </h5>
									</td><td>
										<select class="form-control selectdee" name="committeeid" onchange="this.form.submit();" >
											<%for(Object[] committee : committeeslist){ %>
												<option value="<%=committee[0] %>" <%if( committee[0].toString().equalsIgnoreCase(committeeid)){ committeecode = committee[1].toString(); %> selected <%} %>  > <%=committee[1]!=null?StringEscapeUtils.escapeHtml4(committee[1].toString()): " - " %> </option>
											<% } %>
										</select>
									</td>
								</tr>
							</table>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
			<div class="card-body">				
				
				<form class="form-inline" method="post" action="PreDefinedAgendaAdd.htm" >
					<div class="row" align="center" style="width: 100%;">
						<div class=" col-5">
							<div class="form-group ">
								<label for="modal-agendaitem"><b>Action Item :</b></label>
								<input type="text" class="form-control" name="agendaitem" style="width: 100%" value=""  maxlength="500" required="required">
							</div>
						</div>
						<div class=" col-5">
							<div class="form-group ">
								<label for="modal-remarks"><b>Remarks : </b></label>
								<input type="text" class="form-control" name="remarks" style="width: 100%"  value=""  maxlength="255" required="required" >
							</div>
						</div>
						<div class="col-2">
							<div class="form-group ">
								<label for="modal-duration"><b>Duration :</b></label>
								<input type="number" class="form-control" name="duration" style="width: 100%"  value="" min="1" required="required" >
							</div>
						</div>
						<input type="hidden" name="committeeid"  value="<%=committeeid %>" >	
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<div class="col-md-12" align="center" style="margin-top: 25px;">
							<button type="submit" class="btn btn-sm submit" onclick="return confirm('Are you Sure To Submit ?');">SUBMIT</button>
						</div>
					</div>	
				</form>
	   				
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="card" >
			
			<div class="card-body">
				<div class="row">
					<div class="col-12" align="center"><h4>Pre-Defined Agendas for <%=committeecode %></h4> </div>
				</div>
				<div class="row">
					<div class="col-12">
						<div class="table-responsive " >
							<table class="table  table-bordered" id="MyTable">
								<thead>
									<tr>
										<th>SN.</th>
										<th>Agenda Item</th>
										<th>Remarks</th>
										<th>Duration</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								<%	int count =1;
									for(Object[] obj : DefAgendas){ %>
									<tr>
										<td><%=count++ %></td>
										<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
										<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
										<td><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
										<td> 
											<form method="post" action="PreDefinedAgendaDelete.htm" >
												<button type="button" class="btn btn-sm" data-toggle="modal"  onclick="showEditModal('<%=obj[0] %>' , ' <%=obj[2] %>', '<%=obj[3] %>', '<%=obj[4] %>' );"><i class="fa fa-pencil-square-o fa-lg" aria-hidden="true"></i></button>
												<button type="submit" class="btn btn-sm " onclick="return confirm('Are you Sure To Delete ?');"><i class="fa fa-trash-o fa-lg" aria-hidden="true"></i></button>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="committeeid"  value="<%=committeeid %>" >	
												<input type="hidden" name="agendaid" value="<%=obj[0] %>" />
											</form>
										</td>
									</tr>		
														
								<%} %>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>	
	</div>

	
	
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered "  style="max-width: 60% !important;">	
			<div class="modal-content" >				   
			    <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
			    	<h4 class="modal-title" id="model-card-header" style="color: #145374">Edit Agenda</h4>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
			          <span aria-hidden="true">&times;</span>
			        </button>
			    </div>
				<div class="modal-body"  style="padding: 0.5rem !important;">						
					<div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;width: 100%">
						
						<div class="row" style="width: 100%">
							<form class="form-inline" method="post" action="PreDefinedAgendaEdit.htm" >
									<div class=" col-5">
										<div class="form-group ">
											<label for="modal-agendaitem"><b>Action Item :</b></label>
											<input type="text" class="form-control" name="agendaitem" style="width: 100%" value="" id="modal-agendaitem" maxlength="500" required="required" >
										</div>
									</div>
									<div class=" col-5">
										<div class="form-group ">
											<label for="modal-remarks"><b>Remarks : </b></label>
											<input type="text" class="form-control" name="remarks" style="width: 100%"  value="" id="modal-remarks" maxlength="255" required="required" >
										</div>
									</div>
									<div class="col-2">
										<div class="form-group ">
											<label for="modal-duration"><b>Duration :</b></label>
											<input type="number" class="form-control" name="duration" style="width: 100%"  value="" id="modal-duration" required="required" >
										</div>
									</div>
									<input type="hidden" name="agendaid"  value="" id="modal-agendaid">	
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<div class="col-md-12" align="center" style="margin-top: 25px;">
									<button type="submit" class="btn btn-sm edit" onclick="return confirm('Are you Sure To Update ?');">UPDATE</button>
								</div>
							</form>
		           		</div>		
		           					
					</div>
				</div>
			</div>
		</div> 
	</div>
	
	
<script type="text/javascript">

function showEditModal(agendaid, item, remarks, duration)
{
	$('#modal-agendaid').val(agendaid);
	$('#modal-agendaitem').val(item);
	$('#modal-remarks').val(remarks);
	$('#modal-duration').val(duration);
	$('#exampleModalCenter').modal('toggle');
}

$("#MyTable").DataTable({		 
	 "lengthMenu": [5,10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5,
	 "language": {
	      "emptyTable": "Files not Found"
	    }
});

</script>
		
	
	
	
	
	
</body>
</html>