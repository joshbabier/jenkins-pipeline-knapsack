require 'active_support/time'

RSpec.describe 'Slow 1' do
  it 'does something slowly 1' do
    #sleep(30.minutes)

    expect(42).to eq 42
  end
end
