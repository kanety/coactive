class LookupByMethodCoactor < ApplicationCoactor
  coact :lookup_coactors

  private

  def lookup_coactors
    Coactive::Autoloader.load('app/coactors')
    ApplicationCoactor.descendants.select { |klass| klass.name =~ /^Lookups::/ }.sort_by(&:name)
  end
end
