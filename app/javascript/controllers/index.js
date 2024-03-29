// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from './application'

import CartController from './cart_controller.js'

import ConfettiController from './confetti_controller.js'

import FormController from './form_controller.js'

import ModalController from './modal_controller.js'

import NumberFieldController from './number_field_controller.js'

import PaymentSelectController from './payment_select_controller.js'

import RefreshController from './refresh_controller.js'

import ShipmentController from './shipment_controller.js'

import UserDropdownController from './user_dropdown_controller.js'
application.register('cart', CartController)
application.register('confetti', ConfettiController)
application.register('form', FormController)
application.register('modal', ModalController)
application.register('number-field', NumberFieldController)
application.register('payment-select', PaymentSelectController)
application.register('refresh', RefreshController)
application.register('shipment', ShipmentController)
application.register('user-dropdown', UserDropdownController)
