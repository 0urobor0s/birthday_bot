require "./birthday"

class Birthdays
  def initialize
    @bdays = Array(Birthday).new
    yaml = YAML.parse(File.read("./config/birthdays.yml"))
    yaml["birthdays"].as_h.each do |b|
      name = b[0].to_s
      handle = b[1].as_h["handle"].to_s
      time = Time.parse_utc(b[1].as_h["birthday"].to_s, "%F")
      member_id = b[1].as_h["member_id"].to_s
      @bdays.push Birthday.new(name, handle, time, member_id)
    end
  end

  def today
    today = Array(Tuple(String, String)).new
    now = Time.utc 
    @bdays.each do |b|
      if b.bdate.month == now.month && b.bdate.day == now.day
        today.push Tuple.new(b.name, b.member_id)
      end
    end
    today
  end
end
