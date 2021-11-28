class LookupByObjectCoactor < ApplicationCoactor
  coact A, B
  coact Inherited::A, Inherited::B
end
