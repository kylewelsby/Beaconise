module EventHelper
  def ticket_sale_date(date)
    if date <= Time.now
      "NOW"
    else
      datetime_ago(date)
    end
  end
  
  def ticket_price(event, currency = "gbp")
    if event.free or event.price == 0
      'Free Event'
    elsif event.tbc
      '<span title="Price to be confirmed">TBC</span>'
    else
      case currency.upcase
      when "GBP"
        "&pound; #{event.price}"
      else
        "#{event.price}#{event.currency.upcase}"
      end
    end
  end
  
  def ticket_availabuility(event)
    if event.avalable_tickets > 0
      "<span class=\"tickets_available\">#{ticket_price(event)}</span>"
    else
      "<span class=\"tickets_sold_out\">Sold Out</span>"
    end
  end
end
