# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  scope :business do
    field :public_order_queue, default: true, type: :boolean
    field :app_name, default: "Snack Bar by Yaro", type: :string, validates: { presence: true, length: { in: 2..20 } }
    field :logo_url, type: :string, help_text: "https://superails.com/logo.png"
    field :description, default: "Self checkout snack bar", type: :text, validates: { presence: true, length: { in: 2..200 } }
  end

  ENABLED_CURRENCIES = %w[USD EUR PLN]

  scope :payments do
    field :currency, default: "USD", type: :string, validates: { presence: true, inclusion: { in: ENABLED_CURRENCIES } }, option_values: ENABLED_CURRENCIES
  end

  scope :legal do
    field :address, default: "ul. Kowalska 123, 00-000 Warszawa", type: :string, validates: { presence: true, length: { in: 2..200 } }
    field :email, default: "info@snackbarbyyaro.com", type: :string, validates: { presence: true, length: { in: 2..100 } }
    field :phone, default: "+48 123 456 789", type: :string, validates: { presence: true, length: { in: 2..20 } }
    field :trade_name, default: "Snack Bar By Yaro LLC", type: :string, validates: { presence: true, length: { in: 2..40 } }
    field :trade_vat_number, default: "PL1234567890", type: :string, validates: { presence: true, length: { in: 2..20 } }
  end

  scope :socials do
    field :instagram, default: "https://www.instagram.com/yaro_the_slav", type: :string
    field :twitter, default: "https://twitter.com/yarotheslav", type: :string
    field :tiktok, default: "", type: :string, help_text: "https://www.tiktok.com/@yaro_the_slav"
    field :linkedin, default: "", type: :string, help_text: "https://www.linkedin.com/in/yarotheslav"
    field :youtube, default: "", type: :string, help_text: "https://www.youtube.com/@yaro_the_slav"
    field :facebook, default: "", type: :string, help_text: "https://www.facebook.com/yarotheslav"
    field :pinterest, default: "", type: :string, help_text: "https://www.pinterest.com/yarotheslav"
    field :twitch, default: "", type: :string, help_text: "https://www.twitch.tv/yarotheslav"
    field :discord, default: "", type: :string, help_text: "https://discord.gg/yarotheslav"
    field :telegram, default: "", type: :string, help_text: "https://t.me/yarotheslav"
    field :whatsapp, default: "", type: :string, help_text: "https://wa.me/yarotheslav"
  end

  def self.get_scope(scope_name)
    defined_fields
      .select { |field| field[:scope] == scope_name }
      .each_with_object({}) { |field, hash| hash[field[:key]] = send(field[:key]) }
  end
end
