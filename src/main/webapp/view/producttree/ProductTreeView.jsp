<%@page import="org.apache.logging.log4j.core.pattern.EqualsIgnoreCaseReplacementConverter"%>
<%@page import="java.math.BigDecimal"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List , java.util.stream.Collectors, java.text.DecimalFormat,java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Tree</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>



<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>

   

<!-- ------------------------------- tree css ------------------------------- -->
<style type="text/css">



/*----------------genealogy-tree----------*/
 .genealogy-body{
    white-space: nowrap;
    overflow-y: hidden;
    padding: 50px;
    min-height: 500px;
    padding-top: 0px;
    text-align: center;
}
.genealogy-tree{
  display: inline-block;
} 
.genealogy-tree ul {
    padding-top: 20px; 
    position: relative;
    padding-left: 0px;
    display: flex;
    justify-content: center;
}
.genealogy-tree li {
    float: left; text-align: center;
    list-style-type: none;
    position: relative;
    padding: 17px 0px 0 0px;
}
.genealogy-tree li::before, .genealogy-tree li::after{
    content: '';
    position: absolute; 
    top: 0; 
    right: 50%;
    border-top: 2px solid #ccc;
    width: 50%; 
    height: 18px;
}
.genealogy-tree li::after{
    right: auto; 
    left: 50%;
    border-left: 2px solid #ccc;
}
.genealogy-tree li:only-child::after, .genealogy-tree li:only-child::before {
    display: none;
}
.genealogy-tree li:only-child{ 
    padding-top: 0;
}
.genealogy-tree li:first-child::before, .genealogy-tree li:last-child::after{
    border: 0 none;
}
.genealogy-tree li:last-child::before{
     border-right: 2px solid #ccc;
     border-radius: 0 5px 0 0;
    -webkit-border-radius: 0 5px 0 0;
    -moz-border-radius: 0 5px 0 0;
}
.genealogy-tree li:first-child::after{
    border-radius: 5px 0 0 0;
    -webkit-border-radius: 5px 0 0 0;
    -moz-border-radius: 5px 0 0 0;
}
.genealogy-tree ul ul::before{
    content: '';
    position: absolute;
     top: 0; 
     left: 50%;
    border-left: 2px solid #ccc;
    width: 0;
     height: 20px;
}
.genealogy-tree li .action-view-box{
     text-decoration: none;
     /* font-family: arial, verdana, tahoma; */
     font-size: 11px;
     display: inline-block;
     border-radius: 5px;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
}


 .genealogy-tree li a:hover+ul li::after, 
.genealogy-tree li a:hover+ul li::before, 
.genealogy-tree li a:hover+ul::before, 
.genealogy-tree li a:hover+ul ul::before{
    border-color:  #fbba00;
} 

/*--------------memeber-card-design----------*/
.member-view-box{
    padding:0px 15px;
    text-align: center;
    border-radius: 4px;
    position: relative;
}




</style>
 <!-- ------------------------------- tree css ------------------------------- -->


<style type="text/css">
.action-box
{
    /*  width: fit-content ; 
     height: fit-content; */
     /* min-width:190px; */
   /*   min-width:190px; */
  
    border: 1px solid black;
    
    max-width:100px;
    /* max-height:110px; */
/*     display: block; */
    
   
    /* background: linear-gradient(to bottom right, #0B60B0 5%, #0B60B0 10%, white 10%, white 90%, #D24545 0%, #D24545 0%); */
    
}


.action-box-header
{


/*  max-width:120px; */
	padding:2px;
 	text-align: center;
 	 
   
 	/* color: #3468C0; */
	 /* background: linear-gradient(to bottom right, #0B60B0 5%, #0B60B0 10%, white 10%, white 90%, #D24545 0%, #D24545 0%);  */
}




.action-box-body
{
   padding:0px;
	text-align: center;
	background-color:#FFFFFF ;
	display: block;
    flex-wrap: wrap;
    border-bottom-right-radius : 9px;
	border-bottom-left-radius: 7px;
}


table,td{


      border: 1px solid black;
      border-collapse:collapse;
      padding:2px;
       width:43%;
       font-size:12px;

}

.bottom-div {
    position: fixed;
    bottom: 50px;
    left: -20px;
    width: 100%; /* Ensures the div stretches across the entire width of the page */
}



