# frozen_string_literal: true

#
# NOTE: options_for_select takes an 2d array with format like [text, val] and a default value.
#
module CartsHelper
  module_function

  def shipment_countries_options(default = nil)
    data = I18n.t("models.shipping_regions.codes").invert.to_a
    options = [data, default]
    options_for_select(*options)
  end

  def shipment_tw_cities_options
    options = I18n.t("models.shipments.tw_cities").invert.to_a
    options_for_select(options)
  end

  def shipment_methods_options(shipping_methods)
    options = shipping_methods.map do |shipping_method|
      name, fee = shipping_method.info.values_at(:name, :fee)
      provider_name = shipping_method.provider.name
      [shipment_method_translation(name, provider_name, fee), shipping_method.id]
    end
    options_for_select(options)
  end

  private

  def shipment_method_translation(name, provider_name, fee)
    I18n.t("models.shipping_methods.names.#{name}",
      company: provider_name,
      price: number_to_currency(fee, unit: "NT$ ", precision: 0))
  end
end
