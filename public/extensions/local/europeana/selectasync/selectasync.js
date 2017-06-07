/***** Select 2 extension needs to be done before the extension is doing stuff ******/
jQuery(document).ready(function($) {
    var S2Ext = jQuery.fn.select2.amd;
    console.log('select2 extension loading');
    //console.log(S2Ext);

    S2Ext.define('select2/compat/utils',[
        'jquery'
    ], function ($) {
        function syncCssClasses ($dest, $src, adapter) {
            var classes, replacements = [], adapted;

            classes = $.trim($dest.attr('class'));

            if (classes) {
                classes = '' + classes; // for IE which returns object

                $(classes.split(/\s+/)).each(function () {
                    // Save all Select2 classes
                    if (this.indexOf('select2-') === 0) {
                        replacements.push(this);
                    }
                });
            }

            classes = $.trim($src.attr('class'));

            if (classes) {
                classes = '' + classes; // for IE which returns object

                $(classes.split(/\s+/)).each(function () {
                    // Only adapt non-Select2 classes
                    if (this.indexOf('select2-') !== 0) {
                        adapted = adapter(this);

                        if (adapted != null) {
                            replacements.push(adapted);
                        }
                    }
                });
            }

            $dest.attr('class', replacements.join(' '));
        }

        return {
            syncCssClasses: syncCssClasses
        };
    });

    S2Ext.define('select2/compat/containerCss',[
        'jquery',
        './utils'
    ], function ($, CompatUtils) {
        // No-op CSS adapter that discards all classes by default
        function _containerAdapter (clazz) {
            return null;
        }

        function ContainerCSS () { }

        ContainerCSS.prototype.render = function (decorated) {
            var $container = decorated.call(this);

            var containerCssClass = this.options.get('containerCssClass') || '';

            if ($.isFunction(containerCssClass)) {
                containerCssClass = containerCssClass(this.$element);
            }

            var containerCssAdapter = this.options.get('adaptContainerCssClass');
            containerCssAdapter = containerCssAdapter || _containerAdapter;

            if (containerCssClass.indexOf(':all:') !== -1) {
                containerCssClass = containerCssClass.replace(':all', '');

                var _cssAdapter = containerCssAdapter;

                containerCssAdapter = function (clazz) {
                    var adapted = _cssAdapter(clazz);

                    if (adapted != null) {
                        // Append the old one along with the adapted one
                        return adapted + ' ' + clazz;
                    }

                    return clazz;
                };
            }

            var containerCss = this.options.get('containerCss') || {};

            if ($.isFunction(containerCss)) {
                containerCss = containerCss(this.$element);
            }

            CompatUtils.syncCssClasses($container, this.$element, containerCssAdapter);

            $container.css(containerCss);
            $container.addClass(containerCssClass);

            return $container;
        };

        return ContainerCSS;
    });

    S2Ext.define('select2/compat/dropdownCss',[
        'jquery',
        './utils'
    ], function ($, CompatUtils) {
        // No-op CSS adapter that discards all classes by default
        function _dropdownAdapter (clazz) {
            return null;
        }

        function DropdownCSS () { }

        DropdownCSS.prototype.render = function (decorated) {
            var $dropdown = decorated.call(this);

            var dropdownCssClass = this.options.get('dropdownCssClass') || '';

            if ($.isFunction(dropdownCssClass)) {
                dropdownCssClass = dropdownCssClass(this.$element);
            }

            var dropdownCssAdapter = this.options.get('adaptDropdownCssClass');
            dropdownCssAdapter = dropdownCssAdapter || _dropdownAdapter;

            if (dropdownCssClass.indexOf(':all:') !== -1) {
                dropdownCssClass = dropdownCssClass.replace(':all', '');

                var _cssAdapter = dropdownCssAdapter;

                dropdownCssAdapter = function (clazz) {
                    var adapted = _cssAdapter(clazz);

                    if (adapted != null) {
                        // Append the old one along with the adapted one
                        return adapted + ' ' + clazz;
                    }

                    return clazz;
                };
            }

            var dropdownCss = this.options.get('dropdownCss') || {};

            if ($.isFunction(dropdownCss)) {
                dropdownCss = dropdownCss(this.$element);
            }

            CompatUtils.syncCssClasses($dropdown, this.$element, dropdownCssAdapter);

            $dropdown.css(dropdownCss);
            $dropdown.addClass(dropdownCssClass);

            return $dropdown;
        };

        return DropdownCSS;
    });

    S2Ext.define('select2/compat/initSelection',[
        'jquery'
    ], function ($) {
        function InitSelection (decorated, $element, options) {
            if (options.get('debug') && window.console && console.warn) {
                console.warn(
                    'Select2: The `initSelection` option has been deprecated in favor' +
                    ' of a custom data adapter that overrides the `current` method. ' +
                    'This method is now called multiple times instead of a single ' +
                    'time when the instance is initialized. Support will be removed ' +
                    'for the `initSelection` option in future versions of Select2'
                );
            }

            this.initSelection = options.get('initSelection');
            this._isInitialized = false;

            decorated.call(this, $element, options);
        }

        InitSelection.prototype.current = function (decorated, callback) {
            var self = this;

            if (this._isInitialized) {
                decorated.call(this, callback);

                return;
            }

            this.initSelection.call(null, this.$element, function (data) {
                self._isInitialized = true;

                if (!$.isArray(data)) {
                    data = [data];
                }

                callback(data);
            });
        };

        return InitSelection;
    });

    S2Ext.define('select2/compat/inputData',[
        'jquery'
    ], function ($) {
        function InputData (decorated, $element, options) {
            this._currentData = [];
            this._valueSeparator = options.get('valueSeparator') || ',';

            if ($element.prop('type') === 'hidden') {
                if (options.get('debug') && console && console.warn) {
                    console.warn(
                        'Select2: Using a hidden input with Select2 is no longer ' +
                        'supported and may stop working in the future. It is recommended ' +
                        'to use a `<select>` element instead.'
                    );
                }
            }

            decorated.call(this, $element, options);
        }

        InputData.prototype.current = function (_, callback) {
            function getSelected (data, selectedIds) {
                var selected = [];

                if (data.selected || $.inArray(data.id, selectedIds) !== -1) {
                    data.selected = true;
                    selected.push(data);
                } else {
                    data.selected = false;
                }

                if (data.children) {
                    selected.push.apply(selected, getSelected(data.children, selectedIds));
                }

                return selected;
            }

            var selected = [];

            for (var d = 0; d < this._currentData.length; d++) {
                var data = this._currentData[d];

                selected.push.apply(
                    selected,
                    getSelected(
                        data,
                        this.$element.val().split(
                            this._valueSeparator
                        )
                    )
                );
            }

            callback(selected);
        };

        InputData.prototype.select = function (_, data) {
            if (!this.options.get('multiple')) {
                this.current(function (allData) {
                    $.map(allData, function (data) {
                        data.selected = false;
                    });
                });

                this.$element.val(data.id);
                this.$element.trigger('change');
            } else {
                var value = this.$element.val();
                value += this._valueSeparator + data.id;

                this.$element.val(value);
                this.$element.trigger('change');
            }
        };

        InputData.prototype.unselect = function (_, data) {
            var self = this;

            data.selected = false;

            this.current(function (allData) {
                var values = [];

                for (var d = 0; d < allData.length; d++) {
                    var item = allData[d];

                    if (data.id == item.id) {
                        continue;
                    }

                    values.push(item.id);
                }

                self.$element.val(values.join(self._valueSeparator));
                self.$element.trigger('change');
            });
        };

        InputData.prototype.query = function (_, params, callback) {
            var results = [];

            for (var d = 0; d < this._currentData.length; d++) {
                var data = this._currentData[d];

                var matches = this.matches(params, data);

                if (matches !== null) {
                    results.push(matches);
                }
            }

            callback({
                results: results
            });
        };

        InputData.prototype.addOptions = function (_, $options) {
            var options = $.map($options, function ($option) {
                return $.data($option[0], 'data');
            });

            this._currentData.push.apply(this._currentData, options);
        };

        return InputData;
    });

    S2Ext.define('select2/compat/matcher',[
        'jquery'
    ], function ($) {
        function oldMatcher (matcher) {
            function wrappedMatcher (params, data) {
                var match = $.extend(true, {}, data);

                if (params.term == null || $.trim(params.term) === '') {
                    return match;
                }

                if (data.children) {
                    for (var c = data.children.length - 1; c >= 0; c--) {
                        var child = data.children[c];

                        // Check if the child object matches
                        // The old matcher returned a boolean true or false
                        var doesMatch = matcher(params.term, child.text, child);

                        // If the child didn't match, pop it off
                        if (!doesMatch) {
                            match.children.splice(c, 1);
                        }
                    }

                    if (match.children.length > 0) {
                        return match;
                    }
                }

                if (matcher(params.term, data.text, data)) {
                    return match;
                }

                return null;
            }

            return wrappedMatcher;
        }

        return oldMatcher;
    });

    S2Ext.define('select2/compat/query',[

    ], function () {
        function Query (decorated, $element, options) {
            if (options.get('debug') && window.console && console.warn) {
                console.warn(
                    'Select2: The `query` option has been deprecated in favor of a ' +
                    'custom data adapter that overrides the `query` method. Support ' +
                    'will be removed for the `query` option in future versions of ' +
                    'Select2.'
                );
            }

            decorated.call(this, $element, options);
        }

        Query.prototype.query = function (_, params, callback) {
            params.callback = callback;

            var query = this.options.get('query');

            query.call(null, params);
        };

        return Query;
    });

    S2Ext.define('select2/dropdown/attachContainer',[

    ], function () {
        function AttachContainer (decorated, $element, options) {
            decorated.call(this, $element, options);
        }

        AttachContainer.prototype.position =
            function (decorated, $dropdown, $container) {
                var $dropdownContainer = $container.find('.dropdown-wrapper');
                $dropdownContainer.append($dropdown);

                $dropdown.addClass('select2-dropdown--below');
                $container.addClass('select2-container--below');
            };

        return AttachContainer;
    });

    S2Ext.define('select2/dropdown/stopPropagation',[

    ], function () {
        function StopPropagation () { }

        StopPropagation.prototype.bind = function (decorated, container, $container) {
            decorated.call(this, container, $container);

            var stoppedEvents = [
                'blur',
                'change',
                'click',
                'dblclick',
                'focus',
                'focusin',
                'focusout',
                'input',
                'keydown',
                'keyup',
                'keypress',
                'mousedown',
                'mouseenter',
                'mouseleave',
                'mousemove',
                'mouseover',
                'mouseup',
                'search',
                'touchend',
                'touchstart'
            ];

            this.$dropdown.on(stoppedEvents.join(' '), function (evt) {
                evt.stopPropagation();
            });
        };

        return StopPropagation;
    });

    S2Ext.define('select2/selection/stopPropagation',[

    ], function () {
        function StopPropagation () { }

        StopPropagation.prototype.bind = function (decorated, container, $container) {
            decorated.call(this, container, $container);

            var stoppedEvents = [
                'blur',
                'change',
                'click',
                'dblclick',
                'focus',
                'focusin',
                'focusout',
                'input',
                'keydown',
                'keyup',
                'keypress',
                'mousedown',
                'mouseenter',
                'mouseleave',
                'mousemove',
                'mouseover',
                'mouseup',
                'search',
                'touchend',
                'touchstart'
            ];

            this.$selection.on(stoppedEvents.join(' '), function (evt) {
                evt.stopPropagation();
            });
        };

        return StopPropagation;
    });
});

