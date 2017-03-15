$(document).on('turbolinks:load', function () {
  $('#join-organization-request').on('click', '.btn-join', function () {
    var group_id = $(this).attr('data-group-id');
    var group_type = $(this).attr('data-group-type');
    var url = window.location.pathname + '/group_members/';
    $.ajax({
      url: url,
      method: 'POST',
      data: {group_members: {group_id: group_id, group_type: group_type}},
      success: function (data) {
        $('#join-organization-request').empty();
        $('#leave-organization-request').html(data);
      }
    });
  });

  $('body').on('click', '.btn-destroy', function () {
    var group_id = $(this).attr('data-group-id');
    var group_type = $(this).attr('data-group-type');
    var url = window.location.pathname + '/group_members/' + group_id;
    var action = $('#leave-organization-request span').attr('id');
    bootbox.confirm(I18n.t("organizations.show.are_you_sure"), function (result) {
      if (result) {
        $.ajax({
          url: url,
          method: 'DELETE',
          data: {
            group_members: {
              group_id: group_id,
              group_type: group_type, action: action
            }
          },
          success: function (data) {
            if (action == 'leave') {
              if (typeof (data.status) == 'string') {
                alert(data.status);
              }
              location.reload();
            } else if (action == 'unrequest') {
              $('#leave-organization-request').empty();
              $('#join-organization-request').html(data);
            }
          }
        });
      }
    });
  });

  function fetch_data(id, url, method) {
    $.ajax({
      url: url,
      method: method,
      data: {tab_id: id},
      success: function (data) {
        $('#' + id).html(data);
      }
    });
  }

  $('.tab-ajax a').on('click', function () {
    var id = $(this).attr('data-destination-id');
    var url = window.location.pathname;
    var method = 'GET';
    if (id != 'documents') {
      fetch_data(id, url, method);
    }
  });


  $('body').on('click', '.btn-organization-accept', function () {
    event.preventDefault();
    var id = $(this).attr('data-id');
    var url = window.location.pathname + '/group_members/' + id;
    bootbox.confirm(I18n.t("organizations.show.are_you_sure"), function (result) {
      if (result) {
        $.ajax({
          method: 'PUT',
          url: url,
          data: {group_members: {confirm: true}},
          success: function () {
            var request_item = '#accept-request-' + id;
            if ($(request_item) !== null) {
              $(request_item).remove();
            }
          }
        });
      }
    });
  });

  $('body').on('click', '.btn-organization-decline', function () {
    event.preventDefault();
    var id = $(this).attr('data-id');
    var url = window.location.pathname + '/group_members/' + id + '/admin_add_members/' + id;
    bootbox.confirm(I18n.t("organizations.show.are_you_sure"), function (result) {
      if (result) {
        $.ajax({
          method: 'DELETE',
          url: url,
          success: function () {
            var request_item = '#accept-request-' + id;
            if ($(request_item) !== null) {
              $(request_item).remove();
            }
          }
        });
      }
    })
  });

  $('body').on('click', '.btn-organization-assign', function () {
    var id = $(this).attr('data-id');
    var url = window.location.pathname + '/group_members/' + id;
    bootbox.confirm(I18n.t("organizations.show.are_you_sure"), function (result) {
      if (result) {
        $.ajax({
          method: 'PUT',
          url: url,
          data: {group_members: {role: "admin"}},
          success: function () {
            if ($('[data-id=' + id + ']') != null) {
              $('[data-id=' + id + ']').remove();
            }
          }
        });
      }
    })
  });

  $('.select-user-to-add').select2({
    placeholder: I18n.t("organizations.show.select_user"),
    allowClear: true,
    width: 200
  });

  $('#add-organization-member-btn').on('click', function () {
    var url = window.location.pathname + '/admin_add_members/';
    var user_id = $('#organization-select-user').val();
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
          $('#organization-select-user').find('[value=' + user_id + ']').remove();
          location.reload();
        }
      });
    } else {
      alert(I18n.t("organizations.show.choose_user"))
    }

  });
  $('#organization_picture').bind('change', function () {
    var size_in_megabytes = this.files[0].size / 1024 / 1024;
    if (size_in_megabytes > 2) {
      alert(I18n.t("organizations.new.choose_file_smaller"));
    }
  });

  $('#search_organization_ajax').keyup(function() {
    var org_name = $('#search_organization_ajax').val();
    load_organizations(org_name);
  });

  function load_organizations(org_name){
    $.ajax({
      url: '/api/organizations/',
      method: "GET",
      data: {
        org_name: org_name
      },
      success: function(result){
        if($('#list-organizations') !== null) $('#list-organizations').remove();
        $('#table-organizations').append(result);
      }
    });
  }

});

