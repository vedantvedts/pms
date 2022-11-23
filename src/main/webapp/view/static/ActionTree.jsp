<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Action Tree</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/plugins/ActionTree/css/jquery.orgchart.css" var="acttreecss" />
<link href="${acttreecss}" rel="stylesheet" />
<spring:url value="/resources/plugins/ActionTree/js/jquery.orgchart.js" var="acttreejs" />
<script src="${acttreejs}"></script>

</head>
<body>

<div id="chart-container" style="text-align: left;"></div>

<script type="text/javascript">(function($) {
	  $(function() {
		   var ds = {
		     'name': 'Lao Lao',
		     'title': 'general manager',
		     'children': 
		    	[
			       { 'name': 'Bo Miao', 'title': 'department manager \n department manager \n department manager' },
			       { 'name': 'Su Miao', 'title': 'department manager',
			         'children': 
						[
			        	 
				           { 'name': 'Tie Hua', 'title': 'senior engineer' },
				           { 'name': 'Hei Hei', 'title': 'senior engineer',
				             'children': 
				            	[
					               { 'name': 'Pang Pang', 'title': 'engineer' },
					               { 'name': 'Xiang Xiang', 'title': 'UE engineer' ,
					               'children': 
						            	[
							               { 'name': 'Pang Pang', 'title': 'engineer' },
							               { 'name': 'Xiang Xiang', 'title': 'UE engineer' }
						             	]
					               }
				             	]
				            }
			       		]
			        },
			        
			        { 'name': 'Hong Miao', 'title': 'department manager' },
			        { 'name': 'Chun Miao', 'title': 'department manager' }
		      	]
		    };

		    var oc = $('#chart-container').orgchart({
		      'data' : ds,
		      'nodeContent': 'title',
		      'direction': 'l2r',
		      'pan':true
		    });

		  });
		})(jQuery);</script>
</body>
</html>