<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT STATUS LIST</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
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

.fa-exclamation-triangle{
	font-size: 2.5rem !important;
} 	

.table-project-n{
	color: #005086;
}

.right{
	text-align: right;
}

.center{
	text-align: center;
}

#table thead tr th{
	padding: 0px 0px !important;
}

#table tbody tr td{
	padding:2px 3px !important;
}
.font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 13px;
	  font-weight: 400 !important;
	 
}



		.label{
			border-radius: 3px;
  			color: white;
  			padding:1px 2px;
		}
		.label-primary{
			background-color:#D62AD0; /* D62AD0 */
		}
		.label-warning{
  			background-color:#5C33F6;
		}
		.label-info{
  			background-color:#006400;
  			
		}
		.label-success{
			background-color:#4B0082;
		}
		
		.trup
		{
			padding:5px 5px 0px 5px ;			
			border-top-left-radius : 5px; 
			border-top-right-radius: 5px;
		}
		
		.trdown
		{
			padding:0px 5px 5px 5px ;			
			border-bottom-left-radius : 5px; 
			border-bottom-right-radius: 5px;
		}
		
		.fa-long-arrow-right{
			font-size: 2.20rem;
			padding: 0px 5px;
		}


</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> ProjectStatusList=(List<Object[]>) request.getAttribute("ProjectStatusList");

List<Object[]> projectapprovalflowempdata=(List<Object[]>) request.getAttribute("projectapprovalflowempdata");

DecimalFormat df=new DecimalFormat("0.00");
NFormatConvertion nfc=new NFormatConvertion();
%>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	
	<center>
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </center>
    
    
                    <%} %>


	
<br>	
	
<div class="container-fluid">		
<div class="row">

	
	
	<div class="col-md-12">
	
	
		 <div class="card shadow-nohover" >
		 
		 <h3 class="card-header">Project Status List</h3>
		 
			<div class="card-body"> 
		
						  <table class="table table-bordered table-hover table-striped table-condensed "  id="table1">
                                        <thead>
                                         
                                            <tr>
                                             	
                                                <th >Type</th>
                                                <th >Title</th>
                                                <th >Code</th>
                                                <th >Category </th>
                                                <th >Cost</th>
                                                <th >Duration</th> 
                                                <th> Status</th>	
                                            </tr>
                                        </thead>
                                        <tbody>
										   <%for(Object[] 	obj:ProjectStatusList){ %>
										   
										    <tr>
										 
										   <td class="center"><%if(obj[0]!=null){%><%=obj[0] %><%}else{ %>-<%} %></td>
										   <td><%=obj[2] %></td>
										 	<td><%=obj[3] %></td>
										 	<td><%if(obj[1]!=null){%><%=obj[1] %><%}else{ %>-<%} %></td>
									     	<td class="right" ><%if(obj[4]!=null){%><%=nfc.convert(Double.parseDouble(obj[4].toString())/100000) %><%}else{ %>-<%} %></td>
										     <td class="center"><%if(obj[5]!=null){%><%=obj[5] %><%}else{ %>-<%} %></td>
											<td class="editable-click"><%if(obj[6]!=null){%>
											<a class="font" href="ProjectApprovalTracking.htm?Initiationid=<%=obj[7]%>" target="_blank" ><%=obj[6] %><%}else{ %>-<%} %></a></td>	
	
										    </tr>

										    <%} %>

	    							</tbody>
	    						<tfoot>
	    						<tr>
	    					
	    						<td colspan="8" align="right">
	    						<b>Cost In Lakhs, Duration In Months.</b>
	    						</td>
	    						</tr>
	    						
	    						</tfoot>
	    
                                    </table>
                                    
                     <div align="center" >
<!-- 						<button type="submit" class="btn btn-primary btn-sm add" name="sub" value="Add" style="margin-top: 15px"  >Add</button>
 --><!-- 						<button type="submit" class="btn btn-primary btn-sm add" name="sub" value="Details" style="margin-top: 15px"  onclick=" Prints(myfrm)">Details</button>
 -->					
 
 					</div>	
					
					
					 
					  <hr>
					  
					  <div class="row"  >
						 		<div class="col-md-12" style="text-align: center;"><b>Approval Flow</b></div>
						 	</div>
						 	<div class="row"  style="text-align: center; padding-top: 10px; padding-bottom: 15px; " >
				                <table  align="center" >
				                	<tr>
				                		<td class="trup" style="background: #B5EAEA;">
				                			Division Head
				                		</td>
				                		<td rowspan="2">
				                			 <i class="fa fa-long-arrow-right " aria-hidden="true"></i>
				                		</td >
				                		
				                		<td class="trup" style="background: #C6B4CE;">
				                			P&C DO
				                		</td>
				                		<td rowspan="2">
				                			 <i class="fa fa-long-arrow-right " aria-hidden="true"></i>
				                		</td>
				                		
				                		<td class="trup" style="background: #E8E46E;">
				                			AD 
				                		</td>
				                		<td rowspan="2">
				                			 <i class="fa fa-long-arrow-right " aria-hidden="true"></i>
				                		</td>
				                		
				                		<td class="trup" style="background: #FBC7F7;" >
				                			TCM
				                		</td>
				                			                		
				                	</tr>			   
				                	
				                	<tr>
				                		<td class="trdown" style=" background:#B5EAEA; " >	
				                			<%--  <%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("Division Head") ){ %>
							                     		<%=obj[1] %>,<%=obj[2] %>
							                     	<%} %>
							                     <%} %>
							               <%} %> --%>
							               Division Head ofPDD      
				                		</td>
				                		<td class="trdown"  style="background: #C6B4CE;" >	
				                			<%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("DO-RTMD") ){ %>
							                     		<%=obj[1] %>,<%=obj[2] %>
							                     	<%} %>
							                     <%} %>
							               <%} %>
				                		</td>
				                		<td class="trdown" style="background: #E8E46E;" >	
				                			<%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("AD") ){ %>
							                     		<%=obj[1] %>,<%=obj[2] %>
							                     	<%} %>
							                     <%} %>
							               <%} %>
				                		</td>
				                		<td class="trdown" style="background: #FBC7F7;" >	
				                			<%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("TCM") ){ %>
							                     		<%=obj[1] %>,<%=obj[2] %>
							                     	<%} %>
							                     <%} %>
							               <%} %>
				                		</td>
				                	</tr>             	
				                </table>			             
						 	</div>
                                    
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


 $(document).ready(function(){
	
	$("#table1").DataTable({
		"pageLength": 5
	})
}) 



</script>
<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
</body>
</html>