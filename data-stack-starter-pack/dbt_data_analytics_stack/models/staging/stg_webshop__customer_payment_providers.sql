with
    source as (select * from {{ source("raw_webshop", "customerpaymentprovider") }}),

    renamed as (
        select
            "customer"::varchar as customer_id,
            "provider"::varchar as payment_provider_id,
            "account_no"::varchar as customer_payment_provider_account_no,
            "id"::varchar as customer_payment_provider_id,
            "created_at" as customer_payment_provider_created_at,
            "modified_at" as customer_payment_provider_modified_at
        from source
    )

select *
from renamed
