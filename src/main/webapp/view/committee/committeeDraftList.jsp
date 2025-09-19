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
<spring:url value="/resources/css/committeeModule/committeeDraftList.css" var="committeeDraftList" />
<link href="${committeeDraftList}" rel="stylesheet" />
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
								<h3 class="momDraftStyle">MOM Draft
									List</h3>

							</div>


						</div>
					</div>

					<div class="card-body">
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

								</select> <input type="submit" id="submit" class="inputSubmitStyle">
							</form>


						</div>
						<!-- two divs for List  -->
						<div class="tab-content mt-2" id="pills-tabContent">
							<!-- pendig Div  -->
							<div class=" tab-pane  show active" id="pills-OPD"
								role="tabpanel" aria-labelledby="eNotePendingtab">
								<table
									class="table table-bordered table-hover table-striped table-condensed "
									id="myTable1">
									<thead>
										<tr class="tblTrStyle">
											<th class="text-center">SN</th>
											<th class="text-center">Committee</th>
											<th class="text-center">Meeting Id</th>
											<th class="text-center">MOM</th>
											<th class="text-center">Remarks</th>
										</tr>
									</thead>
									<tbody>
										<%
							int snCount =0;
							for(Object[]obj:draftMomList){ %>
										<tr>
											<td class="text-center"><%=++snCount %>.</td>
											<td><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()).split("/")[2]: " - " %></td>
											<td><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - " %></td>
											<td class="text-center">
												<%if(!obj[1].toString().equalsIgnoreCase("0")){ %>
												<form action="CommitteeMinutesNewDownload.htm" method="get"
													target="_blank">
													<button class="btn btn-link previewBtnStyle"
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
													<button class="btn btn-link previewBtnStyle"
														name="committeescheduleid" value="<%=obj[6]%>"
														data-toggle="tooltip" data-placement="top"
														data-original-data="" title="VIEW MOM">
														<figure class="rolling_icon">
															<img src="view/images/preview3.png">
														</figure>
													</button>


												</form> <%} %>
											</td>
											<td class="width-20">

												<button class="editable-click" type="button"
													onclick="showModal('<%=obj[6].toString()%>','<%=obj[0].toString()%>')">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<i class="fa fa-comments" aria-hidden="true"></i>
															</figure>
															<span class="commentsMarginTop">Comments</span>
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
			<div class="modal-content modalContentWidth">
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