/*******************************************************************************
 * IDE
 * User interface for Aquameta.
 *
 * Created by Aquameta Labs, an open source company in Portland Oregon, USA.
 * Company: http://aquameta.com/
 * Project: http://blog.aquameta.com/
 ******************************************************************************/
begin;

create schema ide;
set search_path=ide;

create or replace view ide.bundle_contained_relation as
select *, count(*) as count from (
select (row_id::meta.schema_id).name as schema_name, (row_id::meta.relation_id).name
from bundle.bundle b
    join bundle.head_db_stage hds on hds.bundle_id=b.id
) x
group by x.schema_name, x.name;



create or replace view ide.foreign_key as
select table_id,
    unnest(from_column_ids) as from_column_id,
    unnest(to_column_ids) as to_column_id
from meta.foreign_key;


commit;

