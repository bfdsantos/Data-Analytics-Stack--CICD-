with
    source as (select * from {{ source("raw_webshop", "customer") }}),

    renamed as (
        select
            "name" as customer_name,
            "email" as customer_email,
            "phone_number" as customer_phone_number,
            "id"::varchar as customer_id,
            "created_at" as customer_created_at,
            "modified_at" as customer_modified_at
        from source
    )

select *
from renamed
