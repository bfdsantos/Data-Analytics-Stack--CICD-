with
    source as (select * from {{ source("raw_webshop", "productcategory") }}),

    renamed as (
        select
            "category"::varchar as category_id,
            "product"::varchar as product_id,
            "id"::varchar as product_category_id,
            "created_at" as product_category_created_at,
            "modified_at" as product_category_modified_at
        from source
    )

select *
from renamed
