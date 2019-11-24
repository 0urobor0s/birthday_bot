struct Birthday
  getter handle
  getter bdate
  getter name
  getter member_id
  
  def initialize(name : String, handle : String, bdate : Time, member_id : String)
    @name = name
    @handle = handle
    @bdate = bdate
    @member_id = member_id
  end
end
