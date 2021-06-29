jQuery(document).ready(function () {
    $('.cn-decline, .cm-btn-success').on('click', function () {
        $('#cookie-button').show('slow', function () {
        })
    })
})

function getCookie() {
    if (document.cookie.includes('klaro')) {
        $('#cookie-button').show('slow', function () {
        })
    }
}

getCookie()

$(document).on('click', '.cm-btn-accept-all', function () {
    $('#cookie-button').show('slow', function () {

    })
})

$(document).on('click', '.cn-decline', function () {
    $('#cookie-button').show('slow', function () {

    })
})

$(document).on('click', '.cm-btn-accept', function () {
    $('#cookie-button').show('slow', function () {

    })
})