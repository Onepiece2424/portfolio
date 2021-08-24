require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  it "id=1のname,description,slugカラムに正しくデータが格納しているかどうか" do
    product = Spree::Product.new(
      name: "Solidus T-Shirt",
      description: "Necessitatibus optio quod ullam itaq...d",
      slug: "solidus-t-shirt"
    )
    expect(product.name).to eq "Solidus T-Shirt"
    expect(product.description).to eq "Necessitatibus optio quod ullam itaq...d"
    expect(product.slug).to eq "solidus-t-shirt"
  end
  it "id=2のname,description,slugカラムに正しくデータが格納しているかどうか" do
    product = Spree::Product.new(
      name: "Solidus Girly",
      description: "Necessitatibus optio quod ullam itaq...s",
      slug: "solidus-girly"
    )
    expect(product.name).to eq "Solidus Girly"
    expect(product.description).to eq "Necessitatibus optio quod ullam itaq...s"
    expect(product.slug).to eq "solidus-girly"
  end
  it "id=3のname,description,slugカラムに正しくデータが格納しているかどうか" do
    product = Spree::Product.new(
      name: "Solidus Snapback Cap",
      description: "Necessitatibus optio quod ullam itaq...s",
      slug: "solidus-snapback-cap"
    )
    expect(product.name).to eq "Solidus Snapback Cap"
    expect(product.description).to eq "Necessitatibus optio quod ullam itaq...s"
    expect(product.slug).to eq "solidus-snapback-cap"
  end
end
