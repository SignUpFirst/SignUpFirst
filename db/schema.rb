# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140731163219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "unaccent"

  create_table "oauth_providers", force: true do |t|
    t.text     "name",       null: false
    t.text     "key",        null: false
    t.text     "secret",     null: false
    t.text     "scope"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "strategy"
    t.text     "path"
    t.index ["name"], :name => "oauth_providers_name_unique", :unique => true
  end

  create_table "channels", force: true do |t|
    t.text     "name",              null: false
    t.text     "description",       null: false
    t.text     "permalink",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "twitter"
    t.text     "facebook"
    t.text     "email"
    t.text     "image"
    t.text     "website"
    t.text     "video_url"
    t.text     "how_it_works"
    t.text     "how_it_works_html"
    t.string   "terms_url"
    t.text     "video_embed_url"
    t.text     "ga_code"
    t.index ["permalink"], :name => "index_channels_on_permalink", :unique => true
  end

  create_table "users", force: true do |t|
    t.text     "email"
    t.text     "name"
    t.text     "bio"
    t.text     "image_url"
    t.boolean  "newsletter",                         default: false
    t.boolean  "project_updates",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                              default: false
    t.text     "full_name"
    t.text     "address_street"
    t.text     "address_number"
    t.text     "address_complement"
    t.text     "address_neighbourhood"
    t.text     "address_city"
    t.text     "address_state"
    t.text     "address_zip_code"
    t.text     "phone_number"
    t.text     "locale",                             default: "pt",  null: false
    t.text     "cpf"
    t.string   "encrypted_password",     limit: 128, default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "twitter"
    t.string   "facebook_link"
    t.string   "other_link"
    t.text     "uploaded_image"
    t.string   "moip_login"
    t.string   "state_inscription"
    t.integer  "channel_id"
    t.datetime "deactivated_at"
    t.text     "reactivate_token"
    t.index ["channel_id"], :name => "fk__users_channel_id"
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["name"], :name => "index_users_on_name"
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    t.foreign_key ["channel_id"], "channels", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_users_channel_id"
  end

  create_table "authorizations", force: true do |t|
    t.integer  "oauth_provider_id", null: false
    t.integer  "user_id",           null: false
    t.text     "uid",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["oauth_provider_id", "user_id"], :name => "index_authorizations_on_oauth_provider_id_and_user_id", :unique => true
    t.index ["oauth_provider_id"], :name => "fk__authorizations_oauth_provider_id"
    t.index ["uid", "oauth_provider_id"], :name => "index_authorizations_on_uid_and_oauth_provider_id", :unique => true
    t.index ["user_id"], :name => "fk__authorizations_user_id"
    t.foreign_key ["oauth_provider_id"], "oauth_providers", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_authorizations_oauth_provider_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_authorizations_user_id"
  end

  create_table "categories", force: true do |t|
    t.text     "name_pt",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_en"
    t.index ["name_pt"], :name => "categories_name_unique", :unique => true
    t.index ["name_pt"], :name => "index_categories_on_name_pt"
  end

  create_table "channel_partners", force: true do |t|
    t.text     "url",        null: false
    t.text     "image",      null: false
    t.integer  "channel_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["channel_id"], :name => "fk__channel_partners_channel_id"
    t.foreign_key ["channel_id"], "channels", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channel_partners_channel_id"
  end

  create_table "channel_posts", force: true do |t|
    t.text     "title",                        null: false
    t.text     "body",                         null: false
    t.text     "body_html",                    null: false
    t.integer  "channel_id",                   null: false
    t.integer  "user_id",                      null: false
    t.boolean  "visible",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.index ["channel_id"], :name => "fk__channel_posts_channel_id"
    t.index ["channel_id"], :name => "index_channel_posts_on_channel_id"
    t.index ["user_id"], :name => "fk__channel_posts_user_id"
    t.index ["user_id"], :name => "index_channel_posts_on_user_id"
    t.foreign_key ["channel_id"], "channels", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channel_posts_channel_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channel_posts_user_id"
  end

  create_table "channel_post_notifications", force: true do |t|
    t.integer  "user_id",         null: false
    t.integer  "channel_post_id", null: false
    t.text     "from_email",      null: false
    t.text     "from_name",       null: false
    t.text     "template_name",   null: false
    t.text     "locale",          null: false
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["channel_post_id"], :name => "fk__channel_post_notifications_channel_post_id"
    t.index ["user_id"], :name => "fk__channel_post_notifications_user_id"
    t.foreign_key ["channel_post_id"], "channel_posts", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channel_post_notifications_channel_post_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channel_post_notifications_user_id"
  end

  create_table "projects", force: true do |t|
    t.text     "name",                                      null: false
    t.integer  "user_id",                                   null: false
    t.integer  "category_id",                               null: false
    t.decimal  "goal",                                      null: false
    t.text     "about",                                     null: false
    t.text     "headline",                                  null: false
    t.text     "video_url"
    t.text     "short_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "about_html"
    t.boolean  "recommended",               default: false
    t.text     "home_page_comment"
    t.text     "permalink",                                 null: false
    t.text     "video_thumbnail"
    t.string   "state"
    t.integer  "online_days",               default: 0
    t.datetime "online_date"
    t.text     "more_links"
    t.text     "first_contributions"
    t.string   "uploaded_image"
    t.string   "video_embed_url"
    t.text     "referal_link"
    t.datetime "sent_to_analysis_at"
    t.text     "audited_user_name"
    t.text     "audited_user_cpf"
    t.text     "audited_user_moip_login"
    t.text     "audited_user_phone_number"
    t.datetime "sent_to_draft_at"
    t.datetime "rejected_at"
    t.text     "traffic_sources",                                        array: true
    t.index ["category_id"], :name => "index_projects_on_category_id"
    t.index ["name"], :name => "index_projects_on_name"
    t.index ["permalink"], :name => "index_projects_on_permalink", :unique => true, :case_sensitive => false
    t.index ["user_id"], :name => "index_projects_on_user_id"
    t.foreign_key ["category_id"], "categories", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "projects_category_id_reference"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "projects_user_id_reference"
  end

  create_table "channels_projects", force: true do |t|
    t.integer "channel_id"
    t.integer "project_id"
    t.index ["channel_id", "project_id"], :name => "index_channels_projects_on_channel_id_and_project_id", :unique => true
    t.index ["project_id"], :name => "index_channels_projects_on_project_id"
    t.foreign_key ["channel_id"], "channels", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channels_projects_channel_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channels_projects_project_id"
  end

  create_table "channels_subscribers", force: true do |t|
    t.integer "user_id",    null: false
    t.integer "channel_id", null: false
    t.index ["channel_id"], :name => "fk__channels_subscribers_channel_id"
    t.index ["user_id", "channel_id"], :name => "index_channels_subscribers_on_user_id_and_channel_id", :unique => true
    t.index ["user_id"], :name => "fk__channels_subscribers_user_id"
    t.foreign_key ["channel_id"], "channels", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channels_subscribers_channel_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_channels_subscribers_user_id"
  end

  create_table "rewards", force: true do |t|
    t.integer  "project_id",            null: false
    t.decimal  "minimum_value",         null: false
    t.integer  "maximum_contributions"
    t.text     "description",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "row_order"
    t.integer  "days_to_delivery"
    t.text     "last_changes"
    t.datetime "deliver_at"
    t.index ["project_id"], :name => "index_rewards_on_project_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "rewards_project_id_reference"
  end

  create_table "contributions", force: true do |t|
    t.integer  "project_id",                            null: false
    t.integer  "user_id",                               null: false
    t.integer  "reward_id"
    t.decimal  "value",                                 null: false
    t.datetime "confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "anonymous",             default: false
    t.text     "key"
    t.boolean  "credits",               default: false
    t.boolean  "notified_finish",       default: false
    t.text     "payment_method"
    t.text     "payment_token"
    t.string   "payment_id"
    t.text     "payer_name"
    t.text     "payer_email"
    t.text     "payer_document"
    t.text     "address_street"
    t.text     "address_number"
    t.text     "address_complement"
    t.text     "address_neighbourhood"
    t.text     "address_zip_code"
    t.text     "address_city"
    t.text     "address_state"
    t.text     "address_phone_number"
    t.text     "payment_choice"
    t.decimal  "payment_service_fee"
    t.string   "state"
    t.text     "referal_link"
    t.index ["key"], :name => "index_contributions_on_key"
    t.index ["project_id"], :name => "index_contributions_on_project_id"
    t.index ["reward_id"], :name => "index_contributions_on_reward_id"
    t.index ["user_id"], :name => "index_contributions_on_user_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "contributions_project_id_reference"
    t.foreign_key ["reward_id"], "rewards", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "contributions_reward_id_reference"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "contributions_user_id_reference"
  end

  create_table "contribution_notifications", force: true do |t|
    t.integer  "user_id",         null: false
    t.integer  "contribution_id", null: false
    t.text     "from_email",      null: false
    t.text     "from_name",       null: false
    t.text     "template_name",   null: false
    t.text     "locale",          null: false
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["contribution_id"], :name => "fk__contribution_notifications_contribution_id"
    t.index ["user_id"], :name => "fk__contribution_notifications_user_id"
    t.foreign_key ["contribution_id"], "contributions", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_contribution_notifications_contribution_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_contribution_notifications_user_id"
  end

  create_view "contribution_reports", "SELECT b.project_id, u.name, b.value, r.minimum_value, r.description, b.payment_method, b.payment_choice, b.payment_service_fee, b.key, (b.created_at)::date AS created_at, (b.confirmed_at)::date AS confirmed_at, u.email, b.payer_email, b.payer_name, COALESCE(b.payer_document, u.cpf) AS cpf, u.address_street, u.address_complement, u.address_number, u.address_neighbourhood, u.address_city, u.address_state, u.address_zip_code, b.state FROM ((contributions b JOIN users u ON ((u.id = b.user_id))) LEFT JOIN rewards r ON ((r.id = b.reward_id))) WHERE ((b.state)::text = ANY ((ARRAY['confirmed'::character varying, 'refunded'::character varying, 'requested_refund'::character varying])::text[]))", :force => true
  create_table "settings", force: true do |t|
    t.text     "name",       null: false
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], :name => "index_configurations_on_name", :unique => true
  end

  create_view "contribution_reports_for_project_owners", "SELECT b.project_id, COALESCE(r.id, 0) AS reward_id, p.user_id AS project_owner_id, r.description AS reward_description, (b.confirmed_at)::date AS confirmed_at, b.value AS contribution_value, (b.value * (SELECT (settings.value)::numeric AS value FROM settings WHERE (settings.name = 'catarse_fee'::text))) AS service_fee, u.email AS user_email, COALESCE(u.full_name, u.name) AS user_name, b.payer_email, b.payment_method, b.anonymous, b.state, COALESCE(u.address_street, b.address_street) AS street, COALESCE(u.address_complement, b.address_complement) AS complement, COALESCE(u.address_number, b.address_number) AS address_number, COALESCE(u.address_neighbourhood, b.address_neighbourhood) AS neighbourhood, COALESCE(u.address_city, b.address_city) AS city, COALESCE(u.address_state, b.address_state) AS address_state, COALESCE(u.address_zip_code, b.address_zip_code) AS zip_code FROM (((contributions b JOIN users u ON ((u.id = b.user_id))) JOIN projects p ON ((b.project_id = p.id))) LEFT JOIN rewards r ON ((r.id = b.reward_id))) WHERE ((b.state)::text = ANY ((ARRAY['confirmed'::character varying, 'waiting_confirmation'::character varying])::text[]))", :force => true
  create_view "contributions_by_periods", "WITH weeks AS (SELECT to_char(current_year.current_year, 'yyyy-mm W'::text) AS current_year, to_char(last_year.last_year, 'yyyy-mm W'::text) AS last_year, current_year.current_year AS label FROM (generate_series((now() - '49 days'::interval), now(), '7 days'::interval) current_year(current_year) JOIN generate_series((now() - '1 year 49 days'::interval), (now() - '1 year'::interval), '7 days'::interval) last_year(last_year) ON ((to_char(last_year.last_year, 'mm W'::text) = to_char(current_year.current_year, 'mm W'::text))))), current_year AS (SELECT w.label, sum(cc.value) AS current_year FROM (contributions cc JOIN weeks w ON ((w.current_year = to_char(cc.confirmed_at, 'yyyy-mm W'::text)))) WHERE ((cc.state)::text = 'confirmed'::text) GROUP BY w.label), last_year AS (SELECT w.label, sum(cc.value) AS last_year FROM (contributions cc JOIN weeks w ON ((w.last_year = to_char(cc.confirmed_at, 'yyyy-mm W'::text)))) WHERE ((cc.state)::text = 'confirmed'::text) GROUP BY w.label) SELECT current_year.label, current_year.current_year, last_year.last_year FROM (current_year JOIN last_year USING (label))", :force => true
  create_view "financial_reports", "SELECT p.name, u.moip_login, p.goal, expires_at(p.*) AS expires_at, p.state FROM (projects p JOIN users u ON ((u.id = p.user_id)))", :force => true
  create_table "payment_notifications", force: true do |t|
    t.integer  "contribution_id", null: false
    t.text     "extra_data"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["contribution_id"], :name => "index_payment_notifications_on_contribution_id"
    t.foreign_key ["contribution_id"], "contributions", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "payment_notifications_backer_id_fk"
  end

  create_table "paypal_payments", id: false, force: true do |t|
    t.text "data"
    t.text "hora"
    t.text "fusohorario"
    t.text "nome"
    t.text "tipo"
    t.text "status"
    t.text "moeda"
    t.text "valorbruto"
    t.text "tarifa"
    t.text "liquido"
    t.text "doe_mail"
    t.text "parae_mail"
    t.text "iddatransacao"
    t.text "statusdoequivalente"
    t.text "statusdoendereco"
    t.text "titulodoitem"
    t.text "iddoitem"
    t.text "valordoenvioemanuseio"
    t.text "valordoseguro"
    t.text "impostosobrevendas"
    t.text "opcao1nome"
    t.text "opcao1valor"
    t.text "opcao2nome"
    t.text "opcao2valor"
    t.text "sitedoleilao"
    t.text "iddocomprador"
    t.text "urldoitem"
    t.text "datadetermino"
    t.text "iddaescritura"
    t.text "iddafatura"
    t.text "idtxn_dereferência"
    t.text "numerodafatura"
    t.text "numeropersonalizado"
    t.text "iddorecibo"
    t.text "saldo"
    t.text "enderecolinha1"
    t.text "enderecolinha2_distrito_bairro"
    t.text "cidade"
    t.text "estado_regiao_território_prefeitura_republica"
    t.text "cep"
    t.text "pais"
    t.text "numerodotelefoneparacontato"
    t.text "extra"
  end

  create_view "project_totals", "SELECT contributions.project_id, sum(contributions.value) AS pledged, ((sum(contributions.value) / projects.goal) * (100)::numeric) AS progress, sum(contributions.payment_service_fee) AS total_payment_service_fee, count(*) AS total_contributions FROM (contributions JOIN projects ON ((contributions.project_id = projects.id))) WHERE ((contributions.state)::text = ANY ((ARRAY['confirmed'::character varying, 'refunded'::character varying, 'requested_refund'::character varying])::text[])) GROUP BY contributions.project_id, projects.goal", :force => true
  create_view "project_financials", "WITH catarse_fee_percentage AS (SELECT (c.value)::numeric AS total, ((1)::numeric - (c.value)::numeric) AS complement FROM settings c WHERE (c.name = 'catarse_fee'::text)), catarse_base_url AS (SELECT c.value FROM settings c WHERE (c.name = 'base_url'::text)) SELECT p.id AS project_id, p.name, u.moip_login AS moip, p.goal, pt.pledged AS reached, pt.total_payment_service_fee AS moip_tax, (cp.total * pt.pledged) AS catarse_fee, (pt.pledged * cp.complement) AS repass_value, to_char(timezone(COALESCE((SELECT settings.value FROM settings WHERE (settings.name = 'timezone'::text)), 'America/Sao_Paulo'::text), expires_at(p.*)), 'dd/mm/yyyy'::text) AS expires_at, ((catarse_base_url.value || '/admin/reports/contribution_reports.csv?project_id='::text) || p.id) AS contribution_report, p.state FROM ((((projects p JOIN users u ON ((u.id = p.user_id))) JOIN project_totals pt ON ((pt.project_id = p.id))) CROSS JOIN catarse_fee_percentage cp) CROSS JOIN catarse_base_url)", :force => true
  create_table "project_notifications", force: true do |t|
    t.integer  "user_id",       null: false
    t.integer  "project_id",    null: false
    t.text     "from_email",    null: false
    t.text     "from_name",     null: false
    t.text     "template_name", null: false
    t.text     "locale",        null: false
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["project_id"], :name => "fk__project_notifications_project_id"
    t.index ["user_id"], :name => "fk__project_notifications_user_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_project_notifications_project_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_project_notifications_user_id"
  end

  create_table "project_posts", force: true do |t|
    t.integer  "user_id",                      null: false
    t.integer  "project_id",                   null: false
    t.text     "title"
    t.text     "comment",                      null: false
    t.text     "comment_html",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "exclusive",    default: false
    t.index ["project_id"], :name => "index_updates_on_project_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "updates_project_id_fk"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "updates_user_id_fk"
  end

  create_table "project_post_notifications", force: true do |t|
    t.integer  "user_id",         null: false
    t.integer  "project_post_id", null: false
    t.text     "from_email",      null: false
    t.text     "from_name",       null: false
    t.text     "template_name",   null: false
    t.text     "locale",          null: false
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["project_post_id"], :name => "fk__project_post_notifications_project_post_id"
    t.index ["user_id"], :name => "fk__project_post_notifications_user_id"
    t.foreign_key ["project_post_id"], "project_posts", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_project_post_notifications_project_post_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_project_post_notifications_user_id"
  end

  create_view "projects_for_home", "WITH recommended_projects AS (SELECT 'recommended'::text AS origin, recommends.id, recommends.name, recommends.user_id, recommends.category_id, recommends.goal, recommends.about, recommends.headline, recommends.video_url, recommends.short_url, recommends.created_at, recommends.updated_at, recommends.about_html, recommends.recommended, recommends.home_page_comment, recommends.permalink, recommends.video_thumbnail, recommends.state, recommends.online_days, recommends.online_date, recommends.traffic_sources, recommends.more_links, recommends.first_contributions AS first_backers, recommends.uploaded_image, recommends.video_embed_url FROM projects recommends WHERE (recommends.recommended AND ((recommends.state)::text = 'online'::text)) ORDER BY random() LIMIT 3), recents_projects AS (SELECT 'recents'::text AS origin, recents.id, recents.name, recents.user_id, recents.category_id, recents.goal, recents.about, recents.headline, recents.video_url, recents.short_url, recents.created_at, recents.updated_at, recents.about_html, recents.recommended, recents.home_page_comment, recents.permalink, recents.video_thumbnail, recents.state, recents.online_days, recents.online_date, recents.traffic_sources, recents.more_links, recents.first_contributions AS first_backers, recents.uploaded_image, recents.video_embed_url FROM projects recents WHERE ((((recents.state)::text = 'online'::text) AND ((now() - recents.online_date) <= '5 days'::interval)) AND (NOT (recents.id IN (SELECT recommends.id FROM recommended_projects recommends)))) ORDER BY random() LIMIT 3), expiring_projects AS (SELECT 'expiring'::text AS origin, expiring.id, expiring.name, expiring.user_id, expiring.category_id, expiring.goal, expiring.about, expiring.headline, expiring.video_url, expiring.short_url, expiring.created_at, expiring.updated_at, expiring.about_html, expiring.recommended, expiring.home_page_comment, expiring.permalink, expiring.video_thumbnail, expiring.state, expiring.online_days, expiring.online_date, expiring.traffic_sources, expiring.more_links, expiring.first_contributions AS first_backers, expiring.uploaded_image, expiring.video_embed_url FROM projects expiring WHERE ((((expiring.state)::text = 'online'::text) AND (expires_at(expiring.*) <= (now() + '14 days'::interval))) AND (NOT (expiring.id IN (SELECT recommends.id FROM recommended_projects recommends UNION SELECT recents.id FROM recents_projects recents)))) ORDER BY random() LIMIT 3) (SELECT recommended_projects.origin, recommended_projects.id, recommended_projects.name, recommended_projects.user_id, recommended_projects.category_id, recommended_projects.goal, recommended_projects.about, recommended_projects.headline, recommended_projects.video_url, recommended_projects.short_url, recommended_projects.created_at, recommended_projects.updated_at, recommended_projects.about_html, recommended_projects.recommended, recommended_projects.home_page_comment, recommended_projects.permalink, recommended_projects.video_thumbnail, recommended_projects.state, recommended_projects.online_days, recommended_projects.online_date, recommended_projects.traffic_sources, recommended_projects.more_links, recommended_projects.first_backers, recommended_projects.uploaded_image, recommended_projects.video_embed_url FROM recommended_projects UNION SELECT recents_projects.origin, recents_projects.id, recents_projects.name, recents_projects.user_id, recents_projects.category_id, recents_projects.goal, recents_projects.about, recents_projects.headline, recents_projects.video_url, recents_projects.short_url, recents_projects.created_at, recents_projects.updated_at, recents_projects.about_html, recents_projects.recommended, recents_projects.home_page_comment, recents_projects.permalink, recents_projects.video_thumbnail, recents_projects.state, recents_projects.online_days, recents_projects.online_date, recents_projects.traffic_sources, recents_projects.more_links, recents_projects.first_backers, recents_projects.uploaded_image, recents_projects.video_embed_url FROM recents_projects) UNION SELECT expiring_projects.origin, expiring_projects.id, expiring_projects.name, expiring_projects.user_id, expiring_projects.category_id, expiring_projects.goal, expiring_projects.about, expiring_projects.headline, expiring_projects.video_url, expiring_projects.short_url, expiring_projects.created_at, expiring_projects.updated_at, expiring_projects.about_html, expiring_projects.recommended, expiring_projects.home_page_comment, expiring_projects.permalink, expiring_projects.video_thumbnail, expiring_projects.state, expiring_projects.online_days, expiring_projects.online_date, expiring_projects.traffic_sources, expiring_projects.more_links, expiring_projects.first_backers, expiring_projects.uploaded_image, expiring_projects.video_embed_url FROM expiring_projects", :force => true
  create_view "projects_in_analysis_by_periods", "WITH weeks AS (SELECT to_char(current_year.current_year, 'yyyy-mm W'::text) AS current_year, to_char(last_year.last_year, 'yyyy-mm W'::text) AS last_year, current_year.current_year AS label FROM (generate_series((now() - '49 days'::interval), now(), '7 days'::interval) current_year(current_year) JOIN generate_series((now() - '1 year 49 days'::interval), (now() - '1 year'::interval), '7 days'::interval) last_year(last_year) ON ((to_char(last_year.last_year, 'mm W'::text) = to_char(current_year.current_year, 'mm W'::text))))), current_year AS (SELECT w.label, count(*) AS current_year FROM (projects p JOIN weeks w ON ((w.current_year = to_char(p.sent_to_analysis_at, 'yyyy-mm W'::text)))) GROUP BY w.label), last_year AS (SELECT w.label, count(*) AS last_year FROM (projects p JOIN weeks w ON ((w.last_year = to_char(p.sent_to_analysis_at, 'yyyy-mm W'::text)))) GROUP BY w.label) SELECT current_year.label, current_year.current_year, last_year.last_year FROM (current_year JOIN last_year USING (label))", :force => true
  create_view "recommendations", "SELECT recommendations.user_id, recommendations.project_id, (sum(recommendations.count))::bigint AS count FROM (SELECT b.user_id, recommendations.id AS project_id, count(DISTINCT recommenders.user_id) AS count FROM (((contributions b JOIN contributions backers_same_projects USING (project_id)) JOIN contributions recommenders ON ((recommenders.user_id = backers_same_projects.user_id))) JOIN projects recommendations ON ((recommendations.id = recommenders.project_id))) WHERE ((((((((((b.state)::text = 'confirmed'::text) AND ((backers_same_projects.state)::text = 'confirmed'::text)) AND ((recommenders.state)::text = 'confirmed'::text)) AND (b.confirmed_at > (now() - '6 mons'::interval))) AND (recommenders.confirmed_at > (now() - '2 mons'::interval))) AND ((recommendations.state)::text = 'online'::text)) AND (b.user_id <> backers_same_projects.user_id)) AND (recommendations.id <> b.project_id)) AND (NOT (EXISTS (SELECT true AS bool FROM contributions b2 WHERE ((((b2.state)::text = 'confirmed'::text) AND (b2.user_id = b.user_id)) AND (b2.project_id = recommendations.id)))))) GROUP BY b.user_id, recommendations.id UNION SELECT b.user_id, recommendations.id AS project_id, 0 AS count FROM ((contributions b JOIN projects p ON ((b.project_id = p.id))) JOIN projects recommendations ON ((recommendations.category_id = p.category_id))) WHERE (((b.state)::text = 'confirmed'::text) AND ((recommendations.state)::text = 'online'::text))) recommendations WHERE (NOT (EXISTS (SELECT true AS bool FROM contributions b2 WHERE ((((b2.state)::text = 'confirmed'::text) AND (b2.user_id = recommendations.user_id)) AND (b2.project_id = recommendations.project_id))))) GROUP BY recommendations.user_id, recommendations.project_id ORDER BY (sum(recommendations.count))::bigint DESC", :force => true
  create_table "states", force: true do |t|
    t.string   "name",       null: false
    t.string   "acronym",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["acronym"], :name => "states_acronym_unique", :unique => true
    t.index ["name"], :name => "states_name_unique", :unique => true
  end

  create_view "statistics", "SELECT (SELECT count(*) AS count FROM users) AS total_users, contributions_totals.total_contributions, contributions_totals.total_contributors, contributions_totals.total_contributed, projects_totals.total_projects, projects_totals.total_projects_success, projects_totals.total_projects_online FROM (SELECT count(*) AS total_contributions, count(DISTINCT contributions.user_id) AS total_contributors, sum(contributions.value) AS total_contributed FROM contributions WHERE ((contributions.state)::text <> ALL (ARRAY[('waiting_confirmation'::character varying)::text, ('invalid_payment'::character varying)::text, ('pending'::character varying)::text, ('canceled'::character varying)::text, 'deleted'::text]))) contributions_totals, (SELECT count(*) AS total_projects, count(CASE WHEN ((projects.state)::text = 'successful'::text) THEN 1 ELSE NULL::integer END) AS total_projects_success, count(CASE WHEN ((projects.state)::text = 'online'::text) THEN 1 ELSE NULL::integer END) AS total_projects_online FROM projects WHERE ((projects.state)::text <> ALL (ARRAY[('draft'::character varying)::text, ('rejected'::character varying)::text]))) projects_totals", :force => true
  create_view "subscriber_reports", "SELECT u.id, cs.channel_id, u.name, u.email FROM (users u JOIN channels_subscribers cs ON ((cs.user_id = u.id)))", :force => true
  create_table "total_backed_ranges", id: false, force: true do |t|
    t.text    "name",  null: false
    t.decimal "lower"
    t.decimal "upper"
  end

  create_table "unsubscribes", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], :name => "index_unsubscribes_on_project_id"
    t.index ["user_id"], :name => "index_unsubscribes_on_user_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "unsubscribes_project_id_fk"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "unsubscribes_user_id_fk"
  end

  create_table "user_notifications", force: true do |t|
    t.integer  "user_id",       null: false
    t.text     "from_email",    null: false
    t.text     "from_name",     null: false
    t.text     "template_name", null: false
    t.text     "locale",        null: false
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], :name => "fk__user_notifications_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_user_notifications_user_id"
  end

  create_view "user_totals", "SELECT b.user_id AS id, b.user_id, count(DISTINCT b.project_id) AS total_contributed_projects, sum(b.value) AS sum, count(*) AS count, sum(CASE WHEN (((p.state)::text <> 'failed'::text) AND (NOT b.credits)) THEN (0)::numeric WHEN (((p.state)::text = 'failed'::text) AND b.credits) THEN (0)::numeric WHEN (((p.state)::text = 'failed'::text) AND ((((b.state)::text = ANY ((ARRAY['requested_refund'::character varying, 'refunded'::character varying])::text[])) AND (NOT b.credits)) OR (b.credits AND (NOT ((b.state)::text = ANY ((ARRAY['requested_refund'::character varying, 'refunded'::character varying])::text[])))))) THEN (0)::numeric WHEN ((((p.state)::text = 'failed'::text) AND (NOT b.credits)) AND ((b.state)::text = 'confirmed'::text)) THEN b.value ELSE (b.value * ((-1))::numeric) END) AS credits FROM (contributions b JOIN projects p ON ((b.project_id = p.id))) WHERE ((b.state)::text = ANY ((ARRAY['confirmed'::character varying, 'requested_refund'::character varying, 'refunded'::character varying])::text[])) GROUP BY b.user_id", :force => true
end
