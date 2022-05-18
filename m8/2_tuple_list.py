"""Program accepts input as comma-separated numbers and prints the numbers as a list and a tuple"""

nums = input("Enter numbers: ")
# normalize input data: convert input string to list and strip possible whitespaces in list elements
numbers = [n.strip() for n in nums.split(',')]
# check that all elements of the list to be numeric
while not all(n.isdigit() for n in numbers):
    print("You have entered:", nums)
    nums = input("Enter comma-separated numbers: ")
    numbers = [n.strip() for n in nums.split(',')]
# output result in the form of list and tuple
print()
print("List:", list(numbers))
print("Tuple:", tuple(numbers))
print()