/***** Your javascript can go below here ******/
jQuery(document).ready(function($) {

    $('.ajaxselector').each(function(element) {
        //console.log('selectasync element:', element, $(this).attr('class'));

        var dataclasses = $(this).attr('class').split(/\s/);
        $(this).data('contenttype',
            dataclasses.find(findCT).split('-').pop());
        $(this).data('contentfields',
            dataclasses.find(findFields).replace('fields-','').split('--'));
        $(this).data('contentkey',
            dataclasses.find(findKey).split('-').pop());

        console.log('dataclasses', $(this).data());

        $(this).select2({
            placeholder: {
                id: '-1', // the value of the option
                text: 'Select from ' + $(this).data('contenttype')
            },
            ajax: {
                url: "/bolt/selectasync/" + $(this).data('contenttype'),
                dataType: 'json',
                delay: 250,
                data: function (params) {
                    console.log('select2 data', params, $(this));
                    var query = {
                        search: params.term,
                        fields: $(this).data('contentfields'),
                        key: $(this).data('contentkey')
                    };
                    return query;
                },
                processResults: function (data, params) {
                    console.log('select2 processResults', data, params);
                    return {
                        results: data.results
                    };
                },
                cache: true
            },
            escapeMarkup: function (markup) { return markup; },
            minimumInputLength: 2
        });
    });
});

function findCT(keys) {
    return keys.match('ct-');
}
function findFields(keys) {
    return keys.match('fields-');
}
function findKey(keys) {
    return keys.match('key-');
}
