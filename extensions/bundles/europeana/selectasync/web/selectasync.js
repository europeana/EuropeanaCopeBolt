/***** Load selectasync scripts ******/
jQuery(document).ready(function($) {
  SA_loadNewAsyncSelectors();
  SA_loadNewAsyncDirs();

  $('.bolt-field-repeater').on('click', '.add-button, .duplicate-button', function() {
    SA_loadNewAsyncSelectors();
    SA_loadNewAsyncDirs();
    console.log('selectasync js refreshed for new repeaters');
  });
  console.log('selectasync js loaded');

});

/* helper to fetch the content type from the css classnames */
function SA_findCT(keys) {
  return keys.match('ct-');
}
/* helper to fetch the fieldnames from the css classnames */
function SA_findFields(keys) {
  return keys.match('fields-');
}
/* helper to fetch the select key field from the css classnames */
function SA_findKey(keys) {
  return keys.match('key-');
}
/* helper to fetch the limit key field from the css classnames */
function SA_findLimit(keys) {
  return keys.match('results-');
}
/* helper to check if a string is a json srting */
function SA_isJson(str) {
  try {
    JSON.parse(str);
  } catch (e) {
    return false;
  }
  return true;
}
/**
 * Sets the value of the <input id="x"> to an array of id's
 * where x = the data-target from the given item
 *
 * The array keys are generated from data-id from the children of
 * the given item that have <div class="btn-group" data-id="n">
 *
 * @param item
 */
function SA_reCalculateIds(item) {
  var sortedIDs = [];
  item.children('div.btn-group').each(
      function(index, element) {
        sortedIDs.push($(element).data('id'));
      }
  );
  var target = item.data('target');
  // console.log('target', target);
  $('#'+target).val(JSON.stringify(sortedIDs));
}
/**
 * SA_loadNewAsyncSelectors initializes all asyncselectors for records that don't have the class yet
 *
 * May be called again
 *
 */
