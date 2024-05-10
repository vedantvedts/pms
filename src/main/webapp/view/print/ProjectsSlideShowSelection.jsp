<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<style type="text/css">
   .modalcontainer {
      position: fixed;
      bottom: 45%;
      right: 20px;
      width: 300px;
      max-width: 80%;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      border-radius: 8px;
      z-index: 1000;
      font-family: Arial, sans-serif;
     display: none;
    }


    .modal-container {
      position: fixed;
      bottom: 20px;
      right: 20px;
      width: 300px;
      max-width: 80%;
    
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      border-radius: 8px;
      display: none;
      z-index: 1000;
      font-family: Arial, sans-serif;
     
    }

    .modalheader {
    display: flex;
    align-items: center;
    justify-content: end;
    padding:8px;
      background-color: #FFC436;
      color: #fff;
      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
    }

    .modalcontent {
    
      padding: 10px 10px 10px 10px;
    }

    .modalfooter {
      text-align: right;
      border-bottom-left-radius: 8px;
      border-bottom-right-radius: 8px;
    }

    .modal-close {
      cursor: pointer;
      color: red;
    }

    /* Style for the button */
    .open-modal-button {
      position: fixed;
      bottom: 10px;
      right: 10px;
      background-color: #007bff;
      color: #fff;
      padding: 5px;
      border: none;
      border-radius: 5px;
      font-weight:bold;
      cursor: pointer;
      z-index: 1001; /* Make sure the button is above the modal */
    }
    
.modal-hr{
	margin: 0px 10px -10px 10px !important;
}

.modal-list{
	font-size: 14px;
	text-align: left;
	padding: 0px !important;
	margin-bottom: 5px;
}

.modal-list li{
	display: inline-block;
}

.modal-list li .modal-span{
	font-size: 2rem;
	padding: 0px 7px;
}

.modal-list li .modal-text{
	font-size: 1rem;
	vertical-align: text-bottom;
	font-family: Lato;
}


</style>

</head>
<%
List<Object[]> ProjectHealthData = (List<Object[]>)request.getAttribute("projecthealthdata");
%>
<body>
<!-- Modal -->
	<div class="modal fade bd-example-modal-xl" id="selectProjectsForSlideShowModal" style="width: 100%" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg " style="max-width: 1800px" role="document">
	  <form action="GetAllProjectSlide.htm" target="_blank" onsubmit="return checkslideinput()" method="post">
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">
	        	Select Projects for SlideShow
	        	<br><br>
	        	<input type="checkbox" id="selectallprojects" style="width: 20px;height: 20px;margin-left: -40%;"> 
	        	<span style="font-size: 1.2rem;">Select All</span> 
	        	
	        </h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      
	      <div class="modal-body" >
	      	<div class="container-fluid">
	        	<% List<Object[]> mainProjectList =  ProjectHealthData!=null && ProjectHealthData.size()>0 ? (ProjectHealthData.stream().filter(e-> e[51]!=null && e[51].toString().equals("1")).collect(Collectors.toList())): new ArrayList<Object[]>();
	        	   List<Object[]> subProjectList =  ProjectHealthData!=null && ProjectHealthData.size()>0 ? (ProjectHealthData.stream().filter(e-> e[51]!=null && e[51].toString().equals("0")).collect(Collectors.toList())): new ArrayList<Object[]>();
	        	%>
	        	
	        	<div class="row">
    				<div class="col-md-12">
				        <div align="left">
				        	<h5>
				        		Main Projects: <input type="checkbox" id="selectmainprojects" style="width: 20px;height: 20px;"> 
				        	</h5> 
				        </div>
       	 				<hr>
        				<% int c = 0;
           					if (mainProjectList != null && mainProjectList.size() > 0) { 
               					for (Object[] obj : mainProjectList) { %>
				                   <% if (c == 4 || c == 0) { %>
				                       <div class="row">
				                   <% } %>
					                       <div class="col-3">
					                           <div style="text-align: left;">
					                               <input checked class="mainprojectlist" name="projectlist" style="text-align: left;margin: 8px;width: 20px; height: 20px;" value="<%=obj[2]%>" type='checkbox'/>
					                               <label for="<%=obj[2]%>">
					                                   <span class="tableprojectname" style="color:black !important;font-size: 13px"> 
					                                       <% if (obj[46] != null) { %><%= obj[46] %><% } else { %>-<% } %> /
					                                       <% if (obj[3] != null) { %><%= obj[3] %><% } else { %>-<% } %> /
					                                       <% if (obj[44] != null) { %><%= obj[44] %><% } else { %>-<% } %>
					                                   </span> 	
					                               </label>
					                           </div>
					                       </div>
						                   <% if (c == 3 || c == mainProjectList.size() - 1) { %>
						                       </div>
						                   <% } %>
                   		<% c++; } } %>
    				</div>
				</div>

	        	
	        	<div class="row" style="margin-top: 1rem;">
	        		<div class="col-md-12">
	        			<div align="left">
	        				<h5>
	        					Sub Projects: <input type="checkbox" id="selectsubprojects" style="width: 20px;height: 20px;">
	        				</h5>
	        			</div>
	        			<hr>
			        	<%int c1=0;
			        		if(subProjectList!=null && subProjectList.size()>0) { 
			        		for(Object[] obj : subProjectList){%>
			        	<%if(c1==4||c1==0) { %>
			        	<div class="row">
			        	<%} %>
							<div class="col-3" >
								<div style="text-align: left;">
									<input checked class="subprojectlist" name="projectlist" style="text-align: left;margin: 8px;width: 20px; height: 20px;" value="<%=obj[2]%>" type='checkbox'/>
									<label for="<%=obj[2]%>">
										<span class="tableprojectname" style="color:black !important;font-size: 13px"> 
										  	<%if(obj[46]!=null){%><%=obj[46] %><%}else {%>-<%} %> /
										  	<%if(obj[3]!=null){%><%=obj[3] %><%}else {%>-<%} %> /
										  	<%if(obj[44]!=null){%><%=obj[44] %><%}else {%>-<%} %>
									  	</span> 	
									</label>
								</div>
							</div>
						<%if(c == 3 || c == subProjectList.size() - 1) { %>
						</div><%}%>
						<%c1++;} }%>
	        		</div>
	        	</div>
	      	</div>
	      </div>
	      <div class="modal-footer">
	      <div class="d-flex align-items-start" style=" padding-right: 900px;" ><p style="text-align: left"><span style="color: red">Note</span>: Master slide is the combination of latest Data of selected project</p></div>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="submit"  class="btn btn-primary">Slide Show</button>
	      </div>
	    </div>
	   </form>
	  </div>
	</div>
	
