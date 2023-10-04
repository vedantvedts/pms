<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Action Assignee</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x: hidden; 
}
h6{
	text-decoration: none !important;
}


</style>
</head>
 
<body>
  <%

  
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  Object[] Assignee=  (Object[]) request.getAttribute("Assignee");
  List<Object[]> SubList=(List<Object[]> ) request.getAttribute("SubList");
  String AssigneeName=(String) request.getAttribute("AssigneeName");
  List<Object[]> LinkList=(List<Object[]> ) request.getAttribute("LinkList");
  String ActionNo=(String) request.getAttribute("ActionNo");
  String text=(String)request.getAttribute("text");
  
 %>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></center>
                    <%} %>

    <br />
    
    


<div class="container-fluid">

	<div class="container" style="margin-bottom:20px;">

		
    		<div class="card" style=" ">
    	
    	
    	
	    		<div class="card-header" style="background-color: #055C9D;height: 100%;">
      				<h6 style="color: white;font-weight: bold;font-size: 1.2rem !important " align="left"> Action :<%if(Assignee!=null && Assignee[5]!=null){%> <%=Assignee[5] %> (<%=Assignee[10] %>) <%}%> 
      				
					<span style="float: right;font-size: 17px;margin-top: 5px">Assignor : <%if(Assignee!=null && Assignee[1]!=null){%> <%=Assignee[1]%>, <%=Assignee[2]%><%}%></span>
      				 </h6>
      			</div>
      		<div class="card-body" >
      			 <div class="row">
      		

   
   <div class="col-md-12" style="padding-left: 0px">
    <% if(LinkList.size()>0){ %>  
   				<div class="table-responsive">
    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" style="margin-top: 20px;">
						<thead>
							<tr>
								<th colspan="7" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;text-transform: capitalize;" >Old Action  Details </th>									
							</tr>	
							<tr>					
								<th style="text-align: left;">As On Date</th>
								<th style="">Progress %</th>
								<th style="">Remarks</th>								
							 	<th style="">Attachment</th>
							 	<!-- <th style="">Upload</th> -->
								<th style="">Action</th>
							</tr>
						</thead>
						<tbody>					
						<%
						for(Object[] obj: LinkList){ %>
														
						<tr >
								<td width="12%">
									<%=sdf.format(obj[3])%>
								</td>
								
								<td width="6%">
									
									<div class="progress" style="background-color:#cdd0cb !important">
  										<div class="progress-bar progress-bar-striped" role="progressbar" style="width: <%=obj[2]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><%=obj[2]%></div>
									</div>
				
										</td>
								
								<td style="text-align: left; width: 10%;"> 
									<%=obj[4]%>
								</td>
								
								<td style="text-align: left; width: 3%;">
								
							 <% 
						        if(obj[5]!=null && obj[5].toString().length()!=0  ){
						        %>
						        <div  align="center">
										<a  
										 href="ActionDataAttachDownload.htm?ActionSubId=<%=obj[6]%>" 
										 target="_blank"><i class="fa fa-download"></i></a>
									</div>
								
									
								<%}else{ %>
								
								<div  align="center">-</div>
								 <%} %>
									
						
								</td>
								
														
								<td style="text-align: left; width: 6%;">
							     Old Action
								</td>
						
						</tr>
														
							<%  } %>	
									</tbody>
					</table>
				</div> 
				<%} %>
   						<div class="table-responsive">
    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" style="margin-top: 20px;">
						<thead>
						<tr>
								<th colspan="4" style="background-color: #346691; color: white; text-align: center;font-size: 18px !important;border-left: 0px solid;text-transform: capitalize;" >Action Updated Details </th>									
							</tr>	
							<tr>					
								<th style="text-align: left;">As On Date</th>
								<th style="">Progress %</th>
								<th style="">Remarks</th>								
							 	<th style="">Attachment</th>
							
							</tr>
						</thead>
						<tbody>					
											
					 	<% if(SubList!=null && SubList.size()>0){ int  count=1;
						for(Object[] obj: SubList){ %>
														
						<tr >
						
							 
							
		
								<td width="12%">
									<%=sdf.format(obj[3])%>
								</td>
								
								<td width="6%">
								
									<div class="progress" style="background-color:#cdd0cb !important">
  										<div class="progress-bar progress-bar-striped" role="progressbar" style="width: <%=obj[2]%>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"><%=obj[2]%></div>
									</div>
				
										</td>
								
								<td style="text-align: left; width: 10%;"> 
									<%=obj[4]%>
								</td>
								
								<td style="text-align: left; width: 3%;">
								
							 <% if(obj[5]!=null && obj[5].toString().length()!=0  ){%>
						        <div  align="center">
										<a  
										 href="ActionDataAttachDownload.htm?ActionSubId=<%=obj[6]%>" 
										 target="_blank"><i class="fa fa-download"></i></a>
									</div>
								<%}else{ %>
								<div  align="center">-</div>
								 <%} %>
						</tr>
							<% count++; } }else{%>
							<tr align="center">
								<td colspan="4"><h5> Action Not Yet Started! </h5></td>
							</tr>
							<%}%>
						</tbody>
					</table>
				</div> 
				<div align="center" >
				<%if(text!=null && text.equalsIgnoreCase("P")){ %>
					<a type="button" class="btn  btn-sm back" href="ActionReports.htm"  >BACK</a>
				<%}else if(text!=null && text.equalsIgnoreCase("Q")){ %>
				<a type="button" class="btn  btn-sm back" href="ActionPdcReport.htm"  >BACK</a>
				<%} %>
				</div>
				</div>
  			</div>
      		</div>
   	</div>   
   </div>  
</div> 
 <div class="row" style="margin-top: 20px;">
 
 
 
 
 
	<div class="col-md-12">
    	
    	<div class="card" style="">
      		
      		<div class="card-body" >
      		
      		
      		

</div>

			</div>
		</div>
	</div>

<script>

function back(){
	
	event.preventDefault;
	$("#Remarks").prop('required',true);
	
	confirm('Are You Sure to Send Back To Assignee ?');
	
}

function close5(){
	
	event.preventDefault;
	$("#Remarks").prop('required',true);
	
	confirm('Are You Sure to Close This Action ?');
	
}

function close2(){
	
	event.preventDefault;
	$("#Remarks").prop('required',false);

	
}
</script>

    




</body>
</html>