</style>

</head>

  <%
  
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  List<Object[]> ProductTreeList=(List<Object[]>)request.getAttribute("ProductTreeList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");

   

 %>

<body id="mybody" style="background-color:#FFFFFF;overflow-y:auto ;" class="body genealogy-body genealogy-scroll">

	

     <button  type="button" class="btn btn-sm "  id="generatePdfBtn" style="margin-left: 1rem;"  onclick="downloadPDF()" ><i class="fa fa-download fa-lg" ></i></button> 

		
	    <div class="genealogy-tree line-top line-bottom"  id="tree">
	  
	 
	  		<ul>
				<li>      
	
						 <div class="member-view-box action-view-box" style=" padding:0px 15px;">
			                    
			                         <div class=" action-box" style="border:-1px;" > 
			                         	
			                         	<div  class="action-box-header" id="aaaa">
			                         	
			                         	 <span style="cursor:pointer;font-weight: bold;font-size: 1.0em;">
	                          			        <%if(ProjectId!=null){	
				                                       Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");%>  
			                                              <%=ProjectDetail[1] %>
	                          			               <%} %>
			                          		 </span>
			                         			 
										</div>
										
			                           
			                </div>
			          </div>
			               
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->
			           <ul class="active">
			           	                
			                <% for(Object[] level1 : ProductTreeList){
			            	   if(level1[2].toString().equalsIgnoreCase("1")) { %>
			              
			                	<li>	 		    
									    <div class="member-view-box action-view-box">
											 <div class="action-box" > 
												
												 <div  class="action-box-header" 
												
												style="background: linear-gradient(to bottom right, 
												<%if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
												<%}else if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
												<%}else if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
												<%}else if(level1[6]!=null && level1[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
												
												<%}else { %> white 5%, white 10% 
												<%} %>
												, white 10%, white 90%,
												
											    <%if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
												<%}else if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
												<%}else if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
												<%}else if(level1[7]!=null && level1[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
												
												<%}else { %> white 5%, white 10% 
												<%} %>
												 
												 );" >  
												
										             <span  style="cursor:pointer;font-weight:bold;font-size: 1.0em;white-space:normal;"> 
										                  <%=level1[3] %>
										                
										             </span>  
										            
													          
											 <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													      
			                          		    </div> 
			                          	 </div> 
									</div> 
											<% List<Object[]> Level1 =ProductTreeList.stream().filter(e-> level1[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
											
											
								<!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->
						                <ul  <% if(Level1!=null && Level1.size()>0){%> class="active" <%}%> >	
						                <%for(Object[] level2 : ProductTreeList){
						                  if(level2[2].toString().equalsIgnoreCase("2") && level1[0].toString().equalsIgnoreCase(level2[1].toString()))
							                { %>
							             
												<li>	
													<div class="member-view-box action-view-box">
															<div class=" action-box" >
															  <div class="action-box-header" 
															  
															      style="background: linear-gradient(to bottom right, 
																<%if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
																<%}else if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
																<%}else if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
																<%}else if(level2[6]!=null && level2[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
																
																<%}else { %> white 5%, white 10% 
																<%} %>
																, white 10%, white 90%,
																
															    <%if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
																<%}else if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
																<%}else if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
																<%}else if(level2[7]!=null && level2[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
																
																<%}else { %> white 5%, white 10% 
																<%} %>
																 
																 );" >
														
															       <span style="cursor:pointer;font-weight:bold;font-size: 1.0em;white-space:normal;"> 
			                          			                              <%=level2[3] %>
			                          			                   </span>
			                          			                   
			                          			                  <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													             
												             
			                          			             </div>
													     </div>
												   </div> 
												   
												   
												   <% List<Object[]> Level2 =ProductTreeList.stream().filter(e-> level2[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
												    
												    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->
										             <ul <% if(Level2!=null && Level2.size()>0){%> class="active" <%}%> >	                
										                	  <%for(Object[] level3 : ProductTreeList){
										                 if(level3[2].toString().equalsIgnoreCase("3") && level2[0].toString().equalsIgnoreCase(level3[1].toString()) )
										                
										                  { %>
																  <li>      
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
																		  style="background: linear-gradient(to bottom right, 
																			<%if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
																			<%}else if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
																			<%}else if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
																			<%}else if(level3[6]!=null && level3[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			, white 10%, white 90%,
																			
																		    <%if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
																			<%}else if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
																			<%}else if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
																			<%}else if(level3[7]!=null && level3[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			 
																			 );" >
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;" >
			                          			                             
			                          			                                <%=level3[3] %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                      <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                   
			                          			                          
												                                              			
													                 </div>
													              </div>
														   </div> 
															
															
															 <% List<Object[]> Level3 =ProductTreeList.stream().filter(e-> level3[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
															
										                <%------------------------------------------------------LEVEL 4 -------------------------------------------------------%>
										                
										               <ul <% if(Level3!=null && Level3.size()>0){%> class="active" <%}%> >	                
										                	 <%for(Object[] level4 : ProductTreeList){
															                 
										                	  if(level4[2].toString().equalsIgnoreCase("4") && level3[0].toString().equalsIgnoreCase(level4[1].toString())) 
										                     { %>    
																  <li>      
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
																		 
																		  style="background: linear-gradient(to bottom right, 
																			<%if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
																			<%}else if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
																			<%}else if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
																			<%}else if(level4[6]!=null && level4[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			, white 10%, white 90%,
																			
																		    <%if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
																			<%}else if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
																			<%}else if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
																			<%}else if(level4[7]!=null && level4[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			 
																			 );" >
																		
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;" >
			                          			                             
			                          			                                <%=level4[3] %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                     
												                                              			
													                    </div>
													                                            
																</div>
														</div> 
																	
																	
																	<% List<Object[]> Level4 =ProductTreeList.stream().filter(e-> level4[0].toString().equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());%>
																	
																	<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%>
																	
														 <ul <% if(Level4!=null && Level4.size()>0){%> class="active" <%}%> >	                
										                	<%for(Object[] level5 : ProductTreeList){%>
								                        	  <% if(level5[2].toString().equalsIgnoreCase("5") && level4[0].toString().equalsIgnoreCase(level5[1].toString()) )
								                             {%> 
																  <li>      
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																		
																		<div class="action-box-header"
																		
																		 style="background: linear-gradient(to bottom right, 
																			<%if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Design")) {%> #D24545  5%, #D24545 10%
																			<%}else if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Realisation")){ %> #E9B824 5%, #E9B824 10%
																			<%}else if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Testing & Evaluation")){ %> #0B60B0 5%, #0B60B0 10%
																			<%}else if(level5[6]!=null && level5[6].toString().equalsIgnoreCase("Ready for Closure")){ %> green 5%, green 10%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			, white 10%, white 90%,
																			
																		    <%if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("In-House Development")) {%>  #FF8911 0%, #FF8911 0%
																			<%}else if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("BTP")){ %>  #FDE767 0%, #FDE767 0%
																			<%}else if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("BTS")){ %>  #B67352 0%, #B67352 0%
																			<%}else if(level5[7]!=null && level5[7].toString().equalsIgnoreCase("COTS")){ %>  #492E87 0%, #492E87 0%
																			
																			<%}else { %> white 5%, white 10% 
																			<%} %>
																			 
																			 );" >
																		
																		
																		<span style="cursor:pointer;font-weight: bold;font-size: 1.0em;white-space:normal;" >
			                          			                             
			                          			                                <%=level5[3] %>
			                          			                                
			                          			                          </span>
			                          			                          
			                          			                          
			                          			                          
			                          			                          <div style="margin-top:-2px;"><i class="fa fa-caret-down" aria-hidden="true" style="font-size: 0.8rem;color:black;padding-top:0px;padding-bottom:0px;cursor: pointer ;"></i></div>
													
													                   
												                                              			
													                        </div>
													                        
													                       </div>
																	</div> 
																	
																	
																	
																	<%--------------------------------------------------------------------------------LEVEL 6 ---------------------------------------------%>
																	
																
																	   
																   </li>
															
														    <% } %>
														<% } %>
														
														
													</ul>      
																	
														<%--------------------------------------------------------------------------------LEVEL 5 ---------------------------------------------%> 
																    
														 </li>
															
												    <% } %>
												<% } %>
														
													 </ul>     
																    
																    
																    
														<!-- --------------------------------------------------------   LEVEL 4 ---------------------------------------------------- -->  		    														    
																    
															 
							                		    </li>
												
													    <% } %>
													<% } %>
											
											
											 
											
							                </ul>    
										                
										                   
										    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->  
												
								 	 </li>
								 <% } %>
                	        <% } %>
                	        
                	       
			                </ul>  
						                  
						        <!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->    
						 		    
                		 </li>
                	   <% } %>
                	<% } %>
					
			
                	
				 </ul> 
                
                         
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->        
			           		
						
	        		</li>
	        		
		        </ul>
		        
			  
	
	    </div>
	    
	    
	   <div class="bottom-div">  
	    <div align="right">
    
     
         <table >

                  <tr>
						<td style="font-weight:bold;">Stage (Upper corner)</td>
						<td style="background-color:#D24545;color:#FFFFFF">Design</td>
						<td style="background-color:#E9B824;color:black">Realisation</td>
						<td style="background-color:#0B60B0;color:#FFFFFF">Testing & Evaluation</td>
						<td style="background-color:green;color:#FFFFFF">Ready for Closure</td>
                  </tr>



                 <tr>
						<td style="font-weight:bold;">Module (Lower corner)</td>
						<td style="background-color:#FF8911;color:black">In-House Development</td>
						<td style="background-color:#FDE767;color:black">BTP</td>
						<td style="background-color:#B67352;color:black">BTS</td>
						<td style="background-color:#492E87;color:#FFFFFF">COTS</td>
                 </tr>

       </table>     
           
     
    
   </div> 
  </div>
	    
	    
	    



