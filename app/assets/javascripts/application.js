// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require js-routes
//= require_tree .


$('.submittable').live('change', function() {
  //$(this).parents('form:first').submit();
});



$(function(){
  $(".datepicker input").datepicker({
      dateFormat: "yy-mm-dd",
      showOn: "button",
      buttonImage: "/assets/calendar.gif",
      buttonImageOnly: true
  });
}); 


// Sorting the list

$(function(){
  $(document).ajaxSend(function(e, xhr, options) {
    var token = $("meta[name='csrf-token']").attr("content");
    xhr.setRequestHeader("X-CSRF-Token", token);
  });


  $('.sortable').sortable(
  {
    placeholder: "ui-state-highlight",
    axis: 'y',
    dropOnEmpty: false,
    handle: '.handle',
    cursor: 'move',
    items: '.row',
    opacity: 0.4,
    scroll: true,
    update: function(){
      var el = this;
      $.ajax({
        type: 'post',
        data: $(el).sortable('serialize'),
        dataType: 'script',
        complete: function(request){
          $(el).effect('highlight');
        },
        url: '/tasks/sort'
      })
    }
  });
});

