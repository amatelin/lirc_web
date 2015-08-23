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

    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/flat-ui.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/compiled/app.css" />
  </head>
  <body ontouchstart="">
  <nav class="navbar navbar-default navbar-lg" role="navigation">
     <h1>RaspiDomo</h1>
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


 <table width="100%">
            <tr>
              <td width="50%" class="pbm">
                <input type="checkbox" checked="" data-toggle="switch" />
              </td>

              <td class="pbm">
                <div class="switch switch-square">
                  <input type="checkbox" checked />
                </div>
              </td>
            </tr>
            
          </table>



</div>
          

      </div>

      <div class="col-md-12">
        <button id="disco_button_on" class="command-once btn btn-wide btn-large btn-warning" href="/play">Disco mode</button>
        <button id="disco_button_off" class="command-once btn btn-wide btn-large btn-warning hidden" href="/stop">End the Disco</button>


      </div>
 

    </div>



    <!-- Load JS here for greater good =============================-->
     <script src="js/jquery-1.8.3.min.js"></script>
    <script src="js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="js/jquery.ui.touch-punch.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap-select.js"></script>
    <script src="js/bootstrap-switch.js"></script>
    <script src="js/flatui-checkbox.js"></script>
    <script src="js/flatui-radio.js"></script>
    <script src="js/jquery.tagsinput.js"></script>
    <script src="js/jquery.placeholder.js"></script>
    <script src="js/google-code-prettify/prettify.js"></script>
    <script src="js/application.js"></script>
     <script src="js/compiled/app.js" type="text/javascript" charset="utf-8"></script>

     <script type="text/javascript">
    
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
