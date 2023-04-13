<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checklist</title>
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">

td{
	padding : 5px 10px;
}

.toggle.btn{
	min-height: 2.0rem !important;
	font-size: 0.95rem !important;
	padding: 0.35rem 0.75rem !important;
}

.fa{
	font-size: 1rem;
}

.nav-item
{
	padding: 0px;
	cursor: pointer;
}

</style>

</head>
<body>

<%
List<Object[]> checklist= (List<Object[]>)request.getAttribute("checklist");
String initiationid= (String)request.getAttribute("initiationid");
Object[] initiationdata= (Object[])request.getAttribute("initiationdata");

%>


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
			<div class="alert alert-success" role="alert" >
                     <%=ses %>
             </div>
        </div>
   <%} %>



	<div class="container-fluid">
		<div class="card">
			<div class="card-header">
				<div class="row">
					<div class="col-6"><h4>CHECKLIST</h4></div>
					<div class="col-6">
						<h4 style="float: right;">Project &nbsp;&nbsp;:&nbsp;&nbsp;<%=initiationdata[9] %> &nbsp;&nbsp;&nbsp;
							<a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectIntiationList.htm" style="color: white!important; float: right;">BACK</a>
						</h4>
					</div>
				</div>
			</div>
			<div class="card-body" > <!-- style="overflow-y : auto; max-height:32rem  " -->
				<div class="" style="margin-top: -20px;">
						<ul class="nav nav-pills nav-tabs nav-fill col-12" id="pills-tab" role="tablist">
						  <li class="nav-item col-4">
							  <div class="nav-link active" style="border: 1px solid #CCD1E4; "  id="cl1-tab" data-toggle="pill" href="#cl1" role="tab"  aria-selected="true" onclick="showtab(1)">
								  Checklist - 1
								  <button type="button" onclick="formsubmit(1)"  id="btn-cl1"  class="btn btn-sm btn-cl"  style="float: right;margin-top: -3px;"><i class="fa fa-download" aria-hidden="true"></i></button>
							  </div>
						  </li>
						  <li class="nav-item col-4">
							  <div class="nav-link" id="cl2-tab" style="border: 1px solid #CCD1E4; " data-toggle="pill" href="#cl2" role="tab"  aria-selected="false" onclick="showtab(2)">
								  Checklist - 2   
								  <button type="button" onclick="formsubmit(2)" id="btn-cl2"  class="btn btn-sm btn-cl" style="float: right;margin-top: -3px;"><i class="fa fa-download" aria-hidden="true"></i></button> 
							  </div>
						  </li>
						  <li class="nav-item col-4">
						    <div class="nav-link" id="cl3-tab" style="border: 1px solid #CCD1E4; " data-toggle="pill" href="#cl3" role="tab"  aria-selected="false" onclick="showtab(3)">
						    	Checklist - 3
						    	<button type="button" onclick="formsubmit(3)" id="btn-cl3"  class="btn btn-sm btn-cl"   style="float: right;margin-top: -3px;"><i class="fa fa-download" aria-hidden="true"></i></button>
						    </div>
						  </li>
						</ul>
				</div>
				
				
				<div class="tab-content" id="pills-tabContent"  style="overflow-y : auto; min-height:32rem ; max-height: 32rem; " >
				  
				  <div class="tab-pane show active" id="cl1" role="tabpanel" >
				  		<div class=""  align="center"  >
				  			<table style="margin: auto;width: 70%; margin-top: 15px;" >
				  				
				  				<% 	ArrayList<String> clsn1 =new  ArrayList<String>();
				  					for(Object[] item : checklist){
				  					
				  					if(Integer.parseInt(item[1].toString())==1 ){
				  					
				  					%>
				  				<tr>
				  				
				  					<td style="width: 10%; text-align: right; padding-top: 0px;">
				  					
				  						<%if(!clsn1.contains(item[2].toString() ))
				  						{
				  							clsn1.add(item[2].toString() );%>
				  							<%=item[2] %>
				  							  
				  						<%} %>
				  						
				  					</td>			
				  					
				  					
				  					<td colspan="4"  style=" overflow-wrap: break-word; width: 60%">
				  						<%if(Integer.parseInt(item[3].toString())>0) { %>	
				  							<%=item[4] %>
				  						<%}else if(Integer.parseInt(item[3].toString())==0){ %>
				  							<b><%=item[4] %></b>
				  						<%} %>
				  					</td>
				  					<td style="width: 20%" >
				  						<%if(Integer.parseInt(item[3].toString())>0) { %>				  						
				  							<input name="toggle" id="toggle_<%=item[0] %>" onchange="updateAnswer('<%=item[0] %>')"  type="checkbox" <%if(item[5]!= null && (item[5]).toString().equalsIgnoreCase("1")){ %> checked <%}%> data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="112" data-height="15" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
				  						<%} %>
				  					</td>
				  				</tr>
				  				<%	}
				  				}%>
				  			</table>
				  		</div>				  		
				  </div>
				  <div class="tab-pane " id="cl2" role="tabpanel" >
					 	<div class=""  align="center"  >
				  			<table style="margin: auto; width: 70%;" >
				  				
				  				
				  				<% 	ArrayList<String> clsn2 =new  ArrayList<String>();
				  					for(Object[] item : checklist){
				  					
				  					if(Integer.parseInt(item[1].toString())==2 ){
				  					
				  					%>
				  				<tr>
				  				
				  					<td style="width: 10%; text-align: right; padding-top: 0px;">
				  					
				  						<%if(!clsn2.contains(item[2].toString() ))
				  						{
				  							clsn2.add(item[2].toString() );%>
				  							<%=item[2] %>
				  							  
				  						<%} %>
				  						
				  					</td>			
				  					
				  					
				  					<td colspan="4"  style=" overflow-wrap: break-word; width: 60%">
				  						<%if(Integer.parseInt(item[3].toString())>0) { %>	
				  							<%=item[4] %>
				  						<%}else if(Integer.parseInt(item[3].toString())==0){ %>
				  							<b><%=item[4] %></b>
				  						<%} %>
				  					</td>
				  					<td style="width: 20%" >
				  						<%if(Integer.parseInt(item[3].toString())>0) { %>				  						
				  							<input name="toggle" id="toggle_<%=item[0] %>"  onchange="updateAnswer('<%=item[0] %>')"  type="checkbox" <%if(item[5]!= null && (item[5]).toString().equalsIgnoreCase("1")){ %> checked <%}%> data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="112" data-height="15" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
				  						<%} %>
				  					</td>
				  				</tr>
				  				<%	}
				  				}%>
				  			</table>
				  		</div>		
						
				  </div>
				  <div class="tab-pane " id="cl3" role="tabpanel" >
				  	<div class=""  align="center"  >
				  			<table style="margin: auto; width: 70%;" >
				  								  				
				  				<% 	ArrayList<String> clsn3 =new  ArrayList<String>();
				  					for(Object[] item : checklist){
				  					
				  					if(Integer.parseInt(item[1].toString())==3 ){
				  					
				  					%>
				  				<tr>
				  				
				  					<td style="width: 10%; text-align: right; padding-top: 0px;">
				  					
				  						<%if(!clsn3.contains(item[2].toString() ))
				  						{
				  							clsn3.add(item[2].toString() );%>
				  							<%=item[2] %>
				  							  
				  						<%} %>
				  						
				  					</td>			
				  					
				  					
				  					<td colspan="4"  style=" overflow-wrap: break-word; width: 60%">
				  						<%if(Integer.parseInt(item[3].toString())>0) { %>	
				  							<%=item[4] %>
				  						<%}else if(Integer.parseInt(item[3].toString())==0){ %>
				  							<b><%=item[4] %></b>
				  						<%} %>
				  					</td>
				  					<td style="width: 20%" >
				  						<%if(Integer.parseInt(item[3].toString())>0) { %>				  						
				  							<input name="toggle" id="toggle_<%=item[0] %>"  onchange="updateAnswer('<%=item[0] %>')"  type="checkbox" <%if(item[5]!= null && (item[5]).toString().equalsIgnoreCase("1")){ %> checked <%}%> data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="112" data-height="15" data-on="<i class='fa fa-check' aria-hidden='true'></i> YES" data-off="<i class='fa fa-times' aria-hidden='true'></i> NO" >
				  						<%} %>
				  					</td>
				  				</tr>
				  				<%	}
				  				}%>
				  			</table>
				  		</div>		
				  		
				  </div>
				</div>
			</div>
		</div>
	</div>
	
	<form method="post" action="IntiationChecklistDownload.htm" target="_blank"  id="cl_download">
		<input type="hidden" name="initiationid" value="<%=initiationid %>" />
		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
		<input type="hidden"  id="formsubmit" name="clno" value="" />
	</form>
	

<script type="text/javascript">
	
function updateAnswer(ChecklistId)
{
	
	$.ajax({
		
		type : "GET",
		url : "IntiationChecklistUpdate.htm",
		data : {
			initiationid  : <%=initiationid %>,
			checklistid : ChecklistId,
		},
		datatype : "json",
		success : function (result){
			console.log(result);
			console.log(typeof (result));
			if(Number(result)>0)
			{
				alert('Checklist Updated');
			}else
			{
				alert('Operation Failed');			
			}			
		}
	})
}

</script>
		<script type="text/javascript">
				$('#btn-cl3').hide();
				$('#btn-cl2').hide();
					function showtab(tabno)
					{
						$('.btn-cl').hide();
						$('#btn-cl'+tabno).show();						
					}
				</script>
								
		<script type="text/javascript">
					function formsubmit(clno)
					{
						$('#formsubmit').val(clno);
						$('#cl_download').submit();
					}
				
				</script>

</body>
</html>