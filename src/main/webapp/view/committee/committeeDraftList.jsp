<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title></title>
<spring:url value="/resources/css/sweetalert2.min.css"
	var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
<link href="${sweetalertCss}" rel="stylesheet" />
<script src="${sweetalertJs}"></script>
<style type="text/css">
#sidebarCollapse {
	display: none;
}

#sidebar {
	display: none;
}

.btn-status {
	position: relative;
	z-index: 1;
}

.btn-status:hover {
	transform: scale(1.05);
	z-index: 5;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}

label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

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

.chat-container {
	max-width: 800px;
	height: 600px;
	margin: 30px auto;
	background-color: #f8f9fa;
	border: 1px solid #dee2e6;
	border-radius: 10px;
	display: flex;
	flex-direction: column;
	overflow: hidden;
}

.chat-body {
	flex-grow: 1;
	overflow-y: auto;
}

.chat-message {
	margin: 10px 0;
	padding: 12px 16px;
	border-radius: 20px;
	max-width: 75%;
	word-break: break-word;
	font-size: 14px;
}

.user-msg {
	background-color: #ffffff;
	border: 1px solid #dee2e6;
	align-self: flex-start;
}

.admin-msg {
	background-color: #d1e7dd;
	border: 1px solid #badbcc;
	align-self: flex-end;
	margin-left: auto;
}

.chat-message strong {
	display: block;
	font-size: 13px;
	color: #343a40;
	margin-bottom: 4px;
}

.timestamp {
	font-size: 11px;
	color: #6c757d;
	text-align: right;
	margin-top: 6px;
}

.chat-input {
	position: sticky;
	bottom: 0;
	z-index: 10;
}

.sender-name {
	font-weight: bold;
	display: block;
	color: #343a40;
}

/* .btn.submit {
    width: 150px;
    border-radius: 25px;
    padding: 8px 20px;
    font-weight: 600;
} */
@media ( max-width : 768px) {
	.chat-container {
		height: auto;
	}
	.chat-message {
		max-width: 90%;
	}
	.btn.submit {
		width: 100%;
	}
}
</style>
</head>
<body>

	<%
