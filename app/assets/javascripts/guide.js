$(document).on('turbolinks:load', function() {
  var id = $('#read_setting_guide').val()
  $(document).ready(function(){
    if (id){
      $('#my-Guide').modal('show');
    }
  });
  $('.close_guide').click(function(){
    var url = window.location.pathname + '/read_guide/' + id;
    $.ajax({
      method: "PUT",
      url: url,
      data: {
        id: id
      }
    });
  })
});
