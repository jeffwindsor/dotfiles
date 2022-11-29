function gpls 
  for i in **/.git
    echo $i
    git -C $i/.. pull
  end
end