List<Object[]>  draftMomList=(List<Object[]>)request.getAttribute("draftMomList");
String  pageSize=(String)request.getAttribute("pageSize");
Long empId = (Long)session.getAttribute("EmpId");
String errorInPageSize=(String)request.getAttribute("errorInPageSize");
%>
	<% if(errorInPageSize!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
			<%=StringEscapeUtils.escapeHtml4(errorInPageSize) %>
		</div>
	</div>
	<%}	%>
	<div class="container-fluid">
		<div class="row mr-4 ml-4">
			<div class="col-md-12">

				<div class="card shadow-nohover">

					<div class="card-header">
						<div class="row">
							<div class="col-md-12">
								<h3 style="color: #055C9D; margin-top: -5px;">MOM Draft
									List</h3>

							</div>


						</div>
					</div>

					<div class="card-body">
						<!-- tabList  -->
						<!-- 	<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  <li class="nav-item" style="width: 50%;"  >
		    <div class="nav-link active" style="text-align: center;" id="eNotePendingtab" data-toggle="pill" data-target="#pills-OPD" role="tab" aria-controls="pills-OPD" aria-selected="true">
			   <span>   
				 
				</span> 
		    </div>
		  </li>
		  <li class="nav-item"  style="width: 50%;">
		    <div class="nav-link" style="text-align: center;" id="eNoteApprovedtab" data-toggle="pill" data-target="#pills-IPD" role="tab" aria-controls="pills-IPD" aria-selected="false">
		 
		    
		    
		    </div>
		  </li>
		</ul> -->
						<div align="right">
							<form action="CommitteeMomDraft.htm" method="get" id="form">
								<span class="text-primary">Show</span> <select id="rowPerPage"
									name="pageSize">
									<option value="5" <%if(Integer.parseInt(pageSize)==5) {%>
										selected <%} %>>5</option>
									<option value="10" <%if(Integer.parseInt(pageSize)==10) {%>
										selected <%} %>>10</option>
									<option value="20" <%if(Integer.parseInt(pageSize)==20) {%>
										selected <%} %>>20</option>
									<option value="25" <%if(Integer.parseInt(pageSize)==25) {%>
										selected <%} %>>25</option>
									<option value="50" <%if(Integer.parseInt(pageSize)==50) {%>
										selected <%} %>>50</option>
									<option value="75" <%if(Integer.parseInt(pageSize)==75) {%>
										selected <%} %>>75</option>
									<option value="100" <%if(Integer.parseInt(pageSize)==100) {%>
										selected <%} %>>100</option>

								</select> <input type="submit" id="submit" style="display: none;">
							</form>


						</div>
						<!-- two divs for List  -->
						<div class="tab-content mt-2" id="pills-tabContent">
							<!-- pendig Div  -->
							<div class=" tab-pane  show active" id="pills-OPD"
								role="tabpanel" aria-labelledby="eNotePendingtab">
								<table
									class="table table-bordered table-hover table-striped table-condensed "
									id="myTable1" style="">
									<thead>
										<tr style="background: #055C9D; color: white;">
											<th style="text-align: center;">SN</th>
											<th style="text-align: center;">Committee</th>
											<th style="text-align: center;">Meeting Id</th>
											<th style="text-align: center;">MOM</th>
											<th style="text-align: center;">Remarks</th>
										</tr>
									</thead>
									<tbody>
										<%
							int snCount =0;
							for(Object[]obj:draftMomList){ %>
										<tr>
											<td style="text-align: center;"><%=++snCount %>.</td>
											<td><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()).split("/")[2]: " - " %></td>
											<td><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - " %></td>
											<td style="text-align: center;">
												<%if(!obj[1].toString().equalsIgnoreCase("0")){ %>
												<form action="CommitteeMinutesNewDownload.htm" method="get"
													target="_blank">
													<button class="btn btn-link"
														style="padding: 0px; margin: 0px;"
														name="committeescheduleid" value="<%=obj[6]%>"
														data-toggle="tooltip" data-placement="top"
														data-original-data="" title="VIEW MOM">
														<figure class="rolling_icon">
															<img src="view/images/preview3.png">
														</figure>
													</button>


												</form> <%}else{ %>
												<form action="CommitteeMinutesViewAllDownload.htm"
													method="get" target="_blank">
													<button class="btn btn-link"
														style="padding: 0px; margin: 0px;"
														name="committeescheduleid" value="<%=obj[6]%>"
														data-toggle="tooltip" data-placement="top"
														data-original-data="" title="VIEW MOM">
														<figure class="rolling_icon">
															<img src="view/images/preview3.png">
														</figure>
													</button>


												</form> <%} %>
											</td>
											<td style="width: 20%;">

												<button class="editable-click" type="button"
													onclick="showModal('<%=obj[6].toString()%>','<%=obj[0].toString()%>')">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<i class="fa fa-comments" aria-hidden="true"></i>
															</figure>
															<span style="margin-top: 0.3rem;">Comments</span>
														</div>
													</div>
												</button>

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
	</div>

	<!-- Modal to give remarks and show remarks   -->
	<div class="modal fade" id="chatModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content" style="width: 200%; margin-left: -50%;">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="chat-container d-flex flex-column">

						<!-- Scrollable chat body -->
						<div class="chat-body flex-grow-1 overflow-auto px-3 py-2" id="messageEditor">

						</div>

						<!-- Fixed input section -->
						<div class="chat-input border-top p-3 bg-white">

							<div class="form-group mb-2">
								<label for="Remarks"><strong>Comment:</strong></label>
								<textarea rows="2" class="form-control" id="Remarks"
									name="Remarks" placeholder="Enter Comments" required></textarea>
							</div>
							<div class="text-center">
								<input type="button" class="btn btn-primary btn-sm submit"
									value="Submit" name="sub" onclick="submitRemarks()"> 
									
