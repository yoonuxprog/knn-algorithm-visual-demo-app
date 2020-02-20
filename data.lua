local data = {}

-- Path for the file to read
local filePath = system.pathForFile( filename, system.DocumentsDirectory  )

if ( filePath ) then
    -- Open the file handle
    local file, errorString = io.open( filePath, "r" )

    if not file then
        -- Error occurred; output the cause
        print( "File error: " .. errorString )
    else
        -- Insert lines into table
        for line in file:lines() do
            local xcor, ycor, class1 = line:match("(%d+),(%d+),(%a+)")
            data[#data + 1] = {xcor, ycor, class1}
        end
        -- Close the file handle
        io.close( file )
    end
end

file = nil

return data