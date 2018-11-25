class Ride < ApplicationRecord
  belongs_to :attraction
  belongs_to :user

  def take_ride
    failure_messages = check_attraction_requirements
    return failure_messages.prepend('Sorry.') unless failure_messages.empty?
    # If no failure_messages are empty? Rider is able to ride, and info should be updated
    update_rider
  end

  private
    def check_attraction_requirements
      messages = ''
      messages += rider_enough_tickets
      messages += rider_tall_enough
      messages
    end

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

    def update_rider
      update_rider_tickets
      update_rider_nausea
      update_rider_happiness
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
