class LookupCoactor < ApplicationCoactor
  coact Lookups::ACoactor
  coact Lookups::BCoactor
end
