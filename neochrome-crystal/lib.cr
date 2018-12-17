class String

  def freqs
    self.chars.reduce({} of Char => Int32) do |h,c|
      h[c] = h.fetch(c, 0) + 1
      h
    end
  end

  def delete (i)
    self[0,i]+self[i+1,self.size]
  end

end
