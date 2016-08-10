require 'active_support/time'

RSpec.describe 'Slow 3' do
  it 'does something slowly 3' do
    #sleep(30.minutes)

    expect(42).to eq 42
  end
end
