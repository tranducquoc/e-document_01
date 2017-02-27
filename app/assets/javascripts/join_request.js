$(document).ready(function () {
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
  })
});
