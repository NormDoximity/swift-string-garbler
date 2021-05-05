#
#
# template.py
#
# alternate template python test file
#
#
#
class ProjectKeys:

    keyData = [89, 102, 113, 102, 71, 105, 70, 78, 116, 118, 107, 81, 108, 70, 83, 76, 66, 77, 97, 113, 119, 100, 117, 75, 73, 56, 76, 66, 82, 74, 51, 102, 52, 83, 100, 81, 119, 48, 76, 43, 67, 100, 73, 61]

    
    key2_value = [68, 109, 119, 99, 89, 90, 67, 115, 114, 108, 89, 80, 73, 100, 82, 71, 73, 102, 65, 120, 90, 88, 102, 98, 97, 101, 85, 120, 97, 50, 98, 82, 120, 102, 55, 103, 57, 50, 121, 81, 115, 76, 104, 72, 72, 114, 48, 102, 107, 51, 55, 113, 47, 83, 121, 78, 87, 118, 48, 61]
    
    key3_value = [112, 121, 48, 73, 77, 69, 120, 116, 87, 87, 72, 118, 101, 78, 103, 120, 112, 88, 109, 55, 117, 106, 83, 98, 107, 48, 100, 101, 122, 79, 87, 111, 87, 72, 97, 81, 76, 66, 67, 51, 53, 68, 69, 75, 121, 116, 79, 98, 77, 118, 109, 97, 48, 53, 97, 106, 100, 113, 99, 110, 49, 106, 43, 89, 116, 88, 85, 85, 53, 88, 76, 122, 47, 105, 99, 61]
    
    key1_value = [112, 122, 111, 99, 88, 110, 75, 53, 66, 83, 77, 47, 116, 75, 54, 110, 103, 76, 118, 110, 83, 80, 77, 117, 54, 79, 117, 119, 119, 112, 90, 97, 56, 108, 105, 66, 72, 47, 121, 117, 72, 99, 84, 85, 56, 56, 51, 74, 77, 56, 79, 48, 106, 49, 90, 117, 69, 67, 69, 61]
    


if __name__ == '__main__':
    keys = ProjectKeys()
    key_len = False if len(keys.keyData) == 0 else True
    key1_len = False if len(keys.key1_value) == 0 else True
    key2_len = False if len(keys.key2_value) == 0 else True
    key3_len = False if len(keys.key3_value) == 0 else True
    result = reduce(lambda p,q: p and q, [key_len, key1_len, key2_len, key3_len])
    message = "Success" if result else "Failed"
    print(message)
