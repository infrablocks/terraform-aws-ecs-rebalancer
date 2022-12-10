# frozen_string_literal: true

require 'spec_helper'

describe 'full' do
  it 'is true' do
    thing = true

    expect(thing).to(be(true))
  end
end
