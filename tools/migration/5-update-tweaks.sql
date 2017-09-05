UPDATE europeana_cope.bolt_field_value SET value_text = value_json_array where fieldname like 'selected%';
UPDATE europeana_cope.bolt_field_value SET value_json_array = null where fieldname like 'selected%';
UPDATE europeana_cope.bolt_field_value SET fieldtype = 'text' where fieldname like 'selected%';
