with
    source as (select * from {{ source("raw_webshop", "productbrand") }}),

    renamed as (
        select
            "name" as product_brand_name,
            "id"::varchar as product_brand_id,
            "created_at" as product_brand_created_at,
            "modified_at" as product_brand_modified_at
        from source
    )

select *
from renamed
