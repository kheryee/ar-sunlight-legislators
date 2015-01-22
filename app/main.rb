require 'sqlite3'
require_relative '../app/models/politician'




# #____________________QUESTION 1______________________

# puts "Which state are you searching for?"
# state = gets.chomp.upcase
# politician = Politician.where('state = ?', state)
# senator = politician.where('title = ?', 'Sen').sort
# representative = politician.where('title = ?', 'Rep').sort

# puts "Senators: "
# senator.each do |p|
#   puts "#{p.title} #{p.firstname} #{p.lastname} \(#{p.party}\)"
# end

# puts "Representatives: "
# representative.each do |p|
#  puts "#{p.title} #{p.firstname} #{p.lastname} \(#{p.party}\)"
# end

#____________________QUESTION 2______________________

# puts "Enter the gender (m or f)"
# gender = gets.chomp.upcase

# politician = Politician.where('in_office = ?', "1")
# senator = politician.where('title = ?', 'Sen')
# rep = politician.where('title = ?', 'Rep')


# gen_senator = senator.where('gender = ?', gender)
# gen_rep = rep.where('gender = ?', gender)

# case gender
#   when 'M'

#   puts "Male Senators: #{gen_senator.count} \(#{gen_senator.count*100/ senator.count}\)"
#   puts "Male representatives: #{gen_rep.count} \(#{gen_rep.count*100/ rep.count}\)"
#   # puts "Total senators: #{senator.count}"

#   when 'F'
#   puts "Female Senators: #{gen_senator.count} \(#{gen_senator.count*100/ senator.count}\)"
#   puts "Female representatives: #{gen_rep.count} \(#{gen_rep.count*100/ rep.count}\)"
#   else
#     puts "Invalid choice!"
# end


#____________________QUESTION 3______________________


politician = Politician.where('in_office = ?', "1")


distinct_state = politician.select(:state).distinct

# senator = Politician.select("state").where("title = 'Sen'").where("in_office = '1'")

# senator.each do |e|
#   puts "#{e.state} count: #{e.count}
poli_array = []
total = 0
distinct_state.each do |p|
  last_total = total
  senator = politician.where("title = ? AND state = ?", "Sen", p.state)
  rep = politician.where("title = ? AND state = ?", "Rep", p.state)
  poli_array << [p.state, rep.count + senator.count]

  # puts "#{p.state}: #{senator.count} Senator\(s\), #{rep.count} Representative\(s\)"
  # total = senator.count + rep.count

  # if poli_array.length == 0
  #   poli_array << p.state
  # else
  #   if total >= last_total
  #     poli_array << p.state
  #   else
  #     poli_array.insert(0, p.state)
  #   end
  # end
end

new_array = poli_array.sort { |x, y| y[1] <=> x[1]}

new_array.each do |p|
  senator = politician.where("title = ? AND state = ?", "Sen", p[0])
  rep = politician.where("title = ? AND state = ?", "Rep", p[0])
  puts "#{p[0]}: #{senator.count} Senator\(s\), #{rep.count} Representative\(s\)"
end
# poli_array.sort


# SELECT state, (SELECT num_of_sen), (num_of_rep), total_rep FROM politician WHERE