<!-- 								<input type="button" class="btn btn-danger btn-sm delete"
									value="Close" name="sub"
									onclick="return confirm('Are You Sure To Close?')"> -->
							</div>


						</div>

					</div>
				</div>

			</div>
		</div>
	</div>


	<script>
		$('#rowPerPage').change(function() {
		    $('#form').submit();
		    $('#submit').click();
		});
		$(function () {
			$('[data-toggle="tooltip"]').tooltip()
			})
			
		
			var scheduleId="0";
			var meetingName = ""
			
			function showModal(a,b){
				
				$.ajax({
				
					type:'GET',
					url:'getMomDraftRemarks.htm',
					datatype:'json',
					data:{
						scheduleId:a,
					},
					success : function (result){
						var ajaxresult = JSON.parse(result);
						
						var empid = '<%=empId %>'
						
						var html = "";
					
				for (var i=0;i<ajaxresult.length;i++){
							
							var sender = ajaxresult[i][4];
							if(sender==empid){
								html=html +'<div class="chat-message user-msg">'
							}else{
								html=html +'<div class="chat-message admin-msg">'
							}
							
							var senderName = ajaxresult[i][0]+", "+ajaxresult[i][1];
							var message = ajaxresult[i][2];
							var arr= ajaxresult[i][3].split(" ");
							var msgdate = arr[0].split("-")[2]+"-"+arr[0].split("-")[1]+"-"+arr[0].split("-")[0];
							
							var msgtime = arr[1].substring(0,5);
							
							html = html +
									'<strong class="sender-name">'+senderName +'</strong>'+message 
									+'<div class="timestamp">'+msgdate+' '+ msgtime+'</div></div>'
						}
						$('#messageEditor').html(html);
					}
					
					
				})
				
				
				
			$('#chatModal').modal('show');
			$('#exampleModalLabel').html("MOM REMARKS FOR "+b)
			scheduleId=a;
			meetingName=b;
		}
			
			function submitRemarks(){
				console.log(scheduleId)
				console.log(meetingName)
				
				var remarks = $('#Remarks').val().trim();
				console.log(remarks)
				
				if(remarks.length==0){
					Swal.fire({
						  icon: "error",
						  title: "Oops...",
						  text: "Remarks can not be empty!",
						
						});
					
					event.preventDefault();
					return false;
				}
				console.log(remarks +"remarks")
				
				Swal.fire({
		    title: 'Are you sure?',
		    text: "Do you want to submit the remarks?",
		    icon: 'warning',
		    showCancelButton: true,
		    confirmButtonText: 'Yes',
		    cancelButtonText: 'No'
		}).then((result) => {
		    if (result.isConfirmed) {
		        $.ajax({
		            type: 'GET',
		            url: 'submitMomRemarks.htm',
		            dataType: 'json',  
		            data: {
		                scheduleId: scheduleId,
		                remarks: remarks
		            },
		            success: function (result) {
		                var ajaxresult = JSON.parse(result);
		                if (Number(ajaxresult) > 0) {
		                    $('#chatModal').modal('hide'); // hide modal first

		                    Swal.fire({
		                        icon: "success",
		                        title: "SUCCESS",
		                        text: "Remarks Given",
		                        allowOutsideClick: false
		                    }).then(() => {
		                        // After Swal is closed, reopen the modal
		                        $('#Remarks').val('');
		                        showModal(scheduleId, meetingName);
		                    });
		                }
		            },
		            error: function () {
		                // Optional: show error message
		                Swal.fire('Error', 'There was an issue submitting your remarks.', 'error');
		            }
		        });
		    }
		})
				
				
			}
		</script>

</body>
</html>