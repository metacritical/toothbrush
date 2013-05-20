scoped_method(){
		scoped_method_inner_method(){
			  printf "The inner scoped method";
		}
		
		declare -A inner["inner_method"]="scoped_method_inner_method";
		echo "${inner["inner_method"]}";
		
}
		

#echo $(scoped_method);
#eval $(scoped_method;)
scoped_method;

