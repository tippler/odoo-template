#!/usr/bin/env bash

set -a
. ./.env
set +a

mkdir -p tmp

echo "reportlab" > tmp/requirements.txt

git clone -b ${ODOO_VERSION} https://github.com/OCA/stock-logistics-barcode.git tmp/barcode
cat tmp/barcode/requirements.txt >> tmp/requirements.txt
mv -f tmp/barcode/calendar* ./custom-addons/
mv -f tmp/barcode/resource_booking ./custom-addons/

git clone -b ${ODOO_VERSION} https://github.com/OCA/account-financial-tools.git tmp/account
cat tmp/account/requirements.txt >> tmp/requirements.txt
mv -f tmp/account/account* ./custom-addons/
mv -f tmp/account/product_category_tax ./custom-addons/
mv -f tmp/account/purchase_unreconciled ./custom-addons/

git clone -b ${ODOO_VERSION} https://github.com/OCA/account-financial-reporting.git tmp/account-financial-reporting
cat tmp/account-financial-reporting/requirements.txt >> tmp/requirements.txt
for dir in tmp/account-financial-reporting/*/; do mv "$dir" ./custom-addons/; done

git clone -b ${ODOO_VERSION} https://github.com/OCA/calendar.git tmp/calendar
cat tmp/calendar/requirements.txt >> tmp/requirements.txt
mv -f tmp/calendar/resource_booking ./custom-addons/
mv -f tmp/calendar/calendar* ./custom-addons/

git clone -b ${ODOO_VERSION} https://github.com/OCA/web.git tmp/web
cat tmp/web/requirements.txt >> tmp/requirements.txt
mv -f tmp/web/web* ./custom-addons/

git clone -b ${ODOO_VERSION} https://github.com/OCA/reporting-engine.git tmp/report
cat tmp/report/requirements.txt >> tmp/requirements.txt
for dir in tmp/report/*/; do mv "$dir" ./custom-addons/; done

git clone -b ${ODOO_VERSION} https://github.com/OCA/server-brand.git tmp/brand
cat tmp/brand/requirements.txt >> tmp/requirements.txt
mv -f tmp/brand/disable_odoo_online ./custom-addons/
mv -f tmp/brand/portal_odoo_debranding ./custom-addons/
mv -f tmp/brand/remove_odoo_enterprise ./custom-addons/

git clone -b ${ODOO_VERSION} https://github.com/OCA/l10n-spain.git tmp/l10n-spain
cat tmp/l10n-spain/requirements.txt >> tmp/requirements.txt
for dir in tmp/l10n-spain/*/; do mv "$dir" ./custom-addons/; done

cp tmp/requirements.txt ./custom-addons/
rm -rf tmp/
