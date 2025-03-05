with
    source as (select * from {{ source("raw_webshop", "product") }}),

    renamed as (
        select
            "name" as product_name,
            "description" as product_description,
            "EAN" as product_ean,
            "price" as product_price,
            "discount_percent" as product_discount_percent,
            "brand"::varchar as product_brand_id,
            "inventory" as product_inventory,
            "published" as product_published,
            "id"::varchar as product_id,
            "created_at" as product_created_at,
            "modified_at" as product_modified_at
        from source
    )

select *
from renamed
