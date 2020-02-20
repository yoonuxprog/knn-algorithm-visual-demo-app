-----------------------------------------------------------------------------------------
--
-- knn.lua
--
-----------------------------------------------------------------------------------------

function getEuclideanDistance( x1, y1, x2, y2 )
    return math.sqrt( ( math.pow( x2 - x1, 2 ) ) + ( math.pow( y2 -  y1, 2 ) ) )
end

function getManhattanDistance( x1, y1, x2, y2 )
    return math.abs(x2 - x1) + math.abs(y2 - y1)
end

-- function getCosineDistance( x1, y1, x2, y2 )
--     return (((x1 * x2) + (y1 * y2)) / ((math.sqrt(math.pow(x1,2) + math.pow(y1,2))) * (math.sqrt(math.pow(x2,2) + math.pow(y2,2)))))
-- end

function getBrayCurtisDistance( x1, y1, x2, y2 )
    return (math.abs( x1 - x2 ) + math.abs( y1 - y2 )) / (math.abs( x1 + x2 ) + math.abs( y1 + y2 ))
end

function getChebyshevDistance( x1, y1, x2, y2 )
    return math.max(math.abs((x2 - x1)) + math.abs((y2 - y1)))
end

function KNNalgorithm(xcor, ycor, k_value)
    datawithdist = {}

    print("X  and  Y  Coordinate: " .. xcor .. " : " .. ycor)

    for k, v in pairs(data) do
    -- v[1] is the X coordinate, v[2] is Y coordinate, v[3] is the class

        if (currentDistanceMetric == "Euclidean Distance") then
            distance  =  getEuclideanDistance(v[1], v[2], xcor, ycor)
        elseif (currentDistanceMetric == "Manhattan Distance") then
            distance  =  getManhattanDistance(v[1], v[2], xcor, ycor)
        elseif (currentDistanceMetric == "Bray Curtis Distance") then
            distance = getBrayCurtisDistance(v[1], v[2], xcor, ycor)
        elseif (currentDistanceMetric == "Chebyshev Distance") then
            distance = getChebyshevDistance(v[1], v[2], xcor, ycor)
        end

        datawithdist[#datawithdist + 1] = {v[1], v[2], v[3], distance}
    end

    print("table before sorting")
    for k, v in pairs (datawithdist) do
        print(k,v[1], v[2], v[3], v[4])
    end

    local function compare( a, b )
        return a[4] < b[4]
    end

    table.sort(datawithdist, compare)

    print("table after sorting")
    for k, v in pairs (datawithdist) do
        print(k, v[1], v[2], v[3], v[4])
    end

    local Kvalue = k_value
    print("this is the k value: " .. Kvalue)

    neighbours = {}

    for k, v in pairs (datawithdist) do
        if k <= Kvalue then
            if unitweights.isOn then
                weightedDist = v[4] * (1 / k)
                neighbours[#neighbours + 1] = {v[1], v[2], v[3], weightedDist}
            else
            weightedDist = v[4]
            neighbours[#neighbours + 1] = {v[1], v[2], v[3], weightedDist}
            end
        end
    end

    print("table after adding weights")
    for k, v in pairs (neighbours) do
        print(k, v[1], v[2], v[3], v[4])
    end

    local counta = 0
    local countb = 0

    for k, v in pairs (neighbours) do
        if v[3]  == "a" then
            counta = counta  +  v[4]
        else
            countb  = countb + v[4]
        end
    end

    local class

    if counta > countb then
        class = "a"
    else
        class = "b"
    end

    return class
end