<%-- 
    Document   : Footer
    Created on : 22 Feb, 2023, 2:45:46 PM
    Author     : HP
--%>
                
                
            </div>
            <a id="back-to-top" href="#" class="btn btn-primary btn-lg back-to-top" style="position: fixed; bottom: 25px; right: 25px; display: none" role="button">
                    <i class="fas fa-chevron-up"></i>
            </a>
        </div>  
    </div>
    
    <script src="../Assets/Templates/Homepage/js/bootstrap.js"></script>
    <script src="../Assets/Templates/Homepage/js/app.js"></script>

    <!-- Need: Apexcharts -->
    <script src="../Assets/Templates/Homepage/extensions/apexcharts/apexcharts.min.js"></script>
    
    <!-- Need: Data tables -->
    <script src="../Assets/Templates/Homepage/extensions/simple-datatables/umd/simple-datatables.js"></script>
    <script src="../Assets/Templates/Homepage/js/pages/simple-datatables.js"></script>
    <script src="../Assets/jQuery/jQuery.js"></script>
    <!-- Need: Sweet Alert -->
    <script>
        $(function() {
            var pgurl = window.location.href.substr(window.location.href.lastIndexOf("/")+1);
            $(".menu li").each(function(){
                if($('a',this).attr("href") == pgurl || $('a', this).attr("href") == '' )
                $(this).addClass("active");
                 
            })
       });
       
       //scroll to top function
       $(document).ready(function(){
	$(window).scroll(function () {
			if ($(this).scrollTop() > 50) {
				$('#back-to-top').fadeIn();
			} else {
				$('#back-to-top').fadeOut();
			}
		});
		// scroll body to 0px on click
		$('#back-to-top').click(function () {
			$('body,html').animate({
				scrollTop: 0
			}, 400);
			return false;
		});
    });
    
    //page loader
    $(document).ready(function() {
        const loader = $("#loader");
        const content = $("#main-content");

        setTimeout(function() {
          loader.hide();
          content.show();
        }, 1500); // Replace 2000 with your desired loading time in milliseconds
        setTimeout(function (){
            $(".skeleton").removeClass("skeleton");
        },3000);
      });
      

    </script>
