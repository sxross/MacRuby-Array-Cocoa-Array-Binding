# LightboxArrayController.rb
# IStockCocoa
#
# Created by Steve Ross on 1/10/10.
# Copyright 2010 Calico Web Development. All rights reserved.

class Lightbox
  attr_accessor :title
  
  def initialize(args = {})
    args.each_pair do |k, v|
      instance_variable_set("@#{k.to_s}", v)
    end
  end

  def number
    @number.to_i
  end
  
  def number=(v)
    @number = v.to_i
  end
  
  def to_s
    "number => #{self.number} (#{self.number.class}) title => #{self.title} (#{self.title.class})"
  end
end

class LightboxArrayController < NSArrayController
  def awakeFromNib
    [
      Lightbox.new(:number => 23456, :title => 'lightbox 123456'),
      Lightbox.new(:number => 134567, :title => 'lightbox 234567')
    ].each do |object|
      puts "adding #{object}"
      self.addObject(object)
    end
  end
end