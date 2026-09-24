function rmiunused
  disknanny check -v | grep unused | cut -d' ' -f 7 | xargs a4c rmi
end
