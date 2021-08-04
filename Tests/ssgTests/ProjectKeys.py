#
#
# template.py
#
# alternate template python test file
#
#
#
class ProjectKeys:

    keyData = [50, 65, 114, 111, 77, 102, 56, 112, 57, 106, 102, 117, 88, 50, 122, 75, 74, 102, 117, 109, 81, 109, 87, 121, 71, 99, 83, 109, 104, 71, 80, 66, 49, 73, 66, 54, 88, 114, 81, 50, 122, 70, 115, 61]

    
    key2_value = [105, 55, 66, 104, 114, 49, 104, 80, 104, 81, 118, 114, 119, 116, 66, 87, 85, 102, 114, 118, 80, 83, 52, 50, 67, 121, 102, 115, 79, 116, 122, 110, 111, 52, 77, 70, 48, 100, 90, 115, 115, 118, 84, 89, 53, 103, 82, 75, 82, 105, 76, 104, 56, 75, 103, 80, 88, 54, 107, 61]
    
    key3_value = [102, 121, 81, 77, 87, 51, 112, 101, 113, 53, 121, 97, 43, 102, 52, 43, 77, 51, 120, 101, 67, 72, 103, 66, 77, 88, 100, 122, 111, 48, 120, 65, 111, 85, 50, 99, 110, 73, 48, 84, 75, 109, 108, 87, 104, 70, 106, 97, 84, 56, 79, 101, 48, 78, 114, 99, 109, 78, 48, 104, 115, 119, 101, 79, 119, 116, 78, 81, 52, 103, 90, 70, 119, 114, 73, 61]
    
    key1_value = [100, 65, 102, 80, 108, 84, 67, 120, 79, 105, 71, 118, 108, 120, 98, 53, 77, 84, 48, 83, 66, 114, 114, 53, 83, 52, 98, 51, 116, 53, 52, 56, 112, 108, 88, 88, 116, 113, 65, 67, 109, 108, 89, 109, 66, 102, 119, 116, 113, 43, 90, 78, 51, 119, 43, 85, 85, 82, 73, 61]
    


if __name__ == '__main__':
    keys = ProjectKeys()
    key_len = False if len(keys.keyData) == 0 else True
    key1_len = False if len(keys.key1_value) == 0 else True
    key2_len = False if len(keys.key2_value) == 0 else True
    key3_len = False if len(keys.key3_value) == 0 else True
    result = reduce(lambda p,q: p and q, [key_len, key1_len, key2_len, key3_len])
    message = "Success" if result else "Failed"
    print(message)