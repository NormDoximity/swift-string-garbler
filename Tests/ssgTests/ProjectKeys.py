#
#
# template.py
#
# alternate template python test file
#
#
#
class ProjectKeys:

    keyData = [102, 101, 111, 55, 70, 107, 109, 105, 112, 97, 75, 47, 115, 99, 70, 67, 57, 48, 43, 76, 101, 113, 107, 81, 121, 74, 78, 56, 68, 105, 97, 83, 82, 66, 83, 121, 48, 116, 111, 87, 116, 67, 107, 61]

    
    key1_value = [85, 108, 121, 76, 84, 56, 103, 52, 71, 98, 117, 54, 48, 70, 80, 106, 102, 56, 47, 81, 101, 82, 57, 105, 57, 111, 90, 81, 88, 121, 50, 57, 88, 70, 55, 116, 111, 56, 49, 80, 82, 75, 105, 66, 110, 114, 71, 86, 67, 77, 106, 101, 74, 111, 106, 88, 116, 51, 85, 61]
    
    key3_value = [74, 112, 87, 48, 56, 83, 57, 83, 77, 115, 107, 52, 109, 43, 55, 87, 65, 98, 50, 120, 76, 105, 53, 56, 87, 77, 102, 50, 87, 51, 48, 88, 99, 110, 110, 78, 53, 47, 122, 101, 52, 66, 55, 51, 52, 75, 90, 100, 90, 79, 90, 101, 50, 111, 82, 72, 57, 55, 111, 83, 103, 116, 118, 89, 99, 52, 79, 105, 84, 109, 111, 100, 69, 122, 107, 61]
    
    key2_value = [86, 88, 89, 51, 116, 79, 98, 119, 78, 89, 66, 101, 65, 103, 121, 116, 86, 67, 107, 51, 51, 48, 50, 83, 83, 107, 54, 80, 48, 113, 65, 111, 48, 49, 56, 69, 79, 67, 75, 111, 56, 84, 80, 114, 121, 105, 43, 54, 79, 57, 106, 114, 56, 52, 119, 53, 105, 109, 73, 61]
    


if __name__ == '__main__':
    keys = ProjectKeys()
    key_len = False if len(keys.keyData) == 0 else True
    key1_len = False if len(keys.key1_value) == 0 else True
    key2_len = False if len(keys.key2_value) == 0 else True
    key3_len = False if len(keys.key3_value) == 0 else True
    result = reduce(lambda p,q: p and q, [key_len, key1_len, key2_len, key3_len])
    message = "Success" if result else "Failed"
    print(message)
