$(document).on('turbolinks:load', function(){
  $('#join_request').submit(function () {
    event.preventDefault();
    var action = $(this).find('form').attr('action');
    button = $(this).find('button#btn-join');
    if (button.hasClass('btn-join')) {
      var method = 'POST';
    } else {
      var method = 'DELETE';
    }
    $.ajax({
      method: method,
      url: action,
      dataType: 'html',
      success: function (result) {
        if ($('#join_request').find('form') !== null) {
          $('#join_request').find('form').remove();
        }
        $('#join_request').append(result);
      }
    });
  });

  $('.btn-accept').on('click', function () {
    event.preventDefault();
    var id = $(this).attr('id');
    var url = window.location.pathname + '/group_members/' + id;

    $.ajax({
      method: 'PUT',
      url: url,
      success: function () {
        var request_item = '#accept-request-'+id;
        if($(request_item) !== null){
          $(request_item).remove();
        }
      }
    })
  })
});
