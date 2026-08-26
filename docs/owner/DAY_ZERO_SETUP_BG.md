# Day Zero — канонична настройка на собственика

## Цел и граница

Това е каноничният, несекретен превод на действията от Phase 1 — Owner Foundation. Собственикът ги изпълнява лично в официалните сайтове и Bitwarden; агентът не получава master credentials. Действие извън одобрен Phase Brief не се изпълнява. Phase 4 не е разрешена от този документ.

Бележките и отчетите използват само символни имена: `PROJECT_OWNER_EMAIL`, `CLOUDFLARE_ACCOUNT_ID`, `STAGING_SUPABASE_PROJECT_REF` и `PRODUCTION_SUPABASE_PROJECT_REF`. Реалните стойности остават извън Git и чата.

Phase 1 не включва създаване на repository, продуктови таблици, продуктов код или продуктови данни. Завършването ѝ не активира Phase 2 или друга следваща фаза.

## Карта на действията

Всяко действие по-долу съдържа: **Какво**, **Защо**, **Риск**, **Очакван резултат**, **Ако е различно** и **Не споделяй**. „OWNER / ACCOUNT“ означава, че действието е само на собственика в неговия браузър.

### 1. Потвърди правилото за безопасност — OWNER / ACCOUNT

- **Какво:** Преди настройка работи само в официалния сайт на доставчика или в Bitwarden; не поставяй secret в чат, Git, issue, PR или публичен документ.
- **Защо:** Публичната Git история и чатът не са място за пароли и recovery материал.
- **Риск:** Безопасност — неправилното споделяне може да даде достъп до проектни акаунти.
- **Очакван резултат:** Secret-ите се въвеждат директно и остават само в одобрения password manager/акаунт.
- **Ако е различно:** Спри въвеждането и следвай [Tool Policy](../governance/TOOL_POLICY.md) за предполагаем теч на secret.
- **Не споделяй:** Парола, recovery code, API key, token, database password, project ref или реален owner email.

### 2. Потвърди проектната Proton идентичност — OWNER / ACCOUNT

- **Какво:** Влез директно в специалната проектна Proton поща, изпрати/получи нормално тестово или потвърждаващо писмо и запиши/обнови данните за вход директно в Bitwarden под PC Advisor BG.
- **Защо:** Тази идентичност е основата за собственост и възстановяване на проектните акаунти.
- **Риск:** ACCOUNT — грешен или недостъпен акаунт нарушава възстановяването.
- **Очакван резултат:** Достъпът до пощата е потвърден, а в несекретния запис се отбелязва само `PROJECT_OWNER_EMAIL = configured privately`.
- **Ако е различно:** Ако достъпът или recovery е недостъпен, спри като `OWNER DECISION REQUIRED`; не заменяй пощата с друга.
- **Не споделяй:** Реален email, парола, recovery code или съдържание на писма за възстановяване.

### 3. Подготви структурата в Bitwarden — OWNER / ACCOUNT

- **Какво:** В съществуващия Bitwarden създай проектна структура `PC Advisor BG` с логически записи/категории за Owner Recovery, Project Email, GitHub, Supabase Local, Supabase Staging, Supabase Production, Hosting and Domains, Analytics and Monitoring, AI Provider (reserved/unused), Affiliate Accounts и Recovery and Backup Records; добави secure note `PC Advisor BG — Resource Inventory`.
- **Защо:** Така собствеността, възстановяването и частните идентификатори са отделени от несвързани проекти.
- **Риск:** ACCOUNT — грешно място или публична бележка може да разкрие чувствителна информация.
- **Очакван резултат:** Проектният vault е готов; несекретният факт е само `Owner Vault ready: YES`.
- **Ако е различно:** Ако наличният план/интерфейс не позволява безопасна структура без цена, не активирай платен план; спри като `OWNER DECISION REQUIRED`.
- **Не споделяй:** Пароли, recovery материал, project refs, token-и или съдържанието на secure note.

### 4. Създай изолирана GitHub Organization — OWNER / ACCOUNT

- **Какво:** Влез със съществуващия личен GitHub акаунт, създай една нова Organization само за PC Advisor BG, избери нулева цена и остани Organization owner; използвай проектната поща за contact/billing, ако текущият интерфейс го позволява, и съхрани slug-а само в private resource inventory.
- **Защо:** Това отделя собствеността на проекта от други организации и запазва човешкия контрол върху акаунта.
- **Риск:** ACCOUNT / COST — грешна организация, нов owner или платен план променят контрол или разход.
- **Очакван резултат:** Има една owner-controlled Organization, без добавен агент като owner и без платена услуга.
- **Ако е различно:** Ако UI предлага платен план, добавяне на owner или неясна промяна на условия, не продължавай; това е `OWNER DECISION REQUIRED`.
- **Не споделяй:** Реален contact email, кодове за вход, token-и или private Organization идентификатори.

### 5. Създай изолиран Cloudflare акаунт — OWNER / ACCOUNT

