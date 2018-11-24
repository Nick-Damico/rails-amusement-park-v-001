class Ride < ApplicationRecord
  belongs_to :attraction
  belongs_to :user

  def take_ride
    failure_messages = ''
    failure_messages += rider_enough_tickets
    failure_messages += rider_tall_enough

    return failure_messages.prepend('Sorry.') unless failure_messages.empty?
    update_rider_tickets
    update_rider_nausea
    update_rider_happiness
  end

  private
    def rider_enough_tickets
      message = ''
      if user.tickets > attraction.tickets
      else
        message = " You do not have enough tickets to ride the #{attraction.name}."
      end
      message
    end

    def rider_tall_enough
      message = ''
      if user.height > attraction.min_height
      else
        message = " You are not tall enough to ride the #{attraction.name}."
      end
      message
    end

    def update_rider_tickets
      ticket_count = user.tickets -= attraction.tickets
      user.update(tickets: ticket_count)
    end

    def update_rider_nausea
      adj_nausea = user.nausea += attraction.nausea_rating
      user.update(nausea: adj_nausea)
    end

    def update_rider_happiness
      adj_happiness = user.happiness += attraction.happiness_rating
      user.update(happiness: adj_happiness)
    end
end
