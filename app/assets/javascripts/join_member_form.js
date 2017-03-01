$(document).ready(function () {
  $('#join_member_form').submit(function () {
    event.preventDefault();
    var action = $(this).find('form').attr('action');
    button = $(this).find('button#btn-join-team');
    if (button.hasClass('btn-join-team')) {
      var method = 'POST';
    } else {
      var method = 'DELETE';
    }
    $.ajax({
      method: method,
      url: action,
      dataType: 'html',
      success: function (result) {
        if ($('#join_member_form').find('form') !== null) {
          $('#join_member_form').find('form').remove();
        }
        $('#join_member_form').append(result);
      }
    });
  });

  $('.btn-team-accept').on('click', function () {
    event.preventDefault();
    var id = $(this).attr('id');
    var url = window.location.pathname + '/group_members/' + id;

    $.ajax({
      method: 'PUT',
      url: url,
      success: function () {
        var request_item = '#accept-team-request-'+id;
        if($(request_item) !== null){
          $(request_item).remove();
        }
      }
    });
  });

  $('.btn-team-decline').on('click', function () {
    event.preventDefault();
    var id = $(this).attr('id');
    var url = window.location.pathname + '/group_members/' + id;

    $.ajax({
      method: 'DELETE',
      url: url,
      success: function () {
        var request_item = '#accept-team-request-'+id;
        if($(request_item) !== null){
          $(request_item).remove();
        }
      }
    });
  });

  $('.btn-team-remove').on('click', function () {
    event.preventDefault();
    var id = $(this).attr('id');
    var url = window.location.pathname + '/group_members/' + id;

    $.ajax({
      method: 'DELETE',
      url: url,
      success: function () {
        var request_item = '#accept-team-member-'+id;
        if($(request_item) !== null){
          $(request_item).remove();
        }
      }
    });
  });

  $('.btn-team-assign').on('click', function () {
    event.preventDefault();
    var id = $(this).attr('id');
    var url = window.location.pathname + '/group_members/' + id;

    $.ajax({
      method: 'PUT',
      url: url,
      success: function () {
        var request_item = '#accept-team-member-'+id;
        if($(request_item) !== null){
          $(request_item).remove();
        }
      }
    });
  });

  $('.btn-team-add').on('click', function () {
    event.preventDefault();
    var id = $(this).attr('id');
    var url = window.location.pathname + '/group_members/';

    $.ajax({
      method: 'POST',
      url: url,
      dataType: 'json',
      data: {user_id: id},
      success: function () {
        var request_item = '#accept-team-add-'+id;
        if($(request_item) !== null){
          $(request_item).remove();
        }
      }
    });
  });

});
