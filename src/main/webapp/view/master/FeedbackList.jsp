<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.* , java.text.DateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>FEEDBACK LIST</title>
<style type="text/css">

.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 33px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 120px;
}

.cc-rockmenu .viewcommittees:hover {
	width: 157px;
}



.cc-rockmenu .rolling .rolling_icon {
	float: left;
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
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu .rolling p {
	margin: 0;
}

.width {
	width: 270px !important;
}

a:hover {
	color: white;
}

</style>


</head>
<body>
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
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</div>
<%} %>

		

			<%
				DateFormat inputFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
				SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
				List<Object[]> FeedbackList = (List<Object[]>) request.getAttribute("FeedbackList");
			%>

			<div class="container-fluid">	

			<div class="row">
			<div class="col-md-1"></div>
				<div class="col-md-10">
				 <div class="card shadow-nohover" >
					<div class="card-header">
						<div class="row">
							<div class="col-md-6"><h3>Feedback List</h3></div>
							<div class="col-md-6"><a class="btn btn-sm back" href="MainDashBoard.htm" style="float: right;">BACK</a></div>
						</div>
					</div>	
					<div class="card-body"> 
					<form action="##">
							 <div class="datatable-dashv1-list custom-datatable-overright">
			                    
			                <table class="table table-bordered table-hover table-striped table-condensed " id="myTable" > 
			                    <thead>
								<tr>
									<th style="text-align: center ; width:5%; ">SN.</th>
									<th style="text-align: center ;width:40%;">Employee Name</th>
									<th style="text-align: center ;width:25%;">Date</th>
									<th style="text-align: center ;width:20%;">View</th>
								</tr>
							</thead>
							<tbody>
								<% int count=0;
									for (Object[] obj : FeedbackList) {
								%>
								<tr>
									<td style=""><%=++count%></td>
									<td style="text-align: center;"><%=obj[1]%></td>
									<td style="text-align: left;"><%=sdf.format(inputFormatter.parse(obj[2].toString()) ) %></td>
									<td style="text-align: left;">
									
										<button type="button" class="editable-click" name="sub" value="Modify" onclick="feedbackmodal('<%=obj[0]%>' , '<%=sdf1.format(inputFormatter.parse(obj[2].toString()) )%>')">
											<div class="cc-rockmenu">
												<div class="rolling">
													<figure class="rolling_icon">
														<img src="view/images/preview3.png">
													</figure>
													<span>View</span>
												</div>
											</div>
										</button>
									</td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
					 <div align="center"> 
					 	<button type="submit" class="btn btn-primary btn-sm add" formaction="FeedBackPage.htm" formmethod="get">ADD Feedback </button>
					 	
					 </div>
					 </form>		
				</div>
			</div>
		</div>
	</div>
	
	</div>
	
	
	
		<div class="modal fade" id="feedbackdata" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 93% !important;height: 90%;">
				<div class="modal-content" style="min-height: 90%;" >
				    <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374">Feedback By <span id="feedby"></span></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
				          <span aria-hidden="true">&times;</span>
				        </button>
				    </div>
				    
					<div class="modal-body"  style="padding: 0.5rem !important;">
						<div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
							<div class="row" id="feedbackdiv">
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	
	

</body>

<script>

function feedbackmodal(feedbackid , feedbackdate)
{
	
	$.ajax({
		
		type : "GET",
		url : "FeedbackContent.htm",
		data : {
			
			feedbackid : feedbackid
			
		},
		datatype : 'json',
		success : function(result) {
			console.log(result);
			
			var result= JSON.parse(result);
			var values= Object.keys(result).map(function(e){
				
				return result[e]
				
			})
			
			$('#feedby').html(values[1]+' on '+feedbackdate);
			$('#feedbackdiv').html(values[3]);
			$('#feedbackdata').modal('toggle');
			
			
		}
	});
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


</html>