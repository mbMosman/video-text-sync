
fileName = "captions.srt"
outFileName = fileName[0, fileName.index(".")] + ".json"

def convertTimeToSecs(timeStr)
  index = timeStr.rindex(":")
  secs = timeStr[index+1..timeStr.length]
  puts("timeStr=#{timeStr} secs=#{secs}")
  timeStr = timeStr[0..index-1]
  index = timeStr.rindex(":")
  if (index != nil && index > 0)
    mins = timeStr[index+1..timeStr.length]
    puts("timeStr=#{timeStr} mins=#{mins}")
    if (mins.length > 0 && mins.to_i > 0)
      secs = (60 * mins.to_i) + secs.to_f
    end
    timeStr = timeStr[0..index-1]
    index = timeStr.rindex(":")
    if (index != nil && index > 0)
      hrs = timeStr[index+1..timeStr.length]
      puts("timeStr=#{timeStr} hrs=#{hrs}")
      if (hrs.length > 0 && hrs.to_i > 0)
        secs = (60 * 60 * hrs.to_i) + secs
      end
    end
  end
  return secs
end

File.open(outFileName, File::CREAT| File::TRUNC | File::WRONLY) do |outFile|

  outFile.puts('{')
  outFile.puts('"captions" : [')

  allLines = File.readlines(fileName)

  lineCount = 0
  while lineCount < allLines.length

    id = allLines[lineCount].chomp
    lineCount += 1
    if (id.length == 0)
      id = allLines[lineCount].chomp
      lineCount += 1
    end

    line2 = allLines[lineCount].chomp
    lineCount += 1

    splitIndex = line2.index(" ")
    startTime = convertTimeToSecs(line2[0..splitIndex].gsub(',', '.')).to_s

    endTime = convertTimeToSecs(line2[splitIndex + 6..line2.length-1].gsub(',', '.')).to_s

    text = allLines[lineCount].chomp
    lineCount += 1

    json = '{ "id": "c' + id + '", "start": "' + startTime + '", "end": "'+ endTime + '" ,"text": "' + text + ' " }'
    if (lineCount < allLines.length - 3)
      json = json + ','
    end
    outFile.puts(json)

  end

  outFile.puts("]")
  outFile.puts("}")
end