- **Какво:** Създай или влез в Cloudflare акаунт, притежаван от проектната Proton идентичност; остани на free/default услуги, запиши account identifier само в private resource inventory и използвай бъдещи scoped token-и, а не Global API Key.
- **Защо:** Отделният акаунт намалява последствията за несвързани проекти и пази ownership границата.
- **Риск:** ACCOUNT / COST — Global API Key, платено надграждане или покупка на домейн са извън безопасното действие.
- **Очакван резултат:** Account ownership е потвърден, не е купен домейн и не е активирана платена услуга.
- **Ако е различно:** Ако се иска плащане, домейн или по-широк достъп, не потвърждавай; спри като `OWNER DECISION REQUIRED`.
- **Не споделяй:** Account ID, token-и, API key, реална поща или данни за плащане.

### 6. Създай изолирани Supabase account и Organization — OWNER / ACCOUNT

- **Какво:** Създай или влез в Supabase с проектната Proton идентичност, създай една Organization за PC Advisor BG и провери в официалния интерфейс дали free capacity поддържа две активни проекта. Не използвай несвързан Supabase проект и не включвай допълнителни продукти.
- **Защо:** Staging и Production трябва да са изолирани, без да се смесват с други данни и акаунти.
- **Риск:** ACCOUNT / COST — недостатъчен free капацитет или допълнителни услуги изискват решение на собственика.
- **Очакван резултат:** Има owner-controlled Organization и потвърдена възможност за два отделни free проекта.
- **Ако е различно:** Ако два проекта не могат да са активни при €0, не добавяй платен ресурс и не заменяй с чужд проект; спри като `OWNER DECISION REQUIRED`.
- **Не споделяй:** Реална поща, Organization ID, project ref, пароли, token-и или API ключове.

### 7. Създай Staging Supabase проект — OWNER / ACCOUNT

- **Какво:** В проектната Supabase Organization създай `pc-advisor-staging`, избери Frankfurt / `eu-central-1`, генерирай и запиши database password директно в Bitwarden, запиши project ref само частно и изчакай статусът да е healthy.
- **Защо:** Staging е отделната хоствана среда за безопасна автоматизирана проверка с тестови данни.
- **Риск:** STAGING / ACCOUNT — грешен регион или неправилна среда нарушава изолацията; не се създават продуктови таблици.
- **Очакван резултат:** Здрав отделен Staging проект във Frankfurt, с private идентификатор и без продуктови данни.
- **Ако е различно:** Ако регионът не е Frankfurt / `eu-central-1`, проектът не е healthy или изборът изисква плащане, не импровизирай; спри като `OWNER DECISION REQUIRED`.
- **Не споделяй:** Project ref, database password, connection string, token-и или screenshots с идентификатори.

### 8. Създай Production Supabase проект — OWNER / ACCOUNT

- **Какво:** В същата проектна Supabase Organization създай `pc-advisor-production`, избери Frankfurt / `eu-central-1`, генерирай и запиши database password директно в Bitwarden, запиши project ref само частно и изчакай статусът да е healthy. Не конфигурирай агентски MCP/инструменти за този проект.
- **Защо:** Production остава изолирана security boundary още от създаването си.
- **Риск:** PRODUCTION / ACCOUNT — това е чувствителна среда; не се създават продуктови таблици или реални данни и не се дава агентски достъп.
- **Очакван резултат:** Здрав отделен Production проект във Frankfurt, контролиран само от собственика.
- **Ако е различно:** Ако интерфейсът поиска по-широк достъп, плащане, друг регион или свързване на агентски инструмент, не потвърждавай; спри като `OWNER DECISION REQUIRED`.
- **Не споделяй:** Project ref, database password, service-role/secret стойности, connection string, token-и или recovery материал.

### 9. Потвърди Phase 1 основата — OWNER / ACCOUNT

- **Какво:** Провери с независим reviewer само несекретните факти: изолирани GitHub/Cloudflare/Supabase акаунти, Frankfurt за двата Supabase проекта, липса на съзнателно активиран платен ресурс и липса на agent Production credentials; подготви несекретен evidence report.
- **Защо:** Phase 1 е валидна само ако owner recovery е запазен и Production границата е реална.
- **Риск:** SECURITY / COST — непроверена изолация или скрита платена услуга не е основание да се продължава.
- **Очакван резултат:** Потвърдени owner control, два отделни Frankfurt проекта, €0 избори и липса на изложен secret; несекретният ledger съдържа само доставчик, потвърждение за собственост, display name, регион и дали recovery е съхранен.
- **Ако е различно:** Когато липсва някой от фактите, не активирай следваща фаза автоматично; класифицирай и докладвай по [Stop Conditions](../governance/STOP_CONDITIONS.md).
- **Не споделяй:** Evidence report не съдържа пароли, recovery codes, project refs, token-и, account IDs или реална owner поща.

## След Day Zero

Завършването на Phase 1 не разрешава следваща фаза. По-нататъшната работа зависи от активен Phase Brief и се управлява от [Project Charter](../governance/PROJECT_CHARTER.md), [Tool Policy](../governance/TOOL_POLICY.md) и [Stop Conditions](../governance/STOP_CONDITIONS.md). Термините са в [Глосар](GLOSSARY_BG.md).
