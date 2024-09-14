# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(name:)
    super
    @name = name
  end
end
