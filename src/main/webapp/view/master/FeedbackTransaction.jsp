<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style>

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

@media (max-width: 768px) {
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
		List<Object[]> transactionList = (List<Object[]>) request.getAttribute("transactionList");
		Object[] feedBackData = (Object[]) request.getAttribute("feedBackData");
		String EmpId = ((Long) session.getAttribute("EmpId")).toString();
		
		FormatConverter fc = new FormatConverter();
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
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md-11">
							<h4>Feedback Transaction</h4>
						</div>
						<div class="col-md-1 right">
		 					<a class="btn btn-info btn-sm shadow-nohover back" style="position:relative;" href="FeedBack.htm">Back</a>
	 					</div>
					</div>
				</div>
				
				<div class="card-body">
					<div class="row">
						<div class="col-md-1"></div>
						<div class="col-md-1 right">
							<h5>Feedback : </h5>
						</div>
						<div class="col-md-10">
							<h6 class="mt-1"><%=feedBackData[3]!=null?StringEscapeUtils.escapeHtml4(feedBackData[3].toString()):"" %> </h6>
						</div>
					</div>
					
					<div class="chat-container d-flex flex-column">
					    <form action="FeedbackTransactionSubmit.htm" method="POST" class="d-flex flex-column h-100">
					        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					
					        <!-- Scrollable chat body -->
					        <div class="chat-body flex-grow-1 overflow-auto px-3 py-2">
					            <% if (transactionList != null && transactionList.size() > 0) {
					                for (Object[] transaction : transactionList) {
					                    String sender = transaction[3].toString();
					                    String senderName = transaction[5] + ", " + transaction[6];
					                    String message = transaction[2].toString();
					                    String timestamp = fc.sdtfTordtf2(transaction[4].toString());
					            %>
					                <div class="chat-message <%= sender.equalsIgnoreCase(EmpId) ? "admin-msg" : "user-msg" %>">
					                    <strong class="sender-name"><%=senderName!=null?StringEscapeUtils.escapeHtml4(senderName):"-" %></strong>: <%= message!=null?StringEscapeUtils.escapeHtml4(message):"-" %>
					                    <div class="timestamp"><%= timestamp!=null?StringEscapeUtils.escapeHtml4(timestamp):"-" %></div>
					                </div>
					            <% }} %>
					        </div>
					
					        <!-- Fixed input section -->
					        <div class="chat-input border-top p-3 bg-white">
					        	<%if(feedBackData[5]!=null && feedBackData[5].toString().equalsIgnoreCase("C")) {%>
					        		<div class="text-center">
					        			<h5>Feedback Closed...!</h5>
						            </div>
					        	<%} else{%>
					        		<div class="form-group mb-2">
						                <label for="Remarks"><strong>Comment:</strong></label>
						                <textarea rows="2" class="form-control" id="Remarks" name="Remarks" placeholder="Enter Comments" required></textarea>
						            </div>
						            <div class="text-center">
						                <input type="submit" class="btn btn-primary btn-sm submit" value="Submit" name="sub" onclick="return confirm('Are You Sure To Submit?')">
						                <input type="submit" class="btn btn-danger btn-sm delete" value="Close" name="sub" onclick="return confirm('Are You Sure To Close?')">
						            </div>
						            <input type="hidden" name="feedbackid" value="<%= feedBackData[0] %>">
					        	<%} %>
					        </div>
					    </form>
					</div>

				</div>
			</div>
		</div>
	</div>
<script>
    window.onload = function () {
        const chatBody = document.querySelector('.chat-body');
        if (chatBody) {
            chatBody.scrollTop = chatBody.scrollHeight;
        }
    };
</script>
				
</body>
</html>