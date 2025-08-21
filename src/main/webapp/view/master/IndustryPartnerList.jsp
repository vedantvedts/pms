<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
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


/* icon styles */

.cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 108px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
  z-index: 9;
  display: inline-block;
  width: 28px;
  height: 52px;
  box-sizing: border-box;
  margin: 0 5px 0 0;
}
.cc-rockmenu .rolling .rolling_icon:hover .rolling {
  width: 312px;
}

.cc-rockmenu .rolling i.fa {
    font-size: 20px;
    padding: 6px;
}
.cc-rockmenu .rolling span {
    display: block;
    font-weight: bold;
    padding: 2px 0;
    font-size: 14px;
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:270px !important;
}





</style>
</head>
<body>
<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> industryPartnerList = (List<Object[]>)request.getAttribute("IndustryPartnerList");
int slno = (Integer)request.getAttribute("slno");

Map<String, List<Object[]>> industryPartnerToListMap = industryPartnerList.stream().collect(Collectors.groupingBy(array -> array[0] + "", LinkedHashMap::new, Collectors.toList()));
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

	
<br>	
	
<div class="container-fluid">		
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover" >
				<div class="card-header">
					<div class=row>
						<div class="col-3"><h4>Industry Partner List</h4></div>
						<div class="col-7"></div>
				 		<div class="col-2">
							<form method="post" style="margin-left: 4.2rem; " action="IndustryPartner.htm" >
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<button type="submit" style="margin-top: -5px;" class="btn btn-sm add" name="Action" value="Add">ADD INDUSTRY PARTNER</button>						
							</form>	
						</div>
					</div>
				</div>
				<div class="card-body"> 
					<%if(industryPartnerList!=null && industryPartnerList.size()>0){ %>
						<!-- search box -->
						<form method="get" class="form-inline my-2 my-lg-0" style="display: flex; justify-content: center; padding-bottom:10px;">
							<div >
								<input name="search" id="search" required class="form-control mr-sm-2" placeholder="Search" aria-label="Search" type="Search" />
								<input type="submit" class="btn btn-outline-success my-2 my-sm-0" name="clicked" value="Search" />
								<a href="IndustryPartner.htm"><button type="submit" class="btn btn-outline-danger my-2 my-sm-0" formnovalidate="formnovalidate" >Reset</button></a>
								
							</div>
						</form>
						<!-- search ends -->
					<%} %>
					<div class="data-table-area mg-b-15">
			        	<div class="container-fluid">
			                
			        		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			                	<div class="sparkline13-list">
			                    	<div class="sparkline13-graph">
			                        	<table class="table table-bordered table-hover table-striped table-condensed "  id=""> 
			                            	
			                            	<thead style=" text-align: center;background: #1967a1;color: white;" >
			                                    <tr>
			                                    	<td rowspan="2">SN</td>
			                                    	<td colspan="2">Industry</td>
			                                    	<td colspan="4">Representative</td>
			                                    	<td rowspan="2">Status</td>
			                                     	<td rowspan="2">Edit and Revoke</td>  
			                                    </tr>     
			                               		<tr>
			                                    	<td>Name</td>
			                                    	<td>Address</td>
			                                    	<td>Name</td>
			                                     	<td>Designation </td>
			                                      	<td>MobileNo </td>
			                                      	<td>Email</td>
			                                   	</tr>
			                            	</thead>
			                                <tbody>
			                                	<%
			                                	//int slno = 0;
			                                	if(industryPartnerList!=null && industryPartnerList.size()>0){
			        	   							
			        	   							for (Map.Entry<String, List<Object[]>> entry : industryPartnerToListMap.entrySet()) {
			                   							String key = entry.getKey();
			                   							List<Object[]> values = entry.getValue();
			                   							int i=0;
			                   							for (Object[] obj : values) {
			        	   						%>
			           
			           								<tr>
			           									<td style="text-align: center;"><%=++slno %></td>
			           									<%if(i==0) {%>
													    	<td  rowspan="<%=values.size() %>" style="vertical-align: middle;"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-"%> %></td>
													    	<td  rowspan="<%=values.size() %>" style="vertical-align: middle;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - "%>+", "+<%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()):" - "%>+" - "+<%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()):" -"%> %></td>
			           									<%} %>
												        <td><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):"-"%> %></td>
												        <td><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()):"-"%> %></td>
												        <td style="text-align: center;"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()):"-"%> %></td>
												        <td><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()):"-"%> %></td>
												        <td style="text-align: center;">
			                                               <%if(Boolean.parseBoolean(obj[8].toString())) {%>
			                                                     <span class="badge badge-success">Active</span>  
			                                               <%}else{ %>
			                                               <span class="badge badge-danger">Inactive</span>
			                                               <%} %>
			                                               </td>
												        <td  class="center width">
															<% if(Boolean.parseBoolean(obj[8].toString())) {%>
													 		<form action="#" method="POST" name="myfrm"  style="display: inline">
																<button  class="editable-click" name="Action" value="Edit" formaction="IndustryPartner.htm">
																	<div class="cc-rockmenu">
																 		<div class="rolling">	
											                        		<figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
											                        		<span>Edit</span>
											                      		</div>
											                     	</div>
											                  	</button>   
											                  	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
											                    
			                                                   <button  class="editable-click" name="Action" value="Revoke" formaction="IndustryPartnerRepRevoke.htm" onclick="return confirm('Are you sure to revoke?')">
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/remove.png" ></figure>
											                        <span>Revoke</span>
											                      </div>
											                     </div>
											                  </button>   
			                                               
															
															<input type="hidden" name="industryPartnerRepId" value="<%=obj[3] %>"/>
															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														
															</form>
															<%}%> 
			                                            </td>

			           								</tr>
			           							<% i++;} } } else {%>
			           								<tr>
			           									<td colspan="9" style="text-align: center;">No Data Available</td>
			           								</tr>
			                                    <%} %> 
											</tbody>				    
			                        	</table>
			                      		<input type="hidden" name="slno" value="<%=slno%>">
			                    	</div>
			                	</div>
			            	</div>
			        	</div>
			    	</div>
			    	<%if(industryPartnerList!=null && industryPartnerList.size()>0){ %>
				    	<div class="pagin" style="display: flex; justify-content: center;padding-bottom:10px;">
							<nav aria-label="Page navigation example" >
								<div class="pagination" >
									<% int pagin = Integer.parseInt(request.getAttribute("pagination").toString()) ; %>
								
										<div class="page-item">
											<form method="get" action="IndustryPartner.htm" onsubmit="return verify()">
												<input class="page-link" type="submit" <%if(pagin==0){ %>disabled<%} %> value="Previous" />
												<% if (request.getAttribute("searchFactor")!=null){ %>
													<input type="hidden" value="<%= request.getAttribute("searchFactor").toString() %>" name="search" />
												<%} %>
												<input type="hidden" id="pagination" name="pagination" value=<%=pagin-1 %> />
												<input type="hidden" name="slno" value="<%=slno%>">
											</form>
										</div>
										<div class="page-item">
											<input class="page-link" type="button" value="<%=pagin+1 %>" disabled/>
										</div>
										<div class="page-item">
											<form method="get" action="IndustryPartner.htm" >
												<% int last=pagin+2;if(Integer.parseInt(request.getAttribute("maxpagin").toString())<last)
													last=0; %>
													<input class="page-link" type="submit" value="Next" <%if(last==0){ %><%="disabled"%><%} %> />
													<input type="hidden" name="pagination" value=<%=pagin+1 %> />
													<input type="hidden" name="slno" value="<%=slno%>">
											</form>
										</div>
								</div>
							</nav>
						</div>
					<%}%>
        		</div>
			</div>
	
		</div>

	</div> 
	
</div>	
	
	
	
	
<script type="text/javascript">

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}	
		  return true;
	 
			
	}




function Delete(myfrm){

	  var cnf=confirm("Are You Sure To Make Industry Partner Revoke !");
	  if(cnf){
	
	return true;
	
	}
	  else{
		  event.preventDefault();
			return false;
			}
	
	}

</script>

<script type="text/javascript">

$(document).ready(function(){
	  $("#myTableIndustryPartner").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
});
});

function verify(){
	const ele = document.getElementById("pagination").value;
	if(ele<0)
	{
		return false;
	}
	return true;
}

</script>

</body>
</html>