<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.documents.model.IGILogicalChannel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
</head>
<body>
<%
	IGILogicalChannel igiLogicalChannel = (IGILogicalChannel) request.getAttribute("igiLogicalChannel");
	List<Object[]> systemProductTreeAllList = (List<Object[]>) request.getAttribute("systemProductTreeAllList");
	List<Object[]> softwareList = systemProductTreeAllList.stream().filter(e -> e[10]!=null && (e[10].toString().equalsIgnoreCase("S") || e[10].toString().equalsIgnoreCase("F")) ).collect(Collectors.toList());
%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8" style="top: 10px;">
				<div class="card shadow-nohover">
					<div class="card-header" style="background-color: #055C9D;">
						<b class="text-white">Logical Channel <%if(igiLogicalChannel!= null) { %>Edit <%} else{%>Add<%} %> </b>
					</div>
					<div class="card-body">
						<form action="IGILogicalChannelDetailsSubmit.htm" method="POST" id="myform">
							<div class="form-group">
	       						<div class="row">
	                    		    <!-- <div class="col-md-7">
       									<label class="form-lable">Logical Channel <span class="mandatory">*</span></label>
       									<input type="text" class="form-control" name="logicalChannel" id="logicalChannel" placeholder="Enter Channel Name" maxlength="255" required>
       								</div> -->
       								<div class="col-md-4">
	        							<label class="form-lable">Sub-System 1<span class="mandatory">*</span></label>
	        							<select class="form-control selectdee source" name="source" id="source" <%if(igiLogicalChannel!= null) { %>disabled<% }%>
		        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
									        
								        	<option value="" disabled selected>Choose...</option>
									        <%
									        for(Object[] obj : softwareList){ %>
									        	<option value="<%=obj[0]+"/"+obj[7] %>" data-id="<%=obj[0]%>" 
									        	<%if(igiLogicalChannel!= null && igiLogicalChannel.getSourceId()==Long.parseLong(obj[0].toString())) {%>selected<%} %> >
									        		<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "+" ("+obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - "+")" %>
									        	</option>
									        <%} %>
										</select>
	        						</div>
	        						<div class="col-md-4">
	        							<label class="form-lable">Sub-System 2<span class="mandatory">*</span></label>
		        						<select class="form-control selectdee destination" name="destination" id="destination" <%if(igiLogicalChannel!= null) { %>disabled<% }%>
		        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
											<option value="" disabled selected>Choose...</option>
									        <% for(Object[] obj : softwareList){ %>
									        	<option value="<%=obj[0]+"/"+obj[7] %>" data-id="<%=obj[0]%>" 
									        		<%if(igiLogicalChannel!= null && igiLogicalChannel.getDestinationId()==Long.parseLong(obj[0].toString())) {%>selected<%} %> >
									        		<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "+" ("+obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - "+")" %>
									        	</option>
									        <%} %>
										</select>
        							</div>
	                    		    <div class="col-md-4">
       									<label class="form-lable">Channel Code <span class="mandatory">*</span></label>
       									<input type="text" class="form-control" name="channelCode" id="channelCode" placeholder="Enter Channel Code" maxlength="5" required 
       									<%if(igiLogicalChannel!= null) { %> value="<%=StringEscapeUtils.escapeHtml4(igiLogicalChannel.getChannelCode()) %>" readonly<% }%>>
       								</div>
                 				 </div>
                			</div>
							<div class="form-group">
	       						<div class="row">
	                    		    <div class="col-md-12">
       									<label class="form-lable">Description <span class="mandatory">*</span></label>
       									<textarea class="form-control" name="description" id="description" rows="2" placeholder="Enter Channel Description" maxlength="1000" required><%if(igiLogicalChannel!= null) { %><%=StringEscapeUtils.escapeHtml4(igiLogicalChannel.getDescription()) %><%} %></textarea>
       								</div>
                 				 </div>
                			</div>
									
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
     						<input type="hidden" name="logicalChannelId" value="<%if(igiLogicalChannel!= null) { %><%=igiLogicalChannel.getLogicalChannelId() %><%} else{%>0<%} %>">
									
							<div class="center mt-2">
								<%if(igiLogicalChannel!= null) { %>
									<button type="submit"class="btn btn-sm edit" onclick="return confirm('Are you sure to Update?')">UPDATE</button>
								<%} else{%>
									<button type="submit"class="btn btn-sm submit" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
								<%} %>
								
								<a class="btn btn-info btn-sm shadow-nohover back" style="position:relative;" href="LogicalChannelMaster.htm">Back</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>				
</body>
</html>