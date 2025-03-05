with
    source as (select * from {{ source("raw_webshop", "customeraddress") }}),

    renamed as (
        select
            "customer"::varchar as customer_id,
            "street" as address_street,
            "number" as address_number,
            "city" as address_city,
            "postal_code" as address_postal_code,
            "country" as address_country,
            "id"::varchar as customer_address_id,
            "created_at" as customer_address_created_at,
            "modified_at" as customer_address_modified_at
        from source
    )

select *
from renamed
