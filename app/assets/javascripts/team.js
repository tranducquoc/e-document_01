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
    var action = $('#leave-team-request span').attr('id');

    $.ajax({
      url: url,
      method: 'DELETE',
      data: {group_members: {group_id: group_id,
        group_type: group_type, action: action}},
      success: function (data) {
        if ( action == 'leave') {
          if (typeof (data.status) == 'string') {
            alert(data.status);
          }
          location.reload();
        } else if ( action == 'unrequest'){
          $('#leave-team-request').empty();
          $('#join-team-request').html(data);
        }
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
      data: {group_members: {confirm: true}},
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
    var id = $(this).attr('data-id');
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
    var id = $(this).attr('data-id');
    var url = window.location.pathname + '/group_members/' + id;

    $.ajax({
      method: 'PUT',
      url: url,
      data: {group_members: {role: "admin"}},
      success: function () {
        if ($('[data-id='+id+']') != null){
          $('[data-id='+id+']').remove();
        }
      }
    });
  });

  $('.btn-team-add').on('click', function () {
    var url = window.location.pathname + '/admin_add_members/';
    var user_id = $('#team-select-user').val();
    var group_id = $(this).attr('data-group-id');
    var group_type = $(this).attr('data-group-type');

    if (user_id) {
      $.ajax({
        url: url,
        method: 'POST',
        data: {
          group_members: {
            user_id: user_id,
            group_id: group_id, group_type: group_type, confirm: true
          }
        },
        success: function (status) {
          alert(status.status);
          $('#team-select-user').find('[value=' + user_id + ']').remove();
        }
      });
    } else{
      alert(I18n.t("organizations.show.choose_user"))
    }
  });

});