function SA_loadNewAsyncSelectors() {

  // iterate through all new ajaxselector fields
  // and initialize the placeholder and select fields
  $('.ajaxselector:not(.ispreloaded)').each(function() {
    //console.log('selectasync element:', $(this).attr('class'), $(this));
    var dataclasses = $(this).attr('class').split(/\s/);
    //console.log('dataclasses', dataclasses);
    $(this).css({width: '100%'});
    $(this).data(
        'contenttype',
        dataclasses.find(SA_findCT).split('-').pop()
    );
    $(this).data(
        'contentfields',
        dataclasses.find(SA_findFields).replace('fields-', '').split('--')
    );
    $(this).data(
        'contentkey',
        dataclasses.find(SA_findKey).split('-').pop()
    );
    $(this).data(
        'limit',
        dataclasses.find(SA_findLimit).split('-').pop()
    );
    var divname = 'visible_' + $(this).attr('name');
    // make a placeholder with working stuff
    divname = divname.replace('modules', '');
    divname = divname.replace(']', '').replace('[', '_');
    divname = divname.replace(']', '').replace('[', '_');
    divname = divname.replace('__', '_');
    $(this).after(
        $('<div>').attr({
          'id': divname
        })
            .data({
              'target': $(this).attr('id')
            })
            .attr({
              'data-target': $(this).attr('id')
            })
            .addClass('selectasync-placeholder')
            .sortable({
              forceHelperSize: true,
              forcePlaceholderSize: true,
              deactivate: function( ) {
                SA_reCalculateIds($(this));
              }
            })
    );
    $(this).parent().addClass('selectasync-was-here form-inline well well-sm');
    selectname = divname.replace('visible_','selector_');
    $(this).parent().append(
        $('<div>')
            .addClass('selectasync-select pull-right')
            .append(
                $('<span>')
                    .addClass('selectasync-search-label')
                    .text('Search in ' + $(this).data('contenttype') + ' and click on the title to add more items:')
            )
            .append(
                $('<input type="text">')
                    .addClass('form-control')
                    .data({
                      'visible': divname,
                      'target': $(this).attr('id')
                    })
                    .attr({
                      'id': selectname,
                      'data-target': $(this).attr('id'),
                      'placeholder': 'type to search in ' + $(this).data('contenttype')
                    })
            )
    );
    $(this).addClass('ispreloaded').hide();
    //console.log('selectasync initialization for:', $(this).attr('name'));
  });

  // prefill the placeholder field with an ajax call
  $('div.selectasync-placeholder:not(.ispreloaded)').each(function() {

    // console.log('selectasync element:', $(this).attr('class'), $(this));
    var target = $('#' + $(this).data('target'));
    var placeholder = $(this);
    var datakeys = $(target).val();
    // console.log('selectasync element:', target, target.data(), datakeys);
    if(datakeys && SA_isJson(datakeys)) {
      datakeys = JSON.parse(datakeys);
    } else if(datakeys && !SA_isJson(datakeys)) {
      datakeys = datakeys.split(',');
    } else {
      // console.log('empty keys for ' + $(this).attr('name'));
      datakeys = [];
      return null;
    }

    //console.log('loading data for selectasync element:', $(this).attr('id'), 'target:', $(this).data('target'));
    // preload options
    $.ajax({
      url: '/admin/selectasync/load/',
      type: 'GET',
      dataType: "json",
      context: placeholder,
      data: {
        ids: datakeys,
        type: target.data('contenttype'),
        fields: target.data('contentfields').join(',')
      },
      beforeSend: function() {
        $(placeholder).append(
            $('<div>')
                .addClass('loadingspinner btn btn-xs btn-warning')
                .text('Loading..')
        );
        // console.log('beforeSend');
      },
      complete: function() {
        var spinners = $(placeholder).find('.loadingspinner');
        $(spinners).detach();
        // console.log('complete');
      },
      error: function(data) {
        console.log('error', data);
        $(placeholder).after(
            $('<div>')
                .addClass('error')
                .text('There was an error preloading, please try refreshing this page..')
        );
      },
      success: function(data) {
        var target = this;
        var unsorted = [];
        // console.log('result data', data.results[data.type], data, datavalues, target);
        if (data.status !== 'error' && data.results[data.type]) {

          var results = data.results[data.type];
          results.forEach(function(e, index) {
            console.log('adding item', e, 'to', target);
            console.log('original sortorder', datakeys);

            // make sure there is a key
            var key = (e.id)?e.id:index;
            // at what position is the key originally
            var datasort = datakeys.indexOf(key);
            // make sure there is a title
            var title = (e.title)?e.title:(e.last_name)?e.first_name + ' ' + e.last_name:(e.position)?e.position:(e.name)?e.name:'no title';
            // make sure there is a status
            var status = (e.status)?e.status:'draft';
            var statusclass = 'btn-info';
            if(status !== 'published') {
              statusclass = 'btn-default';
              title = title + ' (' + status + ')';
            }
            if (status === 'draft') {
              statusclass = 'btn-error';
            }
            unsorted.push(
                $('<div>')
                    .addClass('btn-group')
                    .disableSelection()
                    .data({
                      'for': key,
                      'id': key,
                      'status': status,
                      'title': title,
                      'sort': datasort
                    })
                    .attr({
                      'id': 'sortable-'+key,
                      'for': key,
                      'data-for': key,
                      'data-id': key,
                      'data-status': status,
                      'data-title': title,
                      'data-sort': datasort,
                      'title': title
                    })
                    .append(
                        $('<span>').text(title).addClass('btn btn-xs ' + statusclass)
                    )
                    .append(
                        $('<span>').attr({'aria-label':"Edit"}).addClass('btn btn-default btn-xs').html('<span aria-hidden="true"><i class="fa fa-edit"></i></span>')
                            .on('click', function() {
                              var editable = $(this).parent();
                              var sorter = $(this).parent().parent();
                              var sorterid = '#'+ $(sorter).data('target');
                              var contentdata = $(sorterid).data();
                              var targetid = $(editable).data('id');
                              var datatype = contentdata.contenttype;
                              // console.log('editable', targetid, datatype, $(sorter), contentdata);
                              location.replace('/admin/editcontent/'+datatype+'/'+ targetid);
                            })
                    )
                    .append(
                        $('<span>').attr({'aria-label':"Close"}).addClass('btn btn-warning btn-xs').html('<span aria-hidden="true">&times;</span>')
                            .on('click', function() {
                              var removable = $(this).parent();
                              var sorter = $(this).parent().parent();

                              // console.log('remove element', $(removable), 'from', sorter, sorter.attr('id'));
                              // remove from visible list
                              $(removable).remove();
                              // remove from items
                              SA_reCalculateIds(sorter);
                            })
                    )
            )
          });
        } else {
          console.log('no data', data);
        }
        // reorder elements
        var orderedElements = unsorted;
        orderedElements.sort(function(a, b) {
          // convert to integers from strings
          a = parseInt($(a).data("sort"));
          b = parseInt($(b).data("sort"));
          // compare
          if(a > b) {
            return 1;
          } else if(a < b) {
            return -1;
          } else {
            return 0;
          }
        });
        $(target).append(orderedElements);
        $(placeholder).addClass('ispreloaded');
      }
    });

    // console.log('selectasync load data for:', $(this).attr('name'), $(target).attr('name'));
  });

  // set up the ajaxlookup for new items
  $('div.selectasync-select:not(.ispreloaded) input').each(function() {
    var target = $('#' + $(this).data('target'));
    var selectholder = $(this);
    // console.log('ajaxselect element', $(selectholder).attr('id'));
    // console.log('ajaxselect target', $(target).attr('id'));
    $('#' + $(selectholder).attr('id')).autocomplete({
      source: function(request, response) {
        //console.log('triggered', request, responsecallback);
        $.ajax({
          url: '/admin/selectasync/type/' + target.data('contenttype'),
          type: 'GET',
          dataType: "json",
          context: $(selectholder),
          data: {
            search: request.term,
            type: target.data('contenttype'),
            fields: target.data('contentfields').join(',')
          },
          error: function(data) {
            console.log('error', data);
            $(selectholder).after(
                $('<div>')
                    .addClass('error')
                    .text('There was an error loading data, please try refreshing this page..')
            );
          },
          success: function(data) {
            console.log('data', data.results[data.type], data);
            console.log('response', response);
            if (data.status !== 'error' && data.results[data.type]) {
              var results = data.results[data.type];
              var ajaxcleaned = [];
              results.forEach(function(e, index) {
                var title = (e.title)?e.title:(e.last_name)?e.first_name + ' ' + e.last_name:(e.position)?e.position:(e.name)?e.name:'no title';
                ajaxcleaned.push({
                  'value': e.id,
                  'label': title,
                  'full_item': e
                });
              });
              response(ajaxcleaned);
            } else {
              console.log('no data', data);
              if(data.message) {
                $(selectholder).after(
                    $('<div>')
                        .addClass('error')
                        .text('There was an error loading data, the message was: ' + data.message)
                );
              }
              response([]);
            }
          }
        });
      },
      minLength: 2,
      delay: 200,
      select: function( event, ui ) {
        // console.log('event:', event, 'ui:', ui);
        var target = event.target;
        console.log('target', $(target).data('visible'));
        console.log( "Selected: " + ui.item.value + " aka " + ui.item.label, ui.item );
        var key = ui.item.full_item.id;

        var title = (ui.item.full_item.title)?ui.item.full_item.title:(ui.item.full_item.last_name)?ui.item.full_item.first_name + ' ' + ui.item.full_item.last_name:(ui.full_item.position)?ui.full_item.position:(ui.full_item.name)?ui.full_item.name:'no title';
        // make sure there is a status
        var status = ui.item.full_item.status;
        var statusclass = 'btn-info';
        if(status !== 'published') {
          statusclass = 'btn-default';
          title = title + ' (' + status + ')';
        }
        if (status === 'draft') {
          statusclass = 'btn-error';
        }
        var datasort = 'last';
        /**/
        var newElements = $('<div>')
            .addClass('btn-group')
            .disableSelection()
            .data({
              'for': key,
              'id': key,
              'status': status,
              'title': title,
              'sort': datasort
            })
            .attr({
              'id': 'sortable-'+key,
              'for': key,
              'data-for': key,
              'data-id': key,
              'data-status': status,
              'data-title': title,
              'data-sort': datasort,
              'title': title
            })
            .append(
                $('<span>').text(title).addClass('btn btn-xs ' + statusclass)
            )
            .append(
                $('<span>').attr({'aria-label':"Edit"}).addClass('btn btn-default btn-xs').html('<span aria-hidden="true"><i class="fa fa-edit"></i></span>')
                    .on('click', function() {
                      var editable = $(this).parent();
                      var sorter = $(this).parent().parent();
                      var sorterid = '#'+ $(sorter).data('target');
                      var contentdata = $(sorterid).data();
                      var targetid = $(editable).data('id');
                      var datatype = contentdata.contenttype;
                      // console.log('editable', targetid, datatype, $(sorter), contentdata);
                      location.replace('/admin/editcontent/'+datatype+'/'+ targetid);
                    })
            )
            .append(
                $('<span>').attr({'aria-label':"Close"}).addClass('btn btn-warning btn-xs').html('<span aria-hidden="true">&times;</span>')
                    .on('click', function() {
                      var removable = $(this).parent();
                      var sorter = $(this).parent().parent();

                      // console.log('remove element', $(removable), 'from', sorter, sorter.attr('id'));
                      // remove from visible list
                      $(removable).remove();
                      // remove from items
                      SA_reCalculateIds(sorter);
                    })
            );
        var sorter = '#'+ $(target).data('visible');
        $(sorter).append(newElements);
        SA_reCalculateIds($(sorter));
      },
      close: function( event, ui ) {
        var target = event.target;
        // hide the selected value again after selector is closed
        $(target).val('');
      }
    });
  });
}

