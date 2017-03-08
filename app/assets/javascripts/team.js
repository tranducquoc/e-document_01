$(document).on('turbolinks:load', function(){
  $('#join-team-request').on('click', function () {
    var group_id = $(this).find('button').attr('data-group-id');
    var group_type = $(this).find('button').attr('data-group-type');
    var url = window.location.pathname + '/group_members/';
    $.ajax({
      url: url,
      method: 'POST',
      data: {group_members: {group_id: group_id, group_type: group_type}},
      success: function (data) {
        $('#join-team-request').empty();
        $('#leave-team-request').html(data);
      }
    });
  });
  $('#leave-team-request').on('click', function () {
    var group_id = $(this).find('button').attr('data-group-id');
    var group_type = $(this).find('button').attr('data-group-type');
    var url = window.location.pathname + '/group_members/' + group_id;

    $.ajax({
      url: url,
      method: 'DELETE',
      data: {group_members: {group_id: group_id, group_type: group_type}},
      success: function (data) {
        $('#leave-team-request').empty();
        $('#join-team-request').html(data);
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
    var url = window.location.pathname + '/group_members/' + id + '/admin_add_members/' + id;

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
    var url = window.location.pathname + '/group_members/' + id + '/admin_add_members/' + id;

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
        var member_item = '.action-member-'+id;
        if($(member_item) !== null){
          $(member_item).remove();
        }
      }
    });
  });

  $('.btn-team-add').on('click', function () {
    event.preventDefault();
    var user_id = $(this).attr('id');
    var url = window.location.pathname + '/admin_add_members/';
    var group_id = $(this).attr('data-group-id');
    var group_type = $(this).attr('data-group-type');
    $.ajax({
      method: 'POST',
      url: url,
      dataType: 'json',
      data: {group_members: {user_id: user_id,
        group_id: group_id, group_type: group_type, confirm: true}},
      success: function () {
        var request_item = '#accept-team-add-' + user_id;
        if($(request_item) !== null){
          $(request_item).remove();
        }
      }
    });
  });

});
