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
     <h1>Raspi Remote</h1>
</nav>

    <div id="container">
 


  

      <div class="col-md-6">
        <ul class="remotes">
        {% for remote in remotes %}
          {% set remoteName = loop.key %}
          <li class="remote" id="{{ remoteName }}">
            <ul class="commands">
              <li class="command">
              <button class="command-link command-once btn btn-wide btn-large btn-primary" href="/remotes/MY_REMOTE/ON_BUTTON">Lights on</button>
              </li>
              <li class="command">

              </li>
            {% for command in remote %}
               <li class="command">
                 <button class="command-link {% if repeaters[remoteName][command] %}command-repeater{% else %}command-once{% endif %} btn btn-wide btn-large btn-primary" href="/remotes/{{ remoteName }}/{{ command|url_encode }}">{{ labelForCommand(remoteName, command) }}</button>
               </li>
            {% endfor %}
            </ul>
          </li>
        {% endfor %}
        </ul>
      </div>

      <div class="col-md-6">
          <div class="col-md-12">
           <input type="checkbox"  data-toggle="switch" class="switch" id="light-switch" data-on-color="info"/ href="/remotes/MY_REMOTE/LIGHTS">
           </div>
           <div class="col-md-12">
           <div class="pagination pagination-minimal">
      
            <ul>
              <li class="previous"><a href="#fakelink" class="fui-triangle-up"></a></li>             
              <li class=""><a href="#">16</a></li>
              <li><a href="#">17</a></li>
              <li><a href="#">18</a></li>
              <li><a href="#">19</a></li>
              <li class="active"><a href="">20</a></li>
              <li class=""><a href="#">21</a></li>
              <li class=""><a href="#">22</a></li>
              <li><a href="#">23</a></li>
              <li><a href="#">24</a></li>
              <li><a href="#">25</a></li>
              <li class="next"><a href="#" class="fui-triangle-down"></a></li>
            </ul>
          
            </div>
          </div>
      </div>

      <div class="col-md-6">
         <input type="checkbox"  data-toggle="switch" class="switch"id="ac-switch" data-on-color="info"/ href="/remotes/MY_REMOTE/AC">

      </div>
          

      </div>

      <div class="col-md-12">
        <button id="disco_button_on" class="command-once btn btn-wide btn-large btn-warning" href="/play">Disco mode</button>
        <button id="disco_button_off" class="command-once btn btn-wide btn-large btn-warning hidden" href="/stop">End the Disco</button>


      </div>
 

    </div>



    <script src="js/vendor/jquery.min.js"></script>
    <script src="js/vendor/video.js"></script>
    <script src="js/prettify.js"></script>
    <script src="js/flat-ui.min.js"></script>
    <script src="js/vendor/application.js"></script>
     <script src="js/compiled/app.js" type="text/javascript" charset="utf-8"></script>

     <script type="text/javascript">
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
      $("#disco_button_on").click(function() {
        $("#disco_button_on").toggleClass("hidden");
        $("#disco_button_off").toggleClass("hidden");
        $.ajax({
          type: 'POST',
          url: '/macros/disco_mode',
          success: function(data) {
            console.log('success');
            console.log(data);
          }
        });
      });

      $("#disco_button_off").click(function() {
        $("#disco_button_on").toggleClass("hidden");
        $("#disco_button_off").toggleClass("hidden");
      });
    </script


  </body>
</html>