<script>
$(document).ready(function(){
    // Default: All checkboxes are checked
    $('#selectallprojects, #selectmainprojects, #selectsubprojects').prop('checked', true);

    // Handling click event for Select All checkbox
    $("#selectallprojects").click(function(){
        var isChecked = $(this).prop('checked');
        $('.mainprojectlist, .subprojectlist, #selectmainprojects, #selectsubprojects').prop('checked', isChecked);
    });
    
    // Handling click event for Main Projects checkbox
    $("#selectmainprojects").click(function(){
        var isChecked = $(this).prop('checked');
        $('.mainprojectlist').prop('checked', isChecked);
        // Check if both Main Projects and Sub Projects are checked
        if ($('#selectmainprojects').prop('checked') && $('#selectsubprojects').prop('checked')) {
            $('#selectallprojects').prop('checked', true);
        } else {
            $('#selectallprojects').prop('checked', false);
        }
    });
    
    // Handling click event for Sub Projects checkbox
    $("#selectsubprojects").click(function(){
        var isChecked = $(this).prop('checked');
        $('.subprojectlist').prop('checked', isChecked);
        // Check if both Main Projects and Sub Projects are checked
        if ($('#selectmainprojects').prop('checked') && $('#selectsubprojects').prop('checked')) {
            $('#selectallprojects').prop('checked', true);
        } else {
            $('#selectallprojects').prop('checked', false);
        }
    });

    // Handling click event for individual Main Project checkboxes
    $(".mainprojectlist").click(function() {
        var mainProjectsChecked = $('.mainprojectlist:checked').length;
        var mainProjectsTotal = $('.mainprojectlist').length;
        $('#selectmainprojects').prop('checked', mainProjectsChecked === mainProjectsTotal);
        // Check if all Main Projects are checked
        if ($('#selectmainprojects').prop('checked') && $('#selectsubprojects').prop('checked')) {
            $('#selectallprojects').prop('checked', true);
        } else {
            $('#selectallprojects').prop('checked', false);
        }
    });

    // Handling click event for individual Sub Project checkboxes
    $(".subprojectlist").click(function() {
        var subProjectsChecked = $('.subprojectlist:checked').length;
        var subProjectsTotal = $('.subprojectlist').length;
        $('#selectsubprojects').prop('checked', subProjectsChecked === subProjectsTotal);
        // Check if all Sub Projects are checked
        if ($('#selectmainprojects').prop('checked') && $('#selectsubprojects').prop('checked')) {
            $('#selectallprojects').prop('checked', true);
        } else {
            $('#selectallprojects').prop('checked', false);
        }
    });

    // Handling click event for individual checkboxes inside Main Projects
    $('.mainprojectlist').click(function() {
        if (!$(this).prop('checked')) {
            $('#selectmainprojects').prop('checked', false);
            $('#selectallprojects').prop('checked', false);
        } else {
            var allMainChecked = true;
            $('.mainprojectlist').each(function() {
                if (!$(this).prop('checked')) {
                    allMainChecked = false;
                }
            });
            if (allMainChecked) {
                $('#selectmainprojects').prop('checked', true);
                if ($('#selectsubprojects').prop('checked')) {
                    $('#selectallprojects').prop('checked', true);
                }
            }
        }
    });

    // Handling click event for individual checkboxes inside Sub Projects
    $('.subprojectlist').click(function() {
        if (!$(this).prop('checked')) {
            $('#selectsubprojects').prop('checked', false);
            $('#selectallprojects').prop('checked', false);
        } else {
            var allSubChecked = true;
            $('.subprojectlist').each(function() {
                if (!$(this).prop('checked')) {
                    allSubChecked = false;
                }
            });
            if (allSubChecked && $('#selectmainprojects').prop('checked')) {
                $('#selectallprojects').prop('checked', true);
            }
        }
    });

});
</script>
</body>
</html>