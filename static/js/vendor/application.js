// Some general UI pack related JS
// Extend JS String with repeat method
String.prototype.repeat = function (num) {
  return new Array(Math.round(num) + 1).join(this);
};

(function ($) {

  // Add segments to a slider
  $.fn.addSliderSegments = function () {
    return this.each(function () {
      var $this = $(this),
          option = $this.slider('option'),
          amount = (option.max - option.min)/option.step,
          orientation = option.orientation;
      if ( 'vertical' === orientation ) {
        var output = '', i;
        console.log(amount);
        for (i = 1; i <= amount - 1; i++) {
          console.log(i)
            output += '<div class="ui-slider-segment" style="top:' + 100 / amount * i + '%;"></div>';
        }
        $this.prepend(output);
      } else {
        var segmentGap = 100 / (amount) + '%';
        var segment = '<div class="ui-slider-segment" style="margin-left: ' + segmentGap + ';"></div>';
        $this.prepend(segment.repeat(amount - 1));
      }
    });
  };

  $(function () {

    // Todo list
    $('.todo').on('click', 'li', function () {
      $(this).toggleClass('todo-done');
    });

    // Custom Selects
    if ($('[data-toggle="select"]').length) {
      $('[data-toggle="select"]').select2();
    }

    // Checkboxes and Radio buttons
    $('[data-toggle="checkbox"]').radiocheck();
    $('[data-toggle="radio"]').radiocheck();

    // Tooltips
    $('[data-toggle=tooltip]').tooltip('show');

    // Focus state for append/prepend inputs
    $('.input-group').on('focus', '.form-control', function () {
      $(this).closest('.input-group, .form-group').addClass('focus');
    }).on('blur', '.form-control', function () {
      $(this).closest('.input-group, .form-group').removeClass('focus');
    });

    // Temperature control mechanism
    $('.pagination').on('click', 'a', function () {
      elem_class = $(this).parent().attr("class");

      // Handling the scroller
      if (elem_class && elem_class!="active") {
        // list down (next)
        if (elem_class.indexOf("next")!=-1) {
          // here we append new values to the list so that it is always 10 numbers long
          var min_temp = parseInt($(".pagination li a")[1].textContent);
          if (min_temp>16) { 
            $(".pagination li")[5].remove();
            $('<li><a href="#">'+(min_temp-1)+'</a></li>').insertAfter(".previous");
          }
        } 
        // list up (previous)
        else {
          var max_temp = parseInt($(".pagination li a")[5].textContent);
          if (max_temp<32) { 
            $(".pagination li")[1].remove();
            $('<li><a href="#">'+(max_temp+1)+'</a></li>').insertBefore(".next");
          }
        }
      }
      // manual 
      else {
         $(this).parent().siblings('li').removeClass('active').end().addClass('active').trigger('tempChange');
      }

     
    });

    $('.btn-group').on('click', 'a', function () {
      $(this).siblings().removeClass('active').end().addClass('active');
    });

    // Disable link clicks to prevent page scrolling
    $(document).on('click', 'a[href="#fakelink"]', function (e) {
      e.preventDefault();
    });

    // Switches
    if ($('[data-toggle="switch"]').length) {
      $('[data-toggle="switch"]').bootstrapSwitch();
    }

        // Lights slider initialization
    var $slider = $("#light-slider");
    if ($slider.length > 0) {
      $slider.slider({
        min: 1,
        max: 6,
        value: 6,
        orientation: "horizontal",
        range: "min"
      }).addSliderSegments($slider.slider("option").max);
    }

    // Lights slider event watching (we use two different events because one will fire on PC and the other on mobile)
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
    ).on( "click", function( event, ui ) { 
      abs_value = parseInt($(".ui-slider-range").attr("style").split(":")[1].split("%")[0])
      value = ((abs_value/100)*5)+1
      call = "/macros/lights_lvl" + value
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

    // make code pretty
    window.prettyPrint && prettyPrint();

  });

})(jQuery);
