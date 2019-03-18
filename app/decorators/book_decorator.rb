class BookDecorator < Draper::Decorator
  include BookImage

  delegate_all

  decorates_association :reviews

  RANGES = {
    name: {
      short: 0..25
    },
    description: {
      short: 0..150,
      medium: 0..250,
      end: 250..-1
    }
  }.freeze

  def authors_joined_by_comma
    authors.map(&:name).join(', ')
  end

  def short_name
    name[RANGES[:name][:short]]
  end

  def first_sentence_description
    description.split('.').first
  end

  def short_description
   description[RANGES[:description][:short]]
  end

  def medium_description
   description[RANGES[:description][:medium]]
  end

  def end_of_description
    description[RANGES[:description][:end]]
  end

  def cover_image(type, shadow: true)
    h.image_tag get_cover_image(type), class: get_class_list(shadow)
  end

  def main_cover
    cover.variant(resize: "#{BOOK_IMAGE_SIZES[:main_cover]}!").processed
  end

  def slider_cover
    cover.variant(resize: "#{BOOK_IMAGE_SIZES[:slider_cover]}!").processed
  end

  def cart_cover
    cover.variant(resize: "#{BOOK_IMAGE_SIZES[:cart_cover]}!").processed
  end

  def image(input)
    images[input].variant(resize: "#{BOOK_IMAGE_SIZES[:image]}!").processed
  end
end
