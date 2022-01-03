class LookupByObjectCoactor < ApplicationCoactor
  coact ItemA, ItemB
  coact Inherited::ItemA, Inherited::ItemB
end
