# frozen_string_literal: true

module CartsHelper
  def shipment_countries_options(default = nil)
    data = I18n.t("models.shipping_regions.codes").invert.to_a
    options = [data, default]
    options_for_select(*options)
  end

  def shipment_tw_cities_options(default = nil)
    options = I18n.t("models.shipments.tw_cities").invert.to_a
    options.push(default) if default
    options
  end

  def select_shipment_categories(shipping_methods)
    options = shipping_methods.map do |shipping_method|
      I18n.t("models.shipping_methods.names.#{shipping_method.name}")
    end
    select_tag :"shipment[category]", options_for_select(options), class: "p-4 min-w-[112px]"
  end
end