/**
 * SA_loadNewAsyncDirs initializes all directoryselect for directories that don't have the class yet
 *
 * May be called again
 *
 */
function SA_loadNewAsyncDirs() {
  $('.directoryselect:not(.ispreloaded)').each(function() {
    //console.log(this, $(this));

    var selectholder = $(this);
    //console.log('ajaxselect element', $(selectholder).attr('id'));

    $('#' + $(selectholder).attr('id')).autocomplete({
      source: function(request, response) {
        //console.log('triggered', request, responsecallback);
        $.ajax({
          url: '/admin/selectasync/directories',
          type: 'GET',
          dataType: "json",
          context: $(selectholder),
          data: {
            search: request.term
          },
          error: function(data) {
            console.log('error', data);
            $(selectholder).after(
                $('<div>')
                    .addClass('error')
                    .text('There was an error loading data, please try refreshing this page..')
            );
          },
          success: function(data) {
            //console.log('data', data.results, data);
            if (data.status !== 'error' && data.results) {
              var results = data.results;
              var ajaxcleaned = [];
              results.forEach(function(e, index) {
                ajaxcleaned.push({
                  'value': e.id,
                  'label': e.title,
                  'full_item': e
                });
              });
              response(ajaxcleaned);
            } else {
              console.log('no data', data);
              response([]);
            }
          }
        });
      },
      minLength: 2,
      delay: 200
    });


    $(this).addClass('ispreloaded');
  });
}
