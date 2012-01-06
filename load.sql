delete from lego_sets;
.separator "\t"
.import sets.tsv lego_sets
--create index set_number on sets (number);
