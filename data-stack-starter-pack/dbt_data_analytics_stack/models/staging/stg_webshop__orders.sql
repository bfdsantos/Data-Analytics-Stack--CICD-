with
    source as (select * from {{ source("raw_webshop", "orders") }}),

    renamed as (
        select
            "customer"::varchar as customer_id,
            "status" as order_status,
            "customer_address"::varchar as customer_address_id,
            "id"::varchar as order_id,
            "created_at" as order_created_at,
            "modified_at" as order_modified_at
        from source
    )

select *
from renamed
