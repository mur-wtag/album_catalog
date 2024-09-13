# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(name:)
    @name = name
  end
end
