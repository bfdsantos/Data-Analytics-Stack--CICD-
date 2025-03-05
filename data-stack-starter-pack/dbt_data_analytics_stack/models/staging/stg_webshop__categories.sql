with
    source as (select * from {{ source("raw_webshop", "category") }}),

    renamed as (
        select
            "name" as category_name,
            "id"::varchar as category_id,
            "created_at" as category_created_at,
            "modified_at" as category_modified_at
        from source
    )

select *
from renamed
