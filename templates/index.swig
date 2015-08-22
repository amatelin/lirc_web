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
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/flat-ui.css" />
    <link rel="stylesheet" href="css/compiled/app.css" />
  </head>
  <body ontouchstart="">
    <div id="container">
      <h1 id="titlebar">
        <a class="back hidden"><img src="/images/left-arrow.png" height="40" width="40" /></a>
        <span id="title" data-text="Universal Remote">Universal Remote</span>
      </h1>
      <ul class="remotes-nav">
      {% for remote in remotes %}
        {% set remoteName = loop.key %}
        <li><a class="btn btn-wide btn-large btn-info" href="#{{ remoteName }}">{{ labelForRemote(remoteName) }}</a></li>
      {% endfor %}
      </ul>

      <hr />

     <!-- <ul class="macros-nav">
      {% for macro in macros %}
        {% set macroName = loop.key %}
        <li><button class="btn btn-wide btn-large btn-warning macro-link" href="/macros/{{ macroName }}">{{ macroName }}</button></li>
      {% endfor %}
      </ul>-->


      <div class="prev"></div>

      <ul class="remotes">
      {% for remote in remotes %}
        {% set remoteName = loop.key %}
        <li class="remote" id="{{ remoteName }}">
          <ul class="commands">
            <li class="command">
              <button id="disco_button_on" class="btn btn-wide btn-large btn-warning" href="/play">Disco mode</button>
              <button id="disco_button_off" class="btn btn-wide btn-large btn-warning hidden" href="/stop">End the Disco</button>
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

    <div class="next"></div>

    <script src="js/compiled/app.js" type="text/javascript" charset="utf-8"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
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
	$.ajax({
	type:'POST',
	url: '/play',
	success: function(data) {}
	});
      });
      $("#disco_button_off").click(function() {
        $("#disco_button_on").toggleClass("hidden");
        $("#disco_button_off").toggleClass("hidden");

	$.ajax({
	  type: 'POST', 
	  url: '/stop',
	  success: function(data) {}
	});
      });


    </script


  </body>
</html>