<!-- ------------------------------- tree script ------------------------------- -->
  <script type="text/javascript">

  $(function () {
	    $('.genealogy-tree ul').hide();
	    $('.genealogy-tree>ul').show();
	    $('.genealogy-tree ul.active').show();
	    
	    $('.genealogy-tree li .action-box-header').on('click', function (e) {
			
	    	 /* var children = $(this).parent().parent().parent().find('> ul');
		        if (children.is(":visible")) children.hide('fast').removeClass('active');
		        else children.show('fast').addClass('active');
		        e.stopPropagation(); */
	        
	     var children = $(this).parent().parent().parent().find('> ul');
	        if (children.is(":visible")) {
	        	children.hide('fast').removeClass('active');
	        	
	        	$(this).find('i').removeClass('fa fa-caret-down');
	        	$(this).find('i').addClass('fa fa-caret-up');
	        } else {
	        	children.show('fast').addClass('active');
	        	
	        	$(this).find('i').removeClass('fa fa-caret-up');
	        	$(this).find('i').addClass('fa fa-caret-down');
	    	}
	        e.stopPropagation(); 
	    });
	});
 
</script> 


<!-- <script>


document.getElementById('generatePdfBtn').addEventListener('click', function() {
    downloadJspPage();
});

    function downloadJspPage() {
    	
    	
    	var jspFilePath = "/producttree/ProductTreeView.jsp";


        var link = document.createElement('a');
        link.href = "producttree/ProductTreeView.jsp";
        link.download = 'ProductTreeView.jsp'; // Specify the filename for download

        // Append the link to the body and simulate a click
        document.body.appendChild(link);
        link.click();

        // Remove the link from the DOM
        document.body.removeChild(link);
   }
    


</script>  -->



<!-- <script>
function downloadPDF() {
    // Create a new jsPDF instance
    var doc = new jsPDF();

    // Add content from your JSP page to the PDF
    var content = document.getElementById("mybody").innerHTML; // Replace 'your-content-id' with the ID of the element containing your JSP content
    doc.text(content, 10, 10);

    // Save the PDF
    doc.save("download.pdf");
}
</script> -->


<script>
function downloadPDF() {
	
	//document.getElementById("generatePdfBtn").style.display = "none";
	 var body = document.body; 

	 
	    // Use html2canvas to capture the body content
	    html2canvas(body, {
	        onrendered: function(canvas) {
	            // Convert canvas to base64 image data
	            var imageData = canvas.toDataURL('image/jpeg');

	            // Create a download link for the image
	            var link = document.createElement('a');
	            link.href = imageData;
	            link.download = 'ProductTree.jpg'; // Set the filename for the downloaded image
	            link.click();
	        }
	    });
		
}
</script>



</body>
</html>