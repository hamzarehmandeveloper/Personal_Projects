function reversArray(arr) {
  var reversedArray = [];
  var index = 0;
  for (let i = arr.length - 1; i >= 0; i--) {
    reversedArray[index] = arr[i];
    index++;
  }
  return reversedArray;
}

console.log(reversArray([5, 4, 3, 2, 1]));
