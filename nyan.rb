TEST_RESULTS = 100

def nyan row, frame
  if frame%4 < 2
    case row
    when 0; ',------,  '
    when 1; '|   /\\_/\\ '
    when 2; '|__( ^ .^)'
    when 3; '""  ""    '
    end
  else
    case row
    when 0; ',------,  '
    when 1; '|   /\\_/\\ '
    when 2; '|__( ^ .^)'
    when 3; '  ""  ""  '
    end
  end
end

def dot_spread i
  arr = [0,0,0,0]

  i.times do |n|
    index = (i/4).odd? ? 3-n%4 : n%4 # change direction every 4 dots
    arr[index] += 1
  end

  arr
end

def clear_image
  print "\r" + ("\e[A\e[K"*4)
end

def rainbow_tile total, row, column, tiles_in_this_row, max_column
  tile = '~' if column == max_column and row == 2
  tile ||= ' ' if tiles_in_this_row-1 < column

  tile ||= if column.even?
    if row.even?
      total.even? ? '-' : '_'
    else
      total.even? ? '_' : '-'
    end
  else
    if row.even?
      total.even? ? '_' : '-'
    else
      total.even? ? '-' : '_'
    end
  end
end

TEST_RESULTS.times do |total_iterator|
  clear_image unless total_iterator == 0

  dots = dot_spread total_iterator

  4.times do |row_iterator|
    max_column = (total_iterator/4.0).ceil
    max_column.times do |column_iterator|
      print rainbow_tile total_iterator, row_iterator, column_iterator, dots[row_iterator], max_column-1
    end

    print nyan row_iterator, total_iterator
    print "\n"
  end

  sleep 0.1
end
