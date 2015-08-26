<!DOCTYPE HTML>
<html>
  <head>
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta charset="UTF-8">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width">
    <meta name="viewport" content="initial-scale = 1.0,maximum-scale = 1.0">
    <title>Universal Remote</title>

    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/flat-ui.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/compiled/app.css" />
  </head>
  <body ontouchstart="">
  <nav class="navbar navbar-default navbar-lg" role="navigation">
     <h3 class="control-panel-title">Raspi Remote</h3>
</nav>

    <div class="row">
    <div class="col-xs-12 main-panel">
      <div class="col-xs-12 control-panel">
        <h4 class="control-panel-title light-control-title">Lights</h4>
          <div class="col-xs-6">
            
              <button class="command-once btn btn-default light-control-button" href="/remotes/MY_REMOTE/LIGHTS_UP">
                <span class="glyphicon glyphicon-plus-sign"></span>
              </button>
          
            
              <button class="command-once btn btn-default light-control-button" href="/remotes/MY_REMOTE/LIGHTS_DOWN">
                <span class="glyphicon glyphicon-minus-sign"></span>
              </button>
           
          </div>
          <div class="col-xs-6 light-switch">
           <input type="checkbox"  data-toggle="switch" class="switch" data-on-color="info"/ href="/remotes/MY_REMOTE/LIGHTS">
          </div>
          <div class="col-xs-12 light-slider-container">
            <div id="light-slider"></div>
          </div>
          
      </div>
      <div class="col-xs-12 control-panel">
        <h4 class="control-panel-title">Air conditionning</h4>
          <div class="col-xs-12 ac-switch">
           <input type="checkbox"  data-toggle="switch" class="switch" data-on-color="info"/ href="/remotes/MY_REMOTE/AC">
        </div>
        <div class="pagination pagination-minimal col-xs-12">

          <ul class="temperature-list">
            <li class="previous"><a href="#" class="fui-triangle-up"></a></li>             
            <li class=""><a href="#">20</a></li>
            <li class=""><a href="#">21</a></li>
            <li class=""><a href="#">22</a></li>
            <li><a href="#">23</a></li>
            <li><a href="#">24</a></li>
            <li class="next"><a href="#" class="fui-triangle-down"></a></li>
          </ul>

        </div>
      </div>
      </div>


          

      <div class="col-xs-12 special-mode-panel">
        <button id="special-mode-on" class="command-once btn btn-large btn-danger special-mode-button" href="/play"><span class="glyphicon glyphicon-glass"></span> Start special mode <span class="glyphicon glyphicon-music"></span></button>
        <button id="special-mode-off" class="command-once btn btn-large btn-warning hidden special-mode-button" href="/stop">Stop special mode <span class="glyphicon glyphicon-off"></span></button>
      </div>
 

    </div>



    <script src="js/vendor/jquery.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/vendor/video.js"></script>
    <script src="js/prettify.js"></script>
    <script src="js/flat-ui.min.js"></script>
    <script src="js/jquery.ui.touch-punch.js"></script>
    <script src="js/vendor/application.js"></script>
     <script src="js/compiled/app.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
    // Lights slider initialization
    var $slider = $("#light-slider");
    if ($slider.length > 0) {
      $slider.slider({
        min: 1,
        max: 6,
        value: 6,
        orientation: "horizontal",
        range: "min"
      }).draggable();
    }

    // Lights slider event watching
    $( "#light-slider" ).on( "slidestop", function( event, ui ) { 
      light_value = ui.value;
      call = "/macros/lights_lvl" + light_value
       $.ajax({
        type: 'POST',
        url: call,
        success: function(data) {
          console.log('success');
          console.log(data);
        }
      }) 

      } 
    );

    // Temperature control mechanism 
    $(".pagination").on("tempChange", function(e) {
      var temp = e.target.textContent;
      var call = "/remotes/MY_REMOTE/AC_" + temp
      $.ajax({
        type: 'POST',
        url: call,
        success: function(data) {
          console.log('success');
          console.log(data);
        }
      })  

    })

    // On/off switch mechanism 
    $(".switch").on('switchChange.bootstrapSwitch', function(event, state) {
      address = this.getAttribute("href")

      // Set up call address
      if (state) {
      call =  address + "_ON"
      } else {
      call =   address + "_OFF"  }  

      // make call
      $.ajax({
        type: 'POST',
        url: call,
        success: function(data) {
          console.log('success');
          console.log(data);
        }
      })  
    });
    
    // Disco button mechanism
      $("#special-mode-on").click(function() {
        $("#special-mode-on").toggleClass("hidden");
        $("#special-mode-off").toggleClass("hidden");
        $.ajax({
          type: 'POST',
          url: '/macros/special_mode',
          success: function(data) {
            console.log('success');
            console.log(data);
          }
        });
      });

      $("#special-mode-off").click(function() {
        $("#special-mode-on").toggleClass("hidden");
        $("#special-mode-off").toggleClass("hidden");
      });
    </script>


  </body>
</html>
