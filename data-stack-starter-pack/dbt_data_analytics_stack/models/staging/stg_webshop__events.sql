with
    source as (select * from {{ source("raw_webshop", "event") }}),

    renamed as (
        select
            lower("type"::varchar) as event_type,
            "event"::jsonb #>> '{}' as event_content,
            "id"::varchar as event_id,
            "created_at" as event_created_at,
            "modified_at" as event_modified_at
        from source
    )

select *
from renamed
