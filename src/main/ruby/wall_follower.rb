module Solver
  class WallFollower
    NAME = "Simon_wallFollower"
    attr_accessor :previous, :current_location
    def initialize
      self.previous = {"x" => 0, "y" => 0, "z" => 0}
      self.current_location = {"x" => 0, "y" => 0, "z" => 0}
    end
    def next(room)
      current_location["x"] = room["x"]
      current_location["y"] = room["y"]
      current_location["z"] = room["z"]
      room_to_go_to = nil
      heading = get_direction(previous, current_location)
      
      exits = {}
      room["exits"].each do |exit_hash|
        next_direction = get_direction(current_location, exit_hash)
        exits[next_direction] = exit_hash
      end
      
      right = nil
      left = nil
      straight = nil
      back = nil
      if heading == "+x"
        right = "+y"
        straight = "+x"
        left = "-y"
        back = "-x"
      elsif heading == "-x"
        right = "-y"
        straight = "-x"
        left = "+y"
        back = "+x"
      elsif heading == "+y"
        right = "-x"
        straight = "+y"
        left = "+x"
        back = "-y"
      elsif heading == "-y"
        right = "+x"
        straight = "-y"
        left = "-x"
        back = "+y"
      elsif heading == "random"
        room_to_go_to = room["exits"].sample
      end
      directions = [left, straight, right, back]
      
      directions.each do |direction|
        if exits[direction]
          room_to_go_to = exits[direction]
          break
        end
      end
      
      previous["x"] = room["x"]
      previous["y"] = room["y"]
      previous["z"] = room["z"]
      return room_to_go_to
    end
      
    def get_direction(start, finish)
      diff = {}
      diff["x"] = finish["x"] - start["x"]
      diff["y"] = finish["y"] - start["y"]
      diff["z"] = finish["z"] - start["z"]
      if diff["x"] > 0
        return "+x"
      elsif diff["x"] < 0
        return "-x"
      elsif diff["y"] > 0
        return "+y"
      elsif diff["y"] < 0
        return "-y"
      end
      return "random"
    end
    
  end
end
