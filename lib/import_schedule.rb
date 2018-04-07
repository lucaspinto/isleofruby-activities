# frozen_string_literal: true

require 'json'
require 'pp'

schedule_json = File.read(File.expand_path('../../../2018.isleofruby.org/data/schedule.json', __FILE__))
schedule_data = JSON.parse(schedule_json)

Time.use_zone('Europe/London') do
  CONFERENCE_EVENT      = Event.new
  CONFERENCE_START_DATE = Time.zone.local(2018, 4, 13)

  schedule_data.each do |item|
    item_date   = CONFERENCE_START_DATE.advance(days: item['conference_day'] - 1)
    start_time  = Time.zone.parse(item['start_time'], item_date)
    end_time    = Time.zone.parse(item['end_time'], item_date)

    activity = Activity.new(
      name:           item['title'],
      description:    item['description'],
      location:       item['room'],
      start_time:     start_time,
      end_time:       end_time,
      event:          CONFERENCE_EVENT,
      official:       true,
      requires_event_ticket: true
      # creator_id:
      # limit_of_participants",    default: 10
      # participations_count",     default: 0,     null: false
      # anytime",                  default: false, null: false
    )

    p activity
    # p activity.valid?
    # p activity.errors
    activity.save!

  end
end
