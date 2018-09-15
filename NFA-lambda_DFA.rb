require 'Matrix'
class NFAlambda_DFA
	
	########################## following the Algorithm 5.6.3 ############################
	############### 1 - input an NFA-lambda from the following file #####################
	file = File.foreach('ex_399.txt').map {|line| line.split(/[\s,\n]/)}
	first_state = file[2][0]
	final_state = file[3]
	states_set = file[0]
	alphabets = file[1]

	########################## NFA-lambda ############################
	transition = Array.new(states_set.length){Array.new(alphabets.length)}
	print "\r\nThe transtion table for the input NFA-lambda "
		0.upto(states_set.size-1).each do |i|
		print "\r\n"
			0.upto(alphabets.size-1).each do |j|
				transition[i][j] = file[i+4][j]
				print transition[i][j]
				print "   "
			end
		end
		
		########Looking for the transition that is contained lambda########
		#i = 0
	#while (i <= states_set.length - 1) 
		
		#i = i + 1
	#end 
	
	######################### 2 - input transition function t of M #######################
	# defined it as matrix 
	t = Array.new(states_set.length){Array.new(alphabets.length-1)}
	
	################ 3 - initialize Q' to lambda-closure(q0)###################
	
	print "\r\n The input transition table to create the DFA "
	
	0.upto(states_set.size-1).each do |i|
	print "\r\n"
	alphabet_index = alphabets.length-1
		transition_lambda = Array.new
		transition_lambda = transition[i][alphabet_index].split(":")
		
		0.upto(alphabets.size-2).each do |j|			
			dfa = Array.new() 
			dfa_state = String.new
			dfa = transition[i][j].split(":")
			
			0.upto(dfa.size-1).each do |k|
				dfa_state = dfa_state + ":" + dfa[k]
			end 
			
	################ 4 - repeat ###################
			if (transition_lambda.empty? == false)
				for x in transition_lambda  #if there is a node x in Q' and a symbol a in the set of the alphabets with no arc
					if (x != "nil") # new nodes are generated in this step and added to Q' and the process continues until every node in Q' is deterministic
						if (transition[states_set.index(x)][j] != "nil")
							dfa_state = dfa_state + ":" + transition[states_set.index(x)][j] #2.1.3 add an arc from X to Y labeled a 
						end
					end #done = true
				end #until done
			end
			 t[i][j] = dfa_state
			
		end	
	end
	puts t.to_a.map(&:inspect)
end #end class










