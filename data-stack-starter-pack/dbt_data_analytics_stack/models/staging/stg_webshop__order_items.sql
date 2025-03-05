with
    source as (select * from {{ source("raw_webshop", "orderitem") }}),

    renamed as (
        select
            "order"::varchar as order_id,
            "product"::varchar as product_id,
            "quantity" as item_quantity,
            "price" as item_price,
            "id"::varchar as order_item_id,
            "created_at" as order_item_created_at,
            "modified_at" as order_item_modified_at
        from source
    )

select *
from renamed
