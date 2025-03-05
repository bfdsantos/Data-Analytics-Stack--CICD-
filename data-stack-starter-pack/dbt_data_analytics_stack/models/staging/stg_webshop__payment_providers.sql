with
    source as (select * from {{ source("raw_webshop", "paymentprovider") }}),

    renamed as (
        select
            "name" as payment_provider_name,
            "fixed_payment_costs" as fixed_payment_costs,
            "percentage_payment_costs" as percentage_payment_costs,
            "id"::varchar as payment_provider_id,
            "created_at" as payment_provider_created_at,
            "modified_at" as payment_provider_modified_at
        from source
    )

select *
from renamed
