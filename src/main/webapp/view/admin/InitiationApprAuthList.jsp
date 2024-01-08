<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}

.table .font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 13px;
	  font-weight: 400 !important;
	 
}

.table button {
    background-color: Transparent !important;
    background-repeat:no-repeat;
    border: none;
    cursor:pointer;
    overflow: hidden;
    outline:none;
    text-align: left !important;
}
.table td{
	padding:5px !important;
}
 .resubmitted{
	color:green;
}

	.fa{
		font-size: 1.20rem;
	}
	
.datatable-dashv1-list table tbody tr td{
	padding: 8px 10px !important;
}

.table-project-n{
	color: #005086;
}

#table thead tr th{
	padding: 0px 0px !important;
}

#table tbody tr td{
	padding:2px 3px !important;
}


.width{
	width:270px !important;
}





</style>
</head>
<body>
<%
List<Object[]> InitiationApprAuthList=(List<Object[]>) request.getAttribute("InitiationApprAuthList");

FormatConverter fc = new FormatConverter();
SimpleDateFormat rdf = fc.getRegularDateFormat();
%>

<% String ses=(String)request.getParameter("result"); 
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


	
<br>	
	
<div class="container-fluid">		
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover" >
				<div class="card-header">
					<div class="row">
						<div class="col-md-2"><h4>Approval Authority</h4></div>
					</div>
				</div>
				<div class="card-body"> 
		        	<form action="InitiationApprAuth.htm" method="POST" name="frm1">
						<div class="data-table-area mg-b-15">
			            	<div class="container-fluid">
			                	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			                        <div class="sparkline13-list">
			                            <div class="sparkline13-graph">
			                                <div class="datatable-dashv1-list custom-datatable-overright">
			                					<table class="table table-bordered table-hover table-striped table-condensed " id="myTable" > 
			                      					<thead style=" text-align: center;">
			                                        	<tr> 
						                              		<th>Select</th>
						                              		<th>Admin </th>
				                                            <th>Admin Role</th>
				                                            <th>Admin From</th>
				                                            <th>Admin To</th>
				                                    	</tr>      
			                          				</thead>
								                    <tbody>
						                                 <%
						                                 if(InitiationApprAuthList!=null && InitiationApprAuthList.size()>0) {
						                                 for(Object[] obj:InitiationApprAuthList){ %>
						                                     <tr>
							                                     <td style="text-align: center;"><input type="radio" name="RtmddoId" value=<%=obj[0]%>  ></td> 
							                                     <td style="text-align: left;"><%=obj[6]+"( "+obj[7]+" ), "+obj[8] %></td>
							                                     <td style="text-align: center;"><%=obj[5] %></td>
																 <td style="text-align: center;"><%if(obj[3]!=null){%><%=rdf.format(obj[3]) %><%}else{ %>-<%} %></td>
																 <td style="text-align: center;"><%if(obj[4]!=null){%><%=rdf.format(obj[4]) %><%}else{ %>-<%} %></td>
						                                     </tr>
						                                  <%} }%>
						                             </tbody>
			                 					</table>
			                   				</div>
			                 			</div>
			                		</div>
			             		</div>
			          		</div>
			        	</div>
						<div align="center"> 
							<button type="submit" class="btn btn-primary btn-sm add" name="action" value="Add">ADD</button>&nbsp;&nbsp;
					        <%if(InitiationApprAuthList!=null&&InitiationApprAuthList.size()>0){%>
					        	<button type="submit" class="btn btn-warning btn-sm edit" name="action" value="Edit" onclick="Edit(frm1)"  >EDIT</button>&nbsp;&nbsp;
					        	<button type="submit" class="btn btn-danger btn-sm delete" name="action" value="Revoke" onclick="return Revoke()"  >REVOKE</button>&nbsp;&nbsp;
					        <%}%>
						</div>	
 						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
			        </form>
        		</div>
			</div>
		</div> 
	</div>	
</div>
	
	
<script type="text/javascript">
function Edit(myfrm){
	
	 var fields = $("input[name='RtmddoId']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select Atleast One Admin");
	 event.preventDefault();
	return false;
	}
		  return true;
	}
	
function Revoke() {

	var fields = $("input[name='RtmddoId']").serializeArray();

	if (fields.length === 0) {
		alert("Please Select Atleast One Admin");

		event.preventDefault();
		return false;
	}else {
		if(confirm("Are you sure To Revoke?")){
			return true;
		}else{
			return false;
		}
		
	}
}	
</script>

<script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
});
});

</script>

</body>
</html>