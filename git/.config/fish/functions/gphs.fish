function gphs 
  for i in **/.git
    echo $i
    git -C $i/.. push
  end
end
